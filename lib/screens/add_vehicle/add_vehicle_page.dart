import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/model/add_vehicle_model/owner_typ.dart';
import 'package:ghmc/model/add_vehicle_model/transfer_station_model.dart';
import 'package:ghmc/model/add_vehicle_model/vehicle_type_model.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/provider/add_vehicle/add_vehicle.dart';
import 'package:ghmc/screens/search_page/search_page.dart';
import 'package:ghmc/util/file_picker.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/card_seperate_row.dart';
import 'package:ghmc/widget/loading_widget.dart';
import 'package:provider/provider.dart';

class AddVehiclePage extends StatefulWidget {
  Access access;

  AddVehiclePage(this.access, {Key? key}) : super(key: key);

  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  OwnerTypeModel? ownerTypeModel;
  TransferStationModel? transferStationModel;
  VehicleTypeModel? vehicleTypeModel;
  OwnerTypeDataItem? selectedOwnerType;
  TransferTypeDataItem? selectedTransferType;
  VehicleTypeDataItem? selectedVehicle;
  MultipartFile? vehicle_image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFAD1457),
                  Color(0xFFAD801D9E),
                ],
              ),
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add Vehicle",
                style: TextStyle(fontSize: 25),
              ),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (SearchPage()),
                        ));
                  })
            ],
          ),
        ),
        body: Consumer<AddVehicleProvider>(builder: (context, value, child) {
          if (ownerTypeModel != null)
            return ListView(children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        CardSeperateRow("Land Mark", widget.access.landmarks),
                        CardSeperateRow("Ward", widget.access.ward),
                        CardSeperateRow("Circle", widget.access.circle),
                        CardSeperateRow("Zone", widget.access.zone),
                        CardSeperateRow("City", ""),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: DropdownButton(
                      isExpanded: true,
                      //value: selectedOwnerType,
                      onChanged: (value) {
                        selectedOwnerType = value as OwnerTypeDataItem;
                        setState(() {});
                      },
                      items: ownerTypeModel!.data!
                          .map((e) => DropdownMenuItem<OwnerTypeDataItem>(
                                value: e,
                                child: Text("${e.name}"),
                              ))
                          .toList(),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 40,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),

                      hint: Center(
                        child: Text(
                          selectedOwnerType == null
                              ? "Owner Type"
                              : "${selectedOwnerType!.name}",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (value) {
                        selectedVehicle = value! as VehicleTypeDataItem;
                        setState(() {});
                      },
                      items: vehicleTypeModel!.data!
                          .map((e) => DropdownMenuItem<VehicleTypeDataItem>(
                                value: e,
                                child: Text("${e.name}"),
                              ))
                          .toList(),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 40,
                      ),
                      hint: Center(
                        child: Text(
                          this.selectedVehicle == null
                              ? "Vehicle Type"
                              : "${this.selectedVehicle!.name}",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            hintText: 'Vehicles Reg Number',
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            hintText: 'Driver Name',
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            hintText: 'Driver Mobile Number',
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: DropdownButton(
                        isExpanded: true,
                        value: selectedTransferType,
                        onChanged: (value) {
                          selectedTransferType = value! as TransferTypeDataItem;
                          setState(() {});
                        },
                        items: transferStationModel!.data!
                            .map((e) => DropdownMenuItem<TransferTypeDataItem>(
                                  value: e,
                                  child: Text("${e.name}"),
                                ))
                            .toList(),
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                          size: 40,
                        ),
                        hint: Center(
                          child: Text(
                            selectedTransferType == null
                                ? "Transfer Type"
                                : "${selectedTransferType!.name}",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      height: 150,
                      width: 340,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                              backgroundColor: Colors.black,
                              onPressed: () async {
                                File? file = await FilePick().pickFile();
                                this.vehicle_image = await FileSupport()
                                    .getMultiPartFromFile(file!);
                              },
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 40,
                              )),
                          FloatingActionButton(
                              backgroundColor: Colors.black,
                              onPressed: () {},
                              child: Icon(
                                Icons.picture_in_picture_sharp,
                                color: Colors.white,
                                size: 40,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 200,
                      child: FlatButton(
                          height: 30,
                          minWidth: 100,
                          onPressed: () {},
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
                ],
              )
            ]);
          else
            return Loading();
        }));
  }

  @override
  void initState() {
    super.initState();

    loadInitalData();
  }

  loadInitalData() async {
    final provider = Provider.of<AddVehicleProvider>(context, listen: false);
    await Future.wait([
      provider.getOwnerType(),
      provider.getVehicleType(),
      provider.getTransferStation()
    ]).then((value) {
      this.ownerTypeModel = value[0] as OwnerTypeModel;
      this.vehicleTypeModel = value[1] as VehicleTypeModel;
      this.transferStationModel = value[2] as TransferStationModel;
    });
    provider.notifyListeners();
  }
}
