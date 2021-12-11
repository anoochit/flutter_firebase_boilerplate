import 'package:boilerplate/generated/l10n.dart';
import 'package:boilerplate/pages/signin.dart';
import 'package:boilerplate/services/analytic_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:boilerplate/models/appdata.dart';
import 'package:boilerplate/widgets/error_widget.dart';
import 'package:boilerplate/widgets/loading_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      //locale: const Locale('th'),
      title: 'Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.promptTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        brightness: Brightness.light,
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
            firebaseAnalytics.logAppOpen();
            return const SigninPage();
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
