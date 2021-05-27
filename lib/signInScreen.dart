import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/authenticationDBHelperClass.dart';
import 'package:ghmc/dashBordScreen.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/provider/login_provider.dart';

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
  LoginProvider? _instance;
  bool obsecure=true;
  @override
  Widget build(BuildContext context) {
     _instance =LoginProvider.getInstance(context);

    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {

    if(mode==modes.testing){
      _emailController.text="TSM-Jiyaguda";
      _passwordController.text="123456789";
    }

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
              Image.asset('assets/ic_launcher.png'),
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
                            'SIGN IN',
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
                                labelText: 'User Name',
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
                              obscureText: this.obsecure,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                suffixIcon: InkWell(
                                  onTap: (){
                                setState(() {
                                  this.obsecure=!this.obsecure;
                                });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.remove_red_eye),
                                  ),
                                ),
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

                                    await _instance!.performLogin(_emailController,_passwordController,context);

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
