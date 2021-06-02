import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/provider/login_provider.dart';
import 'package:ghmc/screens/add_data/add_data_page.dart';
import 'package:ghmc/screens/add_vehicle/add_vehicle_page.dart';
import 'package:ghmc/screens/gvp_bvp/gvp_bvp.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';
import 'package:ghmc/screens/settings/settings_page.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';

import 'package:ghmc/util/utils.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late AwesomeDialog dialog;
  double drawer_item_text=15;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFAD1457),
                Color(0xFFAD801D9E),
              ],
            )),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(
                                  "assets/images/ThingstoDoinTelangana.jpg",
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "${Globals.userData!.data!.firstName} ${Globals.userData!.data!.lastName??""}",
                      style:
                      TextStyle(color: Color(0xFFAD801D9E), fontSize: 20),
                    ),
                    Text("${Globals.userData!.data!.mobileNumber??""}",
                        style: TextStyle(
                          color: Color(0xFFAD801D9E),
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: drawer_item_text, color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "Geo Tagging",
                style: TextStyle(fontSize: drawer_item_text, color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.library_books,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "Data Entry",
                style: TextStyle(fontSize: drawer_item_text, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (AddDataPage()),
                    ));
              },
            ),
            if(Globals.userData!.data!.departmentId=="3")
              ListTile(
                leading: Icon(
                  Icons.directions_car_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  "Add Transport Vehicle",
                  style: TextStyle(fontSize: drawer_item_text, color: Colors.white),
                ),
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (AddDataPage()),
                    ));
                },
              ),

            ListTile(
              leading: Icon(
                Icons.directions_car_rounded,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "Add GVP/BEP",
                style: TextStyle(fontSize: drawer_item_text, color: Colors.white),
              ),
              onTap: () {
              /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (GvpBvpScreen()),
                    ));*/
              },
            ),
          /*  ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "Notifications",
                style: TextStyle(fontSize: drawer_item_text, color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "Settings",
                style: TextStyle(fontSize: drawer_item_text, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (SettingPage()),
                    ));
              },
            ),*/
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "LogOut",
                style: TextStyle(fontSize: drawer_item_text, color: Colors.white),
              ),
              onTap: () {
                 dialog=   AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Logout',
                    desc: 'Do you really like to logout?',
                    btnCancelOnPress: () {
                      Navigator.of(context,rootNavigator: true).pop();
                    },
                  btnOkOnPress: () async{
                  await  LoginProvider.getInstance(context).logout(context);


                    },
                )..show();


              },
            ),
          ],
        ),
      ),
    );
  }}
