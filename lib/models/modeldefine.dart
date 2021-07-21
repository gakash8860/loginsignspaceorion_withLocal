
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
    pId: json["p_id"] ,
    pType: json["p_type"],
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
    fId: json["f_id"],
    fName: json["f_name"],
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



List<RoomType> roomTypeFromJson(String str) => List<RoomType>.from(json.decode(str).map((x) => RoomType.fromJson(x)));

String roomTypeToJson(List<RoomType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomType {
  RoomType({
    this.rId,
    this.rName,
    this.user,
    this.fId,
  });

  String rId;
  String rName;
  int user;
  String fId;

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
    rId: json["r_id"],
    rName: json["r_name"],
    user: json["user"],
    fId: json["f_id"],
  );

  Map<String, dynamic> toJson() => {
    "r_id": rId,
    "r_name": rName,
    "user": user,
    "f_id": fId,
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
  int pin19Status;
  int pin20Status;
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
