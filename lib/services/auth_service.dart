import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthService(this._apiService, this._storageService);

  /// Login dengan email dan password
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.post('/auth/login', body: {
      'email': email,
      'password': password,
    });

    final loginResponse = LoginResponse.fromJson(response);

    // Simpan token
    await _storageService.setAccessToken(loginResponse.accessToken);
    if (loginResponse.refreshToken != null) {
      await _storageService.setRefreshToken(loginResponse.refreshToken!);
    }

    // Set token ke API service
    _apiService.setAccessToken(loginResponse.accessToken);

    // Ambil data user dari API
    User? userData;
    try {
      userData = await getCurrentUser();
    } catch (_) {}

    // Simpan data user
    if (userData != null) {
      await _storageService.setUserId(userData.id);
      await _storageService.setUserRole(userData.role);
      await _storageService.setUserEmail(userData.email);
      await _storageService.setUserName(userData.fullName);
      await _storageService.setIsGuest(false);
    } else if (loginResponse.user != null) {
      await _storageService.setUserId(loginResponse.user!.id);
      await _storageService.setUserRole(loginResponse.user!.role);
      await _storageService.setUserEmail(loginResponse.user!.email);
      await _storageService.setUserName(loginResponse.user!.fullName);
      await _storageService.setIsGuest(false);
    }

    return loginResponse;
  }

  /// Register akun baru (murid atau guru)
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
    required String role,
    String? phoneNumber,
    String? biography,
    String? instrument,
    int? yearExperience,
    File? profilePicture,
    File? certificate,
    File? cv,
    File? portfolio,
  }) async {
    final fields = <String, String>{
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'role': role,
      'full_name': fullName,
    };

    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      fields['phone_number'] = phoneNumber;
    }
    if (biography != null && biography.isNotEmpty) {
      fields['biography'] = biography;
    }
    if (instrument != null && instrument.isNotEmpty) {
      fields['instrument'] = instrument;
    }
    if (yearExperience != null) {
      fields['year_experience'] = yearExperience.toString();
    }

    // Prepare files
    List<http.MultipartFile>? files;

    if (profilePicture != null) {
      files ??= [];
      files.add(await http.MultipartFile.fromPath('profile_picture', profilePicture.path));
    }
    if (certificate != null) {
      files ??= [];
      files.add(await http.MultipartFile.fromPath('certificate', certificate.path));
    }
    if (cv != null) {
      files ??= [];
      files.add(await http.MultipartFile.fromPath('cv', cv.path));
    }
    if (portfolio != null) {
      files ??= [];
      files.add(await http.MultipartFile.fromPath('portfolio', portfolio.path));
    }

    if (files != null && files.isNotEmpty) {
      return await _apiService.postMultipartMultipleFiles(
        '/auth/register',
        fields: fields,
        files: files,
      );
    } else {
      return await _apiService.post('/auth/register', body: fields);
    }
  }

  /// Register simple (tanpa file upload) - langsung login setelah register
  Future<User> registerSimple({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
    required String role,
    String? phoneNumber,
    String? instrument,
    int? yearExperience,
  }) async {
    final body = <String, dynamic>{
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'role': role,
      'full_name': fullName,
    };

    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      body['phone_number'] = phoneNumber;
    }
    if (instrument != null && instrument.isNotEmpty) {
      body['instrument'] = instrument;
    }
    if (yearExperience != null) {
      body['year_experience'] = yearExperience;
    }

    // Register ke API
    await _apiService.post('/auth/register', body: body);

    // Langsung login setelah register berhasil
    final loginResponse = await login(email: email, password: password);

    // Return user data
    try {
      final user = await getCurrentUser();
      return user;
    } catch (_) {
      // Fallback: return user dari login response
      return User(
        id: loginResponse.user?.id ?? '',
        email: email,
        fullName: fullName,
        role: role,
      );
    }
  }

  /// Ambil data user yang sedang login
  Future<User> getCurrentUser() async {
    final response = await _apiService.get('/auth/me');
    return User.fromJson(response['data'] ?? response);
  }

  /// Refresh token
  Future<void> refreshToken() async {
    final refreshToken = _storageService.getRefreshToken();
    if (refreshToken == null) {
      throw ApiException('Refresh token tidak ditemukan');
    }

    final response = await _apiService.post('/auth/refresh', body: {
      'refresh_token': refreshToken,
    });

    final loginResponse = LoginResponse.fromJson(response);
    await _storageService.setAccessToken(loginResponse.accessToken);
    if (loginResponse.refreshToken != null) {
      await _storageService.setRefreshToken(loginResponse.refreshToken!);
    }
    _apiService.setAccessToken(loginResponse.accessToken);
  }

  /// Logout
  Future<void> logout() async {
    try {
      final refreshToken = _storageService.getRefreshToken();
      if (refreshToken != null) {
        await _apiService.post('/auth/logout', body: {
          'refresh_token': refreshToken,
        });
      }
    } catch (_) {
      // Ignore errors on logout
    } finally {
      await _storageService.clearAuth();
      _apiService.setAccessToken(null);
    }
  }

  /// Set guest mode dengan nama acak
  Future<void> setGuestMode(String randomName) async {
    await _storageService.setGuestMode(randomName);
  }

  /// Cek apakah user sudah login
  bool isLoggedIn() {
    return _storageService.isLoggedIn();
  }

  /// Cek apakah user guest
  bool isGuest() {
    return _storageService.isGuest();
  }

  /// Inisialisasi session dari stored token
  Future<void> initSession() async {
    final token = _storageService.getAccessToken();
    if (token != null) {
      _apiService.setAccessToken(token);
    }
  }

  /// Ambil daftar instrument
  Future<List<Instrument>> getInstruments() async {
    final response = await _apiService.get('/instrument');
    final data = response['data'] ?? response;

    if (data is List) {
      return data.map((e) => Instrument.fromJson(e)).toList();
    }
    return [];
  }

  /// Get stored user role
  String? getUserRole() {
    return _storageService.getUserRole();
  }

  /// Get stored user email
  String? getUserEmail() {
    return _storageService.getUserEmail();
  }

  /// Get stored user name
  String? getUserName() {
    return _storageService.getUserName();
  }
}
