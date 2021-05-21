import 'package:flutter/material.dart';
import 'package:ghmc/signInScreen.dart';
import 'package:ghmc/splashScreen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GHMC',
      initialRoute: '/',
      routes: {
        '/' : (context) => SplashScreen(),
        '/signIn' : (context) => SignInScreen(),
      },
    );
  }
}

