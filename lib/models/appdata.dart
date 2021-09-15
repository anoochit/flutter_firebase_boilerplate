import 'package:boilerplate/services/auth_service.dart';

late AppData appData;

class AppData {
  String? userDisplayName;
  String? userUid;

  void getUserData() {
    userDisplayName = firebaseAuth.currentUser!.displayName!;
    userUid = firebaseAuth.currentUser!.uid;
  }

  void changeDisplayName(String name) {
    userDisplayName = name;
  }
}
