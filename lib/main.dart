import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/dependency/default_module.dart';
import 'package:send_money/home/bloc/home_bloc.dart';
import 'package:send_money/login/bloc/login_bloc.dart';
import 'package:send_money/modules.dart';
import 'package:send_money/router.dart';
import 'package:send_money/send_money/bloc/send_money_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializedModules();
  runApp(const SendMoney());
}

class SendMoney extends StatelessWidget {
  const SendMoney({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultModule = dependency<DefaultModule>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(defaultModule.loginInteractor)),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<SendMoneyBloc>(create: (context) => SendMoneyBloc(defaultModule.sendMoneyInteractor)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
