import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmc/screens/gvp_bvp/gvp_bvp.dart';
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
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
          ),
          SvgPicture.asset(
            "assets/user.svg",
            width: 100,
            height: 100,
          ),
          ElevatedButton(
              onPressed: () {
                TransferStation().push(context);
              },
              child: Text("Click to transfer")),
          SizedBox(height: 200,),
          ElevatedButton(
              onPressed: () {
                GvpBvpScreen().push(context);
              },
              child: Text("Click to gvp / bvp"))
        ],
      ),
    );
  }
}
