import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:send_money/common_ui/sm_common_button.dart';
import 'package:send_money/common_ui/sm_common_text_field.dart';
import 'package:send_money/utils/constants.dart';
import 'package:send_money/utils/extensions.dart';
import 'package:send_money/utils/sm_text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: SMTextStyle.loginTitle(context),
                ),
              ),
              const SizedBox(height: 24.0),
              SMCommonTextField(
                controller: _emailController,
                hintText: "example@email.com",
                labelText: "Email Address",
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
                onChanged: (value) {
                  setState(() => _email = value);
                },
              ),
              const SizedBox(height: 16.0),
              SMCommonTextField(
                controller: _passwordController,
                labelText: "Password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: _passwordValidator,
                onChanged: (value) {
                  setState(() => _email = value);
                },
              ),
              const SizedBox(height: 16.0),
              SMCommonButton(
                height: context.height * 0.05,
                width: double.infinity,
                title: 'Login',
                isFilled: true,
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    //no op
                  } else {
                    //no op
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email format';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
