import 'package:flutter/material.dart';

Widget getAvatarWidget(BuildContext context, {required String displayName}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
      child: FittedBox(
        child: Text(
          displayName.toUpperCase().characters.first,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
    ),
  );
}

Widget getAvatarBigWidget(BuildContext context, {required String displayName}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
      radius: 60,
      child: SizedBox(
        width: 50,
        child: FittedBox(
          child: Text(
            displayName.toUpperCase().characters.first,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
    ),
  );
}
