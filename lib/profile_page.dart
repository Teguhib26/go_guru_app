import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'service_locator.dart';
import 'edit_profil_page.dart';
import 'notifikasi_page.dart';
import 'keamanan_page.dart';
import 'metode_pembayaran_page.dart';
import 'pusat_bantuan_page.dart';
import 'tentang_aplikasi_page.dart';
import 'alamat_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';
  String _userEmail = '';
  bool _isGuest = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    setState(() {
      _userName = sl.authService.getUserName() ?? 'Pengguna';
      _userEmail = sl.authService.getUserEmail() ?? '';
      _isGuest = sl.authService.isGuest();
    });
  }

  final List<Map<String, dynamic>> _settingsMenu = [
    {'icon': Icons.location_on_outlined, 'label': 'Alamat'},
    {'icon': Icons.person_outline, 'label': 'Edit Profil'},
    {'icon': Icons.notifications_outlined, 'label': 'Notifikasi'},
    {'icon': Icons.security_outlined, 'label': 'Keamanan'},
    {'icon': Icons.payment_outlined, 'label': 'Metode Pembayaran'},
    {'icon': Icons.help_outline, 'label': 'Pusat Bantuan'},
    {'icon': Icons.info_outline, 'label': 'Tentang Aplikasi'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildProfileCard(),
                _buildStatsSection(),
                _buildSettingsSection(),
                _buildLogoutButton(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF4CAF50),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
      ),
      title: const Text(
        'Profil',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/avatars/avatar1.png',
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF4CAF50),
                          size: 36,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            _userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                        if (!_isGuest) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (!_isGuest && _userEmail.isNotEmpty) ...[
                      Text(
                        _userEmail,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ] else if (_isGuest) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Tamu',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilPage())),
                icon: const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFBDBDBD),
                ),
              ),
            ],
          ),
          if (_isGuest) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange[700], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Anda masuk sebagai tamu',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showLoginPrompt,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Masuk / Daftar Akun',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showLoginPrompt() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Masuk ke Akun'),
        content: const Text('Silakan masuk atau daftar akun untuk menikmati semua fitur aplikasi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Nanti'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
            ),
            child: const Text('Masuk'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    if (_isGuest) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              value: '0',
              label: 'Les',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: const Color(0xFFEEEEEE),
          ),
          Expanded(
            child: _buildStatItem(
              value: '0',
              label: 'Jam',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: const Color(0xFFEEEEEE),
          ),
          Expanded(
            child: _buildStatItem(
              value: '-',
              label: 'Rating',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({required String value, required String label}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(_settingsMenu.length, (index) {
          final item = _settingsMenu[index];
          final isLast = index == _settingsMenu.length - 1;
          return Column(
            children: [
              InkWell(
                onTap: () => _navigateToPage(item['label']),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: const Color(0xFF4CAF50),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          item['label'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFFBDBDBD),
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.only(left: 62),
                  child: Container(
                    height: 1,
                    color: const Color(0xFFEEEEEE),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: () => _showLogoutDialog(),
          style: OutlinedButton.styleFrom(
            foregroundColor: _isGuest ? const Color(0xFF4CAF50) : const Color(0xFFFF5722),
            side: BorderSide(
              color: _isGuest ? const Color(0xFF4CAF50) : const Color(0xFFFF5722),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            _isGuest ? 'Keluar dari Mode Tamu' : 'Keluar',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPage(String label) {
    HapticFeedback.lightImpact();
    switch (label) {
      case 'Alamat':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AlamatPage()));
        break;
      case 'Edit Profil':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilPage()));
        break;
      case 'Notifikasi':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const NotifikasiPage()));
        break;
      case 'Keamanan':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const KeamananPage()));
        break;
      case 'Metode Pembayaran':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MetodePembayaranPage()));
        break;
      case 'Pusat Bantuan':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PusatBantuanPage()));
        break;
      case 'Tentang Aplikasi':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TentangAplikasiPage()));
        break;
    }
  }

  void _showLogoutDialog() {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isGuest ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isGuest ? Icons.person_off : Icons.logout,
                    color: _isGuest ? const Color(0xFF4CAF50) : const Color(0xFFFF5722),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _isGuest ? 'Keluar dari Mode Tamu?' : 'Keluar dari akun?',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isGuest
                      ? 'Anda akan keluar dari mode tamu. Data tidak akan disimpan.'
                      : 'Anda yakin ingin keluar dari akun ini?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _handleLogout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isGuest ? const Color(0xFF4CAF50) : const Color(0xFFFF5722),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _isGuest ? 'Keluar' : 'Keluar',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogout() async {
    if (_isGuest) {
      // Guest logout - just clear guest data
      await sl.authService.logout();
    } else {
      // Regular logout
      await sl.authService.logout();
    }

    if (mounted) {
      _showLogoutSuccess();
      // Navigate back to home
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _showLogoutSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text('Berhasil keluar dari akun'),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
