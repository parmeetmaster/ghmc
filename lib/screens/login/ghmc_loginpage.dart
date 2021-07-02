import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/util/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // types
  bool errorLogin = false;

  // formKey for form validation
  final _formKey = GlobalKey<FormState>();

  // TextEditingController
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginProvider? _instance;
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    _instance = LoginProvider.getInstance(context);
    if (modes.testing == mode) {
      _emailController.text = "9533627734";
      _passwordController.text = "123456789";
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFAD1457),
                      Color(0xFFAD801D9E),
                    ],
                  )),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Image.asset(
                      "assets/images/GHMC.png",
                      height: 200,
                      width: 300,
                    ),
                  ),
                ),
                Positioned(
                  right: 00,
                  bottom: 00,
                  left: 00,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 50,
                        width: 320,
                        color: Colors.white,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                height: 350,
                width: 320,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFAD801D9E), width: 2.0),
                                borderRadius: BorderRadius.circular(29)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29),
                              borderSide: BorderSide(
                                  color: Color(0xFFAD801D9E), width: 2.0),
                            ),
                            hintText: 'USER NAME',
                            prefixIcon: Container(
                                margin: EdgeInsets.only(left: 8, right: 8),
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xFFAD1457),
                                        Color(0xFFAD801D9E),
                                      ],
                                    )),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: obsecure,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFAD801D9E), width: 2.0),
                            borderRadius: BorderRadius.circular(29),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(29),
                            borderSide: BorderSide(
                                color: Color(0xFFAD801D9E), width: 2.0),
                          ),
                          hintText: 'PASSWORD',
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                this.obsecure = !this.obsecure;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.remove_red_eye),
                            ),
                          ),
                          prefixIcon: Container(
                            width: 40,
                            margin: EdgeInsets.only(left: 8, right: 8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xFFAD1457),
                                    Color(0xFFAD801D9E),
                                  ],
                                )),
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_emailController.text.isEmpty &&
                            _passwordController.text.isEmpty) {
                          "Email and password Both required"
                              .showSnackbar(context);
                          return;
                        }

                        await _instance!.performLogin(
                            _emailController, _passwordController, context);
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          "SIGN IN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                        width: MediaQuery.of(context).size.width * .5,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(colors: main_color),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
