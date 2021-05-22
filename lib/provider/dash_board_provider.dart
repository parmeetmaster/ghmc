import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:provider/provider.dart';

mixin Callabe<T> {
  getInstances(T? provider, BuildContext context) {
    if (context != null)
      return Provider.of<T>(context);
    else
      return Provider.of<T>(context, listen: false);
  }
}

class DashBoardProvider extends ChangeNotifier with Callabe {
  static DashBoardProvider getInstance(BuildContext context) {

      return Provider.of<DashBoardProvider>(context, listen: false);
  }

  verifyQrData(String qrString) {}

  Future<ApiResponse?> getDriverData(String id, String qrdata)async {
   ApiResponse response=await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/sfa_user_scan", data: {"user_id": id, "geo_id": qrdata}));
 return  response;
  }
}
