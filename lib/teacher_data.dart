class Teacher {
  final String name;
  final String instrument;
  final String experience;
  final String institution;
  final String avatar;
  final String videoUrl;
  final String location;
  final String guruId;

  const Teacher({
    required this.name,
    required this.instrument,
    required this.experience,
    required this.institution,
    required this.avatar,
    required this.videoUrl,
    required this.location,
    required this.guruId,
  });
}

const List<Teacher> allTeachersStatic = [
  Teacher(
    name: 'Mario Daniel',
    instrument: 'Gitar',
    experience: '10 Tahun',
    institution: 'GBN',
    avatar: 'assets/avatar-gen370480c24b85cd4efb553f0a452c88f2.jpg',
    videoUrl: 'assets/funk_guitar_solo.mp4',
    location: 'Jakarta Selatan',
    guruId: 'guru_mario_daniel',
  ),
  Teacher(
    name: 'George Calvin',
    instrument: 'Piano',
    experience: '15 Tahun',
    institution: 'Yamaha',
    avatar: 'assets/avatar-gen5286f0751632aa2cae58627e6686270f.jpg',
    videoUrl: '',
    location: 'Jakarta Timur',
    guruId: 'guru_george_calvin',
  ),
  Teacher(
    name: 'Ayu Rahayu',
    instrument: 'Biola',
    experience: '8 Tahun',
    institution: 'Conservatory',
    avatar: 'assets/avatar-gen370480c24b85cd4efb553f0a452c88f2.jpg',
    videoUrl: '',
    location: 'Bandung',
    guruId: 'guru_ayu_rahayu',
  ),
  Teacher(
    name: 'Rian Putra',
    instrument: 'Drum',
    experience: '12 Tahun',
    institution: 'Metronom Studio',
    avatar: 'assets/avatar-gen5286f0751632aa2cae58627e6686270f.jpg',
    videoUrl: '',
    location: 'Jakarta Barat',
    guruId: 'guru_rian_putra',
  ),
  Teacher(
    name: 'Nia Sari',
    instrument: 'Vokal',
    experience: '7 Tahun',
    institution: 'Voice Academy',
    avatar: 'assets/avatar-gen370480c24b85cd4efb553f0a452c88f2.jpg',
    videoUrl: '',
    location: 'Surabaya',
    guruId: 'guru_nia_sari',
  ),
  Teacher(
    name: 'Alif Sax',
    instrument: 'Saxophone',
    experience: '9 Tahun',
    institution: 'Jazz House',
    avatar: 'assets/avatar-gen5286f0751632aa2cae58627e6686270f.jpg',
    videoUrl: '',
    location: 'Jakarta Utara',
    guruId: 'guru_alif_sax',
  ),
  Teacher(
    name: 'Mira Putri',
    instrument: 'Flute',
    experience: '6 Tahun',
    institution: 'Music School',
    avatar: 'assets/avatar-gen370480c24b85cd4efb553f0a452c88f2.jpg',
    videoUrl: '',
    location: 'Depok',
    guruId: 'guru_mira_putri',
  ),
  Teacher(
    name: 'Dedi Jazz',
    instrument: 'Alat Musik Lainnya',
    experience: '13 Tahun',
    institution: 'Freestyle Studio',
    avatar: 'assets/avatar-gen5286f0751632aa2cae58627e6686270f.jpg',
    videoUrl: '',
    location: 'Bekasi',
    guruId: 'guru_dedi_jazz',
  ),
];
