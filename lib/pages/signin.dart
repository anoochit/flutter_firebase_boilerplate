import 'package:flutter/material.dart';
import 'package:boilerplate/pages/signup.dart';
import 'package:boilerplate/services/auth_service.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
                        "Sign In",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _usernameTextEditingController,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.account_circle), hintText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordTextEditingController,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.lock), hintText: 'Password'),
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
                            child: const Text("Sign Up"),
                            onPressed: () {
                              // goto signup page
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                            },
                          ),
                          ElevatedButton(
                            child: const Text("Sign In"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // signin
                                signIn(username: _usernameTextEditingController.text, password: _passwordTextEditingController.text, context: context);
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
