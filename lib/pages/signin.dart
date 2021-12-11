import 'dart:developer';

import 'package:boilerplate/generated/l10n.dart';
import 'package:boilerplate/models/appdata.dart';
import 'package:boilerplate/services/analytic_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/pages/signup.dart';
import 'package:boilerplate/services/auth_service.dart';
import 'package:get/get.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _usernameTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AppController controller = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    authStateChange();
  }

  @override
  Widget build(BuildContext context) {
    // firebase analytics
    firebaseAnalytics.setCurrentScreen(screenName: 'SignIn');
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        left: true,
        minimum: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Card(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S.of(context).signIn,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _usernameTextEditingController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.account_circle),
                          hintText: S.of(context).email,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).pleaseEnterEmail;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordTextEditingController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: S.of(context).password,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).pleaseEnterPassword;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text("Sign Up"),
                            onPressed: () {
                              // goto signup page
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => const SignupPage()));
                            },
                          ),
                          ElevatedButton(
                            child: Text(S.of(context).signIn),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // signin
                                signIn(
                                    username: _usernameTextEditingController.text,
                                    password: _passwordTextEditingController.text,
                                    context: context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void authStateChange() {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
        // load user data
        controller.getUserData();
      }
    });
  }
}
