import 'package:prm_yuvid/services/auth_service.dart';

class AuthRepo {
  AuthService authService = AuthService();
  
  Future<void> signOut() => authService.signOut();

  Future<bool> isSignedIn() => authService.isSignedIn();

  Future<int> getCurrentUser() => authService.getCurrentUser();
}
