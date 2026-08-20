import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'login_popup.dart';
import 'daftar_murid_page.dart';
import 'daftar_guru_page.dart';
import 'guru_list_page.dart';
import 'guru_view_profile_page.dart';
import 'guru_service.dart';
import 'guru_riwayat_page.dart';
import 'guru_chat_page.dart';
import 'guru_pengaturan_page.dart';
import 'guru_profile_page.dart';
import 'riwayat_page.dart';
import 'profile_page.dart';
import 'pengaturan_page.dart';
import 'banner_data.dart';
import 'ai_konsultan_page.dart';
import 'verifikasi_page.dart';
import 'verifikasi_tunggu_page.dart';
import 'home_guru_page.dart';
import 'invoice_page.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const GoGuruApp(),
    ),
  );
}

class GoGuruApp extends StatelessWidget {
  const GoGuruApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GO GURU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
      routes: {
        '/ai-konsultan': (context) => const AiKonsultanPage(),
        '/verifikasi': (context) => const VerifikasiPage(),
        '/home-guru': (context) => const HomeGuruPage(),
        '/guru-profile': (context) => const GuruProfilePage(),
        '/guru-riwayat': (context) => const GuruRiwayatPage(),
        '/guru-chat': (context) => const GuruChatPage(),
        '/guru-pengaturan': (context) => const GuruPengaturanPage(),
        '/verifikasi-tunggu': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return VerifikasiTungguPage(
            guruName: args?['guruName'] ?? 'Guru Baru',
            instrument: args?['instrument'] ?? '',
          );
        },
        '/daftar-murid': (context) => const DaftarMuridPage(),
        '/daftar-guru': (context) => const DaftarGuruPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _bannerPageController = PageController();
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _showLoginPopup();
  }

  void _showLoginPopup() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      LoginPopup.show(context);
    });
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      if (_bannerPageController.hasClients) {
        final nextIndex = (_currentBannerIndex + 1) % bannerSlides.length;
        _bannerPageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentBannerIndex = nextIndex;
        });
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _bannerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              _buildHeader(),

              // Search Bar
              _buildSearchBar(),

              // Banner Section
              _buildBannerSection(),

              // Instrument Categories
              _buildInstrumentCategories(),

              // Action Buttons
              _buildActionButtons(),

              // Teacher Profiles
              _buildTeacherProfiles(),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: const Text(
        'GO GURU',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4CAF50),
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari apapun di GO GURU',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 9),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
              child: const Icon(
                Icons.search,
                color: Color(0xFF388E3C),
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          // Carousel
          SizedBox(
            height: 100,
            child: PageView.builder(
              controller: _bannerPageController,
              onPageChanged: (index) {
                setState(() {
                  _currentBannerIndex = index;
                });
              },
              itemCount: bannerSlides.length,
              itemBuilder: (context, index) {
                final banner = bannerSlides[index];
                return GestureDetector(
                  onTap: banner.onTap,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(banner.backgroundImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.black.withValues(alpha: 0.0),
                                Colors.black.withValues(alpha: 0.5),
                              ],
                            ),
                          ),
                        ),
                        // Banner text content
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Tag
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green[600],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  banner.tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Title
                              Text(
                                banner.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              // Subtitle
                              Text(
                                banner.subtitle,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 2),
                              // Date and Time
                              if (banner.date.isNotEmpty)
                                Row(
                                  children: [
                                    if (banner.date.isNotEmpty) ...[
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.white70,
                                        size: 10,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        banner.date,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                    if (banner.time.isNotEmpty) ...[
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.access_time,
                                        color: Colors.white70,
                                        size: 10,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        banner.time,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          // Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              bannerSlides.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentBannerIndex == index ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentBannerIndex == index
                      ? const Color(0xFF4CAF50)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstrumentCategories() {
    final instruments = [
      {'name': 'Gitar', 'icon': 'assets/8332396.png', 'filter': 'Gitar'},
      {'name': 'Piano', 'icon': 'assets/5849428.png', 'filter': 'Piano'},
      {'name': 'Biola', 'icon': 'assets/836941.png', 'filter': 'Biola'},
      {'name': 'Drum', 'icon': 'assets/683940.png', 'filter': 'Drum'},
      {'name': 'Vokal', 'icon': 'assets/3890930.png', 'filter': 'Vokal'},
      {'name': 'Saxophone', 'icon': 'assets/4521285.png', 'filter': 'Saxophone'},
      {'name': 'Flute', 'icon': 'assets/8939364.png', 'filter': 'Flute'},
      {
        'name': 'Alat Musik\nLainnya',
        'icon': 'assets/3429255.png',
        'filter': 'Alat Musik Lainnya'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Kategori Alat Musik',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.90,
              crossAxisSpacing: 4,
              mainAxisSpacing: 1,
            ),
            itemCount: instruments.length,
            itemBuilder: (context, index) {
              final item = instruments[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuruListPage(
                        instrument: item['filter']!,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF81C784),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          item['icon']!,
                          width: 38,
                          height: 38,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Builder(
        builder: (context) => Row(
          children: [
            // Daftar Murid Button (Outlined)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarMuridPage(),
                    ),
                  );
                },
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFF4CAF50),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.school_outlined,
                        color: Color(0xFF4CAF50),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Daftar Murid',
                        style: TextStyle(
                          color: Color(0xFF4CAF50),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          // Daftar Guru Button (Filled)
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DaftarGuruPage(),
                  ),
                );
              },
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_add,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Daftar Guru',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildTeacherProfiles() {
    final teachers = GuruService().allTeachers;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              'Guru Pilihan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          // Grid 2 columns for teachers
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              final teacher = teachers[index];
              return Builder(
                builder: (cardContext) => _buildTeacherCardGrid(
                  name: teacher.name,
                  instrument: teacher.instrument,
                  experience: teacher.experience,
                  institution: teacher.institution,
                  avatar: teacher.avatar,
                  videoUrl: teacher.videoUrl,
                  location: teacher.location,
                  cardContext: cardContext,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherCardGrid({
    required String name,
    required String instrument,
    required String experience,
    required String institution,
    required String avatar,
    required String videoUrl,
    required String location,
    required BuildContext cardContext,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          cardContext,
          MaterialPageRoute(
            builder: (context) => GuruViewProfilePage(
              name: name,
              instrument: instrument,
              experience: experience,
              institution: institution,
              avatar: avatar,
              videoUrl: videoUrl,
              location: location,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Avatar - Square, filling the card width
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Instrument Tag
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                instrument,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Institution
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.business,
                  size: 12,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    institution,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Experience
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 12,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  experience,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  size: 12,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Beranda - Active
          _buildNavItem(
            icon: 'assets/25694.png',
            label: 'Beranda',
            isActive: true,
          ),
          // Riwayat
          Builder(
            builder: (ctx) => _buildNavItem(
              icon: 'assets/169244.png',
              label: 'Riwayat',
              isActive: false,
              onTap: () {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (context) => const RiwayatPage(),
                  ),
                );
              },
            ),
          ),
          // Center - AI Konsultan
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(ctx, '/ai-konsultan');
              },
              child: Transform.translate(
                offset: const Offset(0, -16),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/3771456.png',
                    width: 28,
                    height: 20,
                  ),
                ),
              ),
            ),
          ),
          // Profile
          Builder(
            builder: (ctx) => _buildNavItem(
              icon: 'assets/1361765.png',
              label: 'Profile',
              isActive: false,
              onTap: () {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
          ),
          // Pengaturan
          Builder(
            builder: (ctx) => _buildNavItem(
              icon: 'assets/91700.png',
              label: 'Pengaturan',
              isActive: false,
              onTap: () {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (context) => const PengaturanPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String icon,
    required String label,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    final color = isActive ? const Color(0xFF4CAF50) : Colors.grey[500];

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

}
