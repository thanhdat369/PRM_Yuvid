import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/accountDTO.dart';

class AuthService {
  Future<void> signOut() async {
    await MockSession.logout();
  }

  Future<bool> isSignedIn() async {
    return await MockSession.isAuthen();
  }

  Future<int> getCurrentUser() async {
    return await MockSession.getCurrentUser();
  }
}
