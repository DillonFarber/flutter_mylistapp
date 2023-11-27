import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mylistapp/firebase_options.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Container(
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextField(
                            controller: _email,
                            enableSuggestions: true,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                const InputDecoration(hintText: 'Enter Email'),
                          ),
                        ),
                        const Spacer(
                          flex: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextField(
                            controller: _password,
                            obscureText: true,
                            enableSuggestions: true,
                            autocorrect: false,
                            decoration: const InputDecoration(
                                hintText: 'Enter Password'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                                elevation: MaterialStatePropertyAll(10),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                              ),
                              onPressed: () async {
                                final email = _email.text;
                                final password = _password.text;
                                try {
                                  final userCredentials = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  print('success');
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    print("error");
                                    log("error");
                                    if (e.code == 'user-not-found') {
                                      log("user not found");
                                      print("user not found");
                                    } else if (e.code == 'invalid-email') {
                                      print("invalid email");
                                    } else if (e.code == 'wrong-password') {
                                      print("wrong password");
                                    } else if (e.code == 'weak-password') {
                                      print("weak password");
                                    } else {
                                      print(e.code.toString());
                                    }
                                  }
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                                elevation: MaterialStatePropertyAll(10),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                              ),
                              onPressed: () async {},
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
