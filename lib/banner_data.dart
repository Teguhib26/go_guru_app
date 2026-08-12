class BannerData {
  final String tag;
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String backgroundImage;
  final String? actionText;
  final void Function()? onTap;

  const BannerData({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.backgroundImage,
    this.actionText,
    this.onTap,
  });
}

const List<BannerData> bannerSlides = [
  BannerData(
    tag: 'EVENT',
    title: 'Taman Bermain Musik',
    subtitle: 'Ayo ikut bermain musik bersama!',
    date: '24 Mei 2026',
    time: '09:00-10:30',
    backgroundImage: 'assets/images/banner.jpeg',
  ),
  BannerData(
    tag: 'PROMO',
    title: 'Diskon 30% Untuk Siswa Baru',
    subtitle: 'Daftar sekarang dan dapatkan potongan harga spesial',
    date: 'Berlaku s/d 30 Juni 2026',
    time: '',
    backgroundImage: 'assets/images/banner.jpeg',
  ),
  BannerData(
    tag: 'INFO',
    title: 'Guru Terverifikasi Resmi',
    subtitle: 'Semua guru telah melewati proses verifikasi ketat',
    date: 'Go Guru Official',
    time: '',
    backgroundImage: 'assets/images/banner.jpeg',
  ),
  BannerData(
    tag: 'TIPS',
    title: 'Tips Memilih Guru Musik',
    subtitle: 'Pelajari cara menemukan guru yang tepat untukmu',
    date: 'Baca di Blog',
    time: '',
    backgroundImage: 'assets/images/banner.jpeg',
  ),
];
