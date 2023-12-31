// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mylistapp/enums/menu_action.dart';
import 'package:mylistapp/services/auth/auth_service.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            devtools.log(value.toString());
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (_) => false);
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem(value: MenuAction.logout, child: Text('Logout')),
            ];
          }),
        ],
        backgroundColor: Colors.blue,
      ),
      body: const Text('ui-dashboard'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log out'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}
