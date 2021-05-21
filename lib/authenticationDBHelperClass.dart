import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationDBHelperClass {
  static Future<Map<dynamic, dynamic>> signIn(
      {required String email, required String password}) async {
    Map<dynamic, dynamic> resultMap = {};

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      resultMap['error'] = false;
    } catch (error) {
      resultMap['error'] = true;
    }

    return Future<Map<dynamic, dynamic>>.value(resultMap);
  }
}
