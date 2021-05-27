import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/screens/success/success.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';
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

  Future<ApiResponse?> getTransferStationManager(String id, String qrdata)async {
    ApiResponse response=await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/sfa_user", data: {"user_id": id, "geo_id": qrdata}));
    return  response;
  }


  void uploadData(MultipartFile file, int? active_percent, int? type_of_waste, QrDataModel? model, String? scanid, Future<MultipartFile> multipart, BuildContext context) async{

    if(multipart==null){
      "Please select file".showSnackbar(context);
      return;
    }


    MultipartFile? multipart2=await multipart;
    Response? responses;
 try{
    responses=await ApiBase().getInstance()!.post("/add_transferstaion",data: FormData.fromMap({
     'user_id': Globals.userData!.data!.userId,
     'wastage': active_percent,
     'type_waste': type_of_waste,
     'geo_id': scanid,
     'image':multipart2
   }));
 }
 catch(e){
"Something is error".showSnackbar(context);

 }
    MProgressIndicator.hide();
 if(responses!.statusCode==200)
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Upload Successful',
      desc: 'Your data is posted successfully',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    )..show();
  }
}
