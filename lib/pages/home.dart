import 'dart:developer';
import 'package:boilerplate/widgets/avatar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:boilerplate/models/appdata.dart';
import 'package:boilerplate/pages/signin.dart';
import 'package:boilerplate/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    // listen auth state change
    authStateChange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boilerplate"),
        actions: [
          userActionButton(),
        ],
      ),
      body: contenStack(),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  Widget contenStack() {
    return (appData.userDisplayName != null)
        ? IndexedStack(
            index: _currentIndex,
            children: [
              Container(),
              Container(),
            ],
          )
        : Container();
  }

  BottomNavigationBar bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      fixedColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).shadowColor,
      currentIndex: _currentIndex,
      onTap: (value) => setState(() {
        _currentIndex = value;
      }),
      items: const [
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.users), label: 'Menu 1'),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.comments), label: 'Menu 2'),
      ],
    );
  }

  Widget userActionButton() {
    return (appData.userDisplayName != null)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: getAvatarWidget(displayName: (appData.userDisplayName.toString())),
          )
        : Container();
  }

  void authStateChange() {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
        // goto sign in page
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SigninPage()));
      } else {
        log('User is signed in!');
        // load user data
        setState(() {
          appData.getUserData();
        });
      }
    });
  }
}
