import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:send_money/utils/extensions.dart';

class SMLogoutFAB extends StatelessWidget {
  const SMLogoutFAB({super.key});

  void _logout(BuildContext context) {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _logout(context),
      backgroundColor: context.theme.primaryColor,
      tooltip: 'Logout',
      child: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
    );
  }
}
