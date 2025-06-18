import 'package:get_it/get_it.dart';
import 'package:send_money/dependency/default_module.dart';
import 'package:send_money/dependency/network_module.dart';
import 'package:send_money/module.dart';

final dependency = GetIt.instance;

final List<Module> modules = [
  NetworkModule(),
  DefaultModule(),
];

Future<void> initializedModules() async {
  for (final module in modules) {
    await module.setupDependencies();
  }
}
