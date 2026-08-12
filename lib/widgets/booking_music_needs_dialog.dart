import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingMusicNeedsDialog extends StatefulWidget {
  final String guruName;
  final String instrument;

  const BookingMusicNeedsDialog({
    super.key,
    required this.guruName,
    required this.instrument,
  });

  @override
  State<BookingMusicNeedsDialog> createState() => _BookingMusicNeedsDialogState();
}

class _BookingMusicNeedsDialogState extends State<BookingMusicNeedsDialog>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  final TextEditingController _notesController = TextEditingController();
  String? _selectedLevel;
  String? _selectedGenre;
  String? _selectedGoal;

  final List<Map<String, dynamic>> _levels = [
    {'label': 'Pemula', 'icon': Icons.spa, 'desc': 'Baru mulai belajar'},
    {'label': 'Menengah', 'icon': Icons.trending_up, 'desc': 'Sudah bisa dasar'},
    {'label': 'Lanjutan', 'icon': Icons.bolt, 'desc': 'Mau menguasai teknik'},
  ];

  final List<Map<String, dynamic>> _genres = [
    {'label': 'Pop', 'color': const Color(0xFFFF6B9D)},
    {'label': 'Jazz', 'color': const Color(0xFF7B68EE)},
    {'label': 'Rock', 'color': const Color(0xFFFF5722)},
    {'label': 'Klasik', 'color': const Color(0xFF8D6E63)},
    {'label': 'Blues', 'color': const Color(0xFF1976D2)},
    {'label': 'R&B', 'color': const Color(0xFF9C27B0)},
  ];

  final List<Map<String, dynamic>> _goals = [
    {'label': 'Hobi', 'icon': Icons.favorite},
    {'label': 'Persiapan Konser', 'icon': Icons.music_note},
    {'label': 'Ujian / Sertifikasi', 'icon': Icons.school},
    {'label': 'Karir Profesional', 'icon': Icons.workspace_premium},
  ];

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOut),
    );

    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _selectedLevel != null &&
      _selectedGenre != null &&
      _selectedGoal != null;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return AnimatedBuilder(
      animation: _entryController,
      builder: (context, child) {
        return Stack(
          children: [
            // Background overlay with blur effect simulation
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.6 * _fadeAnimation.value),
                ),
              ),
            ),
            // Centered dialog
            Center(
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
      child: _buildDialogContent(context, mediaQuery),
    );
  }

  Widget _buildDialogContent(BuildContext context, MediaQueryData mediaQuery) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.05),
        constraints: BoxConstraints(
          maxHeight: mediaQuery.size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIntro(),
                      const SizedBox(height: 20),
                      _buildLevelSection(),
                      const SizedBox(height: 20),
                      _buildGenreSection(),
                      const SizedBox(height: 20),
                      _buildGoalSection(),
                      const SizedBox(height: 20),
                      _buildNotesSection(),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'KEBUTUHAN BERMUSIKMU',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Booking dengan ${widget.guruName} • ${widget.instrument}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.tips_and_updates_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Ceritakan kebutuhan bermusikmu agar guru dapat menyiapkan materi yang tepat.',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontSize: 12,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelSection() {
    return _buildSection(
      title: 'Tingkatan Saat Ini',
      subtitle: 'Pilih level kemampuan bermusikmu',
      icon: Icons.signal_cellular_alt,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _levels.map((level) {
            final isSelected = _selectedLevel == level['label'];
            final isLast = level == _levels.last;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: isLast ? 0 : 10),
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedLevel = level['label'] as String);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    height: 96,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2E7D32)
                            : Colors.grey[300]!,
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF4CAF50)
                                    .withValues(alpha: 0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          level['icon'] as IconData,
                          color: isSelected ? Colors.white : Colors.grey[700],
                          size: 22,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          level['label'] as String,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          level['desc'] as String,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.9)
                                : Colors.grey[600],
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildGenreSection() {
    return _buildSection(
      title: 'Genre Favorit',
      subtitle: 'Genre musik yang ingin dipelajari',
      icon: Icons.queue_music,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _genres.map((genre) {
          final isSelected = _selectedGenre == genre['label'];
          return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _selectedGenre = genre['label'] as String);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? genre['color'] as Color : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? genre['color'] as Color
                      : Colors.grey[300]!,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (genre['color'] as Color).withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                genre['label'] as String,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGoalSection() {
    return _buildSection(
      title: 'Tujuan Belajar',
      subtitle: 'Apa target utamamu?',
      icon: Icons.flag_outlined,
      child: Column(
        children: _goals.map((goal) {
          final isSelected = _selectedGoal == goal['label'];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedGoal = goal['label'] as String);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4CAF50)
                        : Colors.grey[300]!,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4CAF50)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        goal['icon'] as IconData,
                        color: isSelected ? Colors.white : Colors.grey[700],
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        goal['label'] as String,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF2E7D32)
                              : Colors.black87,
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF4CAF50),
                        size: 20,
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotesSection() {
    return _buildSection(
      title: 'Catatan Tambahan',
      subtitle: 'Ceritakan lebih detail (opsional)',
      icon: Icons.edit_note,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: TextField(
          controller: _notesController,
          maxLines: 3,
          maxLength: 200,
          decoration: InputDecoration(
            hintText: 'Contoh: Saya ingin belajar teknik fingerpicking untuk lagu pop...',
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 13,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(14),
            counterStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              gradient: _isFormValid
                  ? const LinearGradient(
                      colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                    )
                  : const LinearGradient(
                      colors: [Color(0xFFBDBDBD), Color(0xFF9E9E9E)],
                    ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: _isFormValid
                  ? [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: _isFormValid
                    ? () {
                        HapticFeedback.mediumImpact();
                        Navigator.of(context).pop({
                          'level': _selectedLevel,
                          'genre': _selectedGenre,
                          'goal': _selectedGoal,
                          'notes': _notesController.text,
                        });
                      }
                    : null,
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Kirim Permintaan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF4CAF50),
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
