import 'package:get_it/get_it.dart';
import 'package:send_money/login/interactor/login_interactor.dart';
import 'package:send_money/login/interactor/login_interactor_impl.dart';
import 'package:send_money/module.dart';

final defaultModuleDependency = GetIt.instance;

class DefaultModule implements Module {
  late final LoginInteractor loginInteractor;

  @override
  Future<void> setupDependencies() async {
    loginInteractor = LoginInteractorImpl();

    defaultModuleDependency.registerSingleton<DefaultModule>(this);
  }
}
