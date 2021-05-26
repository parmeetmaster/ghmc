import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/driver_data_model.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ghmc/provider/dash_board_provider.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simple_logger/simple_logger.dart';

class TransferStation extends StatefulWidget {
  DriverDataModel? model;
  String? scanid;

  TransferStation({DriverDataModel? model, String? scanid, Key? key}) {
    this.model = model;
    this.scanid = scanid;
  }

  @override
  _TransferStationState createState() => _TransferStationState();
}

class _TransferStationState extends State<TransferStation> {
  double gap = 10;
  int? active_percent = 25;

  int? type_of_waste = 0;

  late Future<MultipartFile> multipart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'menu',
          onPressed: () {},
        ),
        title: const Text('Transfer Station'),
        actions: [
          Image.asset("assets/truck.png"),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Scan',
            onPressed: _truck_loader,
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    _getRowVehicleDetails(key: "Owner Type", value: ""),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Vehicle Type",
                        value: "${widget.model!.data!.vechileType}"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Vehicle Number",
                        value: "${widget.model!.data!.vechileNo}"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Drive Name",
                        value: "${widget.model!.data!.driverName}"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Driver Number",
                        value: "${widget.model!.data!.driverNo}"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Landmark",
                        value: "${widget.model!.data!.landmark}"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Ward", value: "${widget.model!.data!.ward}"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Circle", value: "${widget.model!.data!.circle}"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Zone", value: "${widget.model!.data!.zone}"),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Center(
                child: Text(
              "Percentage of Waste",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
            height: 50,
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getPercentageContainer("25"),
              _getPercentageContainer("50"),
              _getPercentageContainer("75"),
              _getPercentageContainer("100"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
                child: Text(
              "Type of Waste",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
            height: 50,
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineButton(
                onPressed: () {
                  setState(() {
                    this.type_of_waste = 0;
                  });
                },
                borderSide: BorderSide(
                    color: type_of_waste == 0
                        ? Color(0xFF5FD548)
                        : Color(0xFF9C27B0)),
                shape: StadiumBorder(),
                child: const Text("Domestic"),
              ),
              OutlineButton(
                onPressed: () {
                  setState(() {
                    this.type_of_waste = 1;
                  });
                },
                borderSide: BorderSide(
                    color: type_of_waste == 1
                        ? Color(0xFF5FD548)
                        : Color(0xFF9C27B0)),
                shape: StadiumBorder(),
                child: const Text("Commercial"),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF9C27B0),
                              Color(0xFFF06292),
                              Color(0xFFFF5277),
                            ],
                          ),
                        ),
                        height: 50,
                        width: 99,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        this.multipart = getMultiPartFromFile();
                      },
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 100,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 200,
                        width: 99,
                      ),
                    ),
                  ],
                )),
          ),
          InkWell(
            onTap: () async {
              MProgressIndicator.show(context);
              MultipartFile file = await multipart;
              DashBoardProvider.getInstance(context).uploadData(
                  file,
                  active_percent,
                  type_of_waste,
                  widget.model,
                  widget.scanid,
                  multipart,context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 200,
                child: FlatButton(
                    height: 30,
                    minWidth: 100,
                    onPressed: () async {
                      MProgressIndicator.show(context);
                      MultipartFile file = await multipart;
                      DashBoardProvider.getInstance(context).uploadData(
                          file,
                          active_percent,
                          type_of_waste,
                          widget.model,
                          widget.scanid,
                          multipart,context);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }

// widgets
  _getRowVehicleDetails({String key = "", String value = ""}) {
    int flexleft = 4;
    int flexright = 5;
    TextStyle style = TextStyle(
      fontSize: 16,
    );
    return Row(
      children: [
        Expanded(flex: flexleft, child: Text("$key", style: style)),
        SizedBox(
          width: 15,
          child: Text(":"),
        ),
        Expanded(
            flex: flexright,
            child: Text(
              "$value",
              style: style,
            ))
      ],
    );
  }

  _getPercentageContainer(String percent) {
    return InkWell(
      onTap: () {
        this.active_percent = int.parse(percent);
        setState(() {});
      },
      child: Container(
        height: 40,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            percent + "%",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: int.parse(percent) == active_percent
                ? [
                    Color(0xFF297F29),
                    Color(0xFF5FD548),
                    Color(0xFF5BFF69),
                  ]
                : [
                    Color(0xFFFF5277),
                    Color(0xFFF06292),
                    Color(0xFF9C27B0),
                  ],
          ),
        ),
      ),
    );
  }

  void _truck_loader() {}

  Future<MultipartFile> getMultiPartFromFile() async {
    File? file = await pickImage();
    MultipartFile pic = await MultipartFile.fromFile(file!.path,
        filename: file.path.split("/").last,
        contentType: MediaType.parse("image/${file.path.split(".").last}"));
    return pic;
  }

  Future<File?> pickImage() async {
    FilePickerResult? imgRes =
        await FilePicker.platform.pickFiles(type: FileType.image);

    return File(imgRes!.files[0].path!);
  }
}
