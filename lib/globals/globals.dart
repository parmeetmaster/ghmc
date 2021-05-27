import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';

class Globals {
  static CredentialsModel? userData;

  static CredentialsModel? getUserData() {
    return userData!;
  }

  void getuser() {}


}
