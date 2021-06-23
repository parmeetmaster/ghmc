import 'package:flutter/material.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:provider/provider.dart';

class SplashProvider extends ChangeNotifier {


 static SplashProvider  getReference(BuildContext context) {
    return Provider.of<SplashProvider>(context,listen: false);
  }

  initialisation(BuildContext context) async {
   await DashBoardProvider.getReference(context).setZones();
   await DashBoardProvider.getReference(context).setVehicleType();
  }
}
