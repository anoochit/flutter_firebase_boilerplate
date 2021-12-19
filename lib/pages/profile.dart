import 'package:boilerplate/models/appdata.dart';
import 'package:boilerplate/pages/signin.dart';
import 'package:boilerplate/services/analytic_service.dart';
import 'package:boilerplate/services/auth_service.dart';
import 'package:boilerplate/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // firebase analytics
    firebaseAnalytics.setCurrentScreen(screenName: 'Profile Settings');
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (controller) {
        return Column(
          children: [
            getAvatarBigWidget(context, displayName: '${controller.userDisplayName}'),
            Text(
              '${controller.userDisplayName}',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Edit Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever),
              title: const Text('Remove Account'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete Account"),
                    content: const Text("Do you want delete your accout?"),
                    actions: [
                      TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      TextButton(
                          child: const Text("Ok"),
                          onPressed: () {
                            // delete account
                            firebaseAuth.currentUser!.delete();
                            // goto sign in page
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => const SigninPage()));
                          }),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sign Out'),
              onTap: () {
                firebaseAuth.signOut();
                // goto sign in page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SigninPage()));
              },
            ),
          ],
        );
      },
    );
  }
}
