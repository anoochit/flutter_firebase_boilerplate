import 'package:flutter/material.dart';
import 'package:boilerplate/pages/signin.dart';
import 'package:boilerplate/services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _displaynameTextEditingController = TextEditingController();
  final TextEditingController _usernameTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Sign Up",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _displaynameTextEditingController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          hintText: 'Your Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter username";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _usernameTextEditingController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter username";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordTextEditingController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
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
                            child: const Text("Sign In"),
                            onPressed: () {
                              // goto signin page
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SigninPage()));
                            },
                          ),
                          ElevatedButton(
                            child: const Text("Sign Up"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // sign up
                                signUp(
                                    displayName: _displaynameTextEditingController.text,
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
}
