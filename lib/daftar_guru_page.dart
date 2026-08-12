import 'package:flutter/material.dart';
import '../widgets/syarat_ketentuan_dialog.dart';
import 'guru_service.dart';

class DaftarGuruPage extends StatefulWidget {
  const DaftarGuruPage({super.key});

  @override
  State<DaftarGuruPage> createState() => _DaftarGuruPageState();
}

class _DaftarGuruPageState extends State<DaftarGuruPage> {
  final _namaController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedInstrument;
  String? _selectedTahun;

  final List<String> _instruments = [
    'Gitar',
    'Piano',
    'Biola',
    'Drum',
    'Vokal',
    'Saxophone',
    'Flute',
    'Alat Musik Lainnya',
  ];

  final List<String> _tahunList = [
    '1 Tahun',
    '2 Tahun',
    '3 Tahun',
    '5 Tahun',
    '7 Tahun',
    '10 Tahun',
    '15 Tahun',
    '20+ Tahun',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTermsDialog();
    });
  }

  Future<void> _showTermsDialog() async {
    final result = await SyaratKetentuanDialog.show(context);
    if (result != true && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Full background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF4CAF50),
          ),

          // Top cloud decorations
          Positioned(
            top: 0,
            left: -30,
            child: Container(
              width: 140,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 130,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: topPadding + 8,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),

          // Scrollable content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  // Header Section
                  _buildHeader(topPadding),

                  const SizedBox(height: 40),

                  // Name Input Field
                  _buildInputField(
                    controller: _namaController,
                    hint: 'Masukan nama lengkap anda',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 16),

                  // Username Input Field
                  _buildInputField(
                    controller: _usernameController,
                    hint: 'Masukan username',
                    icon: Icons.alternate_email,
                  ),

                  const SizedBox(height: 16),

                  // Email Input Field
                  _buildInputField(
                    controller: _emailController,
                    hint: 'Masukan email anda',
                    icon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 16),

                  // Password Input Field
                  _buildInputField(
                    controller: _passwordController,
                    hint: 'Masukan password',
                    icon: Icons.lock_outline,
                  ),

                  const SizedBox(height: 16),

                  // Confirm Password Input Field
                  _buildInputField(
                    controller: _confirmPasswordController,
                    hint: 'Konfirmasi password',
                    icon: Icons.lock_outline,
                  ),

                  const SizedBox(height: 20),

                  // Instrument and Tahun dropdowns
                  _buildDropdownRow(),

                  const SizedBox(height: 24),

                  // Upload Section Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upload Dokumen',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Upload Sertifikat
                  _buildUploadSection(
                    title: 'Upload Sertifikat mu',
                    icon: Icons.verified_outlined,
                  ),

                  const SizedBox(height: 12),

                  // Upload CV
                  _buildUploadSection(
                    title: 'Upload CV mu',
                    icon: Icons.description_outlined,
                  ),

                  const SizedBox(height: 12),

                  // Upload KTP
                  _buildUploadSection(
                    title: 'Upload KTP',
                    icon: Icons.badge_outlined,
                  ),

                  const SizedBox(height: 12),

                  // Upload Video Portofolio
                  _buildVideoUploadSection(),

                  const SizedBox(height: 32),

                  // Daftar Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _handleDaftar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8F5E9),
                        foregroundColor: const Color(0xFF4CAF50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Bottom cloud decoration - fixed at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomClouds(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double topPadding) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding + 20),
      child: const Center(
        child: Column(
          children: [
            Text(
              'DAFTAR GURU',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final halfWidth = (constraints.maxWidth - 12) / 2;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: halfWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instrument',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildDropdown(
                    value: _selectedInstrument,
                    items: _instruments,
                    onChanged: (value) {
                      setState(() {
                        _selectedInstrument = value;
                      });
                    },
                    hint: 'Pilih',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: halfWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tahun',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildDropdown(
                    value: _selectedTahun,
                    items: _tahunList,
                    onChanged: (value) {
                      setState(() {
                        _selectedTahun = value;
                      });
                    },
                    hint: 'Pilih',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF4CAF50),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          isDense: true,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey[600],
          size: 18,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildUploadSection({
    required String title,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle upload action
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload untuk: $title'),
            backgroundColor: Colors.white.withValues(alpha: 0.9),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Pilih File',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoUploadSection() {
    return GestureDetector(
      onTap: () {
        // Handle video upload action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Upload Video Portofolio'),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Play button icon container
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Upload Video Portofolio mu',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Upload videomu disini',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomClouds() {
    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom cloud - left
          Positioned(
            bottom: 0,
            left: -30,
            child: Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
            ),
          ),
          // Bottom cloud - right
          Positioned(
            bottom: 0,
            right: -40,
            child: Container(
              width: 130,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(65),
                  topRight: Radius.circular(65),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleDaftar() {
    if (_namaController.text.isEmpty || _selectedInstrument == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi data terlebih dahulu'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Register guru
    GuruService().registerGuru(
      name: _namaController.text,
      instrument: _selectedInstrument!,
      experience: _selectedTahun ?? '0 Tahun',
    );

    // Navigate to verifikasi tunggu page with guru data
    Navigator.pushReplacementNamed(
      context,
      '/verifikasi-tunggu',
      arguments: {
        'guruName': _namaController.text,
        'instrument': _selectedInstrument,
      },
    );
  }
}
