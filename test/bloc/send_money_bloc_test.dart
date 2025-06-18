import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/dto/transaction.dart';
import 'package:send_money/send_money/bloc/send_money_bloc.dart';
import 'package:send_money/send_money/bloc/send_money_event.dart';
import 'package:send_money/send_money/bloc/send_money_state.dart';
import 'package:send_money/utils/constants.dart';

import '../mocks/send_money_mocks.mocks.dart';

void main() {
  late SendMoneyBloc sendMoneyBloc;
  late MockSendMoneyInteractor mockSendMoneyInteractor;

  setUp(() {
    mockSendMoneyInteractor = MockSendMoneyInteractor();
    sendMoneyBloc = SendMoneyBloc(mockSendMoneyInteractor);
  });

  tearDown(() {
    sendMoneyBloc.close();
  });

  group('SendMoneyBloc', () {
    blocTest<SendMoneyBloc, SendMoneyState>(
      'emits success=true when amount is valid and sendMoney returns non-null',
      build: () {
        when(mockSendMoneyInteractor.isValid(any)).thenReturn(true);
        when(mockSendMoneyInteractor.sendMoney(any)).thenAnswer((_) async {
          return Transaction.createNew(0);
        });
        return SendMoneyBloc(mockSendMoneyInteractor);
      },
      act: (bloc) => bloc.add(SendMoney(100)),
      expect: () => [
        const SendMoneyState(
          success: false,
          error: '',
          status: SendMoneyStatus.loading,
        ),
        const SendMoneyState(
          success: true,
          error: '',
          status: SendMoneyStatus.done,
        ),
        SendMoneyState.initial(),
      ],
      verify: (_) {
        verify(mockSendMoneyInteractor.isValid(100)).called(1);
        verify(mockSendMoneyInteractor.sendMoney(100)).called(1);
      },
    );

    blocTest<SendMoneyBloc, SendMoneyState>(
      'emits success=false when amount is invalid',
      build: () {
        when(mockSendMoneyInteractor.isValid(any)).thenReturn(false);
        return SendMoneyBloc(mockSendMoneyInteractor);
      },
      act: (bloc) => bloc.add(SendMoney(100000)),
      expect: () => [
        const SendMoneyState(
          success: false,
          error: '',
          status: SendMoneyStatus.loading,
        ),
        const SendMoneyState(
          success: false,
          error: '',
          status: SendMoneyStatus.done,
        ),
        SendMoneyState.initial(),
      ],
      verify: (_) {
        verify(mockSendMoneyInteractor.isValid(100000)).called(1);
        verifyNever(mockSendMoneyInteractor.sendMoney(any));
      },
    );
  });
}
