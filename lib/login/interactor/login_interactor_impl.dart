import 'package:send_money/login/interactor/login_interactor.dart';

import '../../utils/constants.dart';

class LoginInteractorImpl implements LoginInteractor {
  @override
  bool isEmailCorrect(String? email) {
    return email == 'admin@test.com';
  }

  @override
  bool isPasswordCorrect(String? password) {
    return password == 'test1234!';
  }
}
