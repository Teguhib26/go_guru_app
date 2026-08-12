import 'package:flutter/material.dart';
import 'guru_service.dart';
import 'guru_tracking_page.dart';

class GuruRiwayatPage extends StatefulWidget {
  const GuruRiwayatPage({super.key});

  @override
  State<GuruRiwayatPage> createState() => _GuruRiwayatPageState();
}

class _GuruRiwayatPageState extends State<GuruRiwayatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _allSessions = [
    {
      'studentName': 'Andi Pratama',
      'instrument': 'Gitar',
      'avatar': 'assets/avatar-gen370480c24b85cd4efb553f0a452c88f2.jpg',
      'tanggal': '10 Ags 2026',
      'waktu': '14:00 - 15:00',
      'status': 'completed',
      'progress': 1.0,
      'rating': 5,
      'catatan': 'Sesi ke-8, progres baik',
    },
    {
      'studentName': 'Siti Nurhaliza',
      'instrument': 'Piano',
      'avatar': 'assets/avatar-gen5286f0751632aa2cae58627e6686270f.jpg',
      'tanggal': '09 Ags 2026',
      'waktu': '10:00 - 11:00',
      'status': 'completed',
      'progress': 0.75,
      'rating': 4,
      'catatan': 'Sesi ke-6, menguasai not balok',
    },
    {
      'studentName': 'Budi Santoso',
      'instrument': 'Drum',
      'avatar': 'assets/avatar-gen370480c24b85cd4efb553f0a452c88f2.jpg',
      'tanggal': '11 Ags 2026',
      'waktu': '15:30 - 16:30',
      'status': 'ongoing',
      'progress': 0.5,
      'rating': 0,
      'catatan': 'Sesi ke-4, latihan beat dasar',
    },
    {
      'studentName': 'Dewi Lestari',
      'instrument': 'Vokal',
      'avatar': 'assets/avatar-gen5286f0751632aa2cae58627e6686270f.jpg',
      'tanggal': '12 Ags 2026',
      'waktu': '09:00 - 10:00',
      'status': 'upcoming',
      'progress': 0.0,
      'rating': 0,
      'catatan': 'Sesi pertama',
    },
    {
      'studentName': 'Rizky Ramadhan',
      'instrument': 'Gitar',
      'avatar': 'assets/avatar-gen370480c24b85cd4efb553f0a452c88f2.jpg',
      'tanggal': '13 Ags 2026',
      'waktu': '16:00 - 17:00',
      'status': 'upcoming',
      'progress': 0.0,
      'rating': 0,
      'catatan': 'Sesi ke-2',
    },
    {
      'studentName': 'Maya Putri',
      'instrument': 'Biola',
      'avatar': 'assets/avatar-gen5286f0751632aa2cae58627e6686270f.jpg',
      'tanggal': '05 Ags 2026',
      'waktu': '11:00 - 12:00',
      'status': 'cancelled',
      'progress': 0.25,
      'rating': 0,
      'catatan': 'Murid cancel karena sakit',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredSessions(String status) {
    if (status == 'all') return _allSessions;
    return _allSessions.where((s) => s['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          _buildHeader(),
          _buildTabs(),
          Expanded(
            child: SafeArea(
              top: false,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSessionList(_getFilteredSessions('all')),
                  _buildSessionList(_getFilteredSessions('ongoing')),
                  _buildSessionList(_getFilteredSessions('upcoming')),
                  _buildSessionList(_getFilteredSessions('completed')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final guruName = GuruService().currentGuru?.name ?? 'Guru';

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF4CAF50),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Riwayat Mengajar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            guruName,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF4CAF50),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF4CAF50),
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        tabs: const [
          Tab(text: 'Semua'),
          Tab(text: 'Berlangsung'),
          Tab(text: 'Mendatang'),
          Tab(text: 'Selesai'),
        ],
      ),
    );
  }

  Widget _buildSessionList(List<Map<String, dynamic>> sessions) {
    if (sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada sesi',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        return _buildSessionCard(sessions[index]);
      },
    );
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
    final statusColor = session['status'] == 'completed'
        ? const Color(0xFF4CAF50)
        : session['status'] == 'ongoing'
            ? const Color(0xFF2196F3)
            : session['status'] == 'upcoming'
                ? const Color(0xFFFF9800)
                : Colors.red;

    final statusText = session['status'] == 'completed'
        ? 'Selesai'
        : session['status'] == 'ongoing'
            ? 'Berlangsung'
            : session['status'] == 'upcoming'
                ? 'Mendatang'
                : 'Dibatalkan';

    return GestureDetector(
      onTap: () {
        if (session['status'] == 'ongoing' || session['status'] == 'upcoming') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuruTrackingPage(
                studentName: session['studentName'],
                instrument: session['instrument'],
                studentAvatar: session['avatar'],
                address: 'Jl. Sudirman No. 123, Jakarta',
                distanceKm: 2.5,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xFFE8F5E9),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        session['avatar'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            color: Color(0xFF4CAF50),
                            size: 28,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session['studentName'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                session['instrument'],
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF4CAF50),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              session['tanggal'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (session['status'] != 'cancelled') ...[
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress Pengajaran',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          '${(session['progress'] * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: session['progress'],
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    session['waktu'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (session['status'] == 'completed' && session['rating'] > 0) ...[
                    const SizedBox(width: 16),
                    ...List.generate(5, (index) {
                      return Icon(
                        index < session['rating']
                            ? Icons.star
                            : Icons.star_border,
                        size: 14,
                        color: const Color(0xFFFFB300),
                      );
                    }),
                  ],
                ],
              ),
            ),
            if (session['catatan'].isNotEmpty)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.notes,
                      size: 14,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        session['catatan'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
