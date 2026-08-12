import 'package:flutter/material.dart';

class Translations {
  final Locale locale;

  Translations(this.locale);

  static Translations? of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static const LocalizationsDelegate<Translations> delegate = _TranslationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('id'), // Indonesian
    Locale('en'), // English
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'id': {
      // Common
      'app_name': 'GO GURU',
      'save': 'Simpan',
      'cancel': 'Batal',
      'confirm': 'Konfirmasi',
      'delete': 'Hapus',
      'edit': 'Edit',
      'back': 'Kembali',
      'next': 'Lanjut',
      'done': 'Selesai',
      'success': 'Berhasil',
      'error': 'Gagal',
      'loading': 'Memuat...',
      'search': 'Cari',
      'search_hint': 'Cari...',
      'no_data': 'Tidak ada data',
      'retry': 'Coba Lagi',

      // Navigation
      'home': 'Beranda',
      'profile': 'Profil',
      'history': 'Riwayat',
      'settings': 'Pengaturan',
      'chat': 'Chat',

      // Profile Page
      'edit_profile': 'Edit Profil',
      'notifications': 'Notifikasi',
      'security': 'Keamanan',
      'payment_methods': 'Metode Pembayaran',
      'help_center': 'Pusat Bantuan',
      'about_app': 'Tentang Aplikasi',
      'logout': 'Keluar',
      'logout_confirm': 'Keluar dari akun?',
      'logout_message': 'Anda yakin ingin keluar dari akun ini?',
      'logout_success': 'Berhasil keluar dari akun',
      'member_since': 'Anggota sejak',
      'total_lessons': 'Total Les',
      'total_hours': 'Total Jam',
      'rating': 'Rating',

      // Edit Profile
      'personal_info': 'Informasi Pribadi',
      'full_name': 'Nama Lengkap',
      'email': 'Email',
      'phone': 'Nomor Telepon',
      'bio': 'Bio',
      'save_changes': 'Simpan Perubahan',
      'profile_updated': 'Profil berhasil diperbarui!',
      'change_photo': 'Ubah Foto',

      // Notifications
      'general_notifications': 'Notifikasi Umum',
      'push_notifications': 'Notifikasi Push',
      'push_notifications_desc': 'Terima notifikasi di perangkat',
      'email_notifications': 'Notifikasi Email',
      'email_notifications_desc': 'Kirim pembaruan ke email',
      'sms_notifications': 'Notifikasi SMS',
      'sms_notifications_desc': 'Terima pesan teks',
      'notification_types': 'Jenis Notifikasi',
      'lesson_reminders': 'Pengingat Les',
      'lesson_reminders_desc': 'Notifikasi sebelum les dimulai',
      'promo_notifications': 'Promo & Diskon',
      'promo_notifications_desc': 'Tawaran khusus dan promo menarik',
      'chat_notifications': 'Notifikasi Chat',
      'chat_notifications_desc': 'Pesan baru dari guru atau murid',
      'sound': 'Suara',
      'sound_desc': 'Mainkan suara notifikasi',
      'vibration': 'Getaran',
      'vibration_desc': 'Getar saat ada notifikasi',

      // Security
      'change_password': 'Ubah Password',
      'change_password_desc': 'Perbarui kata sandi akun Anda',
      'old_password': 'Password Lama',
      'new_password': 'Password Baru',
      'confirm_password': 'Konfirmasi Password Baru',
      'password_changed': 'Password berhasil diperbarui!',
      'biometric_login': 'Biometric Login',
      'biometric_login_desc': 'Gunakan sidik jari untuk masuk',
      'two_factor_auth': 'Two-Factor Authentication',
      'two_factor_auth_desc': 'Verifikasi dua langkah',
      'login_activity': 'Aktivitas Login',
      'login_activity_desc': 'Lihat perangkat yang masuk',
      'delete_account': 'Hapus Akun',
      'delete_account_desc': 'Permanen menghapus akun Anda',
      'delete_account_confirm': 'Hapus Akun?',
      'delete_account_message': 'Akun Anda akan dihapus secara permanen. Semua data, histori, dan langganan akan hilang.',

      // Payment Methods
      'payment_info': 'Penting',
      'payment_info_message': 'Pastikan rekening/e-wallet aktif untuk menerima pembayaran.',
      'make_default': 'Jadikan Utama',
      'add_payment_method': 'Tambah Metode Pembayaran',
      'bank_transfer': 'Transfer Bank',
      'e_wallet': 'E-Wallet',
      'bank_name': 'Nama Bank / E-Wallet',
      'account_number': 'Nomor Rekening / Telepon',
      'account_holder': 'Nama Pemilik',
      'payment_added': 'Metode pembayaran berhasil ditambahkan!',
      'delete_payment': 'Hapus Metode Pembayaran?',
      'delete_payment_message': 'Metode pembayaran ini akan dihapus dari akun Anda.',

      // Help Center
      'contact_us': 'Hubungi Kami',
      'chat_with_us': 'Chat dengan Kami',
      'email_us': 'Email Kami',
      'call_us': 'Telepon',
      'categories': 'Kategori',
      'all': 'Semua',
      'account_cat': 'Akun',
      'lesson_cat': 'Les',
      'payment_cat': 'Pembayaran',
      'technical': 'Teknis',
      'faq': 'Pertanyaan yang Sering Diajukan',

      // About App
      'about_go_guru': 'Tentang GO GURU',
      'about_go_guru_desc': 'GO GURU adalah aplikasi platform les privat musik yang menghubungkan siswa dengan guru-guru berkualitas.',
      'app_version': 'Versi',
      'trusted_app': 'Aplikasi Terpercaya',
      'verified_teachers': 'Guru Terverifikasi',
      'flexible': 'Fleksibel',
      'quality': 'Berkualitas',
      'terms_conditions': 'Syarat & Ketentuan',
      'terms_conditions_desc': 'Kebijakan penggunaan aplikasi',
      'privacy_policy': 'Kebijakan Privasi',
      'privacy_policy_desc': 'Perlindungan data pribadi',
      'license': 'Lisensi',
      'license_desc': 'Lisensi dan hak cipta',
      'developer_info': 'Informasi Pengembang',
      'company': 'Perusahaan',
      'website': 'Website',
      'about_soon': 'Dokumen akan segera tersedia. Silakan kunjungi website kami di www.goguru.id untuk informasi lengkap.',

      // Address
      'address_title': 'Alamat',
      'location_info': 'Lokasi Mengajar',
      'location_desc': 'Alamat ini akan ditampilkan ke murid untuk lokasi les privat.',
      'full_address': 'Alamat Lengkap',
      'address': 'Alamat',
      'address_hint': 'Jl. Nama jalan No. XX, RT/RW, Kelurahan, Kecamatan',
      'city': 'Kota/Kabupaten',
      'postal_code': 'Kode Pos',
      'make_primary': 'Jadikan Alamat Utama',
      'primary_address_desc': 'Alamat utama untuk mengajar',
      'save_address': 'Simpan Alamat',
      'address_saved': 'Alamat berhasil disimpan!',

      // Settings/Language
      'language': 'Bahasa',
      'language_settings': 'Pengaturan Bahasa',
      'select_language': 'Pilih Bahasa',
      'indonesian': 'Indonesia',
      'english': 'English',
      'language_changed': 'Bahasa berhasil diubah!',
      'app_will_restart': 'Aplikasi akan diperbarui sesuai bahasa yang dipilih.',

      // Rate App
      'rate_app': 'Beri Rating',
      'rate_app_desc': 'Rate aplikasi ini',
      'rate_message': 'Bagaimana pengalaman Anda dengan GO GURU?',
      'rate_title': 'Berikan Rating',
      'submit_rating': 'Kirim Rating',
      'thanks_rating': 'Terima kasih atas rating Anda!',

      // Contact
      'contact_title': 'Hubungi Kami',
      'contact_message': 'Tim support GO GURU siap membantu Anda.',
      'whatsapp': 'WhatsApp',
      'instagram': 'Instagram',
      'twitter': 'Twitter',
      'facebook': 'Facebook',

      // Guru Pages
      'teacher_tracking': 'Tracking Mengajar',
      'teaching_history': 'Riwayat Mengajar',
      'student_chat': 'Chat Murid',
      'guru_settings': 'Pengaturan',
      'guru_profile': 'Profil Guru',

      // Booking
      'booking_lesson': 'Booking Les',
      'skill_level': 'Tingkat Kemampuan',
      'beginner': 'Pemula',
      'beginner_desc': 'Belum pernah bermain musik',
      'intermediate': 'Menengah',
      'intermediate_desc': 'Sudah paham dasar-dasar',
      'advanced': 'Lanjutan',
      'advanced_desc': 'Tingkat mahir & profesional',
      'select_day': 'Pilih Hari',
      'select_time': 'Pilih Jam',
      'musical_needs': 'Kebutuhan Bermusik',
      'have_instrument': 'Apakah kamu sudah memiliki alat musik?',
      'yes': 'Sudah',
      'no': 'Belum',
      'instrument_needed': 'Tuliskan alat musik yang dibutuhkan...',
      'additional_notes': 'Catatan Tambahan',
      'notes_hint': 'Catatan untuk guru (opsional)...',
      'submit_booking': 'Kirim Permintaan Booking',

      // Profile Teacher
      'about_teacher': 'Tentang Guru',
      'schedule': 'Jadwal',
      'reviews': 'Ulasan',
      'verified': 'Terverifikasi',
      'lesson_fee': 'Biaya Les Per Jam',
      'booking': 'Booking',
      'book_now': 'Booking Sekarang',
      'what_students_like': 'Yang disukai murid',
      'teaching_location': 'Lokasi Praktik',
      'practice_at': 'Praktik di',
      'alumni': 'Alumnus',
      'graduated_from': 'Lulusan',
      'available_schedule': 'Jadwal Tersedia',
      'lesson_time': 'Waktu les: 09:00-20:00 WIB',
      'rating_reviews': 'Rating & Ulasan',
      'latest_reviews': 'Ulasan Terbaru',
      'reviews_count': 'ulasan',
    },
    'en': {
      // Common
      'app_name': 'GO GURU',
      'save': 'Save',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'delete': 'Delete',
      'edit': 'Edit',
      'back': 'Back',
      'next': 'Next',
      'done': 'Done',
      'success': 'Success',
      'error': 'Failed',
      'loading': 'Loading...',
      'search': 'Search',
      'search_hint': 'Search...',
      'no_data': 'No data',
      'retry': 'Try Again',

      // Navigation
      'home': 'Home',
      'profile': 'Profile',
      'history': 'History',
      'settings': 'Settings',
      'chat': 'Chat',

      // Profile Page
      'edit_profile': 'Edit Profile',
      'notifications': 'Notifications',
      'security': 'Security',
      'payment_methods': 'Payment Methods',
      'help_center': 'Help Center',
      'about_app': 'About App',
      'logout': 'Logout',
      'logout_confirm': 'Logout from account?',
      'logout_message': 'Are you sure you want to logout from this account?',
      'logout_success': 'Successfully logged out',
      'member_since': 'Member since',
      'total_lessons': 'Total Lessons',
      'total_hours': 'Total Hours',
      'rating': 'Rating',

      // Edit Profile
      'personal_info': 'Personal Information',
      'full_name': 'Full Name',
      'email': 'Email',
      'phone': 'Phone Number',
      'bio': 'Bio',
      'save_changes': 'Save Changes',
      'profile_updated': 'Profile updated successfully!',
      'change_photo': 'Change Photo',

      // Notifications
      'general_notifications': 'General Notifications',
      'push_notifications': 'Push Notifications',
      'push_notifications_desc': 'Receive notifications on device',
      'email_notifications': 'Email Notifications',
      'email_notifications_desc': 'Send updates to email',
      'sms_notifications': 'SMS Notifications',
      'sms_notifications_desc': 'Receive text messages',
      'notification_types': 'Notification Types',
      'lesson_reminders': 'Lesson Reminders',
      'lesson_reminders_desc': 'Notifications before lesson starts',
      'promo_notifications': 'Promo & Discounts',
      'promo_notifications_desc': 'Special offers and promotions',
      'chat_notifications': 'Chat Notifications',
      'chat_notifications_desc': 'New messages from teachers or students',
      'sound': 'Sound',
      'sound_desc': 'Play notification sound',
      'vibration': 'Vibration',
      'vibration_desc': 'Vibrate on notifications',

      // Security
      'change_password': 'Change Password',
      'change_password_desc': 'Update your account password',
      'old_password': 'Old Password',
      'new_password': 'New Password',
      'confirm_password': 'Confirm New Password',
      'password_changed': 'Password updated successfully!',
      'biometric_login': 'Biometric Login',
      'biometric_login_desc': 'Use fingerprint to login',
      'two_factor_auth': 'Two-Factor Authentication',
      'two_factor_auth_desc': 'Two-step verification',
      'login_activity': 'Login Activity',
      'login_activity_desc': 'View logged in devices',
      'delete_account': 'Delete Account',
      'delete_account_desc': 'Permanently delete your account',
      'delete_account_confirm': 'Delete Account?',
      'delete_account_message': 'Your account will be permanently deleted. All data, history, and subscriptions will be lost.',

      // Payment Methods
      'payment_info': 'Important',
      'payment_info_message': 'Make sure your bank/e-wallet is active to receive payments.',
      'make_default': 'Set as Default',
      'add_payment_method': 'Add Payment Method',
      'bank_transfer': 'Bank Transfer',
      'e_wallet': 'E-Wallet',
      'bank_name': 'Bank Name / E-Wallet',
      'account_number': 'Account Number / Phone',
      'account_holder': 'Account Holder',
      'payment_added': 'Payment method added successfully!',
      'delete_payment': 'Delete Payment Method?',
      'delete_payment_message': 'This payment method will be removed from your account.',

      // Help Center
      'contact_us': 'Contact Us',
      'chat_with_us': 'Chat with Us',
      'email_us': 'Email Us',
      'call_us': 'Call Us',
      'categories': 'Categories',
      'all': 'All',
      'account_cat': 'Account',
      'lesson_cat': 'Lesson',
      'payment_cat': 'Payment',
      'technical': 'Technical',
      'faq': 'Frequently Asked Questions',

      // About App
      'about_go_guru': 'About GO GURU',
      'about_go_guru_desc': 'GO GURU is a music tutoring platform that connects students with qualified teachers.',
      'app_version': 'Version',
      'trusted_app': 'Trusted App',
      'verified_teachers': 'Verified Teachers',
      'flexible': 'Flexible',
      'quality': 'Quality',
      'terms_conditions': 'Terms & Conditions',
      'terms_conditions_desc': 'Application usage policy',
      'privacy_policy': 'Privacy Policy',
      'privacy_policy_desc': 'Personal data protection',
      'license': 'License',
      'license_desc': 'License and copyrights',
      'developer_info': 'Developer Information',
      'company': 'Company',
      'website': 'Website',
      'about_soon': 'Document will be available soon. Please visit our website at www.goguru.id for complete information.',

      // Address
      'address_title': 'Address',
      'location_info': 'Teaching Location',
      'location_desc': 'This address will be shown to students for tutoring location.',
      'full_address': 'Full Address',
      'address': 'Address',
      'address_hint': 'St. Street Name No. XX, RT/RW, Village, District',
      'city': 'City',
      'postal_code': 'Postal Code',
      'make_primary': 'Set as Primary Address',
      'primary_address_desc': 'Primary address for teaching',
      'save_address': 'Save Address',
      'address_saved': 'Address saved successfully!',

      // Settings/Language
      'language': 'Language',
      'language_settings': 'Language Settings',
      'select_language': 'Select Language',
      'indonesian': 'Indonesia',
      'english': 'English',
      'language_changed': 'Language changed successfully!',
      'app_will_restart': 'App will be updated according to the selected language.',

      // Rate App
      'rate_app': 'Rate App',
      'rate_app_desc': 'Rate this application',
      'rate_message': 'How is your experience with GO GURU?',
      'rate_title': 'Give Rating',
      'submit_rating': 'Submit Rating',
      'thanks_rating': 'Thank you for your rating!',

      // Contact
      'contact_title': 'Contact Us',
      'contact_message': 'GO GURU support team is ready to help you.',
      'whatsapp': 'WhatsApp',
      'instagram': 'Instagram',
      'twitter': 'Twitter',
      'facebook': 'Facebook',

      // Guru Pages
      'teacher_tracking': 'Teaching Tracking',
      'teaching_history': 'Teaching History',
      'student_chat': 'Student Chat',
      'guru_settings': 'Settings',
      'guru_profile': 'Teacher Profile',

      // Booking
      'booking_lesson': 'Book Lesson',
      'skill_level': 'Skill Level',
      'beginner': 'Beginner',
      'beginner_desc': 'Never played music before',
      'intermediate': 'Intermediate',
      'intermediate_desc': 'Already understand the basics',
      'advanced': 'Advanced',
      'advanced_desc': 'Master & professional level',
      'select_day': 'Select Day',
      'select_time': 'Select Time',
      'musical_needs': 'Musical Needs',
      'have_instrument': 'Do you have a musical instrument?',
      'yes': 'Yes',
      'no': 'No',
      'instrument_needed': 'Write the instrument needed...',
      'additional_notes': 'Additional Notes',
      'notes_hint': 'Notes for teacher (optional)...',
      'submit_booking': 'Submit Booking Request',

      // Profile Teacher
      'about_teacher': 'About Teacher',
      'schedule': 'Schedule',
      'reviews': 'Reviews',
      'verified': 'Verified',
      'lesson_fee': 'Lesson Fee Per Hour',
      'booking': 'Booking',
      'book_now': 'Book Now',
      'what_students_like': 'What Students Like',
      'teaching_location': 'Teaching Location',
      'practice_at': 'Practice at',
      'alumni': 'Alumni',
      'graduated_from': 'Graduated from',
      'available_schedule': 'Available Schedule',
      'lesson_time': 'Lesson time: 09:00-20:00 WIB',
      'rating_reviews': 'Rating & Reviews',
      'latest_reviews': 'Latest Reviews',
      'reviews_count': 'reviews',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? _localizedValues['id']?[key] ?? key;
  }
}

class _TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const _TranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['id', 'en'].contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) async {
    return Translations(locale);
  }

  @override
  bool shouldReload(_TranslationsDelegate old) => false;
}

String t(BuildContext context, String key) {
  return Translations.of(context)?.translate(key) ?? key;
}
