---
title: "Roadmap & Timeline GO GURU"
subtitle: "Dari MVP hingga Siap Rilis (Android & iOS)"
author: "Tim Produk GO GURU"
date: "20 Juli 2026"
geometry: "margin=2.4cm 2cm"
fontsize: 10pt
mainfont: "Helvetica"
colorlinks: true
linkcolor: "ForestGreen"
toccolor: "ForestGreen"
---

# Ringkasan Eksekutif

**GO GURU** adalah aplikasi mobile (Flutter) untuk **mencari guru musik privat** (gitar, piano, biola, drum, vokal, saxophone, flute, dll.). Target rilis akhir adalah aplikasi mobile-only Android & iOS yang siap rilis di Play Store dan App Store dengan fitur setara aplikasi layanan jasa profesional sekelas **Halodoc** dalam hal kualitas UX, keandalan, dan operasional — tetapi tetap dalam **niche guru musik privat**.

Dokumen ini menyusun timeline **1 bulan (4 minggu) non-stop** dengan tim kecil (1–2 engineer full-time + 1 desainer part-time + 1 PM). Mengingat targetnya agresif, dilakukan trade-off eksplisit pada cakupan: banyak hal di-*mock* atau menggunakan managed service, payment gateway pakai Midtrans/Xendit sandbox, compliance mengikuti standar minimum Play/App Store.

## Prinsip Roadmap

1. **Foundation dulu** — stabilisasi struktur kode, state management, dan test infra sebelum fitur.
2. **Backend sebagai managed service** — pakai Firebase/Supabase agar tidak menulis backend dari nol.
3. **Paralel maksimum** — track UI, integrasi, dan QA berjalan paralel di setiap minggu.
4. **Cut corners secara sadar** — semua shortcut didokumentasikan di Bagian "Trade-off".

## Cakupan Akhir (Definition of Done)

- Autentikasi (email/Google/Apple), onboarding, profil pengguna (murid & guru).
- Listing & pencarian guru dengan filter (instrument, harga, jarak, rating).
- Booking sesi privat (online via video call & offline home-visit).
- Chat in-app + notifikasi real-time.
- Pembayaran via Midtrans/Xendit (sandbox untuk 1.0, production menyusul 2 minggu pasca-rilis).
- Rating & review setelah sesi.
- Verifikasi guru (unggah sertifikat/CV/video portofolio) + dasbor guru.
- Pelanggaran & refund dasar.
- Build rilis siap-upload ke Play Store & App Store.

---

# Kondisi Aplikasi Saat Ini (Audit 20 Jul 2026)

| Aspek | Status | Catatan |
|---|---|---|
| Project Flutter | ✅ Ada | SDK `^3.10.0-290.4.beta`, package `cupertino_icons`, `device_preview`, `video_player` |
| Halaman | ✅ 4 statis | `main.dart` (HomePage), `daftar_guru_page.dart`, `daftar_murid_page.dart`, `guru_profile_page.dart` |
| Widget kustom | 1 | `widgets/booking_music_needs_dialog.dart` |
| State management | ❌ | `setState` saja, belum ada Provider/Riverpod/Bloc |
| Routing | ❌ | `Navigator.push` manual, belum ada `go_router` |
| Backend/API | ❌ | Tidak ada; data guru hard-coded di `main.dart` |
| Autentikasi | ❌ | Form statis, `_handleDaftar` hanya snackbar |
| Database | ❌ | Tidak ada |
| Payment | ❌ | Tidak ada |
| Test | ⚠️ | 1 widget test smoke, hard-coded name "Herri Budiawan" tidak cocok dengan data aktual |
| CI/CD | ❌ | Tidak ada GitHub Actions / Fastlane |
| Android signing | ⚠️ | `signingConfig = debug` di `app/build.gradle.kts`, applicationId `com.example.*` |
| iOS signing | ❌ | Default, belum ada provisioning profile |
| Asset branding | ✅ | Logo, banner, ikon instrumen tersedia |
| Launcher icon | ✅ | `flutter_launcher_icons` configured |
| Dark mode / a11y | ❌ | Hanya light theme |

**Kesimpulan audit**: fondasi visual sudah ada, tetapi secara struktural aplikasi masih berupa *prototype statis*. ~70% effort roadmap di bawah ini adalah **membangun infrastruktur yang belum ada**, bukan menambah halaman baru.

---

# Timeline 1 Bulan (4 Minggu Non-Stop)

> Asumsi: 1–2 engineer Flutter full-time, 1 desainer part-time, 1 PM. Setiap hari kerja = 8 jam efektif. Track paralel berjalan simultan.

## Peta Visual Pekan

```
PEKAN 1 │████ Foundation & Arsitektur ████████████│
PEKAN 2 │████ MVP Fungsional (Auth + Listing + Booking Mock) ███│
PEKAN 3 │████ Integrasi Nyata (Payment + Chat + Verifikasi) ██│
PEKAN 4 │████ QA, Polish, Build Rilis & Submit ████████████│
```

---

## PEKAN 1 — Foundation & Arsitektur  *(Hari 1–7)*

**Tujuan:** mengubah prototype statis menjadi aplikasi dengan struktur yang siap diskalakan.

| Hari | Track A — Arsitektur & Kode | Track B — Backend & Auth | Track C — UX/Desain |
|---|---|---|---|
| 1–2 | Inisialisasi struktur folder (`lib/core`, `lib/data`, `lib/domain`, `lib/presentation`). Tambah `go_router`, `flutter_riverpod`, `freezed`, `json_serializable`. Migrasi data guru hard-coded ke model. | Setup Firebase project (Auth + Firestore + Storage + FCM). Konfigurasi Android & iOS (google-services.json, GoogleService-Info.plist). | Audit desain 4 halaman existing, buat design tokens (warna, tipografi, spacing). |
| 3 | Setup tema Material 3 + dark mode + localization (`id`, `en`). | Implementasi Firebase Auth (email/password, Google Sign-In, Apple Sign-In iOS). | Rancang alur onboarding (3 slide), splash, login, register. |
| 4 | Refactor `main.dart` menjadi `app.dart` + `router.dart`. Hapus `device_preview` dari release build. | Skema Firestore: `users`, `teachers`, `instruments`, `bookings`, `reviews`, `chats`. Rules keamanan. | Rancang halaman profil guru detail + card listing. |
| 5 | Setup error handling global (`runZonedGuarded`), Sentry/Crashlytics, logger. | Storage bucket untuk sertifikat/CV/video portofolio. Validasi MIME & ukuran maks. | Rancang halaman booking, status pesanan, detail sesi. |
| 6 | Setup testing infra: `flutter_test`, `mocktail`, `integration_test`, golden test dasar. | Seed data: 5 instrument, 20 guru dummy, 3 murid dummy. | Rancang halaman chat list + chat room. |
| 7 | **Demo internal #1.** Checklist: app launch bersih, login email/Google bekerja, listing guru tampil dari Firestore. |  |  |

**Deliverables Pekan 1:**
- Struktur `lib/` final + lint rules.
- Firebase project live (dev environment).
- Tema & token desain.
- 1 demo internal.

---

## PEKAN 2 — MVP Fungsional *(Hari 8–14)*

**Tujuan:** murid bisa registrasi → cari guru → pesan (mock payment) → lihat status.

| Hari | Track A — Fitur Murid | Track B — Fitur Guru | Track C — QA & Infra |
|---|---|---|---|
| 8 | Halaman onboarding 3 slide + login/register (email, Google, Apple). | Halaman daftar guru (form sudah ada di `daftar_guru_page.dart`) — integrasikan ke Firestore. | Setup GitHub Actions: format, analyze, test, build APK debug. |
| 9 | HomePage: search bar berfungsi (Firestore query), filter (instrument, range harga, jarak), kartu guru. | Dasbor guru: daftar booking masuk, terima/tolak, kalender ketersediaan. | Tulis unit test untuk model, repository, use-case inti. |
| 10 | Halaman detail guru (portofolio, sertifikat, video, review, tombol "Pesan"). | Halaman profil guru publik (read-only untuk murid). | Widget test untuk halaman kritis (login, home, detail guru). |
| 11 | Alur booking: pilih jadwal → ringkasan → konfirmasi. Status: `pending`, `confirmed`, `completed`, `cancelled`. | Notifikasi ke guru saat booking baru (FCM). | Setup emulator/device farm (Firebase Test Lab opsional). |
| 12 | Halaman "Pesanan Saya" + detail pesanan + tombol chat/batalkan. | Halaman edit profil & portofolio (unggah ulang sertifikat/ video). | Lint 0 warning, coverage minimal 40%. |
| 13 | Rating & review setelah `completed`. | Tampilan pendapatan dummy (belum riil). | Performance pass: `flutter run --profile`, ukur startup < 3 dtk di mid-range. |
| 14 | **Demo internal #2.** Murid end-to-end alur: daftar → cari → pesan → status "dikonfirmasi guru" → rating. |  |  |

**Deliverables Pekan 2:**
- Alur murid end-to-end.
- Alur guru end-to-end.
- CI hijau (build + test).
- Demo #2.

---

## PEKAN 3 — Integrasi Nyata *(Hari 15–21)*

**Tujuan:** payment gateway live (sandbox), chat real-time, verifikasi guru.

| Hari | Track A — Payment & Komersial | Track B — Chat & Notifikasi | Track C — Verifikasi & Trust |
|---|---|---|---|
| 15 | Pilih payment gateway: **Midtrans Snap** (unggul untuk Indonesia) atau Xendit. Sandbox integration. | Implementasi chat 1-on-1 dengan Firestore + optimistic UI + read receipts. | Alur verifikasi guru: admin review sertifikat/CV/video, status `verified`/`rejected`. |
| 16 | Halaman pembayaran Snap WebView. Webhook → update `bookings.status = paid`. | Notifikasi FCM untuk chat baru, booking update, reminder H-1. | Halaman "Profil Tersertifikasi" badge di kartu guru. |
| 17 | Flow refund sebagian (opsional v1.0 — di-cut ke v1.1). | Pesan suara singkat & lampiran gambar (opsional v1.0). | Laporan guru oleh murid → admin queue. |
| 18 | Invoice PDF otomatis (email + download di app). | Halaman inbox notifikasi in-app. | Halaman Syarat & Ketentuan + Kebijakan Privasi (wajib Play/App Store). |
| 19 | Voucher/promo kode dasar (1 kode aktif, max 1 per user). | Settings: bahasa, notifikasi, hapus akun. | Audit izin Android (`INTERNET`, `CAMERA`, `RECORD_AUDIO`, `POST_NOTIFICATIONS`). |
| 20 | Dashboard ringkas untuk admin (web ringan) — manual moderasi. | Dark mode pass. | iOS `Info.plist`: `NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription`, `NSMicrophoneUsageDescription`. |
| 21 | **Demo internal #3.** Skenario: bayar via Midtrans sandbox → chat dengan guru → terima notifikasi → sesi "selesai" → rating + review. |  |  |

**Deliverables Pekan 3:**
- Payment sandbox end-to-end.
- Chat real-time.
- Verifikasi guru manual oleh admin.
- Dokumen legal untuk store.

---

## PEKAN 4 — QA, Polish & Build Rilis *(Hari 22–28)*

**Tujuan:** siap submit ke Play Store & App Store.

| Hari | Track A — QA & Bug Bash | Track B — Polish UX | Track C — Release Build |
|---|---|---|---|
| 22 | Test plan tertulis (40+ skenario). Eksekusi di Android & iOS. | Empty state, error state, loading state untuk semua layar. | Setup signing key Android (upload key Play Console). Provisioning profile iOS. |
| 23 | Regression pass dari Pekan 1–3. | Animasi transisi, micro-interactions, haptic. | `flutter build appbundle --release` & `flutter build ipa --release`. |
| 24 | Performance audit: ukuran APK/IPA < 40 MB, startup < 3 dtk. | A11y pass: kontras warna, label semantics, font scale test. | Privacy nutrition label (App Store) & Data safety form (Play Store) diisi. |
| 25 | Security check: API keys di env, Firestore rules ditinjau ulang, deep link aman. | Onboarding copywriter final, screenshot 8 bahasa EN. | Listing store: judul, deskripsi (id+en), ikon, feature graphic, screenshot 6.5" & 5.5". |
| 26 | Internal UAT: 5 tester eksternal coba di device sendiri. | Final review desain (konsistensi spacing, tipografi). | Submit internal track (Play) + TestFlight (iOS). |
| 27 | Perbaiki bug P0/P1 dari UAT. | Final QA visual vs desain. | Submit produksi: Play Store production track, App Store review. |
| 28 | **RILIS!** 🎉 Monitoring dasbor live (Crashlytics, Sentry, Firebase Analytics). |  |  |

**Deliverables Pekan 4:**
- Build rilis ditandatangani.
- Listing store lengkap.
- Build submitted (waktu review Apple 1–3 hari, Google beberapa jam–1 hari).

---

# Struktur Tim & Budget

## Tim Minimum

| Peran | Jumlah | Komitmen |
|---|---|---|
| Engineering Lead (Flutter) | 1 | Full-time |
| Flutter Engineer | 1 | Full-time (bisa overlap dengan lead di Pekan 1) |
| Product Designer | 1 | Part-time (20 jam/minggu) |
| Product Manager / Owner | 1 | Part-time (10 jam/minggu) |
| QA (bisa overlap dengan engineer) | 0.5 | Part-time |

## Budget Estimasi (1 Bulan)

| Item | Estimasi (IDR) |
|---|---|
| Firebase (Blaze) — bulan 1 | 200.000 |
| Apple Developer Account (existing) | 1.350.000 / tahun |
| Google Play Developer (existing) | 400.000 (sekali) |
| Midtrans sandbox → production fee | 0 (sandbox) / ~2% transaksi |
| Asset tambahan (ikon, ilustrasi) | 500.000 |
| **Total bulan 1 (diluar gaji)** | **~2,5 juta** |

---

# Trade-off Eksplisit

Karena timeline 1 bulan adalah agresif, berikut keputusan yang diambil secara sadar beserta risikonya:

| # | Keputusan | Risiko | Mitigasi |
|---|---|---|---|
| 1 | Pakai Firebase/Supabase, bukan backend custom | Vendor lock-in, biaya skala | Abstraksi repository layer agar migrasi lebih mudah |
| 2 | Payment Midtrans/Xendit **sandbox** di v1.0 | Tidak bisa transaksi riil saat rilis | Plan v1.1 (minggu 5–6) aktifkan production key |
| 3 | Verifikasi guru **manual** oleh admin | Tidak scalable, bottleneck | Bangun antarmuka admin; otomatisasi di v2.0 |
| 4 | Video call pakai plugin open-source (mis. `flutter_webrtc` + signaling Firebase) — tidak pakai Zoom/Agora berbayar | Kualitas lebih rendah, butuh pengerjaan tambahan | Pakai Agora SDK free tier (10.000 menit/bulan) sebagai fallback |
| 5 | Hanya 1 bahasa (ID) di v1.0 | Pasar EN tertunda | Struktur `intl` siap, tambah `en` di v1.1 |
| 6 | Tidak ada tes E2E otomatis lengkap | Bug lolos ke produksi | Manual test plan 40+ skenario + monitoring ketat |
| 7 | Tidak ada fitur rekomendasi AI | Pengalaman kurang personal | Tambahkan di roadmap v2.0 (bulan 3–6) |
| 8 | Dark mode ditambahkan Pekan 3, bukan Pekan 1 | Visually inconsistent di tengah | Dipercepat dengan token desain Pekan 1 |

---

# Post-Rilis: Roadmap v1.1 (Minggu 5–8)

Jika v1.0 diterima pasar, prioritas berikut dalam 1 bulan berikutnya:

1. **Aktifkan payment production** (Midtrans/Xendit production key + webhook hardening).
2. **Chat enhancement**: pesan suara, lampiran, reaksi.
3. **Sistem refund** sebagian otomatis.
4. **Voucher & promo engine** (berbasis rules Firestore).
5. **Rekomendasi guru** berbasis filter popularitas + jarak.
6. **Optimasi Performa**: lazy-load list, image caching (`cached_network_image`), shrink APK size.
7. **Analytics & funnel** untuk konversi booking.

---

# Risiko & Pivots

| Risiko | Dampak | Pemicu | Pivots |
|---|---|---|---|
| Review App Store ditolak | Rilis tertunda 3–7 hari | Privacy label salah, izin kurang | Ikuti [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) sejak Pekan 3 |
| Payment gateway gagal integrasi | Tidak ada monetisasi | Bug SDK, kredensial salah | Backup: Stripe Indonesia (jika Midtrans/Xendit gagal) |
| Tim terlalu kecil | Kualitas menurun | Cuti/overload | Tambah 1 engineer freelance Pekan 3 |
| Bug kritis di rilis | Reputasi rusak | Lolos QA | Hotfix pipeline sudah disiapkan via Fastlane |
| Traction rendah | Produk tidak viable | <100 unduhan minggu pertama | Fokus marketing di komunitas musik lokal |

---

# Lampiran A — Tech Stack Final

- **Framework**: Flutter `^3.10.0-290.4.beta`
- **State**: `flutter_riverpod`
- **Routing**: `go_router`
- **Backend**: Firebase (Auth + Firestore + Storage + FCM + Functions)
- **Payment**: Midtrans Snap (sandbox) / Xendit alternatif
- **Chat**: Firestore real-time + FCM
- **Video call**: `flutter_webrtc` + Firebase signaling / Agora free tier
- **Localization**: `flutter_intl`
- **Analytics**: Firebase Analytics + Crashlytics
- **CI/CD**: GitHub Actions → Fastlane (opsional) → Firebase App Distribution
- **Testing**: `flutter_test`, `mocktail`, `integration_test`

---

# Lampiran B — Checklist Rilis

- [ ] `flutter build appbundle --release` sukses
- [ ] `flutter build ipa --release` sukses
- [ ] Android: upload key terdaftar di Play Console
- [ ] iOS: provisioning profile production aktif
- [ ] Data safety form (Play) terisi
- [ ] Privacy nutrition label (App Store) terisi
- [ ] Listing store: judul, deskripsi, ikon, screenshot, feature graphic
- [ ] Privacy Policy URL aktif & dapat diakses publik
- [ ] Syarat & Ketentuan versi final
- [ ] Kontak dukungan (email) aktif
- [ ] Crashlytics/Sentry menerima event dari build rilis
- [ ] Internal UAT pass (5 tester)
- [ ] Demo ke stakeholder / investor

---

# Penutup

Timeline ini realistis *jika* tim kecil tetap fokus selama 4 minggu penuh tanpa gangguan. Setiap trade-off di atas didokumentasikan agar tidak menjadi technical debt tak terlihat di v2.0. Setelah v1.0 stabil, iterasi v1.1 (minggu 5–8) akan menutup gap monetization dan personalization, lalu v2.0 (bulan 3+) mulai menambahkan fitur rekomendasi AI dan perluasan kategori di luar musik.

**Apakah timeline ini sesuai dengan ekspektasi Anda? Jika ya, saya akan lanjut generate file PDF-nya di `docs/timeline.pdf`.**