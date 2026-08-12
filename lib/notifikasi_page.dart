import 'package:flutter/material.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _lessonReminders = true;
  bool _promoNotifications = false;
  bool _chatNotifications = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Notifikasi Umum'),
                    const SizedBox(height: 12),
                    _buildNotificationToggle(
                      title: 'Notifikasi Push',
                      subtitle: 'Terima notifikasi di perangkat',
                      value: _pushNotifications,
                      onChanged: (v) => setState(() => _pushNotifications = v),
                    ),
                    _buildNotificationToggle(
                      title: 'Notifikasi Email',
                      subtitle: 'Kirim pembaruan ke email',
                      value: _emailNotifications,
                      onChanged: (v) => setState(() => _emailNotifications = v),
                    ),
                    _buildNotificationToggle(
                      title: 'Notifikasi SMS',
                      subtitle: 'Terima pesan teks',
                      value: _smsNotifications,
                      onChanged: (v) => setState(() => _smsNotifications = v),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Jenis Notifikasi'),
                    const SizedBox(height: 12),
                    _buildNotificationToggle(
                      title: 'Pengingat Les',
                      subtitle: 'Notifikasi sebelum les dimulai',
                      value: _lessonReminders,
                      onChanged: (v) => setState(() => _lessonReminders = v),
                    ),
                    _buildNotificationToggle(
                      title: 'Promo & Diskon',
                      subtitle: 'Tawaran khusus dan promo menarik',
                      value: _promoNotifications,
                      onChanged: (v) => setState(() => _promoNotifications = v),
                    ),
                    _buildNotificationToggle(
                      title: 'Notifikasi Chat',
                      subtitle: 'Pesan baru dari guru atau murid',
                      value: _chatNotifications,
                      onChanged: (v) => setState(() => _chatNotifications = v),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Preferensi Suara'),
                    const SizedBox(height: 12),
                    _buildNotificationToggle(
                      title: 'Suara',
                      subtitle: 'Mainkan suara notifikasi',
                      value: _soundEnabled,
                      onChanged: (v) => setState(() => _soundEnabled = v),
                    ),
                    _buildNotificationToggle(
                      title: 'Getaran',
                      subtitle: 'Getar saat ada notifikasi',
                      value: _vibrationEnabled,
                      onChanged: (v) => setState(() => _vibrationEnabled = v),
                    ),
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
                    'Notifikasi',
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildNotificationToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF4CAF50).withValues(alpha: 0.5),
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFF4CAF50);
              }
              return Colors.grey;
            }),
          ),
        ],
      ),
    );
  }
}
