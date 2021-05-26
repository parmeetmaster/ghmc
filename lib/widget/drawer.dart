import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/screens/add_data/add_data_page.dart';
import 'package:ghmc/screens/gvp_bvp/gvp_bvp.dart';
import 'package:ghmc/screens/settings/settings_page.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/util/utils.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
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
                              "assets"
                                  "/images/ThingstoDoinTelangana.jpg",
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text(
                      "${Globals.userData!.data!.firstName} ${Globals.userData!.data!.lastName??""}",
                      style:
                      TextStyle(color: Color(0xFFAD801D9E), fontSize: 25),
                    ),
                    Text("${Globals.userData!.data!.mobileNumber??""}",
                        style: TextStyle(
                          color: Color(0xFFAD801D9E),
                          fontSize: 25,
                        )),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 25, color: Colors.white),
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
                style: TextStyle(fontSize: 25, color: Colors.white),
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
                style: TextStyle(fontSize: 25, color: Colors.white),
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
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (GvpBvpScreen()),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "Notifications",
                style: TextStyle(fontSize: 25, color: Colors.white),
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
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (SettingPage()),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                "LogOut",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }}
