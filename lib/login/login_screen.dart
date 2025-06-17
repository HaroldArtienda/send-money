import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:send_money/common_ui/sm_common_button.dart';
import 'package:send_money/common_ui/sm_common_text_field.dart';
import 'package:send_money/login/bloc/login_bloc.dart';
import 'package:send_money/login/bloc/login_event.dart';
import 'package:send_money/login/bloc/login_state.dart';
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
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

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
                labelText: "Email Address",
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
                onChanged: (value) => setState(() => _email = value),
              ),
              const SizedBox(height: 16.0),
              SMCommonTextField(
                controller: _passwordController,
                labelText: "Password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: _passwordValidator,
                onChanged: (value) => setState(() => _email = value),
              ),
              const SizedBox(height: 16.0),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.error.isNotEmpty && !state.isLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }

                  if (state.success && !state.isLoading) {
                    context.replace(SMRoute.home.path);
                  }
                },
                builder: (context, state) {
                  return state.isLoading
                      ? CircularProgressIndicator()
                      : SMCommonButton(
                          height: context.height * 0.05,
                          width: double.infinity,
                          title: 'Login',
                          isFilled: true,
                          onTap: () => validate(loginBloc),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validate(LoginBloc loginBloc) {
    if (_formKey.currentState?.validate() ?? false) {
      loginBloc.add(
        Login(_emailController.text, _passwordController.text),
      );
    }
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
