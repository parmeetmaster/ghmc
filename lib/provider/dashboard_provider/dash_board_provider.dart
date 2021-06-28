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
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

enum downloadType{gvp_bep,transfer_station,vehicle_type}

class DashBoardProvider extends ChangeNotifier {
  AwesomeDialog? dialog;
  DashBoardProvider? _instance;
  String demo = "00";
  MenuItemModel? zones; // used to show dialog with item on dashboard
  MenuItemModel? vehicle_type; // used to show dialog with item on dashboard
  MenuItemModel? transfer_station; // used to show dialog with item on dashboard
  StateSetter? setState; // this used to manage download bottom sheet

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

  Future<ApiResponse?> getGepBepInfo(
      {required String userid, required String dateString}) async {
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/dashboard_gvp_bep",
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

  _showDownloadProgress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          this.setState = setState;

          // 🔴 sheeet Dismiss here
          if (double.tryParse(percentage)! >= 100) {
            this.setState=null;
          Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.pop(ctx);
          });
          }

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
                  height: 30,
                ),
                new CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: ((){
                    if(double.tryParse(percentage)!>100){
                      percentage="100";
                      if(this.setState!=null)
                     this.setState!((){});
                      return 1.0;


                    }else if(double.tryParse(percentage)!<0){
                      percentage="100";
                      if(this.setState!=null)
                      setState((){});
                      return 0.0;
                    }

                    else{
                      return double.tryParse(percentage)! / 100;
                    }

                  }()),
                  center: new Text("${this.percentage}%"),
                  progressColor: Colors.green,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  String percentage = "0";

  void downloadFile(
      {required BuildContext context,
      required String filename,
      required String url}) async {
    percentage = "0"; //◀ reset percentage here


    _showConfirmDownloadBottomSheet(context, () async {
      _showDownloadProgress(context);
      String? android_path = "${await FileSupport().getRootFolderPath()}/Download/";
      File? file = await FileSupport().downloadFileInDownloadFolderAndroid(
          url: url,
          //  path: android_path,
          filename: "${filename}",
          extension: ".xls",
          progress: (p) {
            p.printinfo;
            percentage=p;
            if(setState!=null)
            this.setState!((){});
          });
    });
  }

  // download master gvp bep file

  void downloadMasterFile(
      {required BuildContext context,
        required String filename, DateTime? startDate, DateTime? endDate, MenuItem? selected_transfer_station, MenuItem? selected_vehicle, MenuItem? selected_zone,required dynamic? operation}) async {
    percentage = "0"; //◀ reset percentage here
    String url="";
    Dio dio = new Dio();
    String? android_path = "${await FileSupport().getDownloadFolderPath()}/";
    android_path.printwarn;

    Directory directory = await new Directory(android_path);
    // create directory if not exist
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    directory;

    String fullPath = android_path + filename + ".xls";
    fullPath.printinfo;
    File file = new File("");

  Map<String,dynamic> map= {
    'user_id': '${Globals.userData!.data!.userId}',
    'start_date': '${DateFormat("dd-MM-yyyy").format(startDate!)}',
    'end_date': '${DateFormat("dd-MM-yyyy").format(endDate!)}',
    'zone_id': '${selected_zone!.id}',
    'vehicle_type': '${selected_vehicle!.id}'
    };

  if(operation==downloadType.transfer_station)
  map.addAll({"transfer_station":'${selected_transfer_station!.id}'});



  if(operation==downloadType.gvp_bep){
    url="https://digitalraiz.com/projects/geo_tagginging_ghmc/api/dashboard_gvp_bep_download";
  }else if(operation==downloadType.transfer_station){
    url="https://digitalraiz.com/projects/geo_tagginging_ghmc/api/transfer_search";
  }
    try {
      Response response = await dio.get(
        url,
        queryParameters:map,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
        onReceiveProgress: (received, total) {
          "Download Started".showSnackbar(context);
          if (total != -1) {
           if(int.parse((received / total * 100).toStringAsFixed(0))>=100){
             "Download Complete".showSnackbar(context);
          }
        }}
      );
      print(response.headers);
      file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }

}

}
