import 'package:get_it/get_it.dart';
import 'package:send_money/module.dart';
import 'package:dio/dio.dart';

final networkModuleDependency = GetIt.instance;

class NetworkModule extends Module {
  late Dio provideDio;

  @override
  Future<void> setupDependencies() async {
    provideDio = Dio(
      BaseOptions(
        baseUrl: 'https://684ff260e7c42cfd1796af7c.mockapi.io/api/v1/', //todo: hide this
      ),
    );

    networkModuleDependency.registerSingleton<NetworkModule>(this);
  }
}
