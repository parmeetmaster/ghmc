/// success : true
/// message : "Successfully completed"
/// data : [{"id":"1","name":"Charminar"},{"id":"3","name":"Kukatpally"},{"id":"4","name":"Secunderabad"},{"id":"7","name":"Serilingampally"},{"id":"8","name":"Khairatabad"},{"id":"9","name":"L B Nagar"}]

class ZoneModel {
  bool? success;
  String? message;
  List<ZoneItem>? data;

  ZoneModel({
      this.success, 
      this.message, 
      this.data});

  ZoneModel.fromJson(dynamic json) {
    success = json["success"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(ZoneItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["message"] = message;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Charminar"

class ZoneItem {
  String? id;
  String? name;

  ZoneItem({
      this.id, 
      this.name});

  ZoneItem.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }

}