import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/add_vehicle_model/owner_typ.dart';
import 'package:ghmc/model/add_vehicle_model/transfer_station_model.dart';
import 'package:ghmc/model/add_vehicle_model/vehicle_type_model.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/util/utils.dart';

class AddDataProvider extends ChangeNotifier {

  void uploadVehicleData(OwnerTypeDataItem? selectedOwnerType,
      TransferTypeDataItem? selectedTransferType,
      VehicleTypeDataItem? selectedVehicle,
      MultipartFile? vehicle_image,
      Access access,
      TextEditingController registration_number,
      TextEditingController driver_name,
      BuildContext context, TextEditingController phone_number) async {
    if (selectedOwnerType == null) {
      "Select Owner Type".showSnackbar(context);
      return;
    } else if (selectedTransferType == null) {
      "Select Transfer Type".showSnackbar(context);
      return;
    } else if (selectedVehicle == null) {
      "Select vehicle first".showSnackbar(context);
      return;
    } else if (registration_number.text == null) {
      "Please fill Registration number".showSnackbar(context);
      return;
    } else if (driver_name.text == null) {
      "Please fill driver name".showSnackbar(context);
      return;
    } else if (phone_number.text == null) {
      "Please fill phone number".showSnackbar(context);
      return;
    } else if (double.tryParse(phone_number.text) != null) {
      "Check Phone number is numeric".showSnackbar(context);
      return;
    }

    var map = {
      'user_id': Globals.userData!.data!.userId,
      'zone_id': access.zone,
      'circle_id': access.circleId,
      'ward_id': access.wardId,
      'land_mark_id': access.landmarksId,
      'owner_type_id': selectedOwnerType.id,
      'vechile_type_id': selectedVehicle.id,
      'reg_no': registration_number.text,
      'driver_name': driver_name.text,
      'driver_mobile': phone_number.text,
      'transfer_station_id': selectedVehicle.id,
      'image': vehicle_image
    };

    ApiResponse response = await ApiBase()
        .baseFunction(() =>
        ApiBase().getInstance()!.post(
            "/add_vechile", data: FormData.fromMap(map)
        ));
    if (response.status == 200) {
      "vechile added successfully".showSnackbar(context);
    } else {
      "Something error".showSnackbar(context);
    }
  }

  uplaodTransferStation(BuildContext context) async {
// todo need to update data
    Map<String, dynamic> map = {
      'user_id': '"1"',
      'transfer_station_id': '"250"',
      'address': '"hyderabad"',
      'latitude': '"17.256389"',
      'longitude': '"72.235689"'
    };


    ApiResponse response = await ApiBase()
        .baseFunction(() =>
        ApiBase().getInstance()!.post(
            "/add_transfer_station", data: FormData.fromMap(map)
        ));
    if (response.status == 200) {
      "vechile added successfully".showSnackbar(context);
    } else {
      "Something error".showSnackbar(context);
    }
  }


}