import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ghmc/provider/add_gvp_bep_provider/addGvpBepProvider.dart';
import 'package:ghmc/provider/add_data/add_data_provider.dart';
import 'package:ghmc/provider/add_vehicle/add_vehicle.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/provider/location_provider/location_provider.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/provider/splash_provider/splash_provider.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';
import 'package:ghmc/splashScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ghmc/util/share_preferences.dart';
import 'package:ghmc/util/utils.dart';
import 'package:provider/provider.dart';

import 'provider/support/support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveUtils.initalised();

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
