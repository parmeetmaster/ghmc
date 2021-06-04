import 'package:dio/dio.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/add_vehicle_model/owner_typ.dart';
import 'package:ghmc/model/add_vehicle_model/transfer_station_model.dart';
import 'package:ghmc/model/add_vehicle_model/vehicle_type_model.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/util/utils.dart';
class AddVehicleProvider with ChangeNotifier {
  String? ion;

  getInstance() {
    return AddVehicleProvider();
  }

  Future<OwnerTypeModel?> getOwnerType() async {
    OwnerTypeModel? ownerType;
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/owner_type"));
    if (response.status == 200)
      ownerType = OwnerTypeModel.fromJson(response.completeResponse);
    return ownerType;
  }

  Future<VehicleTypeModel?> getVehicleType() async {
    VehicleTypeModel? vehicleType;
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/vechiles_type"));
    if (response.status == 200)
      vehicleType = VehicleTypeModel.fromJson(response.completeResponse);
    return vehicleType;
  }

  Future<TransferStationModel?> getTransferStation() async {
    TransferStationModel? transferStationModel;
    ApiResponse response = await ApiBase()
        .baseFunction(() => ApiBase().getInstance()!.get("/transfer"));
    if (response.status == 200)
      transferStationModel =
          TransferStationModel.fromJson(response.completeResponse);
    return transferStationModel;
  }


  // post






}
