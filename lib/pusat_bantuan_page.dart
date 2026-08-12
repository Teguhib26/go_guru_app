import 'package:flutter/material.dart';

class PusatBantuanPage extends StatefulWidget {
  const PusatBantuanPage({super.key});

  @override
  State<PusatBantuanPage> createState() => _PusatBantuanPageState();
}

class _PusatBantuanPageState extends State<PusatBantuanPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';

  final List<Map<String, dynamic>> _faqCategories = [
    {'id': 'all', 'name': 'Semua', 'icon': Icons.apps},
    {'id': 'account', 'name': 'Akun', 'icon': Icons.person_outline},
    {'id': 'lesson', 'name': 'Les', 'icon': Icons.music_note},
    {'id': 'payment', 'name': 'Pembayaran', 'icon': Icons.payment},
    {'id': 'technical', 'name': 'Teknis', 'icon': Icons.build_outlined},
  ];

  final List<Map<String, dynamic>> _faqs = [
    {
      'category': 'account',
      'question': 'Bagaimana cara mengubah kata sandi?',
      'answer': 'Anda dapat mengubah kata sandi melalui menu Pengaturan > Keamanan > Ubah Password. Pastikan kata sandi baru memiliki minimal 8 karakter.',
    },
    {
      'category': 'account',
      'question': 'Bagaimana cara memperbarui profil?',
      'answer': 'Untuk memperbarui profil, pergi ke menu Profil dan pilih "Edit Profil". Anda dapat mengubah nama, foto, dan informasi lainnya.',
    },
    {
      'category': 'lesson',
      'question': 'Bagaimana cara memesan les?',
      'answer': '1. Pilih guru yang Anda inginkan\n2. Klik tombol "Booking"\n3. Pilih tingkat kemampuan, hari, dan jamles\n4. Konfirmasi pemesanan\n5. Lakukan pembayaran',
    },
    {
      'category': 'lesson',
      'question': 'Bagaimana jika guru membatalkanles?',
      'answer': 'Jika guru membatalkanles, Anda akan mendapat pemberitahuan dan dana akan dikembalikan penuh ke akun Anda.',
    },
    {
      'category': 'payment',
      'question': 'Metode pembayaran apa saja yangtersedia?',
      'answer': 'Kami menerima Transfer Bank (BCA, Mandiri, BRI, BNI), E-Wallet (GoPay, OVO, Dana, ShopeePay), dan Kartu Kredit.',
    },
    {
      'category': 'payment',
      'question': 'Bagaimana cara meminta refund?',
      'answer': 'Pengajuan refund dapat melalui menu Riwayat > Pilih sesi > Ajukan Refund. Refund akan diproses dalam 1-3 hari kerja.',
    },
    {
      'category': 'technical',
      'question': 'Aplikasi tidak bisa dibuka怎么办?',
      'answer': 'Coba langkah berikut:\n1. Restart HP Anda\n2. Update aplikasi ke versi terbaru\n3. Hapus cache aplikasi\n4. Install ulang jika perlu',
    },
    {
      'category': 'technical',
      'question': 'Tidak menerima notifikasi?',
      'answer': 'Pastikan notifikasi aplikasi diaktifkan di pengaturan HP Anda. Cek juga menu Notifikasi di aplikasi GO GURU.',
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {'icon': Icons.chat_outlined, 'label': 'Chat dengan Kami', 'color': Color(0xFF4CAF50)},
    {'icon': Icons.email_outlined, 'label': 'Email Kami', 'color': Color(0xFF2196F3)},
    {'icon': Icons.phone_outlined, 'label': 'Telepon', 'color': Color(0xFFFF9800)},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredFaqs {
    if (_selectedCategory == 'all') {
      return _faqs;
    }
    return _faqs.where((faq) => faq['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchSection(),
                    _buildQuickActions(),
                    _buildCategorySection(),
                    _buildFaqSection(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF4CAF50),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                ),
                const Expanded(
                  child: Text(
                    'Pusat Bantuan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cari pertanyaan...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hubungi Kami',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(_quickActions.length, (index) {
              final action = _quickActions[index];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fitur chat segera hadir!')),
                      );
                    } else if (index == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email: help@goguru.id')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Telepon: 021-1234-5678')),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: index < _quickActions.length - 1 ? 8 : 0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (action['color'] as Color).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            action['icon'] as IconData,
                            color: action['color'] as Color,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          action['label'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Text(
            'Kategori',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _faqCategories.length,
            itemBuilder: (context, index) {
              final category = _faqCategories[index];
              final isSelected = _selectedCategory == category['id'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category['id'] as String;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4CAF50) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF4CAF50) : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        size: 16,
                        color: isSelected ? Colors.white : Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        category['name'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFaqSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pertanyaan yang Sering Diajukan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(_filteredFaqs.length, (index) {
            return _buildFaqItem(_filteredFaqs[index]);
          }),
        ],
      ),
    );
  }

  Widget _buildFaqItem(Map<String, dynamic> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Text(
          faq['question'] as String,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        iconColor: const Color(0xFF4CAF50),
        children: [
          Text(
            faq['answer'] as String,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
