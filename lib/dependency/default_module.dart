import 'package:get_it/get_it.dart';
import 'package:send_money/login/interactor/login_interactor.dart';
import 'package:send_money/login/interactor/login_interactor_impl.dart';
import 'package:send_money/module.dart';
import 'package:send_money/send_money/interactor/send_money_interactor.dart';
import 'package:send_money/send_money/interactor/send_money_interactor_impl.dart';

final defaultModuleDependency = GetIt.instance;

class DefaultModule implements Module {
  late final LoginInteractor loginInteractor;
  late final SendMoneyInteractor sendMoneyInteractor;

  @override
  Future<void> setupDependencies() async {
    loginInteractor = LoginInteractorImpl();
    sendMoneyInteractor = SendMoneyInteractorImpl();

    defaultModuleDependency.registerSingleton<DefaultModule>(this);
  }
}
