// To parse this JSON data, do
//
//     final credentials = credentialsFromJson(jsonString);

import 'dart:convert';

class CredentialsModel {
  CredentialsModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory CredentialsModel.fromRawJson(String str) =>
      CredentialsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CredentialsModel.fromJson(Map<String, dynamic> json) => CredentialsModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.departmentName,
    this.token,
    this.department_id,
    this.access,
  });

  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? departmentName;
  String? department_id;
  String? token;
  List<dynamic>? access;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
    department_id: json["department_id"],
        departmentName: json["department_name"],
        token: json["token"],
        access: List<dynamic>.from(json["access"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
    "department_id": department_id,
        "mobile_number": mobileNumber,
        "department_name": departmentName,
        "token": token,
        "access": List<dynamic>.from(access!.map((x) => x)),
      };
}
