import 'dart:async';
import 'dart:io' show Platform;

/*import 'package:barcode_scan2/barcode_scan2.dart';*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'package:ghmc/provider/dash_board_provider.dart';
import 'package:ghmc/screens/add_vehicle/add_vehicle_page.dart';
import 'package:ghmc/screens/gvp_bvp/gvp_bvp.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/userDataScreen.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/drawer.dart';

import 'globals/globals.dart';
import 'screens/Testscreens/test_screen.dart';
import 'util/qrcode_screen.dart';

class DashBordScreen extends StatefulWidget {
  CredentialsModel? credentialsModel;

  DashBordScreen(this.credentialsModel, {Key? key}) : super(key: key);

  @override
  _DashBordScreenState createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen>    with SingleTickerProviderStateMixin {
/*  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];*/
  TabController? _tabController;
  int _activeIndex = 0;
  @override
  void initState() {
    super.initState();
    print(widget.credentialsModel!.data!.email);
    /*   Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });*/

    _tabController = TabController(
    length: 2, vsync: this
    );

  }



  @override
  Widget build(BuildContext context) {
    int activetab;


/*    final scanResult = this.scanResult;*/
    return MaterialApp(
      home: DefaultTabController(
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
              IconButton(
                icon: const Icon(Icons.map),
                tooltip: 'map',
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.qr_code_scanner_rounded),
                tooltip: 'Scan',
                onPressed: _scan,
              ),
            ],
            bottom: TabBar(

              indicator: BoxDecoration(
                  border: Border(
                left: BorderSide(color: Colors.white),
                // provides to left side
                right: BorderSide(color: Colors.white), // for right side
              )),
              tabs: [
                Tab(
                  icon: Text(
                    "Vehicle",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Tab(
                  icon: Text(
                    "Gvp/Bvp",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          body: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      children: [
        TestScreen(),
        TestScreen(),
      ],
    );
  }

  Future<void> _scan() async {
    String qrdata = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => QRScreen()));
    print("QR DATA IS : $qrdata");
    print(qrdata);
    MProgressIndicator.show(context);
    ApiResponse? model;

    if (Globals.userData!.data!.department_id == "3") {
      // if user is admin
      model = await DashBoardProvider.getInstance(context)
          .getDriverData(widget.credentialsModel!.data!.userId!, qrdata);
    } else if (Globals.userData!.data!.department_id == "4") {
      // if user is transfer manager
      model = await DashBoardProvider.getInstance(context)
          .getTransferStationManager(
              widget.credentialsModel!.data!.userId!, qrdata);
    }

    MProgressIndicator.hide();

    // check user for attendence
    if (Globals.getUserData()!.data!.department_id == "3") {
      justDialog(model);
    } else if (Globals.getUserData()!.data!.department_id == "4") {
      showTransferScreen(model, qrdata);
    }
  }

  int flexleft = 3;
  int flexright = 5;
  TextStyle style = TextStyle(
    fontSize: 16,
  );

  showSuccessDialog(QrDataModel model) {

    Dialog leadDialog = Dialog(
      child: Container(
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
                SizedBox(
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
                ),
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
                        flex: flexleft,
                        child: Text("Created On", style: style)),
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
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
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
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => leadDialog);
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
}
// todo add validation for jpg and png
