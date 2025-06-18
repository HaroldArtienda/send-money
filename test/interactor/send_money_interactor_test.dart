import 'package:flutter_test/flutter_test.dart';
import 'package:send_money/send_money/interactor/send_money_interactor_impl.dart';

void main() {
  late SendMoneyInteractorImpl interactor;

  setUp(() {
    interactor = SendMoneyInteractorImpl();
  });

  test('returns true when amount is less than 5000', () async {
    final result = await interactor.isValid(4999.99);
    expect(result, isTrue);
  });

  test('returns false when amount is equal to or greater than 5000', () async {
    final resultEqual = await interactor.isValid(5000);
    final resultGreater = await interactor.isValid(10000);
    expect(resultEqual, isFalse);
    expect(resultGreater, isFalse);
  });
}
