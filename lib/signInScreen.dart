import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/authenticationDBHelperClass.dart';
import 'package:ghmc/dashBordScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // types
  bool errorLogin = false;

  // formKey for form validation
  final _formKey = GlobalKey<FormState>();

  // TextEditingController
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF9C27B0),
                Color(0xFFF06292),
                Color(0xFFFF5277),
              ],
            ),
          ),
        ),
        Center(
          child: ListView(
            children: [
              Image.asset('assets/GHMC.png'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    // width: MediaQuery.of(context).size.width * 0.90,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 18.0,
                          ),
                          Text(
                            'LOGIN',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.account_circle_rounded),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Enter valid email address';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid password';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width *
                                  double.infinity,
                              // child: GestureDetector(
                              //   child: Container(
                              //     child: Center(
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Text('LOGIN'),
                              //       ),
                              //     ),
                              //     decoration: BoxDecoration(
                              //       gradient: LinearGradient(
                              //         colors: <Color>[
                              //           Color(0xFF9C27B0),
                              //           Color(0xFFF06292),
                              //           Color(0xFFFF5277),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              //   onTap: () async {
                              //     if (_formKey.currentState!.validate()) {
                              //       var x = await AuthenticationDBHelperClass
                              //           .signIn(
                              //         email: _emailController.text,
                              //         password: _passwordController.text,
                              //       );
                              //       if (!x['error']) {
                              //         Navigator.pushReplacement(
                              //           context,
                              //           CupertinoPageRoute(
                              //             builder: (context) =>
                              //                 DashBordScreen(),
                              //           ),
                              //         );
                              //       } else {
                              //         setState(() {
                              //           errorLogin = true;
                              //           Text('Incorrect Email or password');
                              //         });
                              //       }
                              //     }
                              //   },
                              // ),
                              ///
                              child:  ElevatedButton(
                                  child: Text('LOGIN'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var x = await AuthenticationDBHelperClass
                                          .signIn(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                      if (!x['error']) {
                                        Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                DashBordScreen(),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          errorLogin = true;
                                          Text('Incorrect Email or password');
                                        });
                                      }
                                    }
                                  },
                              ),
                            ),
                          ),
                          errorLogin
                              ? Text('Enter valid details')
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
