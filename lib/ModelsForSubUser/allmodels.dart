// To parse this JSON data, do
//
//     final subUserFloorType = subUserFloorTypeFromJson(jsonString);

import 'dart:convert';



List<SubUserPlaceType> subUserPlaceTypeFromJson(String str) => List<SubUserPlaceType>.from(json.decode(str).map((x) => SubUserPlaceType.fromJson(x)));

String subUserPlaceTypeToJson(List<SubUserPlaceType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubUserPlaceType {
  SubUserPlaceType({
    this.pId,
    this.pType,
    this.user,
  });

  String pId;
  String pType;
  int user;

  factory SubUserPlaceType.fromJson(Map<String, dynamic> json) => SubUserPlaceType(
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


List<SubUserFloorType> subUserFloorTypeFromJson(String str) => List<SubUserFloorType>.from(json.decode(str).map((x) => SubUserFloorType.fromJson(x)));

String subUserFloorTypeToJson(List<SubUserFloorType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubUserFloorType {
  SubUserFloorType({
    this.fId,
    this.fName,
    this.user,
    this.pId,
  });

  String fId;
  String fName;
  int user;
  String pId;

  factory SubUserFloorType.fromJson(Map<String, dynamic> json) => SubUserFloorType(
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
//     final subUserFlatType = subUserFlatTypeFromJson(jsonString);



List<SubUserFlatType> subUserFlatTypeFromJson(String str) => List<SubUserFlatType>.from(json.decode(str).map((x) => SubUserFlatType.fromJson(x)));

String subUserFlatTypeToJson(List<SubUserFlatType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubUserFlatType {
  SubUserFlatType({
    this.fltId,
    this.fltName,
    this.user,
    this.fId,
  });

  String fltId;
  String fltName;
  int user;
  String fId;

  factory SubUserFlatType.fromJson(Map<String, dynamic> json) => SubUserFlatType(
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


List<SubUserRoomType> subUserRoomTypeFromJson(String str) => List<SubUserRoomType>.from(json.decode(str).map((x) => SubUserRoomType.fromJson(x)));

String subUserRoomTypeToJson(List<SubUserRoomType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubUserRoomType {
  SubUserRoomType({
    this.rId,
    this.rName,
    this.user,
    this.fltId,
  });

  String rId;
  String rName;
  int user;
  String fltId;

  factory SubUserRoomType.fromJson(Map<String, dynamic> json) => SubUserRoomType(
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


List<SubUserDeviceType> subUserDeviceTypeFromJson(String str) => List<SubUserDeviceType>.from(json.decode(str).map((x) => SubUserDeviceType.fromJson(x)));

String subUserDeviceTypeToJson(List<SubUserDeviceType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubUserDeviceType {
  SubUserDeviceType({
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

  factory SubUserDeviceType.fromJson(Map<String, dynamic> json) => SubUserDeviceType(
    id: json["id"],
    // dateInstalled: DateTime.parse(json["date_installed"]),
    user: json["user"],
    rId: json["r_id"],
    dId: json["d_id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    // "date_installed": "${dateInstalled.year.toString().padLeft(4, '0')}-${dateInstalled.month.toString().padLeft(2, '0')}-${dateInstalled.day.toString().padLeft(2, '0')}",
    "user": user,
    "r_id": rId,
    "d_id": dId,
  };
}


SubUserDevicePinNameType subUserDevicePinNameTypeFromJson(String str) => SubUserDevicePinNameType.fromJson(json.decode(str));

String subUserDevicePinNameTypeToJson(SubUserDevicePinNameType data) => json.encode(data.toJson());

class SubUserDevicePinNameType {
  SubUserDevicePinNameType({
    this.dId,
    this.pin1Name,
    this.pin2Name,
    this.pin3Name,
    this.pin4Name,
    this.pin5Name,
    this.pin6Name,
    this.pin7Name,
    this.pin8Name,
    this.pin9Name,
    this.pin10Name,
    this.pin11Name,
    this.pin12Name,
    this.pin13Name,
    this.pin14Name,
    this.pin15Name,
    this.pin16Name,
    this.pin17Name,
    this.pin18Name,
    this.pin19Name,
    this.pin20Name,
  });

  String dId;
  String pin1Name;
  String pin2Name;
  String pin3Name;
  String pin4Name;
  String pin5Name;
  String pin6Name;
  String pin7Name;
  String pin8Name;
  String pin9Name;
  String pin10Name;
  String pin11Name;
  String pin12Name;
  dynamic pin13Name;
  dynamic pin14Name;
  dynamic pin15Name;
  dynamic pin16Name;
  dynamic pin17Name;
  dynamic pin18Name;
  dynamic pin19Name;
  dynamic pin20Name;

  factory SubUserDevicePinNameType.fromJson(Map<String, dynamic> json) => SubUserDevicePinNameType(
    dId: json["d_id"],
    pin1Name: json["pin1Name"],
    pin2Name: json["pin2Name"],
    pin3Name: json["pin3Name"],
    pin4Name: json["pin4Name"],
    pin5Name: json["pin5Name"],
    pin6Name: json["pin6Name"],
    pin7Name: json["pin7Name"],
    pin8Name: json["pin8Name"],
    pin9Name: json["pin9Name"],
    pin10Name: json["pin10Name"],
    pin11Name: json["pin11Name"],
    pin12Name: json["pin12Name"],
    pin13Name: json["pin13Name"],
    pin14Name: json["pin14Name"],
    pin15Name: json["pin15Name"],
    pin16Name: json["pin16Name"],
    pin17Name: json["pin17Name"],
    pin18Name: json["pin18Name"],
    pin19Name: json["pin19Name"],
    pin20Name: json["pin20Name"],
  );

  Map<String, dynamic> toJson() => {
    "d_id": dId,
    "pin1Name": pin1Name,
    "pin2Name": pin2Name,
    "pin3Name": pin3Name,
    "pin4Name": pin4Name,
    "pin5Name": pin5Name,
    "pin6Name": pin6Name,
    "pin7Name": pin7Name,
    "pin8Name": pin8Name,
    "pin9Name": pin9Name,
    "pin10Name": pin10Name,
    "pin11Name": pin11Name,
    "pin12Name": pin12Name,
    "pin13Name": pin13Name,
    "pin14Name": pin14Name,
    "pin15Name": pin15Name,
    "pin16Name": pin16Name,
    "pin17Name": pin17Name,
    "pin18Name": pin18Name,
    "pin19Name": pin19Name,
    "pin20Name": pin20Name,
  };
}
PinStatusSubUser pinStatusFromJson(String str) => PinStatusSubUser.fromJson(json.decode(str));

String pinStatusToJson(PinStatusSubUser data) => json.encode(data.toJson());

class PinStatusSubUser {
  PinStatusSubUser({
    this.id,
    this.pin1Status,
    this.pin2Status,
    this.pin3Status,
    this.pin4Status,
    this.pin5Status,
    this.pin6Status,
    this.pin7Status,
    this.pin8Status,
    this.pin9Status,
    this.pin10Status,
    this.pin11Status,
    this.pin12Status,
    this.pin13Status,
    this.pin14Status,
    this.pin15Status,
    this.pin16Status,
    this.pin17Status,
    this.pin18Status,
    this.pin19Status,
    this.pin20Status,
    this.dId,
  });

  int id;
  int pin1Status;
  int pin2Status;
  int pin3Status;
  int pin4Status;
  int pin5Status;
  int pin6Status;
  int pin7Status;
  int pin8Status;
  int pin9Status;
  int pin10Status;
  int pin11Status;
  int pin12Status;
  int pin13Status;
  int pin14Status;
  int pin15Status;
  int pin16Status;
  int pin17Status;
  int pin18Status;
  String pin19Status;
  String pin20Status;
  String dId;

  factory PinStatusSubUser.fromJson(Map<String, dynamic> json) => PinStatusSubUser(
    id: json["id"],
    pin1Status: json["pin1Status"],
    pin2Status: json["pin2Status"],
    pin3Status: json["pin3Status"],
    pin4Status: json["pin4Status"],
    pin5Status: json["pin5Status"],
    pin6Status: json["pin6Status"],
    pin7Status: json["pin7Status"],
    pin8Status: json["pin8Status"],
    pin9Status: json["pin9Status"],
    pin10Status: json["pin10Status"],
    pin11Status: json["pin11Status"],
    pin12Status: json["pin12Status"],
    pin13Status: json["pin13Status"],
    pin14Status: json["pin14Status"],
    pin15Status: json["pin15Status"],
    pin16Status: json["pin16Status"],
    pin17Status: json["pin17Status"],
    pin18Status: json["pin18Status"],
    pin19Status: json["pin19Status"],
    pin20Status: json["pin20Status"],
    dId: json["d_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pin1Status": pin1Status,
    "pin2Status": pin2Status,
    "pin3Status": pin3Status,
    "pin4Status": pin4Status,
    "pin5Status": pin5Status,
    "pin6Status": pin6Status,
    "pin7Status": pin7Status,
    "pin8Status": pin8Status,
    "pin9Status": pin9Status,
    "pin10Status": pin10Status,
    "pin11Status": pin11Status,
    "pin12Status": pin12Status,
    "pin13Status": pin13Status,
    "pin14Status": pin14Status,
    "pin15Status": pin15Status,
    "pin16Status": pin16Status,
    "pin17Status": pin17Status,
    "pin18Status": pin18Status,
    "pin19Status": pin19Status,
    "pin20Status": pin20Status,
    "d_id": dId,
  };
}

SubUserSensorData sensorDataFromJson(String str) => SubUserSensorData.fromJson(json.decode(str));

String sensorDataToJson(SubUserSensorData data) => json.encode(data.toJson());

class SubUserSensorData {
  SubUserSensorData({
    this.id,
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
    this.dId,
  });

  int id;
  double sensor1;
  double sensor2;
  double sensor3;
  double sensor4;
  double sensor5;
  double sensor6;
  double sensor7;
  double sensor8;
  double sensor9;
  double sensor10;
  String dId;

  factory SubUserSensorData.fromJson(Map<String, dynamic> json) => SubUserSensorData(
    id: json["id"] as int,
    sensor1: json["sensor1"]  as double,
    sensor2: json["sensor2"]  as double,
    sensor3: json["sensor3"]  as double,
    sensor4: json["sensor4"]  as double,
    sensor5: json["sensor5"]as double,
    sensor6: json["sensor6"]as double,
    sensor7: json["sensor7"]as double,
    sensor8: json["sensor8"]as double,
    sensor9: json["sensor9"]as double,
    sensor10: json["sensor10"]as double,
    dId: json["d_id"] ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "d_id": dId,
  };
}