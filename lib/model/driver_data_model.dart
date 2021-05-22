// To parse this JSON data, do
//
//     final driverDataModel = driverDataModelFromJson(jsonString);

import 'dart:convert';

class DriverDataModel {
  DriverDataModel({
    this.success,
    this.login,
    this.message,
    this.data,
  });

  bool? success;
  bool? login;
  String? message;
  Data? data;

  factory DriverDataModel.fromRawJson(String str) => DriverDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverDataModel.fromJson(Map<String, dynamic> json) => DriverDataModel(
    success: json["success"],
    login: json["login"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "login": login,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.vechileType,
    this.vechileNo,
    this.driverName,
    this.driverNo,
    this.address,
    this.landmark,
    this.ward,
    this.circle,
    this.zone,
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

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    vechileType: json["vechile_type"],
    vechileNo: json["vechile_no"],
    driverName: json["driver_name"],
    driverNo: json["driver_no"],
    address: json["address"],
    landmark: json["landmark"],
    ward: json["ward"],
    circle: json["circle"],
    zone: json["zone"],
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
    "created_date": createdDate,
  };
}
