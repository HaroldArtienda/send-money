import 'package:get_it/get_it.dart';
import 'package:send_money/dependency/network_module.dart';
import 'package:send_money/home/interactor/home_interactor.dart';
import 'package:send_money/home/interactor/home_interactor_impl.dart';
import 'package:send_money/login/interactor/login_interactor.dart';
import 'package:send_money/login/interactor/login_interactor_impl.dart';
import 'package:send_money/module.dart';
import 'package:send_money/send_money/interactor/send_money_interactor.dart';
import 'package:send_money/send_money/interactor/send_money_interactor_impl.dart';
import 'package:send_money/service/transaction_service.dart';
import 'package:send_money/service/transaction_service_impl.dart';

final defaultModuleDependency = GetIt.instance;

class DefaultModule implements Module {
  late final LoginInteractor loginInteractor;
  late final SendMoneyInteractor sendMoneyInteractor;
  late final TransactionService transactionService;
  late final HomeInteractor homeInteractor;

  @override
  Future<void> setupDependencies() async {
    final networkModule = defaultModuleDependency<NetworkModule>();

    loginInteractor = LoginInteractorImpl();
    sendMoneyInteractor = SendMoneyInteractorImpl();
    transactionService = TransactionServiceImpl(networkModule.provideDio);
    homeInteractor = HomeInteractorImpl(transactionService);

    defaultModuleDependency.registerSingleton<DefaultModule>(this);
  }
}
