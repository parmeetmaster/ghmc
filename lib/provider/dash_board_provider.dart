import 'package:dio/dio.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/screens/success/success.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
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

  void uploadData(MultipartFile file, int? active_percent, int? type_of_waste, DriverDataModel? model, String? scanid, Future<MultipartFile> multipart, BuildContext context) async{
    MultipartFile? multipart2=await multipart;
    ApiBase().getInstance()!.post("/add_transferstaion",data: FormData.fromMap({
      'user_id': Globals.userData!.data!.userId,
      'wastage': active_percent,
      'type_waste': type_of_waste,
      'geo_id': scanid,
      'image':multipart2
    }));
    MProgressIndicator.hide();
  Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessScreen()));
  }
}
