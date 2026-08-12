import 'teacher_data.dart';

class GuruData {
  final String id;
  final String name;
  final String instrument;
  final String experience;
  final String institution;
  final String avatar;
  final String videoUrl;
  final String location;
  final DateTime registeredAt;
  final bool isVerified;

  GuruData({
    required this.id,
    required this.name,
    required this.instrument,
    this.experience = '0 Tahun',
    this.institution = 'Belum Terdaftar',
    this.avatar = 'assets/avatar-gen370480c24b85cd4efb553f0a452c88f2.jpg',
    this.videoUrl = '',
    this.location = 'Indonesia',
    DateTime? registeredAt,
    this.isVerified = true,
  }) : registeredAt = registeredAt ?? DateTime.now();

  Teacher toTeacher() {
    return Teacher(
      name: name,
      instrument: instrument,
      experience: experience,
      institution: institution,
      avatar: avatar,
      videoUrl: videoUrl,
      location: location,
      guruId: id,
    );
  }
}

class GuruService {
  static final GuruService _instance = GuruService._internal();
  factory GuruService() => _instance;
  GuruService._internal();

  final List<GuruData> _registeredGurus = [];
  GuruData? _currentGuru;

  List<GuruData> get registeredGurus => List.unmodifiable(_registeredGurus);
  GuruData? get currentGuru => _currentGuru;

  List<Teacher> get allTeachers {
    final guruTeachers = _registeredGurus.map((g) => g.toTeacher()).toList();
    return [...allTeachersStatic, ...guruTeachers];
  }

  void registerGuru({
    required String name,
    required String instrument,
    String experience = '0 Tahun',
    String institution = 'Belum Terdaftar',
  }) {
    final id = 'guru_${name.toLowerCase().replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}';

    final guru = GuruData(
      id: id,
      name: name,
      instrument: instrument,
      experience: experience,
      institution: institution,
    );

    _registeredGurus.add(guru);
    _currentGuru = guru;
  }

  void setCurrentGuru(GuruData guru) {
    _currentGuru = guru;
  }

  GuruData? getGuruById(String id) {
    try {
      return _registeredGurus.firstWhere((g) => g.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateGuruProfile({
    required String id,
    String? name,
    String? instrument,
    String? experience,
    String? institution,
    String? avatar,
    String? location,
  }) {
    final index = _registeredGurus.indexWhere((g) => g.id == id);
    if (index != -1) {
      final oldGuru = _registeredGurus[index];
      _registeredGurus[index] = GuruData(
        id: oldGuru.id,
        name: name ?? oldGuru.name,
        instrument: instrument ?? oldGuru.instrument,
        experience: experience ?? oldGuru.experience,
        institution: institution ?? oldGuru.institution,
        avatar: avatar ?? oldGuru.avatar,
        videoUrl: oldGuru.videoUrl,
        location: location ?? oldGuru.location,
        registeredAt: oldGuru.registeredAt,
        isVerified: oldGuru.isVerified,
      );
      if (_currentGuru?.id == id) {
        _currentGuru = _registeredGurus[index];
      }
    }
  }
}
