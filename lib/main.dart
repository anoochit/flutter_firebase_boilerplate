import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:boilerplate/models/appdata.dart';
import 'package:boilerplate/pages/home.dart';
import 'package:boilerplate/widgets/error_widget.dart';
import 'package:boilerplate/widgets/loading_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  appData = AppData();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // has error
          if (snapshot.hasError) {
            return const Scaffold(
              body: ErrorMessageWidget(),
            );
          }

          // load home page
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomePage();
          }

          // loading
          return const Scaffold(
            body: LoadingWidget(),
          );
        },
      ),
    );
  }
}
