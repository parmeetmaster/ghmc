import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:provider/provider.dart';

import '../dashBordScreen.dart';

class LoginProvider extends ChangeNotifier {

  static CredentialsModel? user;

  static LoginProvider getInstance(BuildContext context) {

      return Provider.of<LoginProvider>(context, listen: false);
  }

  // call at time of input qr code
  performLogin(TextEditingController emailController,
      TextEditingController passwordController, BuildContext context) async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.post("/login", data: {
              "identity": emailController.text.toString(),
              "password": passwordController.text.toString(),
            }));
    user=  CredentialsModel.fromJson(response.completeResponse);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashBordScreen(user),
      ),
    );
  }



}
