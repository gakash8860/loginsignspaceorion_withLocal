// To parse this JSON data, do
//
//     final tempAccessPlace = tempAccessPlaceFromJson(jsonString);

import 'dart:convert';

List<TempAccessPlace> tempAccessPlaceFromJson(String str) => List<TempAccessPlace>.from(json.decode(str).map((x) => TempAccessPlace.fromJson(x)));

String tempAccessPlaceToJson(List<TempAccessPlace> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempAccessPlace {
  TempAccessPlace({
    this.pId,
    this.pType,
    this.user,
  });

  String pId;
  String pType;
  int user;

  factory TempAccessPlace.fromJson(Map<String, dynamic> json) => TempAccessPlace(
    pId: json["p_id"],
    pType: json["p_type"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "p_id": pId,
    "p_type": pType,
    "user": user,
  };
}
// To parse this JSON data, do
//
//     final tempAccessFloor = tempAccessFloorFromJson(jsonString);


List<TempAccessFloor> tempAccessFloorFromJson(String str) => List<TempAccessFloor>.from(json.decode(str).map((x) => TempAccessFloor.fromJson(x)));

String tempAccessFloorToJson(List<TempAccessFloor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempAccessFloor {
  TempAccessFloor({
    this.fId,
    this.fName,
    this.user,
    this.pId,
  });

  String fId;
  String fName;
  int user;
  String pId;

  factory TempAccessFloor.fromJson(Map<String, dynamic> json) => TempAccessFloor(
    fId: json["f_id"],
    fName: json["f_name"],
    user: json["user"],
    pId: json["p_id"],
  );

  Map<String, dynamic> toJson() => {
    "f_id": fId,
    "f_name": fName,
    "user": user,
    "p_id": pId,
  };
}
// To parse this JSON data, do
//
//     final tempAccessFlat = tempAccessFlatFromJson(jsonString);



List<TempAccessFlat> tempAccessFlatFromJson(String str) => List<TempAccessFlat>.from(json.decode(str).map((x) => TempAccessFlat.fromJson(x)));

String tempAccessFlatToJson(List<TempAccessFlat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempAccessFlat {
  TempAccessFlat({
    this.fltId,
    this.fltName,
    this.user,
    this.fId,
  });

  String fltId;
  String fltName;
  int user;
  String fId;

  factory TempAccessFlat.fromJson(Map<String, dynamic> json) => TempAccessFlat(
    fltId: json["flt_id"],
    fltName: json["flt_name"],
    user: json["user"],
    fId: json["f_id"],
  );

  Map<String, dynamic> toJson() => {
    "flt_id": fltId,
    "flt_name": fltName,
    "user": user,
    "f_id": fId,
  };
}


List<TempAccessRoom> tempAccessRoomFromJson(String str) => List<TempAccessRoom>.from(json.decode(str).map((x) => TempAccessRoom.fromJson(x)));

String tempAccessRoomToJson(List<TempAccessRoom> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempAccessRoom {
  TempAccessRoom({
    this.rId,
    this.rName,
    this.user,
    this.fltId,
  });

  String rId;
  String rName;
  int user;
  String fltId;

  factory TempAccessRoom.fromJson(Map<String, dynamic> json) => TempAccessRoom(
    rId: json["r_id"],
    rName: json["r_name"],
    user: json["user"],
    fltId: json["flt_id"],
  );

  Map<String, dynamic> toJson() => {
    "r_id": rId,
    "r_name": rName,
    "user": user,
    "flt_id": fltId,
  };
}
// To parse this JSON data, do
//
//     final tempAccessDevice = tempAccessDeviceFromJson(jsonString);



List<TempAccessDevice> tempAccessDeviceFromJson(String str) => List<TempAccessDevice>.from(json.decode(str).map((x) => TempAccessDevice.fromJson(x)));

String tempAccessDeviceToJson(List<TempAccessDevice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempAccessDevice {
  TempAccessDevice({
    this.id,
    this.dateInstalled,
    this.user,
    this.rId,
    this.dId,
  });

  int id;
  DateTime dateInstalled;
  int user;
  String rId;
  String dId;

  factory TempAccessDevice.fromJson(Map<String, dynamic> json) => TempAccessDevice(
    id: json["id"],
    dateInstalled: DateTime.parse(json["date_installed"]),
    user: json["user"],
    rId: json["r_id"],
    dId: json["d_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_installed": "${dateInstalled.year.toString().padLeft(4, '0')}-${dateInstalled.month.toString().padLeft(2, '0')}-${dateInstalled.day.toString().padLeft(2, '0')}",
    "user": user,
    "r_id": rId,
    "d_id": dId,
  };


}
// To parse this JSON data, do
//
//     final tempAccessSensor = tempAccessSensorFromJson(jsonString);



TempAccessSensor tempAccessSensorFromJson(String str) => TempAccessSensor.fromJson(json.decode(str));

String tempAccessSensorToJson(TempAccessSensor data) => json.encode(data.toJson());

class TempAccessSensor {
  TempAccessSensor({
    this.dId,
    this.sensor1,
    this.sensor2,
    this.sensor3,
    this.sensor4,
    this.sensor5,
    this.sensor6,
    this.sensor7,
    this.sensor8,
    this.sensor9,
    this.sensor10,
  });

  String dId;
  int sensor1;
  double sensor2;
  double sensor3;
  int sensor4;
  int sensor5;
  int sensor6;
  int sensor7;
  int sensor8;
  int sensor9;
  int sensor10;

  factory TempAccessSensor.fromJson(Map<String, dynamic> json) => TempAccessSensor(
    dId: json["d_id"],
    sensor1: json["sensor1"],
    sensor2: json["sensor2"].toDouble(),
    sensor3: json["sensor3"].toDouble(),
    sensor4: json["sensor4"],
    sensor5: json["sensor5"],
    sensor6: json["sensor6"],
    sensor7: json["sensor7"],
    sensor8: json["sensor8"],
    sensor9: json["sensor9"],
    sensor10: json["sensor10"],
  );

  Map<String, dynamic> toJson() => {
    "d_id": dId,
    "sensor1": sensor1,
    "sensor2": sensor2,
    "sensor3": sensor3,
    "sensor4": sensor4,
    "sensor5": sensor5,
    "sensor6": sensor6,
    "sensor7": sensor7,
    "sensor8": sensor8,
    "sensor9": sensor9,
    "sensor10": sensor10,
  };
}
