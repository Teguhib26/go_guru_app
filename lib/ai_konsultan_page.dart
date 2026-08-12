import 'package:flutter/material.dart';
import 'teacher_data.dart';
import 'guru_service.dart';

class AiKonsultanPage extends StatefulWidget {
  const AiKonsultanPage({super.key});

  @override
  State<AiKonsultanPage> createState() => _AiKonsultanPageState();
}

class _AiKonsultanPageState extends State<AiKonsultanPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _quickQuestions = [
    'Rekomendasi guru gitar',
    'Harga les piano',
    'Tips pilih alat musik',
    'Jadwal les weekend',
    'Guru biola terbaik',
    'Les musik online',
  ];

  final Map<String, String> _responses = {
    'gitar': 'Gitar pilihan sempurna untuk pemula! 🎸\n\nTips memulai:\n• Pilih gitar akustik\n• Latihan chord dasar: C, G, D, Em, Am\n• Gunakan metronom\n• Latihan rutin 30 menit/hari\n\nMau saya bantu cari guru gitar?',
    'piano': 'Piano alat musik klasik yang indah! 🎹\n\nTips belajar piano:\n• Mulai dengan piano elektrik\n• Pelajari teori musik dasar\n• Latihan skala\n• Perhatikan postur tangan\n\nMau tahu guru piano di areamu?',
    'biola': 'Biola butuh kesabaran tinggi! 🎻\n\nTips belajar biola:\n• Perhatikan postur tubuh\n• Latihan vibrato bertahap\n• Gunakan shoulder rest\n• Pilih senar berkualitas\n\nMau saya carikan guru biola?',
    'drum': 'Drum bangun sense ritme kuat! 🥁\n\nTips belajar drum:\n• Mulai dengan drum pad\n• Pelajari pola ritme dasar\n• Latihan dengan metronom\n• Fokus kontrol dynamics\n\nMau tahu guru drum terbaik?',
    'vokal': 'Bernyanyi bakat alami! 🎤\n\nTips melatih vokal:\n• Pemanasan vokal dulu\n• Latihan pernapasan diafragma\n• Jangan paksakan suara\n• Tirukan idolamu\n\nMau saya rekomendasikan guru vokal?',
    'saxophone': 'Saxophone sangat ekspresif! 🎷\n\nTips belajar saxophone:\n• Mulai dengan alto sax\n• Latihan embouchure harian\n• Jaga kebersihan alat\n• Pelajari improvisasi dasar\n\nMau tahu guru saxophone?',
    'flute': 'Flute alat yang elegan! 🎵\n\nTips belajar flute:\n• Latihan pernapasan perut\n• Posisi jari yang tepat\n• Kualitas udara stabil\n• Rawat flute dengan baik\n\nMau saya bantu cari guru flute?',
    'harga': 'Perkiraan harga les privat:\n\n🎸 Gitar: Rp100rb - Rp250rb\n🎹 Piano: Rp150rb - Rp400rb\n🎻 Biola: Rp125rb - Rp300rb\n🥁 Drum: Rp125rb - Rp350rb\n🎤 Vokal: Rp100rb - Rp250rb\n🎷 Saxophone: Rp150rb - Rp350rb\n🎵 Flute: Rp100rb - Rp250rb\n\nHarga tergantung pengalaman guru.',
    'pemula': 'Untuk pemula:\n\n1️⃣ Pilih alat yang kamu suka\n2️⃣ Mulai dengan yang affordable\n3️⃣ Cari guru yang sabar\n4️⃣ Latihan rutin 30mnt/hari\n5️⃣ Nikmati proses belajar!\n\nButuh 3-6 bulan untuk basics.',
    'jadwal': 'Pilihan jadwal les musik:\n\n🕐 Pagi (08:00 - 12:00)\n🕐 Siang (12:00 - 17:00)\n🕐 Sore (17:00 - 20:00)\n🕐 Weekend (Sabtu & Minggu)\n\nKamu bisa atur sesuai kebutuhan!',
    'online': 'Perbandingan les online vs offline:\n\n📱 ONLINE\n✓ Fleksibel, dari mana saja\n✓ Lebih terjangkau\n✓ Bisa ulang rekaman\n\n🏠 OFFLINE\n✓ Interaksi langsung\n✓ Koreksi langsung\n✓ Lebih fokus',
    'rekomendasi': 'Saya bantu cari guru terbaik! 🏆\n\nBoleh tahu preferensimu:\n\n• Alat musik yang dipelajari?\n• Level saat ini?\n• Lokasi/areamu?\n• Budget per sesi?\n\nJawab atau pilih pertanyaan cepat!',
    'tips': 'Tips umum belajar musik:\n\n📌 Konsisten - latih setiap hari\n📌 Mulai dari basics\n📌 Gunakan metronom\n📌 Rekam progresso\n📌 Nikmati proses!\n\nAda yang ingin ditanyakan?',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addWelcome();
    });
  }

  void _addWelcome() {
    _messages.add(ChatMessage(
      isUser: false,
      message: 'Halo! 👋\n\nSaya GURUMU, AI Konsultan Go Guru.\n\nSilakan tanyakan tentang:\n• Rekomendasi guru musik\n• Tips belajar alat musik\n• Informasi harga & jadwal\n\nAtau pilih pertanyaan cepat 👇',
    ));
    setState(() {});
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(ChatMessage(isUser: true, message: text));
    setState(() {});
    _messageController.clear();
    _scrollToBottom();

    await Future.delayed(Duration(milliseconds: 500 + (text.length * 5)));

    final response = _getResponse(text);
    _messages.add(ChatMessage(isUser: false, message: response));
    setState(() {});
    _scrollToBottom();
  }

  String _getResponse(String text) {
    final lower = text.toLowerCase();

    for (var entry in _responses.entries) {
      if (lower.contains(entry.key)) {
        return entry.value;
      }
    }

    if (lower.contains('siapa') || lower.contains('nama')) {
      return _responses['rekomendasi']!;
    }

    if (lower.contains(' apa') || lower.contains('?')) {
      return 'Saya bisa bantu dengan:\n\n🎓 Rekomendasi guru musik\n💰 Harga les\n🎯 Tips belajar musik\n📅 Jadwal les\n\nCoba tanyakan lebih spesifik!';
    }

    return 'Terima kasih! 🙏\n\nSilakan tanyakan tentang:\n• Rekomendasi guru musik\n• Tips & trik belajar\n• Harga & jadwal les\n\nAtau pilih pertanyaan cepat 👇';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _onTeacherTap(Teacher teacher) {
    Navigator.pushNamed(context, '/guru-profile', arguments: {
      'name': teacher.name,
      'instrument': teacher.instrument,
      'experience': teacher.experience,
      'institution': teacher.institution,
      'avatar': teacher.avatar,
      'videoUrl': teacher.videoUrl,
      'location': teacher.location,
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildMessages()),
          _buildQuickQuestions(),
          _buildInput(bottomPadding),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: topPadding + 8, left: 16, right: 16, bottom: 12),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF4CAF50)),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.auto_awesome, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Text(
            'GURUMU',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B5E20),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBubble(msg),
            if (!msg.isUser) _buildTeacherSection(),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  Widget _buildBubble(ChatMessage msg) {
    return Row(
      mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!msg.isUser) ...[
          _buildAiAvatar(),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: msg.isUser ? const Color(0xFF4CAF50) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(msg.isUser ? 20 : 4),
                bottomRight: Radius.circular(msg.isUser ? 4 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              msg.message,
              style: TextStyle(
                fontSize: 14,
                color: msg.isUser ? Colors.white : Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ),
        if (msg.isUser) ...[
          const SizedBox(width: 8),
          _buildUserAvatar(),
        ],
      ],
    );
  }

  Widget _buildAiAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.auto_awesome, size: 16, color: Colors.white),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.person, size: 18, color: Colors.grey),
    );
  }

  Widget _buildTeacherSection() {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Guru Rekomendasi',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: GuruService().allTeachers.length,
              itemBuilder: (context, index) {
                final teacher = GuruService().allTeachers[index];
                return _buildTeacherCard(teacher, index == 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherCard(Teacher teacher, bool isTop) {
    return GestureDetector(
      onTap: () => _onTeacherTap(teacher),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: isTop
              ? Border.all(color: const Color(0xFFFFC107).withValues(alpha: 0.5), width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    teacher.avatar,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey[200],
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teacher.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          teacher.instrument,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.location_on, size: 11, color: Colors.grey[500]),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    teacher.location,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 11, color: Colors.grey[500]),
                const SizedBox(width: 2),
                Text(
                  teacher.experience,
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
                if (isTop) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Top',
                      style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickQuestions() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _quickQuestions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _sendMessage(_quickQuestions[index]),
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Text(
                    _quickQuestions[index],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF424242),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInput(double bottomPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 12 + bottomPadding),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(23),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Ketik pertanyaan...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => _sendMessage(_messageController.text),
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(23),
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final bool isUser;
  final String message;

  ChatMessage({required this.isUser, required this.message});
}
