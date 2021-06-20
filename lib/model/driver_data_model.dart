// To parse this JSON data, do
//
//     final driverDataModel = driverDataModelFromJson(jsonString);

import 'dart:convert';

class QrDataModel {
  QrDataModel({
    this.success,
    this.login,
    this.message,
    this.data,
  });

  bool? success;
  bool? login;
  String? message;
  QrData? data;

  factory QrDataModel.fromRawJson(String str) =>
      QrDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QrDataModel.fromJson(Map<String, dynamic> json) => QrDataModel(
        success: json["success"],
        login: json["login"],
        message: json["message"],
        data: QrData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "login": login,
        "message": message,
        "data": data!.toJson(),
      };
}

class QrData {
  QrData({
    this.vechileType,
    this.vechileNo,
    this.driverName,
    this.driverNo,
    this.address,
    this.landmark,
    this.ward,
    this.circle,
    this.zone,
    this.owner_type,
    this.createdDate,
  });

  String? vechileType;
  String? vechileNo;
  String? driverName;
  String? driverNo;
  String? address;
  String? landmark;
  String? ward;
  String? circle;
  String? zone;
  String? createdDate;
  String? owner_type;

  factory QrData.fromRawJson(String str) => QrData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QrData.fromJson(Map<String, dynamic> json) => QrData(
        vechileType: json["vechile_type"],
        vechileNo: json["vechile_no"],
        driverName: json["driver_name"],
        driverNo: json["driver_no"],
        address: json["address"],
        landmark: json["landmark"],
        ward: json["ward"],
        circle: json["circle"],
        zone: json["zone"],
        owner_type: json["owner_type"],
        createdDate: json["created_date"],
      );

  Map<String, dynamic> toJson() => {
        "vechile_type": vechileType,
        "vechile_no": vechileNo,
        "driver_name": driverName,
        "driver_no": driverNo,
        "address": address,
        "landmark": landmark,
        "ward": ward,
        "circle": circle,
        "zone": zone,
        "owner_type": owner_type,
        "created_date": createdDate,
      };
}
