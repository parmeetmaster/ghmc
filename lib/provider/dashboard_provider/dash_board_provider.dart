import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/dashboard/zone_model.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/screens/success/success.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

class DashBoardProvider extends ChangeNotifier {
  AwesomeDialog? dialog;
  DashBoardProvider? _instance;
  String demo = "00";
  MenuItemModel? zones;
  MenuItemModel? vehicle_type;
  MenuItemModel? transfer_station;



  getProviderObject() {
    _instance = _instance ?? new DashBoardProvider();
    return _instance;
  }

  static DashBoardProvider getReference(BuildContext context) {
    return Provider.of<DashBoardProvider>(context, listen: false);
  }

  verifyQrData(String qrString) {}

  setZones() async {
    ApiResponse response = await getZones();
    zones = MenuItemModel.fromJson(response.completeResponse);
  }

  setTransferStation() async {
    ApiResponse response = await getTransferStation();
    transfer_station = MenuItemModel.fromJson(response.completeResponse);
  }

  setVehicleType() async {
    ApiResponse response = await getVehicleType();
    vehicle_type = MenuItemModel.fromJson(response.completeResponse);
  }

  Future<ApiResponse?> getDriverData(String id, String qrdata) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/sfa_user_scan", data: {"user_id": id, "geo_id": qrdata}));
    return response;
  }

  Future<ApiResponse?> getTransferStationManager(
      String id, String qrdata) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/sfa_user", data: {"user_id": id, "geo_id": qrdata}));
    return response;
  }

  uploadData(
      int? active_percent,
      int? type_of_waste,
      QrDataModel? model,
      String? scanid,
      Future<MultipartFile> multipart,
      BuildContext context) async {
    if (multipart == null) {
      "Please select file".showSnackbar(context);
      return;
    }

    MultipartFile? multipart2 = await multipart;
    Response? responses;
    try {
      responses = await ApiBase().getInstance()!.post("/add_transferstaion",
          data: FormData.fromMap({
            'user_id': Globals.userData!.data!.userId,
            'wastage': active_percent,
            'type_waste': type_of_waste,
            'geo_id': scanid,
            'image': multipart2
          }));
    } catch (e) {
      "Something is error".showSnackbar(context);
    }
    MProgressIndicator.hide();
    if (responses!.statusCode == 200)
      dialog = AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Upload Successful',
        desc: 'Your data is posted successfully',
        btnOkOnPress: () {
          dialog!.dismiss();
          //Navigator.of(context,rootNavigator: true);
        },
      )..show();
  }

  void updatePassword(
      {TextEditingController? old_password,
      TextEditingController? new_password,
      TextEditingController? new_confirm_password}) {}

  Future<ApiResponse?> getVehicesInfo(
      {required String userid, required String dateString}) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/vechile_dashboard",
            data: {"user_id": userid, "date": dateString}));
    MProgressIndicator.hide();
    return response;
  }

  Future<ApiResponse> getZones() async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/zones"));
    MProgressIndicator.hide(); // close indicator
    return response;
  }

  Future<ApiResponse> getTransferStation() async {
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/transfer"));
    MProgressIndicator.hide(); // close indicator
    return response;
  }


  Future<ApiResponse> getVehicleType() async {
    ApiResponse response = await ApiBase().baseFunction(
        () => ApiBase().getInstance()!.get("/dash_vechiles_type"));
    MProgressIndicator.hide(); // close indicator
    return response;
  }

  Future<ApiResponse?> getReport( {String? startdate, String? enddate, MenuItem? zone, MenuItem? vehicle,}) async {
    ApiResponse response = await ApiBase().baseFunction(
        () => ApiBase().getInstance()!.post("/search_view", data: {
              'user_id': Globals.userData!.data!.userId,
              'zone_id': zone!.id,
              'start_date': startdate,
              'end_date': enddate,
              'vehicle_type': vehicle!.id
            }));
    MProgressIndicator.hide(); // close indicator
    return response;
  }

  void downloadFile(
      {required BuildContext context,
      required String filename,
    required  String url}) async {

    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            content: Container(
              constraints: BoxConstraints(
                  maxHeight:
                  MediaQuery.of(context).size.height *
                      .8),
              width:
              MediaQuery.of(context).size.width * 0.8,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    "Select Zone",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                  /*    LinearProgressIndicator(
                        backgroundColor: Colors.cyanAccent,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                        value: _progressValue,
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
          );
        });



    String? android_path = "${await FileSupport().getRootFolderPath()}/GHMC/";
    File? file = await FileSupport().downloadCustomLocation(
        url: "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4",
        path: android_path,
        filename: "Progress",
        extension: ".xls",
        progress: (p) {
          p.printinfo;
        });

    print("download file size ${FileSupport().getFileSize(file: file!)}");
  }


}
