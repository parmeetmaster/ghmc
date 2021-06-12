import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/support/support_types.dart';

class SupportProvider extends ChangeNotifier {
  Future<ApiResponse?> getSupporTypes() async {
    ApiResponse response =
        await ApiBase().baseFunction(() => ApiBase().getInstance()!.get(
              "/services_type",
            ));
    return response;
  }

  Future<ApiResponse?> submitComplaint(
      {SupportItems? item,
      TextEditingController? controller,
      File? photo,
      File? recording,
      BuildContext? context})  async{

    Map<String,dynamic> map={
      'user_id': '${Globals.userData!.data!.userId}',
      'support_list_id': '${item!.id}',
      'description': '${controller!.text}',
      'voice_recorder': await FileSupport().getMultiPartFromFile(recording!),
      'image': await FileSupport().getMultiPartFromFile(photo!),
    };

    ApiResponse response =
        await ApiBase().baseFunction(() => ApiBase().getInstance()!.post(
      "/add_support",data: FormData.fromMap(map)
    ));
    return response;




  }
}
