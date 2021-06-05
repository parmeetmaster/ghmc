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
    Response? responses;
    try {
      ApiResponse response = await ApiBase().baseFunction(
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
    } catch (e) {
      print(e);
      // "Something is error".showSnackbar(context);
    }
    if (responses!.statusCode == 200)
      // dialog = AwesomeDialog(
      //   context: context,
      //   dialogType: DialogType.SUCCES,
      //   animType: AnimType.BOTTOMSLIDE,
      //   title: 'Upload Successful',
      //   desc: 'Your data is posted successfully',
      //   btnOkOnPress: () {
      //     dialog!.dissmiss();
      //     //Navigator.of(context,rootNavigator: true);
      //   },
      // )..show();
      print('55555555555555555555555555');
      print('Upload Successful');
  }
}
