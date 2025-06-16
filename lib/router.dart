import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:send_money/login/login_screen.dart';
import 'package:send_money/utils/constants.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: SMRoute.login.path,
      builder: (ctx, state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: SMRoute.home.path,
      builder: (ctx, state) {
        return Scaffold();
      },
    ),
    GoRoute(
      path: SMRoute.sendMoney.path,
      builder: (ctx, state) {
        return Scaffold();
      },
    ),
    GoRoute(
      path: SMRoute.transaction.path,
      builder: (ctx, state) {
        return Scaffold();
      },
    ),
  ],
);
