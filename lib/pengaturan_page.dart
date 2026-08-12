import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bahasa_page.dart';
import 'keamanan_page.dart';
import 'pusat_bantuan_page.dart';
import 'tentang_aplikasi_page.dart';
import 'hubungi_kami_page.dart';
import 'beri_rating_page.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _locationEnabled = true;

  final List<Map<String, dynamic>> _settingsSections = [
    {
      'title': 'Preferensi',
      'items': [
        {'icon': Icons.notifications_outlined, 'label': 'Notifikasi', 'type': 'switch', 'key': 'notifications'},
        {'icon': Icons.dark_mode_outlined, 'label': 'Mode Gelap', 'type': 'switch', 'key': 'darkMode'},
        {'icon': Icons.volume_up_outlined, 'label': 'Suara', 'type': 'switch', 'key': 'sound'},
        {'icon': Icons.vibration_outlined, 'label': 'Getaran', 'type': 'switch', 'key': 'vibration'},
      ],
    },
    {
      'title': 'Privasi & Keamanan',
      'items': [
        {'icon': Icons.lock_outlined, 'label': 'Ubah Password', 'type': 'navigate'},
        {'icon': Icons.fingerprint, 'label': 'Sidik Jari', 'type': 'switch', 'key': 'fingerprint'},
        {'icon': Icons.privacy_tip_outlined, 'label': 'Kebijakan Privasi', 'type': 'navigate'},
      ],
    },
    {
      'title': 'Tampilan',
      'items': [
        {'icon': Icons.language, 'label': 'Bahasa', 'type': 'value', 'value': 'Indonesia'},
        {'icon': Icons.location_on_outlined, 'label': 'Lokasi', 'type': 'switch', 'key': 'location'},
      ],
    },
    {
      'title': 'Dukungan',
      'items': [
        {'icon': Icons.help_outline, 'label': 'Pusat Bantuan', 'type': 'navigate'},
        {'icon': Icons.chat_bubble_outline, 'label': 'Hubungi Kami', 'type': 'navigate'},
        {'icon': Icons.star_outline, 'label': 'Beri Rating', 'type': 'navigate'},
      ],
    },
    {
      'title': 'Tentang',
      'items': [
        {'icon': Icons.info_outline, 'label': 'Tentang Aplikasi', 'type': 'navigate'},
        {'icon': Icons.description_outlined, 'label': 'Syarat & Ketentuan', 'type': 'navigate'},
        {'icon': Icons.new_releases_outlined, 'label': 'Versi Aplikasi', 'type': 'value', 'value': '1.0.0'},
      ],
    },
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
                const SizedBox(height: 16),
                ..._buildAllSections(),
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
        'Pengaturan',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }

  List<Widget> _buildAllSections() {
    List<Widget> widgets = [];
    for (var section in _settingsSections) {
      widgets.add(_buildSection(section));
    }
    return widgets;
  }

  Widget _buildSection(Map<String, dynamic> section) {
    final title = section['title'] as String;
    final items = section['items'] as List<Map<String, dynamic>>;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4CAF50),
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...List.generate(items.length, (index) {
            final item = items[index];
            final isLast = index == items.length - 1;
            return Column(
              children: [
                _buildSettingsItem(item),
                if (!isLast)
                  Padding(
                    padding: const EdgeInsets.only(left: 56),
                    child: Container(
                      height: 1,
                      color: const Color(0xFFEEEEEE),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(Map<String, dynamic> item) {
    final icon = item['icon'] as IconData;
    final label = item['label'] as String;
    final type = item['type'] as String;

    return InkWell(
      onTap: type == 'navigate' ? () => _handleNavigate(label) : null,
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
                icon,
                color: const Color(0xFF4CAF50),
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
            _buildTrailingWidget(type, item),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailingWidget(String type, Map<String, dynamic> item) {
    switch (type) {
      case 'switch':
        return Switch.adaptive(
          value: _getSwitchValue(item['key'] as String),
          onChanged: (value) => _handleSwitch(item['key'] as String, value),
          activeTrackColor: const Color(0xFF4CAF50),
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return Colors.grey;
          }),
        );
      case 'value':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 22,
            ),
          ],
        );
      case 'navigate':
        return Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
          size: 22,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  bool _getSwitchValue(String key) {
    switch (key) {
      case 'notifications':
        return _notificationsEnabled;
      case 'darkMode':
        return _darkModeEnabled;
      case 'sound':
        return _soundEnabled;
      case 'vibration':
        return _vibrationEnabled;
      case 'location':
        return _locationEnabled;
      case 'fingerprint':
        return false;
      default:
        return false;
    }
  }

  void _handleSwitch(String key, bool value) {
    HapticFeedback.lightImpact();
    setState(() {
      switch (key) {
        case 'notifications':
          _notificationsEnabled = value;
          break;
        case 'darkMode':
          _darkModeEnabled = value;
          _showSnackBar(value ? 'Mode gelap diaktifkan' : 'Mode gelap nonaktif');
          break;
        case 'sound':
          _soundEnabled = value;
          break;
        case 'vibration':
          _vibrationEnabled = value;
          break;
        case 'location':
          _locationEnabled = value;
          _showSnackBar(value ? 'Lokasi diaktifkan' : 'Lokasi nonaktif');
          break;
      }
    });
  }

  void _handleNavigate(String label) {
    HapticFeedback.lightImpact();
    switch (label) {
      case 'Bahasa':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const BahasaPage()));
        break;
      case 'Ubah Password':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const KeamananPage()));
        break;
      case 'Kebijakan Privasi':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TentangAplikasiPage()));
        break;
      case 'Pusat Bantuan':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PusatBantuanPage()));
        break;
      case 'Hubungi Kami':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HubungiKamiPage()));
        break;
      case 'Beri Rating':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const BeriRatingPage()));
        break;
      case 'Tentang Aplikasi':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TentangAplikasiPage()));
        break;
      case 'Syarat & Ketentuan':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TentangAplikasiPage()));
        break;
      default:
        _showComingSoon(label);
    }
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Segera hadir!'),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
