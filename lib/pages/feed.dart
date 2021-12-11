import 'dart:developer';

import 'package:boilerplate/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/services/analytic_service.dart';
import 'package:flutterfire_ui/firestore.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // firebase analytics
    firebaseAnalytics.setCurrentScreen(screenName: 'Feed');
    return FirestoreQueryBuilder(
      query: firebaseFirestore.collection("feed").orderBy('createdAt', descending: true),
      pageSize: 10,
      builder: (BuildContext context, FirestoreQueryBuilderSnapshot<dynamic> snapshot, Widget? child) {
        // error
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        // loading
        if (snapshot.isFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // show data
        return ListView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (BuildContext context, int index) {
            // if we reached the end of the currently obtained items, we try to
            // obtain more items
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              // Tell FirestoreQueryBuilder to try to obtain more items.
              // It is safe to call this function from within the build method.
              snapshot.fetchMore();
            }
            return ListTile(
              title: Text(snapshot.docs[index]['title']),
              onTap: () {
                // firebase analytics) ;
              },
            );
          },
        );
      },
    );
  }
}
