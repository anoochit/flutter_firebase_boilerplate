import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage firebaseStorage = FirebaseStorage.instance;

Future<bool> uploadFile(
    {required String filePath, required String targetRef}) async {
  File file = File(filePath);

  try {
    // upload image
    await firebaseStorage.ref(targetRef).putFile(file);
    return true;
  } catch (e) {
    // cannnot upload image
    log("Error cannot upload file - " + e.toString());
    return false;
  }
}

Future<String> getDownloadURL({required String targetRef}) async {
  String downloadURL = await firebaseStorage.ref(targetRef).getDownloadURL();
  return downloadURL;
}
