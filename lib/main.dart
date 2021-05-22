import 'package:flutter/material.dart';
import 'package:ghmc/provider/dash_board_provider.dart';
import 'package:ghmc/provider/login_provider.dart';
import 'package:ghmc/signInScreen.dart';
import 'package:ghmc/splashScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (ctx)=>LoginProvider()),
      ChangeNotifierProvider(create: (ctx)=>DashBoardProvider())


    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GHMC',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/signIn': (context) => SignInScreen(),
      },
    );
  }
}
