import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/storage_service.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late ApiService apiService;
  late StorageService storageService;
  late AuthService authService;

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    // Initialize services
    apiService = ApiService();
    storageService = StorageService();
    authService = AuthService(apiService, storageService);

    // Initialize storage
    await storageService.init();

    // Initialize session from stored token
    await authService.initSession();

    _isInitialized = true;
  }

  bool get isLoggedIn => authService.isLoggedIn();
  String? get userRole => authService.getUserRole();
}

// Global instance
final sl = ServiceLocator();
