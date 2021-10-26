
import 'dart:convert';

final user2var="";

List<PlaceType> placeTypeFromJson(String str) => List<PlaceType>.from(json.decode(str).map((x) => PlaceType.fromJson(x)));

String placeTypeToJson(List<PlaceType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaceType {
  String pId;
  String pType;
  int user;

  PlaceType({
    this.pId,
    this.pType,
    this.user,
  });




  factory PlaceType.fromJson(Map<String, dynamic> json) => PlaceType(
    pId: json["p_id"].toString() ,
    pType: json["p_type"].toString(),
    user: json["user"] ,
  );

  Map<String, dynamic> toJson() => {
    "p_id": pId,
    "p_type": pType,
    "user": user,
  };

}


List<FloorType> floorTypeFromJson(String str) => List<FloorType>.from(json.decode(str).map((x) => FloorType.fromJson(x)));

String floorTypeToJson(List<FloorType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FloorType {
  FloorType({
    this.fId,
    this.fName,
    this.user,
    this.pId,
  });

  String fId;
  String fName;
  int user;
  String pId;

  factory FloorType.fromJson(Map<String, dynamic> json) => FloorType(
    fId: json["f_id"].toString(),
    fName: json["f_name"].toString(),
    user: json["user"],
    pId: json["p_id"].toString(),
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
//     final roomType = roomTypeFromJson(jsonString);



List<RoomType> roomTypeFromJson(String str) => List<RoomType>.from(json.decode(str).map((x) => RoomType.fromJson(x)));

String roomTypeToJson(List<RoomType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomType {
  RoomType({
    this.rId,
    this.rName,
    this.user,
    this.fltId,
  });

  String rId;
  String rName;
  int user;
  String fltId;

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
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

List<Device> deviceFromJson(String str) => List<Device>.from(json.decode(str).map((x) => Device.fromJson(x)));

String deviceToJson(List<Device> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Device {
  Device({
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

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    // id: json["id"],
    // dateInstalled: DateTime.parse(json["date_installed"]),
    user: json["user"],
    rId: json["r_id"],
    dId: json["d_id"],
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    // "date_installed": "${dateInstalled.toString().padLeft(4, '0')}-${dateInstalled.month.toString().padLeft(2, '0')}-${dateInstalled.day.toString().padLeft(2, '0')}",
    "user": user,
    "r_id": rId,
    "d_id": dId,
  };
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.username,
    this.password1,
    this.password2,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNo,
  });

  String username;
  String password1;
  String password2;
  String firstName;
  String lastName;
  String email;
  int phoneNo;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    password1: json["password1"],
    password2: json["password2"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneNo: json["phone_no"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password1": password1,
    "password2": password2,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_no": phoneNo,
  };

}

IpAddress ipAddressFromJson(String str) => IpAddress.fromJson(json.decode(str));

String ipAddressToJson(IpAddress data) => json.encode(data.toJson());

class IpAddress {
  IpAddress({
    this.id,
    this.ipaddress,
    this.dId,
  });

  int id;
  String ipaddress;
  String dId;

  factory IpAddress.fromJson(Map<String, dynamic> json) => IpAddress(
    id: json["id"],
    ipaddress: json["ipaddress"],
    dId: json["d_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ipaddress": ipaddress,
    "d_id": dId,
  };
}
// To parse this JSON data, do
//
//     final sensorData = sensorDataFromJson(jsonString);


SensorData sensorDataFromJson(String str) => SensorData.fromJson(json.decode(str));

String sensorDataToJson(SensorData data) => json.encode(data.toJson());

class SensorData {
  SensorData({
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

  factory SensorData.fromJson(Map<String, dynamic> json) => SensorData(
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
// To parse this JSON data, do
//
//     final devicePin = devicePinFromJson(jsonString);



// To parse this JSON data, do
//
//     final devicePin = devicePinFromJson(jsonString);



List<DevicePin> devicePinFromJson(String str) => List<DevicePin>.from(json.decode(str).map((x) => DevicePin.fromJson(x)));

String devicePinToJson(List<DevicePin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DevicePin {
  DevicePin({
    this.id,
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
    this.dId,
  });

  int id;
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
  String pin13Name;
  String pin14Name;
  String pin15Name;
  String pin16Name;
  String pin17Name;
  String pin18Name;
  String pin19Name;
  String pin20Name;
  String dId;

  factory DevicePin.fromJson(Map<String, dynamic> json) => DevicePin(
    id: json["id"],
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
    dId: json["d_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "d_id": dId,
  };
}
// To parse this JSON data, do
//
//     final userDataUSingToken = userDataUSingTokenFromJson(jsonString);


UserDataUSingToken userDataUSingTokenFromJson(String str) => UserDataUSingToken.fromJson(json.decode(str));

String userDataUSingTokenToJson(UserDataUSingToken data) => json.encode(data.toJson());

class UserDataUSingToken {
  UserDataUSingToken({
    this.email,
    this.firstName,
    this.lastName,
  });

  String email;
  String firstName;
  String lastName;

  factory UserDataUSingToken.fromJson(Map<String, dynamic> json) => UserDataUSingToken(
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
  };
}
// To parse this JSON data, do
//
//     final emergencyNumberClass = emergencyNumberClassFromJson(jsonString);

EmergencyNumberClass emergencyNumberClassFromJson(String str) => EmergencyNumberClass.fromJson(json.decode(str));

String emergencyNumberClassToJson(EmergencyNumberClass data) => json.encode(data.toJson());

class EmergencyNumberClass {
  EmergencyNumberClass({
    this.id,
    this.number1,
    this.number2,
    this.number3,
    this.number4,
    this.number5,
    this.user,
    this.dId,
  });

  int id;
  String number1;
  String number2;
  String number3;
  String number4;
  String number5;
  int user;
  String dId;

  factory EmergencyNumberClass.fromJson(Map<String, dynamic> json) => EmergencyNumberClass(
    id: json["id"],
    number1: json["number1"],
    number2: json["number2"],
    number3: json["number3"],
    number4: json["number4"],
    number5: json["number5"],
    user: json["user"],
    dId: json["d_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number1": number1,
    "number2": number2,
    "number3": number3,
    "number4": number4,
    "number5": number5,
    "user": user,
    "d_id": dId,
  };
}

// To parse this JSON data, do
//
//     final allSubUserData = allSubUserDataFromJson(jsonString);



List<AllSubUserData> allSubUserDataFromJson(String str) => List<AllSubUserData>.from(json.decode(str).map((x) => AllSubUserData.fromJson(x)));

String allSubUserDataToJson(List<AllSubUserData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllSubUserData {
  AllSubUserData({
    this.id,
    this.name,
    this.user,
    this.email,
    this.pId,
  });

  int id;
  String name;
  int user;
  String email;
  String pId;

  factory AllSubUserData.fromJson(Map<String, dynamic> json) => AllSubUserData(
    id: json["id"],
    name: json["name"],
    user: json["user"],
    email: json["email"],
    pId: json["p_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user": user,
    "email": email,
    "p_id": pId,
  };
}

// To parse this JSON data, do
//
//     final pinStatus = pinStatusFromJson(jsonString);


PinStatus pinStatusFromJson(String str) => PinStatus.fromJson(json.decode(str));

String pinStatusToJson(PinStatus data) => json.encode(data.toJson());

class PinStatus {
  PinStatus({
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

  factory PinStatus.fromJson(Map<String, dynamic> json) => PinStatus(
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
// To parse this JSON data, do
//
//     final flat = flatFromJson(jsonString);


Flat flatFromJson(String str) => Flat.fromJson(json.decode(str));

String flatToJson(Flat data) => json.encode(data.toJson());

class Flat {
  Flat({
    this.fltId,
    this.fltName,
    this.user,
    this.fId,
  });

  String fltId;
  String fltName;
  int user;
  String fId;

  factory Flat.fromJson(Map<String, dynamic> json) => Flat(
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


// To parse this JSON data, do
//
//     final tempUser = tempUserFromJson(jsonString);


List<TempUser> tempUserFromJson(String str) => List<TempUser>.from(json.decode(str).map((x) => TempUser.fromJson(x)));

String tempUserToJson(List<TempUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempUser {
  TempUser({
    this.id,
    this.ownerName,
    this.mobile,
    this.email,
    this.name,
    this.date,
    this.timing,
    this.user,
    this.pId,
    this.fId,
    this.fltId,
    this.rId,
    this.dId,
  });

  int id;
  String ownerName;
  String mobile;
  String email;
  String name;
  DateTime date;
  String timing;
  int user;
  dynamic pId;
  String fId;
  dynamic fltId;
  dynamic rId;
  dynamic dId;

  factory TempUser.fromJson(Map<String, dynamic> json) => TempUser(
    id: json["id"],
    ownerName: json["owner_name"],
    mobile: json["mobile"],
    email: json["email"],
    name: json["name"],
    date: DateTime.parse(json["date"]),
    timing: json["timing"],
    user: json["user"],
    pId: json["p_id"],
    fId: json["f_id"],
    fltId: json["flt_id"],
    rId: json["r_id"],
    dId: json["d_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_name": ownerName,
    "mobile": mobile,
    "email": email,
    "name": name,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "timing": timing,
    "user": user,
    "p_id": pId,
    "f_id": fId,
    "flt_id": fltId,
    "r_id": rId,
    "d_id": dId,
  };
}



List<SubAccessPage> subAccessPageFromJson(String str) => List<SubAccessPage>.from(json.decode(str).map((x) => SubAccessPage.fromJson(x)));

String subAccessPageToJson(List<SubAccessPage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubAccessPage {
  SubAccessPage({
    this.id,
    this.ownerName,
    this.name,
    this.user,
    this.email,
    this.pId,
  });

  int id;
  String ownerName;
  String name;
  int user;
  String email;
  String pId;

  factory SubAccessPage.fromJson(Map<String, dynamic> json) => SubAccessPage(
    id: json["id"],
    ownerName: json["owner_name"],
    name: json["name"],
    user: json["user"],
    email: json["email"],
    pId: json["p_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_name": ownerName,
    "name": name,
    "user": user,
    "email": email,
    "p_id": pId,
  };
}

class PerDayEnergy {
  String dId;
  double day1;
  double day2;
  double day3;
  double day4;
  double day5;
  double day6;
  double day7;
  double day8;
  double day9;
  double day10;
  double day11;
  double day12;
  double day13;
  double day14;
  double day15;
  double day16;
  double day17;
  double day18;
  double day19;
  double day20;
  double day21;
  double day22;
  double day23;
  double day24;
  double day25;
  double day26;
  double day27;
  double day28;
  double day29;
  double day30;
  double day31;
  double day32;
  double day33;
  double day34;
  double day35;
  double day36;
  double day37;
  double day38;
  double day39;
  double day40;
  double day41;
  double day42;
  double day43;
  double day44;
  double day45;
  double day46;
  double day47;
  double day48;
  double day49;
  double day50;
  double day51;
  double day52;
  double day53;
  double day54;
  double day55;
  double day56;
  double day57;
  double day58;
  double day59;
  double day60;
  double day61;
  double day62;
  double day63;
  double day64;
  double day65;
  double day66;
  double day67;
  double day68;
  double day69;
  double day70;
  double day71;
  double day72;
  double day73;
  double day74;
  double day75;
  double day76;
  double day77;
  double day78;
  double day79;
  double day80;
  double day81;
  double day82;
  double day83;
  double day84;
  double day85;
  double day86;
  double day87;
  double day88;
  double day89;
  double day90;
  double day91;
  double day92;
  double day93;
  double day94;
  double day95;
  double day96;
  double day97;
  double day98;
  double day99;
  double day100;
  double day101;
  double day102;
  double day103;
  double day104;
  double day105;
  double day106;
  double day107;
  double day108;
  double day109;
  double day110;
  double day111;
  double day112;
  double day113;
  double day114;
  double day115;
  double day116;
  double day117;
  double day118;
  double day119;
  double day120;
  double day121;
  double day122;
  double day123;
  double day124;
  double day125;
  double day126;
  double day127;
  double day128;
  double day129;
  double day130;
  double day131;
  double day132;
  double day133;
  double day134;
  double day135;
  double day136;
  double day137;
  double day138;
  double day139;
  double day140;
  double day141;
  double day142;
  double day143;
  double day144;
  double day145;
  double day146;
  double day147;
  double day148;
  double day149;
  double day150;
  double day151;
  double day152;
  double day153;
  double day154;
  double day155;
  double day156;
  double day157;
  double day158;
  double day159;
  double day160;
  double day161;
  double day162;
  double day163;
  double day164;
  double day165;
  double day166;
  double day167;
  double day168;
  double day169;
  double day170;
  double day171;
  double day172;
  double day173;
  double day174;
  double day175;
  double day176;
  double day177;
  double day178;
  double day179;
  double day180;
  double day181;
  double day182;
  double day183;
  double day184;
  double day185;
  double day186;
  double day187;
  double day188;
  double day189;
  double day190;
  double day191;
  double day192;
  double day193;
  double day194;
  double day195;
  double day196;
  double day197;
  double day198;
  double day199;
  double day200;
  double day201;
  double day202;
  double day203;
  double day204;
  double day205;
  double day206;
  double day207;
  double day208;
  Null day209;
  double day210;
  double day211;
  double day212;
  double day213;
  double day214;
  double day215;
  double day216;
  double day217;
  double day218;
  double day219;
  double day220;
  double day221;
  double day222;
  double day223;
  double day224;
  double day225;
  double day226;
  double day227;
  double day228;
  double day229;
  double day230;
  double day231;
  double day232;
  double day233;
  double day234;
  double day235;
  double day236;
  double day237;
  double day238;
  double day239;
  double day240;
  double day241;
  double day242;
  double day243;
  double day244;
  double day245;
  double day246;
  double day247;
  double day248;
  double day249;
  double day250;
  double day251;
  double day252;
  double day253;
  double day254;
  double day255;
  double day256;
  double day257;
  double day258;
  double day259;
  double day260;
  double day261;
  double day262;
  double day263;
  double day264;
  double day265;
  double day266;
  double day267;
  double day268;
  double day269;
  double day270;
  double day271;
  double day272;
  double day273;
  double day274;
  double day275;
  double day276;
  double day277;
  double day278;
  double day279;
  double day280;
  double day281;
  double day282;
  double day283;
  double day284;
  double day285;
  double day286;
  double day287;
  double day288;
  double day289;
  double day290;
  double day291;
  double day292;
  double day293;
  double day294;
  double day295;
  double day296;
  double day297;
  double day298;
  double day299;
  double day300;
  double day301;
  double day302;
  double day303;
  double day304;
  double day305;
  double day306;
  double day307;
  double day308;
  double day309;
  double day310;
  double day311;
  double day312;
  double day313;
  double day314;
  double day315;
  double day316;
  double day317;
  double day318;
  double day319;
  double day320;
  double day321;
  double day322;
  double day323;
  double day324;
  double day325;
  double day326;
  double day327;
  double day328;
  double day329;
  double day330;
  double day331;
  double day332;
  double day333;
  double day334;
  double day335;
  double day336;
  double day337;
  double day338;
  double day339;
  double day340;
  double day341;
  double day342;
  double day343;
  double day344;
  double day345;
  double day346;
  double day347;
  double day348;
  double day349;
  double day350;
  double day351;
  double day352;
  double day353;
  double day354;
  double day355;
  double day356;
  double day357;
  double day358;
  double day359;
  double day360;
  double day361;
  double day362;
  double day363;
  double day364;
  double day365;
  double day366;

  PerDayEnergy(
      {this.dId,
        this.day1,
        this.day2,
        this.day3,
        this.day4,
        this.day5,
        this.day6,
        this.day7,
        this.day8,
        this.day9,
        this.day10,
        this.day11,
        this.day12,
        this.day13,
        this.day14,
        this.day15,
        this.day16,
        this.day17,
        this.day18,
        this.day19,
        this.day20,
        this.day21,
        this.day22,
        this.day23,
        this.day24,
        this.day25,
        this.day26,
        this.day27,
        this.day28,
        this.day29,
        this.day30,
        this.day31,
        this.day32,
        this.day33,
        this.day34,
        this.day35,
        this.day36,
        this.day37,
        this.day38,
        this.day39,
        this.day40,
        this.day41,
        this.day42,
        this.day43,
        this.day44,
        this.day45,
        this.day46,
        this.day47,
        this.day48,
        this.day49,
        this.day50,
        this.day51,
        this.day52,
        this.day53,
        this.day54,
        this.day55,
        this.day56,
        this.day57,
        this.day58,
        this.day59,
        this.day60,
        this.day61,
        this.day62,
        this.day63,
        this.day64,
        this.day65,
        this.day66,
        this.day67,
        this.day68,
        this.day69,
        this.day70,
        this.day71,
        this.day72,
        this.day73,
        this.day74,
        this.day75,
        this.day76,
        this.day77,
        this.day78,
        this.day79,
        this.day80,
        this.day81,
        this.day82,
        this.day83,
        this.day84,
        this.day85,
        this.day86,
        this.day87,
        this.day88,
        this.day89,
        this.day90,
        this.day91,
        this.day92,
        this.day93,
        this.day94,
        this.day95,
        this.day96,
        this.day97,
        this.day98,
        this.day99,
        this.day100,
        this.day101,
        this.day102,
        this.day103,
        this.day104,
        this.day105,
        this.day106,
        this.day107,
        this.day108,
        this.day109,
        this.day110,
        this.day111,
        this.day112,
        this.day113,
        this.day114,
        this.day115,
        this.day116,
        this.day117,
        this.day118,
        this.day119,
        this.day120,
        this.day121,
        this.day122,
        this.day123,
        this.day124,
        this.day125,
        this.day126,
        this.day127,
        this.day128,
        this.day129,
        this.day130,
        this.day131,
        this.day132,
        this.day133,
        this.day134,
        this.day135,
        this.day136,
        this.day137,
        this.day138,
        this.day139,
        this.day140,
        this.day141,
        this.day142,
        this.day143,
        this.day144,
        this.day145,
        this.day146,
        this.day147,
        this.day148,
        this.day149,
        this.day150,
        this.day151,
        this.day152,
        this.day153,
        this.day154,
        this.day155,
        this.day156,
        this.day157,
        this.day158,
        this.day159,
        this.day160,
        this.day161,
        this.day162,
        this.day163,
        this.day164,
        this.day165,
        this.day166,
        this.day167,
        this.day168,
        this.day169,
        this.day170,
        this.day171,
        this.day172,
        this.day173,
        this.day174,
        this.day175,
        this.day176,
        this.day177,
        this.day178,
        this.day179,
        this.day180,
        this.day181,
        this.day182,
        this.day183,
        this.day184,
        this.day185,
        this.day186,
        this.day187,
        this.day188,
        this.day189,
        this.day190,
        this.day191,
        this.day192,
        this.day193,
        this.day194,
        this.day195,
        this.day196,
        this.day197,
        this.day198,
        this.day199,
        this.day200,
        this.day201,
        this.day202,
        this.day203,
        this.day204,
        this.day205,
        this.day206,
        this.day207,
        this.day208,
        this.day209,
        this.day210,
        this.day211,
        this.day212,
        this.day213,
        this.day214,
        this.day215,
        this.day216,
        this.day217,
        this.day218,
        this.day219,
        this.day220,
        this.day221,
        this.day222,
        this.day223,
        this.day224,
        this.day225,
        this.day226,
        this.day227,
        this.day228,
        this.day229,
        this.day230,
        this.day231,
        this.day232,
        this.day233,
        this.day234,
        this.day235,
        this.day236,
        this.day237,
        this.day238,
        this.day239,
        this.day240,
        this.day241,
        this.day242,
        this.day243,
        this.day244,
        this.day245,
        this.day246,
        this.day247,
        this.day248,
        this.day249,
        this.day250,
        this.day251,
        this.day252,
        this.day253,
        this.day254,
        this.day255,
        this.day256,
        this.day257,
        this.day258,
        this.day259,
        this.day260,
        this.day261,
        this.day262,
        this.day263,
        this.day264,
        this.day265,
        this.day266,
        this.day267,
        this.day268,
        this.day269,
        this.day270,
        this.day271,
        this.day272,
        this.day273,
        this.day274,
        this.day275,
        this.day276,
        this.day277,
        this.day278,
        this.day279,
        this.day280,
        this.day281,
        this.day282,
        this.day283,
        this.day284,
        this.day285,
        this.day286,
        this.day287,
        this.day288,
        this.day289,
        this.day290,
        this.day291,
        this.day292,
        this.day293,
        this.day294,
        this.day295,
        this.day296,
        this.day297,
        this.day298,
        this.day299,
        this.day300,
        this.day301,
        this.day302,
        this.day303,
        this.day304,
        this.day305,
        this.day306,
        this.day307,
        this.day308,
        this.day309,
        this.day310,
        this.day311,
        this.day312,
        this.day313,
        this.day314,
        this.day315,
        this.day316,
        this.day317,
        this.day318,
        this.day319,
        this.day320,
        this.day321,
        this.day322,
        this.day323,
        this.day324,
        this.day325,
        this.day326,
        this.day327,
        this.day328,
        this.day329,
        this.day330,
        this.day331,
        this.day332,
        this.day333,
        this.day334,
        this.day335,
        this.day336,
        this.day337,
        this.day338,
        this.day339,
        this.day340,
        this.day341,
        this.day342,
        this.day343,
        this.day344,
        this.day345,
        this.day346,
        this.day347,
        this.day348,
        this.day349,
        this.day350,
        this.day351,
        this.day352,
        this.day353,
        this.day354,
        this.day355,
        this.day356,
        this.day357,
        this.day358,
        this.day359,
        this.day360,
        this.day361,
        this.day362,
        this.day363,
        this.day364,
        this.day365,
        this.day366});

  PerDayEnergy.fromJson(Map<String, dynamic> json) {
    dId = json['d_id'];
    day1 = json['day1'];
    day2 = json['day2'];
    day3 = json['day3'];
    day4 = json['day4'];
    day5 = json['day5'];
    day6 = json['day6'];
    day7 = json['day7'];
    day8 = json['day8'];
    day9 = json['day9'];
    day10 = json['day10'];
    day11 = json['day11'];
    day12 = json['day12'];
    day13 = json['day13'];
    day14 = json['day14'];
    day15 = json['day15'];
    day16 = json['day16'];
    day17 = json['day17'];
    day18 = json['day18'];
    day19 = json['day19'];
    day20 = json['day20'];
    day21 = json['day21'];
    day22 = json['day22'];
    day23 = json['day23'];
    day24 = json['day24'];
    day25 = json['day25'];
    day26 = json['day26'];
    day27 = json['day27'];
    day28 = json['day28'];
    day29 = json['day29'];
    day30 = json['day30'];
    day31 = json['day31'];
    day32 = json['day32'];
    day33 = json['day33'];
    day34 = json['day34'];
    day35 = json['day35'];
    day36 = json['day36'];
    day37 = json['day37'];
    day38 = json['day38'];
    day39 = json['day39'];
    day40 = json['day40'];
    day41 = json['day41'];
    day42 = json['day42'];
    day43 = json['day43'];
    day44 = json['day44'];
    day45 = json['day45'];
    day46 = json['day46'];
    day47 = json['day47'];
    day48 = json['day48'];
    day49 = json['day49'];
    day50 = json['day50'];
    day51 = json['day51'];
    day52 = json['day52'];
    day53 = json['day53'];
    day54 = json['day54'];
    day55 = json['day55'];
    day56 = json['day56'];
    day57 = json['day57'];
    day58 = json['day58'];
    day59 = json['day59'];
    day60 = json['day60'];
    day61 = json['day61'];
    day62 = json['day62'];
    day63 = json['day63'];
    day64 = json['day64'];
    day65 = json['day65'];
    day66 = json['day66'];
    day67 = json['day67'];
    day68 = json['day68'];
    day69 = json['day69'];
    day70 = json['day70'];
    day71 = json['day71'];
    day72 = json['day72'];
    day73 = json['day73'];
    day74 = json['day74'];
    day75 = json['day75'];
    day76 = json['day76'];
    day77 = json['day77'];
    day78 = json['day78'];
    day79 = json['day79'];
    day80 = json['day80'];
    day81 = json['day81'];
    day82 = json['day82'];
    day83 = json['day83'];
    day84 = json['day84'];
    day85 = json['day85'];
    day86 = json['day86'];
    day87 = json['day87'];
    day88 = json['day88'];
    day89 = json['day89'];
    day90 = json['day90'];
    day91 = json['day91'];
    day92 = json['day92'];
    day93 = json['day93'];
    day94 = json['day94'];
    day95 = json['day95'];
    day96 = json['day96'];
    day97 = json['day97'];
    day98 = json['day98'];
    day99 = json['day99'];
    day100 = json['day100'];
    day101 = json['day101'];
    day102 = json['day102'];
    day103 = json['day103'];
    day104 = json['day104'];
    day105 = json['day105'];
    day106 = json['day106'];
    day107 = json['day107'];
    day108 = json['day108'];
    day109 = json['day109'];
    day110 = json['day110'];
    day111 = json['day111'];
    day112 = json['day112'];
    day113 = json['day113'];
    day114 = json['day114'];
    day115 = json['day115'];
    day116 = json['day116'];
    day117 = json['day117'];
    day118 = json['day118'];
    day119 = json['day119'];
    day120 = json['day120'];
    day121 = json['day121'];
    day122 = json['day122'];
    day123 = json['day123'];
    day124 = json['day124'];
    day125 = json['day125'];
    day126 = json['day126'];
    day127 = json['day127'];
    day128 = json['day128'];
    day129 = json['day129'];
    day130 = json['day130'];
    day131 = json['day131'];
    day132 = json['day132'];
    day133 = json['day133'];
    day134 = json['day134'];
    day135 = json['day135'];
    day136 = json['day136'];
    day137 = json['day137'];
    day138 = json['day138'];
    day139 = json['day139'];
    day140 = json['day140'];
    day141 = json['day141'];
    day142 = json['day142'];
    day143 = json['day143'];
    day144 = json['day144'];
    day145 = json['day145'];
    day146 = json['day146'];
    day147 = json['day147'];
    day148 = json['day148'];
    day149 = json['day149'];
    day150 = json['day150'];
    day151 = json['day151'];
    day152 = json['day152'];
    day153 = json['day153'];
    day154 = json['day154'];
    day155 = json['day155'];
    day156 = json['day156'];
    day157 = json['day157'];
    day158 = json['day158'];
    day159 = json['day159'];
    day160 = json['day160'];
    day161 = json['day161'];
    day162 = json['day162'];
    day163 = json['day163'];
    day164 = json['day164'];
    day165 = json['day165'];
    day166 = json['day166'];
    day167 = json['day167'];
    day168 = json['day168'];
    day169 = json['day169'];
    day170 = json['day170'];
    day171 = json['day171'];
    day172 = json['day172'];
    day173 = json['day173'];
    day174 = json['day174'];
    day175 = json['day175'];
    day176 = json['day176'];
    day177 = json['day177'];
    day178 = json['day178'];
    day179 = json['day179'];
    day180 = json['day180'];
    day181 = json['day181'];
    day182 = json['day182'];
    day183 = json['day183'];
    day184 = json['day184'];
    day185 = json['day185'];
    day186 = json['day186'];
    day187 = json['day187'];
    day188 = json['day188'];
    day189 = json['day189'];
    day190 = json['day190'];
    day191 = json['day191'];
    day192 = json['day192'];
    day193 = json['day193'];
    day194 = json['day194'];
    day195 = json['day195'];
    day196 = json['day196'];
    day197 = json['day197'];
    day198 = json['day198'];
    day199 = json['day199'];
    day200 = json['day200'];
    day201 = json['day201'];
    day202 = json['day202'];
    day203 = json['day203'];
    day204 = json['day204'];
    day205 = json['day205'];
    day206 = json['day206'];
    day207 = json['day207'];
    day208 = json['day208'];
    day209 = json['day209'];
    day210 = json['day210'];
    day211 = json['day211'];
    day212 = json['day212'];
    day213 = json['day213'];
    day214 = json['day214'];
    day215 = json['day215'];
    day216 = json['day216'];
    day217 = json['day217'];
    day218 = json['day218'];
    day219 = json['day219'];
    day220 = json['day220'];
    day221 = json['day221'];
    day222 = json['day222'];
    day223 = json['day223'];
    day224 = json['day224'];
    day225 = json['day225'];
    day226 = json['day226'];
    day227 = json['day227'];
    day228 = json['day228'];
    day229 = json['day229'];
    day230 = json['day230'];
    day231 = json['day231'];
    day232 = json['day232'];
    day233 = json['day233'];
    day234 = json['day234'];
    day235 = json['day235'];
    day236 = json['day236'];
    day237 = json['day237'];
    day238 = json['day238'];
    day239 = json['day239'];
    day240 = json['day240'];
    day241 = json['day241'];
    day242 = json['day242'];
    day243 = json['day243'];
    day244 = json['day244'];
    day245 = json['day245'];
    day246 = json['day246'];
    day247 = json['day247'];
    day248 = json['day248'];
    day249 = json['day249'];
    day250 = json['day250'];
    day251 = json['day251'];
    day252 = json['day252'];
    day253 = json['day253'];
    day254 = json['day254'];
    day255 = json['day255'];
    day256 = json['day256'];
    day257 = json['day257'];
    day258 = json['day258'];
    day259 = json['day259'];
    day260 = json['day260'];
    day261 = json['day261'];
    day262 = json['day262'];
    day263 = json['day263'];
    day264 = json['day264'];
    day265 = json['day265'];
    day266 = json['day266'];
    day267 = json['day267'];
    day268 = json['day268'];
    day269 = json['day269'];
    day270 = json['day270'];
    day271 = json['day271'];
    day272 = json['day272'];
    day273 = json['day273'];
    day274 = json['day274'];
    day275 = json['day275'];
    day276 = json['day276'];
    day277 = json['day277'];
    day278 = json['day278'];
    day279 = json['day279'];
    day280 = json['day280'];
    day281 = json['day281'];
    day282 = json['day282'];
    day283 = json['day283'];
    day284 = json['day284'];
    day285 = json['day285'];
    day286 = json['day286'];
    day287 = json['day287'];
    day288 = json['day288'];
    day289 = json['day289'];
    day290 = json['day290'];
    day291 = json['day291'];
    day292 = json['day292'];
    day293 = json['day293'];
    day294 = json['day294'];
    day295 = json['day295'];
    day296 = json['day296'];
    day297 = json['day297'];
    day298 = json['day298'];
    day299 = json['day299'];
    day300 = json['day300'];
    day301 = json['day301'];
    day302 = json['day302'];
    day303 = json['day303'];
    day304 = json['day304'];
    day305 = json['day305'];
    day306 = json['day306'];
    day307 = json['day307'];
    day308 = json['day308'];
    day309 = json['day309'];
    day310 = json['day310'];
    day311 = json['day311'];
    day312 = json['day312'];
    day313 = json['day313'];
    day314 = json['day314'];
    day315 = json['day315'];
    day316 = json['day316'];
    day317 = json['day317'];
    day318 = json['day318'];
    day319 = json['day319'];
    day320 = json['day320'];
    day321 = json['day321'];
    day322 = json['day322'];
    day323 = json['day323'];
    day324 = json['day324'];
    day325 = json['day325'];
    day326 = json['day326'];
    day327 = json['day327'];
    day328 = json['day328'];
    day329 = json['day329'];
    day330 = json['day330'];
    day331 = json['day331'];
    day332 = json['day332'];
    day333 = json['day333'];
    day334 = json['day334'];
    day335 = json['day335'];
    day336 = json['day336'];
    day337 = json['day337'];
    day338 = json['day338'];
    day339 = json['day339'];
    day340 = json['day340'];
    day341 = json['day341'];
    day342 = json['day342'];
    day343 = json['day343'];
    day344 = json['day344'];
    day345 = json['day345'];
    day346 = json['day346'];
    day347 = json['day347'];
    day348 = json['day348'];
    day349 = json['day349'];
    day350 = json['day350'];
    day351 = json['day351'];
    day352 = json['day352'];
    day353 = json['day353'];
    day354 = json['day354'];
    day355 = json['day355'];
    day356 = json['day356'];
    day357 = json['day357'];
    day358 = json['day358'];
    day359 = json['day359'];
    day360 = json['day360'];
    day361 = json['day361'];
    day362 = json['day362'];
    day363 = json['day363'];
    day364 = json['day364'];
    day365 = json['day365'];
    day366 = json['day366'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['d_id'] = this.dId;
    data['day1'] = this.day1;
    data['day2'] = this.day2;
    data['day3'] = this.day3;
    data['day4'] = this.day4;
    data['day5'] = this.day5;
    data['day6'] = this.day6;
    data['day7'] = this.day7;
    data['day8'] = this.day8;
    data['day9'] = this.day9;
    data['day10'] = this.day10;
    data['day11'] = this.day11;
    data['day12'] = this.day12;
    data['day13'] = this.day13;
    data['day14'] = this.day14;
    data['day15'] = this.day15;
    data['day16'] = this.day16;
    data['day17'] = this.day17;
    data['day18'] = this.day18;
    data['day19'] = this.day19;
    data['day20'] = this.day20;
    data['day21'] = this.day21;
    data['day22'] = this.day22;
    data['day23'] = this.day23;
    data['day24'] = this.day24;
    data['day25'] = this.day25;
    data['day26'] = this.day26;
    data['day27'] = this.day27;
    data['day28'] = this.day28;
    data['day29'] = this.day29;
    data['day30'] = this.day30;
    data['day31'] = this.day31;
    data['day32'] = this.day32;
    data['day33'] = this.day33;
    data['day34'] = this.day34;
    data['day35'] = this.day35;
    data['day36'] = this.day36;
    data['day37'] = this.day37;
    data['day38'] = this.day38;
    data['day39'] = this.day39;
    data['day40'] = this.day40;
    data['day41'] = this.day41;
    data['day42'] = this.day42;
    data['day43'] = this.day43;
    data['day44'] = this.day44;
    data['day45'] = this.day45;
    data['day46'] = this.day46;
    data['day47'] = this.day47;
    data['day48'] = this.day48;
    data['day49'] = this.day49;
    data['day50'] = this.day50;
    data['day51'] = this.day51;
    data['day52'] = this.day52;
    data['day53'] = this.day53;
    data['day54'] = this.day54;
    data['day55'] = this.day55;
    data['day56'] = this.day56;
    data['day57'] = this.day57;
    data['day58'] = this.day58;
    data['day59'] = this.day59;
    data['day60'] = this.day60;
    data['day61'] = this.day61;
    data['day62'] = this.day62;
    data['day63'] = this.day63;
    data['day64'] = this.day64;
    data['day65'] = this.day65;
    data['day66'] = this.day66;
    data['day67'] = this.day67;
    data['day68'] = this.day68;
    data['day69'] = this.day69;
    data['day70'] = this.day70;
    data['day71'] = this.day71;
    data['day72'] = this.day72;
    data['day73'] = this.day73;
    data['day74'] = this.day74;
    data['day75'] = this.day75;
    data['day76'] = this.day76;
    data['day77'] = this.day77;
    data['day78'] = this.day78;
    data['day79'] = this.day79;
    data['day80'] = this.day80;
    data['day81'] = this.day81;
    data['day82'] = this.day82;
    data['day83'] = this.day83;
    data['day84'] = this.day84;
    data['day85'] = this.day85;
    data['day86'] = this.day86;
    data['day87'] = this.day87;
    data['day88'] = this.day88;
    data['day89'] = this.day89;
    data['day90'] = this.day90;
    data['day91'] = this.day91;
    data['day92'] = this.day92;
    data['day93'] = this.day93;
    data['day94'] = this.day94;
    data['day95'] = this.day95;
    data['day96'] = this.day96;
    data['day97'] = this.day97;
    data['day98'] = this.day98;
    data['day99'] = this.day99;
    data['day100'] = this.day100;
    data['day101'] = this.day101;
    data['day102'] = this.day102;
    data['day103'] = this.day103;
    data['day104'] = this.day104;
    data['day105'] = this.day105;
    data['day106'] = this.day106;
    data['day107'] = this.day107;
    data['day108'] = this.day108;
    data['day109'] = this.day109;
    data['day110'] = this.day110;
    data['day111'] = this.day111;
    data['day112'] = this.day112;
    data['day113'] = this.day113;
    data['day114'] = this.day114;
    data['day115'] = this.day115;
    data['day116'] = this.day116;
    data['day117'] = this.day117;
    data['day118'] = this.day118;
    data['day119'] = this.day119;
    data['day120'] = this.day120;
    data['day121'] = this.day121;
    data['day122'] = this.day122;
    data['day123'] = this.day123;
    data['day124'] = this.day124;
    data['day125'] = this.day125;
    data['day126'] = this.day126;
    data['day127'] = this.day127;
    data['day128'] = this.day128;
    data['day129'] = this.day129;
    data['day130'] = this.day130;
    data['day131'] = this.day131;
    data['day132'] = this.day132;
    data['day133'] = this.day133;
    data['day134'] = this.day134;
    data['day135'] = this.day135;
    data['day136'] = this.day136;
    data['day137'] = this.day137;
    data['day138'] = this.day138;
    data['day139'] = this.day139;
    data['day140'] = this.day140;
    data['day141'] = this.day141;
    data['day142'] = this.day142;
    data['day143'] = this.day143;
    data['day144'] = this.day144;
    data['day145'] = this.day145;
    data['day146'] = this.day146;
    data['day147'] = this.day147;
    data['day148'] = this.day148;
    data['day149'] = this.day149;
    data['day150'] = this.day150;
    data['day151'] = this.day151;
    data['day152'] = this.day152;
    data['day153'] = this.day153;
    data['day154'] = this.day154;
    data['day155'] = this.day155;
    data['day156'] = this.day156;
    data['day157'] = this.day157;
    data['day158'] = this.day158;
    data['day159'] = this.day159;
    data['day160'] = this.day160;
    data['day161'] = this.day161;
    data['day162'] = this.day162;
    data['day163'] = this.day163;
    data['day164'] = this.day164;
    data['day165'] = this.day165;
    data['day166'] = this.day166;
    data['day167'] = this.day167;
    data['day168'] = this.day168;
    data['day169'] = this.day169;
    data['day170'] = this.day170;
    data['day171'] = this.day171;
    data['day172'] = this.day172;
    data['day173'] = this.day173;
    data['day174'] = this.day174;
    data['day175'] = this.day175;
    data['day176'] = this.day176;
    data['day177'] = this.day177;
    data['day178'] = this.day178;
    data['day179'] = this.day179;
    data['day180'] = this.day180;
    data['day181'] = this.day181;
    data['day182'] = this.day182;
    data['day183'] = this.day183;
    data['day184'] = this.day184;
    data['day185'] = this.day185;
    data['day186'] = this.day186;
    data['day187'] = this.day187;
    data['day188'] = this.day188;
    data['day189'] = this.day189;
    data['day190'] = this.day190;
    data['day191'] = this.day191;
    data['day192'] = this.day192;
    data['day193'] = this.day193;
    data['day194'] = this.day194;
    data['day195'] = this.day195;
    data['day196'] = this.day196;
    data['day197'] = this.day197;
    data['day198'] = this.day198;
    data['day199'] = this.day199;
    data['day200'] = this.day200;
    data['day201'] = this.day201;
    data['day202'] = this.day202;
    data['day203'] = this.day203;
    data['day204'] = this.day204;
    data['day205'] = this.day205;
    data['day206'] = this.day206;
    data['day207'] = this.day207;
    data['day208'] = this.day208;
    data['day209'] = this.day209;
    data['day210'] = this.day210;
    data['day211'] = this.day211;
    data['day212'] = this.day212;
    data['day213'] = this.day213;
    data['day214'] = this.day214;
    data['day215'] = this.day215;
    data['day216'] = this.day216;
    data['day217'] = this.day217;
    data['day218'] = this.day218;
    data['day219'] = this.day219;
    data['day220'] = this.day220;
    data['day221'] = this.day221;
    data['day222'] = this.day222;
    data['day223'] = this.day223;
    data['day224'] = this.day224;
    data['day225'] = this.day225;
    data['day226'] = this.day226;
    data['day227'] = this.day227;
    data['day228'] = this.day228;
    data['day229'] = this.day229;
    data['day230'] = this.day230;
    data['day231'] = this.day231;
    data['day232'] = this.day232;
    data['day233'] = this.day233;
    data['day234'] = this.day234;
    data['day235'] = this.day235;
    data['day236'] = this.day236;
    data['day237'] = this.day237;
    data['day238'] = this.day238;
    data['day239'] = this.day239;
    data['day240'] = this.day240;
    data['day241'] = this.day241;
    data['day242'] = this.day242;
    data['day243'] = this.day243;
    data['day244'] = this.day244;
    data['day245'] = this.day245;
    data['day246'] = this.day246;
    data['day247'] = this.day247;
    data['day248'] = this.day248;
    data['day249'] = this.day249;
    data['day250'] = this.day250;
    data['day251'] = this.day251;
    data['day252'] = this.day252;
    data['day253'] = this.day253;
    data['day254'] = this.day254;
    data['day255'] = this.day255;
    data['day256'] = this.day256;
    data['day257'] = this.day257;
    data['day258'] = this.day258;
    data['day259'] = this.day259;
    data['day260'] = this.day260;
    data['day261'] = this.day261;
    data['day262'] = this.day262;
    data['day263'] = this.day263;
    data['day264'] = this.day264;
    data['day265'] = this.day265;
    data['day266'] = this.day266;
    data['day267'] = this.day267;
    data['day268'] = this.day268;
    data['day269'] = this.day269;
    data['day270'] = this.day270;
    data['day271'] = this.day271;
    data['day272'] = this.day272;
    data['day273'] = this.day273;
    data['day274'] = this.day274;
    data['day275'] = this.day275;
    data['day276'] = this.day276;
    data['day277'] = this.day277;
    data['day278'] = this.day278;
    data['day279'] = this.day279;
    data['day280'] = this.day280;
    data['day281'] = this.day281;
    data['day282'] = this.day282;
    data['day283'] = this.day283;
    data['day284'] = this.day284;
    data['day285'] = this.day285;
    data['day286'] = this.day286;
    data['day287'] = this.day287;
    data['day288'] = this.day288;
    data['day289'] = this.day289;
    data['day290'] = this.day290;
    data['day291'] = this.day291;
    data['day292'] = this.day292;
    data['day293'] = this.day293;
    data['day294'] = this.day294;
    data['day295'] = this.day295;
    data['day296'] = this.day296;
    data['day297'] = this.day297;
    data['day298'] = this.day298;
    data['day299'] = this.day299;
    data['day300'] = this.day300;
    data['day301'] = this.day301;
    data['day302'] = this.day302;
    data['day303'] = this.day303;
    data['day304'] = this.day304;
    data['day305'] = this.day305;
    data['day306'] = this.day306;
    data['day307'] = this.day307;
    data['day308'] = this.day308;
    data['day309'] = this.day309;
    data['day310'] = this.day310;
    data['day311'] = this.day311;
    data['day312'] = this.day312;
    data['day313'] = this.day313;
    data['day314'] = this.day314;
    data['day315'] = this.day315;
    data['day316'] = this.day316;
    data['day317'] = this.day317;
    data['day318'] = this.day318;
    data['day319'] = this.day319;
    data['day320'] = this.day320;
    data['day321'] = this.day321;
    data['day322'] = this.day322;
    data['day323'] = this.day323;
    data['day324'] = this.day324;
    data['day325'] = this.day325;
    data['day326'] = this.day326;
    data['day327'] = this.day327;
    data['day328'] = this.day328;
    data['day329'] = this.day329;
    data['day330'] = this.day330;
    data['day331'] = this.day331;
    data['day332'] = this.day332;
    data['day333'] = this.day333;
    data['day334'] = this.day334;
    data['day335'] = this.day335;
    data['day336'] = this.day336;
    data['day337'] = this.day337;
    data['day338'] = this.day338;
    data['day339'] = this.day339;
    data['day340'] = this.day340;
    data['day341'] = this.day341;
    data['day342'] = this.day342;
    data['day343'] = this.day343;
    data['day344'] = this.day344;
    data['day345'] = this.day345;
    data['day346'] = this.day346;
    data['day347'] = this.day347;
    data['day348'] = this.day348;
    data['day349'] = this.day349;
    data['day350'] = this.day350;
    data['day351'] = this.day351;
    data['day352'] = this.day352;
    data['day353'] = this.day353;
    data['day354'] = this.day354;
    data['day355'] = this.day355;
    data['day356'] = this.day356;
    data['day357'] = this.day357;
    data['day358'] = this.day358;
    data['day359'] = this.day359;
    data['day360'] = this.day360;
    data['day361'] = this.day361;
    data['day362'] = this.day362;
    data['day363'] = this.day363;
    data['day364'] = this.day364;
    data['day365'] = this.day365;
    data['day366'] = this.day366;
    return data;
  }
}

