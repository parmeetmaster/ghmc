import 'dart:async';
import 'dart:io' show File, Platform;

/*import 'package:barcode_scan2/barcode_scan2.dart';*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/model/culvert/culvert_issue.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/screens/add_vehicle/add_vehicle_page.dart';
import 'package:ghmc/screens/culvert/culvert.dart';
import 'package:ghmc/screens/dashboard/vehicle_tab.dart';
import 'package:ghmc/screens/errors/14_no_result_found.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/util/open_camera.dart';
import 'package:ghmc/util/permission.dart';
import 'package:ghmc/util/qrcode_screen.dart';
import 'package:ghmc/widget/drawer.dart';
import 'package:ghmc/util/utils.dart';
import 'package:provider/provider.dart';

import '../../globals/globals.dart';
import '../Testscreens/test_screen.dart';
import 'dashbaord/dashboard_body.dart';
import 'map_button_screen/gvp_bep_image_upload.dart';

enum WhatToDo { qrscan }

class DashBordScreen extends StatefulWidget {
  CredentialsModel? credentialsModel;

  dynamic operation;

  DashBordScreen({Key? key, dynamic? operaton = null}) {
    credentialsModel = Globals.userData;
    this.operation = operaton;
  }

  @override
  _DashBordScreenState createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen>
    with SingleTickerProviderStateMixin {
  int _activeIndex = 0;
  File? vehicle_image;

  @override
  void initState() {
    PermissionUtils().initialisationPermission();
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      print("WidgetsBinding");
    });

    //🎰 it call function when build is complete
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (widget.operation != null) {
        if (widget.operation == WhatToDo.qrscan) {
          _scan();
        }
      }
    });

    final provider = DashBoardProvider.getReference(context);
    provider.setAuthentications();
    provider.checkNearGepBep(context);
  }

  @override
  Widget build(BuildContext context) {
    // its for qr scan from multiple screens

    int activetab;

/*    final scanResult = this.scanResult;*/
    return Consumer<DashBoardProvider>(builder: (context, value, child) {
      if (Globals.authority != null)
        return Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              drawer: Drawer(
                child: MainDrawer(),
              ),
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF9C27B0),
                        Color(0xFFF06292),
                        Color(0xFFFF5277),
                      ],
                    ),
                  ),
                ),
                /*    leading: IconButton(
                  icon: const Icon(Icons.menu),
                  tooltip: 'menu',
                  onPressed: () {},
                ),*/
                title: const Text('Dash Board'),
                actions: [
                  if (value.is_any_gep_bep == null ||
                      value.is_any_gep_bep == false)
                    IconButton(
                      icon: const Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      tooltip: 'Map',
                      onPressed: () {},
                    ),
                  if (value.is_any_gep_bep == true)
                    IconButton(
                      icon: const Icon(
                        Icons.map,
                        color: Colors.green,
                      ),
                      tooltip: 'Map',
                      onPressed: () {
                        GvpBepImageUpload().push(context);
                      },
                    ),
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner_rounded),
                    tooltip: 'Qr Scan',
                    onPressed: _scan,
                  ),
                ],
              ),
              body: Globals.authority!.data!.first.dashboard == true
                  ? DashBoardBody()
                  : Container(),
            ),
          ),
        );
      else
        return Scaffold(
            body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
    });
  }

  // code to invoke scan in flutter

  _scan() async {
    if (PermissionUtils().isCameraEnable() == false) {
      await "Please give Camera Permission".showSnackbar(context);
      Future.delayed(Duration(seconds: 5)).then(
          (value) async => await PermissionUtils().initialisationPermission());
      return;
    }

    String qrdata = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => QRScreen()));
    print("QR DATA IS : $qrdata");
    Globals.userData!.data!.userId!.printwtf;
    MProgressIndicator.show(context);
    ApiResponse? model;
    if (Globals.userData!.data!.departmentId == "3") {
      //see if user is admin
      model = await DashBoardProvider.getReference(context)
          .getDriverData(widget.credentialsModel!.data!.userId!, qrdata);
    } else if (Globals.userData!.data!.departmentId == "4") {
      //see if user is transfer manager
      model = await DashBoardProvider.getReference(context)
          .getTransferStationManager(
              widget.credentialsModel!.data!.userId!, qrdata);
    } else if (Globals.userData!.data!.departmentId == "10") {
      //see if user is culert eligible
      model = await DashBoardProvider.getReference(context)
          .getCulvertData(widget.credentialsModel!.data!.userId!, qrdata);
    }
    print(" here is data${model!.status}");
    if (model.status != 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NoResultFoundScreen()));
    }

    MProgressIndicator.hide();
    if (model.status != 200) {
      model.message!.showSnackbar(context);
    }

    // check user for attendence
    if (Globals.getUserData()!.data!.departmentId == "3") {
      justDialog(model);
    } else if (Globals.getUserData()!.data!.departmentId == "4") {
      showTransferScreen(model, qrdata);
    } else if (Globals.getUserData()!.data!.departmentId == "10") {
      showCulvertScreen(model, qrdata);
    }
  }

  int flexleft = 3;
  int flexright = 5;
  TextStyle style = TextStyle(
    fontSize: 16,
  );

  // show vehicles dashboard
  showSuccessDialog(QrDataModel model) {


    showDialog(context: context, builder: (BuildContext context){
      return Dialog(
        child: StatefulBuilder(
          builder: (context, StateSetter setState1) {
            return Container(
              width: 360.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: ListView(shrinkWrap: true,

                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      SvgPicture.asset(
                        'assets/check.svg',
                        width: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Successfully scanned",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Vehicle Type", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.vechileType!.trim()}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Vehicle Number", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.vechileNo!.trim()}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Driver Name", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.driverName}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft,
                              child: Text("Driver Phno", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.driverNo}",
                                style: style,
                              ))
                        ],
                      ),
                      /*              SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: flexleft, child: Text("Address", style: style)),
                        SizedBox(
                          width: 15,
                          child: Text(":"),
                        ),
                        Expanded(
                            flex: flexright,
                            child: Text(
                              "${model.data!.address}",
                              style: style,
                            ))
                      ],
                    ),*/
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft, child: Text("Landmark", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.landmark}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(flex: flexleft, child: Text("Ward", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.ward}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft, child: Text("Circle", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.circle}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: flexleft, child: Text("Scan Date", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.createdDate}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(flex: flexleft, child: Text("Zone", style: style)),
                          SizedBox(
                            width: 15,
                            child: Text(":"),
                          ),
                          Expanded(
                              flex: flexright,
                              child: Text(
                                "${model.data!.zone}",
                                style: style,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () async {
                          vehicle_image = await Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) => CameraPicture()));
                          setState1((){} );
                        },
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: vehicle_image == null
                                  ? Colors.black
                                  : Colors.green[500],
                            ),
                          ),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          if (vehicle_image == null) {
                            "Please add Image".showSnackbar(context);
                          }
                          final provider =
                          Provider.of<DashBoardProvider>(context, listen: false);
                          ApiResponse? response = await provider.uploadVehicleImage(
                              vehicle_image: vehicle_image, id: model.data!.id);
                          if (response!.status == 200) {
                            vehicle_image=null;
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.2),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green[800],
                                borderRadius: BorderRadius.circular(30)),
                            // Make rounded corner
                            child: Text(
                              "Done",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ]),
              ),
            );
          }
        ),
      );
    });
  }

  // step 2.1 qr
  justDialog(
    ApiResponse? model,
  ) {
    if (model!.status == 200)
      showSuccessDialog(QrDataModel.fromJson(model.completeResponse ?? ""));
    setState(() {});
  }

  // step 2.2 qr
  showTransferScreen(ApiResponse? model, String qrdata) {
    if (model!.status == 200)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => TransferStation(
                    model: QrDataModel.fromJson(model.completeResponse ?? ""),
                    scanid: qrdata,
                  )));
  }

  void showCulvertScreen(ApiResponse model, String qrdata) {
    if (model.status == 200)
      CulvertScreen(CulvertIssue.fromJson(model.completeResponse))
          .push(context);
  }
}
// todo add validation for jpg and png
