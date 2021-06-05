// import 'dart:js';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghmc/api/api.dart';
import 'package:provider/provider.dart';

class AddGvpBepProvider extends ChangeNotifier {

  AwesomeDialog? dialog;

  static AddGvpBepProvider getInstance(BuildContext context) {
    return Provider.of<AddGvpBepProvider>(context, listen: false);
  }

  Future<ApiResponse?> addGvpBepData({
    String? type,
    String? userId,
    String? zoneId,
    String? circleId,
    String? wardId,
    String? landMarkId,
    String? address,
    String? latitude,
    String? longitude,
  }) async {
    ApiResponse response;
       response = await ApiBase().baseFunction(
        () => ApiBase().getInstance()!.post('/add_gvp_bep', data: {
          'type': type,
          'user_id': userId,
          'zone_id': zoneId,
          'circle_id': circleId,
          'ward_id': wardId,
          'land_mark_id': landMarkId,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
        }),
      );
      return response;
  }
}
