import 'package:flutter/material.dart';

//  colors
List<Color> grid = [
  Color(0xFF9C27B0),
  Color(0xFFF06292),
  Color(0xFFFF5277),
];

List<Color> btn_grid = [
  Color(0xFFC11E63),
  Color(0xFFC11E63),
];

const Color primary_color = Color(0xFFAD1457);

List<Color> main_color = [
  Color(0xFFAD1457),
  Color(0xFFAD801D9E),
];

//  variables
enum modes { testing, release }
dynamic mode = modes.release;

// string

const login_credentials =
    "login_credentials"; // 🧊 this is used for shared preferences
const google_place_api_key =
    "AIzaSyDFUPgy5FpZkVED-9CBHlIsNeEVqMVolWA"; // 🗾 google map credentials
