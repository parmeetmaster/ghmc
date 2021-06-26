import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/dashboard/zone_model.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/screens/success/success.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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

  Future<ApiResponse> getTransferStationTabData(
      {String? dateString, String? userid}) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/transfer_station_dashboard",
            data: {"date": dateString!, "user_id": userid}));
    MProgressIndicator.hide(); // close indicator
    return response;
  }

  Future<ApiResponse> getVehicleType() async {
    ApiResponse response = await ApiBase().baseFunction(
        () => ApiBase().getInstance()!.get("/dash_vechiles_type"));
    MProgressIndicator.hide(); // close indicator
    return response;
  }

  Future<ApiResponse?> getReport({
    String? startdate,
    String? enddate,
    MenuItem? zone,
    MenuItem? vehicle,
  }) async {
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

  _showConfirmDownloadBottomSheet(
      BuildContext context, Function performDownload) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                    )),
              ],
            ),
            Center(
              child: Text(
                "Do you like to download ?",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: GradientButton(
                title: "Download File",
                height: 20,
                fontsize: 14,
                onclick: () async {
                  Navigator.pop(ctx);
                  performDownload();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  double percentage=0.0;
  _performDownload(StateSetter setState) async{

    String? android_path = "${await FileSupport().getRootFolderPath()}/GHMC/";
    File? file = await FileSupport().downloadCustomLocation(
        url: "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4",
        path: android_path,
        filename: "Progress",
        extension: ".xls",
        progress: (p) {
          p.printinfo;
          setState((){

          });
        });

    print("download file size ${FileSupport().getFileSize(file: file!)}");




  }

  _showDownloadProgress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                        )),
                  ],
                ),
                Center(
                  child: Text(
                    "Downlaod Progress",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                new CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: 0.7,
                  center: new Text("100%"),
                  progressColor: Colors.green,
                ),

              ],
            ),
          );
        });
      },
    );
  }

  void downloadFile(
      {required BuildContext context,
      required String filename,
      required String url}) async {
    percentage=0;
    _showConfirmDownloadBottomSheet(context, () {
      _showDownloadProgress(context);
    });


  }
}
