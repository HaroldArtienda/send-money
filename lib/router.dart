import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:send_money/login/login_screen.dart';
import 'package:send_money/utils/constants.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: loginRoute,
      builder: (ctx, state) {
        return LoginScreen();
      },
    ),
  ],
);
