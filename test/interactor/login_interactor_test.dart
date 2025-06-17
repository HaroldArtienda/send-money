import 'package:flutter_test/flutter_test.dart';
import 'package:send_money/login/interactor/login_interactor.dart';
import 'package:send_money/login/interactor/login_interactor_impl.dart';

void main() {
  late LoginInteractor interactor;

  setUp(() {
    interactor = LoginInteractorImpl();
  });

  group('LoginInteractorImpl', () {
    test('returns true for correct email', () {
      expect(interactor.isEmailCorrect('admin@test.com'), isTrue);
    });

    test('returns false for incorrect email', () {
      expect(interactor.isEmailCorrect('wrong@test.com'), isFalse);
    });

    test('returns true for correct password', () {
      expect(interactor.isPasswordCorrect('test1234!'), isTrue);
    });

    test('returns false for incorrect password', () {
      expect(interactor.isPasswordCorrect('wrong123'), isFalse);
    });

    test('returns false when email is null', () {
      expect(interactor.isEmailCorrect(null), isFalse);
    });

    test('returns false when password is null', () {
      expect(interactor.isPasswordCorrect(null), isFalse);
    });
  });
}
