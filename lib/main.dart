import 'package:flutter/material.dart';
import 'package:mylistapp/constants/routes.dart';
import 'package:mylistapp/views/dashboard_view.dart';
import 'package:mylistapp/views/login_view.dart';
import 'package:mylistapp/views/register_view.dart';
import 'package:mylistapp/views/verify_email_view.dart';
import 'package:mylistapp/services/auth/auth_service.dart';
// import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      dashboardRoute: (context) => const DashboardView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const DashboardView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return Scaffold(
                appBar: AppBar(),
                body: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()));
        }
      },
    );
  }
}
