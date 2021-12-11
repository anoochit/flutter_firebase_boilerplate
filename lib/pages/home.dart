import 'package:boilerplate/generated/l10n.dart';
import 'package:boilerplate/pages/chat.dart';
import 'package:boilerplate/pages/feed.dart';
import 'package:boilerplate/pages/profile.dart';
import 'package:boilerplate/services/analytic_service.dart';
import 'package:boilerplate/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:boilerplate/models/appdata.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  AppController controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    // firebase analytics
    firebaseAnalytics.setCurrentScreen(screenName: 'Home');

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        actions: [
          userActionButton(onTab: () {
            controller.currentIndex.value = 2;
            controller.update();
          }),
        ],
      ),
      body: contenStack(),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  Widget contenStack() {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller) {
          if (controller.userUid != null) {
            return IndexedStack(
              index: controller.currentIndex.value,
              children: const [
                FeedPage(),
                ChatPage(),
                ProfilePage(),
              ],
            );
          } else {
            return const Center(
              child: Text("Please Login"),
            );
          }
        });
  }

  Widget bottomNavigationBar(BuildContext context) {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.white.withOpacity(0.6),
              selectedItemColor: Colors.white,
              currentIndex: controller.currentIndex.value,
              onTap: (value) {
                controller.currentIndex.value = value;
                controller.update();
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.users), label: 'Feed'),
                BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.comments), label: 'Chat'),
                BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userAlt), label: 'Profile'),
              ],
            ),
          );
        });
  }

  Widget userActionButton({required VoidCallback onTab}) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (controller) {
        return GestureDetector(
          child: getAvatarWidget(
            context,
            displayName: '${controller.userDisplayName}',
          ),
          onTap: onTab,
        );
      },
    );
  }
}
