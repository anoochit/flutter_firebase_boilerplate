import 'dart:developer';

import 'package:boilerplate/services/auth_service.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  // user profile
  String? userDisplayName;
  String? userUid;

  // navigation bottom
  RxInt currentIndex = 0.obs;

  void getUserData() {
    userDisplayName = firebaseAuth.currentUser!.displayName!;
    userUid = firebaseAuth.currentUser!.uid;
    log("current user = " + userDisplayName!);
    log("current user uid = " + userUid!);
    update();
  }

  void changeDisplayName(String name) {
    userDisplayName = name;
    update();
  }
}
