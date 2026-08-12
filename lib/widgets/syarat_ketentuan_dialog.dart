import 'package:flutter/material.dart';

class SyaratKetentuanDialog extends StatefulWidget {
  const SyaratKetentuanDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (context) => const SyaratKetentuanDialog(),
    );
  }

  @override
  State<SyaratKetentuanDialog> createState() => _SyaratKetentuanDialogState();
}

class _SyaratKetentuanDialogState extends State<SyaratKetentuanDialog> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_hasScrolledToBottom && _scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 20) {
        setState(() {
          _hasScrolledToBottom = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.88),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Flexible(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: '1. Definisi',
                      items: const [
                        ('Go Guru', 'Platform digital yang menghubungkan penyedia jasa pengajaran dengan pengguna yang membutuhkan jasa pengajaran.'),
                        ('Mitra Guru', 'Pengguna terdaftar yang telah lolos verifikasi untuk menyediakan jasa pengajaran independen melalui platform Go Guru.'),
                        ('Pengguna Jasa', 'Pengguna terdaftar (siswa atau wali/orang tua siswa) yang menggunakan aplikasi untuk memesan layanan dari Mitra Guru.'),
                        ('Layanan', 'Sesi pengajaran atau bimbingan belajar yang disepakati antara Mitra Guru dan Pengguna Jasa melalui platform Go Guru.'),
                      ],
                    ),
                    _buildSection(
                      title: '2. Keaslian Data dan Verifikasi Registrasi',
                      items: const [
                        ('', 'Seluruh Pengguna (Mitra Guru dan Pengguna Jasa) wajib memberikan data pribadi yang valid, akurat, dan dapat dipertanggungjawabkan secara hukum pada saat registrasi (termasuk KTP, ijazah, atau dokumen pendukung lainnya).'),
                        ('', 'Go Guru berhak melakukan uji kelayakan (background check) terhadap dokumen, kualifikasi akademik, dan rekam jejak kriminal Mitra Guru.'),
                        ('', 'Pemalsuan identitas, kredensial akademik, atau informasi apa pun merupakan pelanggaran hukum berat. Go Guru berhak melakukan pemblokiran akun secara sepihak dan meneruskan kasus tersebut kepada pihak berwajib.'),
                        ('', 'Pengguna bertanggung jawab penuh atas kerahasiaan kata sandi dan keamanan akun masing-masing.'),
                      ],
                    ),
                    _buildSection(
                      title: '3. Keamanan, Keselamatan, dan Tata Tertib',
                      items: const [
                        ('Bagi Pengguna Jasa:', 'Anda wajib memastikan lokasi belajar (jika dilakukan secara tatap muka/offline) berada di lingkungan yang aman, kondusif, dan tidak melanggar norma kesusilaan atau hukum yang berlaku di Indonesia.'),
                        ('Bagi Mitra Guru:', 'Anda wajib bersikap profesional, berpakaian sopan, dan dilarang keras melakukan tindakan kekerasan (fisik maupun verbal), pelecehan, atau tindakan diskriminatif lainnya selama Layanan berlangsung.'),
                        ('', 'Go Guru menyediakan fitur "Lapor/Darurat" di dalam aplikasi. Setiap indikasi tindak kejahatan atau pelanggaran kode etik akan diproses secara tegas, termasuk pemberian sanksi administratif hingga pelaporan ke kepolisian.'),
                        ('', 'Untuk pengguna jasa di bawah umur (di bawah 18 tahun), sesi pembelajaran wajib diawasi oleh orang tua atau wali yang sah.'),
                      ],
                    ),
                    _buildSection(
                      title: '4. Pemesanan, Penjadwalan, dan Pembayaran',
                      items: const [
                        ('', 'Proses pemesanan, penjadwalan, dan penentuan durasi belajar dilakukan sepenuhnya melalui sistem aplikasi Go Guru.'),
                        ('', 'Pembayaran jasa hanya sah jika dilakukan melalui saluran pembayaran resmi (payment gateway) yang tersedia di dalam aplikasi Go Guru.'),
                        ('', 'Go Guru tidak bertanggung jawab atas kerugian finansial yang timbul akibat transaksi yang dilakukan di luar platform Go Guru.'),
                        ('', 'Kebijakan pembatalan jadwal oleh salah satu pihak akan dikenakan penyesuaian dana (refund/penalty) sesuai dengan ketentuan yang tertera pada halaman Kebijakan Pembatalan aplikasi.'),
                      ],
                    ),
                    _buildSection(
                      title: '5. Benefit dan Fasilitas Pengguna',
                      items: const [
                        ('Benefit Mitra Guru:', 'Akses ke pasar siswa yang luas, fleksibilitas dalam mengatur jadwal dan tarif mengajar, perlindungan sistem pembayaran yang transparan, serta sistem rating yang objektif untuk membangun reputasi profesional.'),
                        ('Benefit Pengguna Jasa:', 'Aksesibilitas mencari guru yang kredibel dan terverifikasi, transparansi harga, kepastian jadwal, serta jaminan penggantian guru apabila Mitra Guru gagal memenuhi standar pelayanan platform.'),
                      ],
                    ),
                    _buildDisclaimerSection(),
                    _buildDisputeSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.article_outlined,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Syarat dan Ketentuan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Penggunaan Aplikasi Go Guru',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.grey[600],
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFFFECB3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Color(0xFFF9A825),
                  size: 15,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Silakan baca dan pahami seluruh syarat dan ketentuan sebelum melanjutkan.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.brown[600],
                      height: 1.3,
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

  Widget _buildSection({
    required String title,
    required List<(String, String)> items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF81C784),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: item.$1.isEmpty
                        ? Text(
                            item.$2,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF424242),
                              height: 1.55,
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF424242),
                                height: 1.55,
                              ),
                              children: [
                                TextSpan(
                                  text: item.$1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                                TextSpan(text: item.$2),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDisclaimerSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'PENYANGKALAN & PEMBATASAN TANGGUNG JAWAB',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildDisclaimerItem(
              'Status Kemitraan',
              'Go Guru adalah perusahaan penyedia platform teknologi. Kami bukan institusi pendidikan, sekolah, atau lembaga penyedia tenaga kerja.\n\nHubungan antara Go Guru dan Mitra Guru adalah hubungan kemitraan independen (independent contractor), bukan hubungan kerja.',
            ),
            const SizedBox(height: 8),
            _buildDisclaimerItem(
              'Jaminan Hasil Akademik',
              'Go Guru tidak memberikan jaminan bahwa penggunaan Layanan akan menghasilkan pencapaian nilai akademik tertentu.\n\nHasil dari proses pembelajaran sangat bergantung pada komitmen, kapasitas individu siswa, dan sinergi dengan Mitra Guru.',
            ),
            const SizedBox(height: 8),
            _buildDisclaimerItem(
              'Batasan Tanggung Jawab',
              'Segala interaksi tatap muka di luar pengawasan sistem aplikasi berada di luar kendali langsung Go Guru.\n\nGo Guru dibebaskan dari segala tuntutan hukum, klaim kerugian, atau kerusakan yang terjadi selama sesi pengajaran, kecuali dapat dibuktikan kelalaian fatal pada sistem aplikasi Kami.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimerItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF37474F),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          content,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF616161),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildDisputeSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFA5D6A7),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.balance_outlined,
                  color: Color(0xFF2E7D32),
                  size: 14,
                ),
                SizedBox(width: 5),
                Text(
                  'PENYELESAIAN SENGKETA',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            const Text(
              'Segala perselisihan yang timbul sehubungan dengan penggunaan aplikasi Go Guru akan diselesaikan terlebih dahulu melalui jalur musyawarah untuk mufakat (Mediasi Internal).\n\nApabila mufakat tidak tercapai dalam waktu 30 (tiga puluh) hari kalender, maka para pihak sepakat untuk menyelesaikan sengketa tersebut melalui yurisdiksi Pengadilan Negeri di wilayah kantor pusat PT Go Guru Indonesia, dengan tetap mengacu pada Hukum Negara Kesatuan Republik Indonesia.',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF2E7D32),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_hasScrolledToBottom)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_downward,
                    size: 14,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Scroll ke bawah untuk membaca seluruh ketentuan',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4CAF50),
                    side: const BorderSide(color: Color(0xFF81C784), width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed: _hasScrolledToBottom
                        ? () => Navigator.of(context).pop(true)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _hasScrolledToBottom
                          ? const Color(0xFF4CAF50)
                          : Colors.grey[300],
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      disabledForegroundColor: Colors.grey[600],
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_hasScrolledToBottom) ...[
                          const Icon(Icons.check_circle, size: 16),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          _hasScrolledToBottom ? 'Saya Setuju' : 'Baca Ketentuan',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
