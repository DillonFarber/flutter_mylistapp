// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:mylistapp/constants/routes.dart';
import 'package:mylistapp/services/auth/auth_exceptions.dart';
import 'package:mylistapp/services/auth/auth_service.dart';
import 'package:mylistapp/utilities/show_error_log.dart';
import 'package:mylistapp/views/verify_email_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email; //
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter Email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: true,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter Password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'email already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'email is invalid');
              } on GenericAuthException {
                await showErrorDialog(context, 'Failed to register user');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            style: const ButtonStyle(
              alignment: Alignment.center,
              elevation: MaterialStatePropertyAll(10),
              backgroundColor: MaterialStatePropertyAll(Colors.black),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text(
              'Go to Login!',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
