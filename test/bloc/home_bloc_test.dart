import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:send_money/home/bloc/home_bloc.dart';
import 'package:send_money/home/bloc/home_event.dart';
import 'package:send_money/home/bloc/home_state.dart';

main() {
  late HomeBloc bloc;

  setUp(() {
    bloc = HomeBloc();
  });

  tearDown(() {
    bloc.close();
  });

  group('HomeBloc', () {
    final double fakeMoney = 124590.91;

    blocTest(
      'emit success walletMoney',
      build: () => HomeBloc(),
      act: (bloc) => bloc.add(GetWalletMoney()),
      wait: Duration(milliseconds: 2200),
      expect: () => [
        HomeState(walletMoney: 0.0, isLoading: true, error: ''),
        HomeState(walletMoney: fakeMoney, isLoading: false, error: '')
      ]
    );
  });
}
