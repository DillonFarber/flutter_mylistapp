// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mylistapp/constants/routes.dart';
import 'package:mylistapp/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification email. Please open it to verify your email."),
          const Text(
              "If you haven't received a verification email, please press resend email verification."),
          TextButton(
              onPressed: () async {
                final user = AuthService.firebase().currentUser;
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Resend email verififcation')),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Restarting'),
          )
        ],
      ),
    );
  }
}
