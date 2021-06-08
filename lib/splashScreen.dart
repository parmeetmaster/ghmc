import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';

import 'package:ghmc/util/share_preferences.dart';

import 'screens/dashboard/dashBordScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkuserLoggedIn() async {
    String? userdata = await SPreference().getString(login_credentials);
    if (userdata != null) {
      Globals.userData=CredentialsModel.fromRawJson(userdata);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DashBordScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 2),
      () async => checkuserLoggedIn(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Mobile splash screen 2.jpg',
      fit: BoxFit.cover,
    );
  }
}
