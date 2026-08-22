import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserRole = 'user_role';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyIsGuest = 'is_guest';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Access Token
  Future<void> setAccessToken(String token) async {
    await _prefs.setString(_keyAccessToken, token);
  }

  String? getAccessToken() {
    return _prefs.getString(_keyAccessToken);
  }

  Future<void> removeAccessToken() async {
    await _prefs.remove(_keyAccessToken);
  }

  // Refresh Token
  Future<void> setRefreshToken(String token) async {
    await _prefs.setString(_keyRefreshToken, token);
  }

  String? getRefreshToken() {
    return _prefs.getString(_keyRefreshToken);
  }

  Future<void> removeRefreshToken() async {
    await _prefs.remove(_keyRefreshToken);
  }

  // User Role
  Future<void> setUserRole(String role) async {
    await _prefs.setString(_keyUserRole, role);
  }

  String? getUserRole() {
    return _prefs.getString(_keyUserRole);
  }

  // User Email
  Future<void> setUserEmail(String email) async {
    await _prefs.setString(_keyUserEmail, email);
  }

  String? getUserEmail() {
    return _prefs.getString(_keyUserEmail);
  }

  // User ID
  Future<void> setUserId(String id) async {
    await _prefs.setString(_keyUserId, id);
  }

  String? getUserId() {
    return _prefs.getString(_keyUserId);
  }

  // User Name
  Future<void> setUserName(String name) async {
    await _prefs.setString(_keyUserName, name);
  }

  String? getUserName() {
    return _prefs.getString(_keyUserName);
  }

  // Is Guest
  Future<void> setIsGuest(bool isGuest) async {
    await _prefs.setBool(_keyIsGuest, isGuest);
  }

  bool getIsGuest() {
    return _prefs.getBool(_keyIsGuest) ?? false;
  }

  // Check if logged in
  bool isLoggedIn() {
    return getAccessToken() != null;
  }

  // Check if is guest
  bool isGuest() {
    return getIsGuest();
  }

  // Clear all auth data
  Future<void> clearAuth() async {
    await _prefs.remove(_keyAccessToken);
    await _prefs.remove(_keyRefreshToken);
    await _prefs.remove(_keyUserRole);
    await _prefs.remove(_keyUserEmail);
    await _prefs.remove(_keyUserId);
    await _prefs.remove(_keyUserName);
    await _prefs.remove(_keyIsGuest);
  }

  // Set guest mode with random name
  Future<void> setGuestMode(String randomName) async {
    await setUserName(randomName);
    await setIsGuest(true);
    // Clear any existing tokens
    await removeAccessToken();
    await removeRefreshToken();
    await removeUserRole();
    await removeUserEmail();
    await removeUserId();
  }

  Future<void> removeUserRole() async {
    await _prefs.remove(_keyUserRole);
  }

  Future<void> removeUserEmail() async {
    await _prefs.remove(_keyUserEmail);
  }

  Future<void> removeUserId() async {
    await _prefs.remove(_keyUserId);
  }

  Future<void> removeUserName() async {
    await _prefs.remove(_keyUserName);
  }
}
