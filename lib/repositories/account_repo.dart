import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/services/account_service.dart';

class AccountRepository {
  AccountApiProvider accountApiProvider = AccountApiProvider();

  Future<AccountDTO> login(String username, String password) =>
      accountApiProvider.login(username, password);
  Future<bool> editProfile(AccountEditDTO dto) =>
      accountApiProvider.editProfile(dto);

  Future<AccountSignUpDTO> signup(AccountSignUpDTO dto) =>
      accountApiProvider.signup(dto);
}
