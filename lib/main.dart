import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ghmc/provider/add_gvp_bep_provider/addGvpBepProvider.dart';
import 'package:ghmc/provider/add_data/add_data_provider.dart';
import 'package:ghmc/provider/add_vehicle/add_vehicle.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/provider/location_provider/location_provider.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/provider/splash_provider/splash_provider.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';
import 'package:ghmc/splashScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ghmc/util/share_preferences.dart';
import 'package:ghmc/util/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'provider/support/support.dart';

import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Declared as global, outside of any class
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  // Use this method to automatically convert the push data, in case you gonna use our data standard
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveUtils.initalised();

  FirebaseApp firebaseApp = await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getToken().then((value) {
    String? token = value;
    print(token);
    token!.printwtf; // print fcm token
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => LoginProvider()),
      ChangeNotifierProvider(create: (ctx) => DashBoardProvider()),
      ChangeNotifierProvider(create: (ctx) => AddVehicleProvider()),
      ChangeNotifierProvider(create: (ctx) => AddDataProvider()),
      ChangeNotifierProvider(create: (ctx) => LocationProvider()),
      ChangeNotifierProvider(create: (ctx) => AddGvpBepProvider()),
      ChangeNotifierProvider(create: (ctx) => SupportProvider()),
      ChangeNotifierProvider(create: (ctx) => SplashProvider()),
      ChangeNotifierProvider(create: (ctx) => CulvertProvider()),
    ],
    child: Phoenix(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HiveUtils utils = new HiveUtils();
    // utils.addRecord(DownloadModel(id: "14",download_link: "www.google.com",download_path: "storage", file_type: 'mp4', file_name: 'dad.com',));
    utils.getRecordsById("14");
    return MaterialApp(
      /*  theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme,
        )
      ),*/
      debugShowCheckedModeBanner: false,
      title: 'GHMC',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/signIn': (context) => LoginPage(),
      },
    );
  }
}
// todo working start from owner type test pending
