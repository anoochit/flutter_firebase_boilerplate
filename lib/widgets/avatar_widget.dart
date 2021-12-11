import 'package:flutter/material.dart';

Widget getAvatarWidget(BuildContext context, {required String displayName}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
      child: Text(
        displayName.toUpperCase().characters.first,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
    ),
  );
}
