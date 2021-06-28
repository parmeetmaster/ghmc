import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';

abstract class FAppBar {
  static getCommonAppBar({String title = ""}) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: main_color,
          ),
        ),
      ),
      title: Text('${title}'),
    );
  }
}
