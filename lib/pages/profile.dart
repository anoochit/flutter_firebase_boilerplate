import 'package:boilerplate/pages/signin.dart';
import 'package:boilerplate/services/analytic_service.dart';
import 'package:boilerplate/services/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // firebase analytics
    firebaseAnalytics.setCurrentScreen(screenName: 'Profile Settings');
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Edit Profile'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.delete_forever),
          title: const Text('Remove Account'),
          onTap: () {
            //firebaseAuth.currentUser!.delete();
            // goto sign in page
            //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const SigninPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Sign Out'),
          onTap: () {
            firebaseAuth.signOut();
            // goto sign in page
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SigninPage()));
          },
        ),
      ],
    );
  }
}
