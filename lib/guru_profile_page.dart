import 'package:flutter/material.dart';

class GuruProfilePage extends StatelessWidget {
  final String? name;
  final String? instrument;
  final String? experience;
  final String? institution;
  final String? avatar;
  final String? videoUrl;
  final String? location;

  const GuruProfilePage({
    super.key,
    this.name,
    this.instrument,
    this.experience,
    this.institution,
    this.avatar,
    this.videoUrl,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        title: Text(name ?? 'Profil Guru'),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Profil Guru'),
      ),
    );
  }
}
