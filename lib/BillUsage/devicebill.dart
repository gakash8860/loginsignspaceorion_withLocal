import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animated_button/animated_button.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart' as dio;
class DeviceBill extends StatefulWidget {
  const DeviceBill({Key key}) : super(key: key);

  @override
  _DeviceBillState createState() => _DeviceBillState();
}

class _DeviceBillState extends State<DeviceBill> {
  String datefinal;
  var difference;
  List<PerDayEnergy> perDayEnergy;
  double total=0.0;
  var currentDifference;
  int data;
  PlaceType pt;
  FloorType fl;
  Flat flt;
  List<RoomType> rm;
  RoomType rm2;
  Device dv2;
  List<Device> dv;
  bool placeBool = false;
  bool floorBool = false;
  bool flatBool = false;
  bool roomBool = false;
  var onlyDayEnergyList = List(366);
  var finalEnergyValue;
  List minute = [
    '10 minute',
    '20 minute',
    '30 minute',
    '40 minute',
    '50 minute',
    '60 minute'
  ];
  List hour = [
    '1 hour',
    '2 hour',
    '3 hour',
    '4 hour',
    '5 hour',
    '6 hour',
    '7 hour',
    '8 hour',
    '9 hour',
    '10 hour',
    '11 hour',
    '12 hour',
    '13 hour',
    '14 hour',
    '15 hour',
    '16 hour',
    '17 hour',
    '18 hour',
    '19 hour',
    '20 hour',
    '21 hour',
    '22 hour',
    '23 hour',
    '24 hour'
  ];

  String chooseValueMinute;
  String chooseValueHour;
  String chooseValueDay;
  double _valueMinute;
  double _valueHour;
  int _valueDay;
  double changeValue;
  List<dynamic> tenMinuteEnergy;
  List<dynamic> hourEnergy;
  List<dynamic> dayEnergy= List(366);
  var last10Minute = 'Please Select';
  var pleaseSelect = 'Please Select';
  // String difference = "";
  DateTime pickedDate;
  DateTime pickedDate2;
  var currentDate;

  String cutDate;
  String cutDate2;

  Future placeVal;
  bool completeTask=false;
  Future floorValWeb;
  Future floorVal;


  Future flatVal;
  Future flatValWeb;
  Future roomVal;
  Future roomValWeb;
  Future deviceVal;
  Future deviceValWeb;
  var selectedflat;
  var selectedroom;
  var selecteddeviceId;

  Future placeValWeb;
  @override
  void initState() {
    super.initState();
    placeVal = getplaces();
    placeValWeb = getplacesWeb();
    pickedDate = DateTime.now();
    pickedDate2 = DateTime.now();

  }

  var tokenWeb;
  Future getTokenWeb()async{
    final pref= await SharedPreferences.getInstance();
    tokenWeb=pref.getString('tokenWeb');
    return tokenWeb;
  }
  Future<List<PlaceType>> getplaces() async {
    String token = await getToken();
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = API + 'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
      data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }
  }
  Future<List<PlaceType>> getplacesWeb() async {
    String token = await getTokenWeb();
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = API + 'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
      data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }
  }

  Future getEnergyTenMinutes(String dId) async {
    String token = await getToken();
    final url = API + 'pertenminuteenergy?d_id=' + dId;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('tenMinuteEnergy ${response.statusCode}');
    if (response.statusCode == 200) {
      tenMinuteEnergy = jsonDecode(response.body);
      if(tenMinuteEnergy.isEmpty ){
        setState(() {
          pleaseSelect='There is not Data';
        });
        thereIsNoData(context);

      }
      print('tenMinuteEnergy ${tenMinuteEnergy}');
      if (chooseValueMinute == '10 minute') {
        setState(() {
         double changeValue = double.parse(tenMinuteEnergy[0]['enrgy10']);
          _valueMinute = changeValue;
        });
      } else if (chooseValueMinute == '20 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          _valueMinute = op1 + op2;
        });
      } else if (chooseValueMinute == '30 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[0]['enrgy30']);
          _valueMinute = op1 + op2 + op3;
        });
      } else if (chooseValueMinute == '40 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[0]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[0]['enrgy40']);
          _valueMinute = op1 + op2 + op3 + op4;
        });
      } else if (chooseValueMinute == '50 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[0]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[0]['enrgy40']);
          double op5 = double.parse(tenMinuteEnergy[0]['enrgy50']);
          _valueMinute = op1 + op2 + op3 + op4 + op5;
        });
      } else if (chooseValueMinute == '60 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[0]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[0]['enrgy40']);
          double op5 = double.parse(tenMinuteEnergy[0]['enrgy50']);
          double op6 = double.parse(tenMinuteEnergy[0]['enrgy60']);
          _valueMinute = op1 + op2 + op3 + op4 + op5;
        });
      }

      print('tenMinuteEnergy $tenMinuteEnergy');
      print('tenMinuteEnergy $last10Minute');
    }
  }
  Future getEnergyTenMinutesWeb(String dId) async {
    String token = await getTokenWeb();
    final url = API + 'pertenminuteenergy?d_id=' + dId;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('tenMinuteEnergy ${response.statusCode}');
    if (response.statusCode == 200) {
      tenMinuteEnergy = jsonDecode(response.body);
      print('webtenMinuet $tenMinuteEnergy');
      if(tenMinuteEnergy.isEmpty ){
        setState(() {
          pleaseSelect='There is not Data';
        });
        thereIsNoData(context);

      }
      print('tenMinuteEnergy ${tenMinuteEnergy}');
      if (chooseValueMinute == '10 minute') {
        setState(() {
         double changeValue = double.parse(tenMinuteEnergy[0]['enrgy10']);
          _valueMinute = changeValue;
        });
      } else if (chooseValueMinute == '20 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          _valueMinute = op1 + op2;
        });
      } else if (chooseValueMinute == '30 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[0]['enrgy30']);
          _valueMinute = op1 + op2 + op3;
        });
      } else if (chooseValueMinute == '40 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[0]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[0]['enrgy40']);
          _valueMinute = op1 + op2 + op3 + op4;
        });
      } else if (chooseValueMinute == '50 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[0]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[0]['enrgy40']);
          double op5 = double.parse(tenMinuteEnergy[0]['enrgy50']);
          _valueMinute = op1 + op2 + op3 + op4 + op5;
        });
      } else if (chooseValueMinute == '60 minute') {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[0]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[0]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[0]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[0]['enrgy40']);
          double op5 = double.parse(tenMinuteEnergy[0]['enrgy50']);
          double op6 = double.parse(tenMinuteEnergy[0]['enrgy60']);
          _valueMinute = op1 + op2 + op3 + op4 + op5;
        });
      }

      print('tenMinuteEnergy $tenMinuteEnergy');
      print('tenMinuteEnergy $last10Minute');
    }
  }

  Future<List<FloorType>> getfloors(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<FloorType> floors =
      data.map((data) => FloorType.fromJson(data)).toList();
      print(floors);
      return floors;
    }
  }
  Future<List<FloorType>> getfloorsWeb(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<FloorType> floors =
      data.map((data) => FloorType.fromJson(data)).toList();
      print(floors);
      return floors;
    }
  }

  Future<List<Flat>> getflat(String fId) async {
    final url = API + 'addyourflat/?f_id=' + fId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Flat> flatData = data.map((data) => Flat.fromJson(data)).toList();
      print(flatData);
      return flatData;
    }
  }
  Future<List<Flat>> getflatWeb(String fId) async {
    final url = API + 'addyourflat/?f_id=' + fId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Flat> flatData = data.map((data) => Flat.fromJson(data)).toList();
      print(flatData);
      return flatData;
    }
  }

  Future getEnergyDay(String dId) async {
    String token = await getToken();
    final url = API + 'perdaysenergy?d_id=' + dId;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('tenMinuteEnergy ${response.statusCode}');
    print('tenMinuteEnergy ${response.body}');
    if (response.statusCode == 200) {
     List<dynamic> data=jsonDecode(response.body);
     if(data.isEmpty ){
       setState(() {
         pleaseSelect='There is not Data';
       });
        return thereIsNoData(context);

     }
     for(int i=0;i<366;i++){
       onlyDayEnergyList[i]=0.0;
     }
     print('beforeSsumData ${onlyDayEnergyList}');
    for(int i=0;i<366;i++){
      onlyDayEnergyList[i]=data[0]['day$i'];
    }
     print('sumData ${onlyDayEnergyList}');
    int i=1;

    while(i<=difference){
      print(' asasa ${onlyDayEnergyList[i+currentDifference]}');
      setState(() {
        total=total+onlyDayEnergyList[i+currentDifference];
        finalEnergyValue=total.toString();
      });
      i++;
      print('sumDatatotal ${total}');
    }
    total=0.0;
     print('sumDatatotal_final ${total}');


    }
  }
  Future getEnergyDayWeb(String dId) async {
    String token = await getTokenWeb();
    final url = API + 'perdaysenergy?d_id=' + dId;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('tenMinuteEnergy ${response.statusCode}');
    print('tenMinuteEnergy ${response.body}');
    if (response.statusCode == 200) {
     List<dynamic> data=jsonDecode(response.body);
     if(data.isEmpty ){
       setState(() {
         pleaseSelect='There is not Data';
       });
       return thereIsNoData(context);

     }
     for(int i=0;i<366;i++){
       onlyDayEnergyList[i]=0.0;
     }
     print('beforeSsumData ${onlyDayEnergyList}');
    for(int i=0;i<366;i++){
      onlyDayEnergyList[i]=data[0]['day$i'];
    }
     print('sumData ${onlyDayEnergyList}');
    int i=1;

    while(i<=difference){
      print(' asasa ${onlyDayEnergyList[i+currentDifference]}');
      setState(() {
        total=total+onlyDayEnergyList[i+currentDifference];
        finalEnergyValue=total.toString();
      });
      i++;
      print('sumDatatotal ${total}');
    }
    total=0.0;
     print('sumDatatotal_final ${total}');


    }
  }

  Future<List<RoomType>> getrooms(String flt_id) async {
    final url = API + 'addroom/?flt_id=' + flt_id;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<RoomType> rooms =
      data.map((data) => RoomType.fromJson(data)).toList();
      print(rooms);
      return rooms;
    }
  }
  Future<List<RoomType>> getroomsWeb(String flt_id) async {
    final url = API + 'addroom/?flt_id=' + flt_id;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<RoomType> rooms =
      data.map((data) => RoomType.fromJson(data)).toList();
      print(rooms);
      return rooms;
    }
  }

  Future getEnergyHour(String dId) async {
    String token = await getToken();
    final url = API + 'perhourenergy?d_id=' + dId;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('tenMinuteEnergy ${response.statusCode}');
    if (response.statusCode == 200) {
      hourEnergy = jsonDecode(response.body);
      print('hour $hourEnergy');
      if(hourEnergy.isEmpty ){
        setState(() {
          pleaseSelect='There is not Data';
        });
        return thereIsNoData(context);

      }
      if (chooseValueHour == '1 hour') {
        setState(() {
          var last10Minute = hourEnergy[0]['hour1'];
          changeValue = double.parse(last10Minute);
          _valueHour = changeValue;
          print('sasa $last10Minute');
        });
      } else if (chooseValueHour == '2 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          _valueHour = op1 + op2;
        });
      } else if (chooseValueHour == '3 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          _valueHour = op1 + op2 + op3;
        });
      } else if (chooseValueHour == '4 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          _valueHour = op1 + op2 + op3 + op4;
        });
      } else if (chooseValueHour == '5 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          _valueHour = op1 + op2 + op3 + op4 + op5;
        });
      } else if (chooseValueHour == '6 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6;
        });
      } else if (chooseValueHour == '7 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7;
        });
      } else if (chooseValueHour == '8 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8;
        });
      } else if (chooseValueHour == '9 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9;
        });
      } else if (chooseValueHour == '10 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          _valueHour =
              op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9 + op10;
        });
      } else if (chooseValueHour == '11 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          _valueHour =
              op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9 + op10 + op11;
        });
      } else if (chooseValueHour == '12 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12;
        });
      } else if (chooseValueHour == '13 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13;
        });
      } else if (chooseValueHour == '14 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14;
        });
      } else if (chooseValueHour == '15 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15;
        });
      } else if (chooseValueHour == '16 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16;
        });
      }
      else if (chooseValueHour == '17 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17;
        });
      }
      else if (chooseValueHour == '18 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18;
        });
      }
      else if (chooseValueHour == '19 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19;
        });
      }
      else if (chooseValueHour == '20 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20;
        });
      }
      else if (chooseValueHour == '21 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          double op21 = double.parse(hourEnergy[0]['hour21']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20+op21;
        });
      }
      else if (chooseValueHour == '22 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          double op21 = double.parse(hourEnergy[0]['hour21']);
          double op22 = double.parse(hourEnergy[0]['hour22']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20+op21+op22;
        });
      }
      else if (chooseValueHour == '23 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          double op21 = double.parse(hourEnergy[0]['hour21']);
          double op22 = double.parse(hourEnergy[0]['hour22']);
          double op23 = double.parse(hourEnergy[0]['hour23']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20+op21+op22+op23;
        });
      }
      else if (chooseValueHour == '24 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          double op21 = double.parse(hourEnergy[0]['hour21']);
          double op22 = double.parse(hourEnergy[0]['hour22']);
          double op23 = double.parse(hourEnergy[0]['hour23']);
          double op24 = double.parse(hourEnergy[0]['hour24']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20+op21+op22+op23;
        });
      }
    }
  }

  Future getEnergyHourWeb(String dId) async {
    String token = await getTokenWeb();
    final url = API + 'perhourenergy?d_id=' + dId;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('tenMinuteEnergy ${response.statusCode}');
    if (response.statusCode == 200) {
      hourEnergy = jsonDecode(response.body);
      print('hour $hourEnergy');
      if(hourEnergy.isEmpty ){
        setState(() {
          pleaseSelect='There is not Data';
        });
        return thereIsNoData(context);

      }
      if (chooseValueHour == '1 hour') {
        setState(() {
          var last10Minute = hourEnergy[0]['hour1'];
          changeValue = double.parse(last10Minute);
          _valueHour = changeValue;
          print('sasa $last10Minute');
        });
      } else if (chooseValueHour == '2 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          _valueHour = op1 + op2;
        });
      } else if (chooseValueHour == '3 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          _valueHour = op1 + op2 + op3;
        });
      } else if (chooseValueHour == '4 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          _valueHour = op1 + op2 + op3 + op4;
        });
      } else if (chooseValueHour == '5 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          _valueHour = op1 + op2 + op3 + op4 + op5;
        });
      } else if (chooseValueHour == '6 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6;
        });
      } else if (chooseValueHour == '7 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7;
        });
      } else if (chooseValueHour == '8 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8;
        });
      } else if (chooseValueHour == '9 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9;
        });
      } else if (chooseValueHour == '10 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          _valueHour =
              op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9 + op10;
        });
      } else if (chooseValueHour == '11 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          _valueHour =
              op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9 + op10 + op11;
        });
      } else if (chooseValueHour == '12 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12;
        });
      } else if (chooseValueHour == '13 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13;
        });
      } else if (chooseValueHour == '14 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14;
        });
      } else if (chooseValueHour == '15 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15;
        });
      } else if (chooseValueHour == '16 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16;
        });
      }
      else if (chooseValueHour == '17 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17;
        });
      }
      else if (chooseValueHour == '18 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18;
        });
      }
      else if (chooseValueHour == '19 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19;
        });
      }
      else if (chooseValueHour == '20 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20;
        });
      }
      else if (chooseValueHour == '21 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          double op21 = double.parse(hourEnergy[0]['hour21']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20+op21;
        });
      }
      else if (chooseValueHour == '22 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          double op21 = double.parse(hourEnergy[0]['hour21']);
          double op22 = double.parse(hourEnergy[0]['hour22']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20+op21+op22;
        });
      }
      else if (chooseValueHour == '23 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          double op21 = double.parse(hourEnergy[0]['hour21']);
          double op22 = double.parse(hourEnergy[0]['hour22']);
          double op23 = double.parse(hourEnergy[0]['hour23']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20+op21+op22+op23;
        });
      }
      else if (chooseValueHour == '24 hour') {
        setState(() {
          double op1 = double.parse(hourEnergy[0]['hour1']);
          double op2 = double.parse(hourEnergy[0]['hour2']);
          double op3 = double.parse(hourEnergy[0]['hour3']);
          double op4 = double.parse(hourEnergy[0]['hour4']);
          double op5 = double.parse(hourEnergy[0]['hour5']);
          double op6 = double.parse(hourEnergy[0]['hour6']);
          double op7 = double.parse(hourEnergy[0]['hour7']);
          double op8 = double.parse(hourEnergy[0]['hour8']);
          double op9 = double.parse(hourEnergy[0]['hour9']);
          double op10 = double.parse(hourEnergy[0]['hour10']);
          double op11 = double.parse(hourEnergy[0]['hour11']);
          double op12 = double.parse(hourEnergy[0]['hour12']);
          double op13 = double.parse(hourEnergy[0]['hour13']);
          double op14 = double.parse(hourEnergy[0]['hour14']);
          double op15 = double.parse(hourEnergy[0]['hour15']);
          double op16 = double.parse(hourEnergy[0]['hour16']);
          double op17 = double.parse(hourEnergy[0]['hour17']);
          double op18 = double.parse(hourEnergy[0]['hour18']);
          double op19 = double.parse(hourEnergy[0]['hour19']);
          double op20 = double.parse(hourEnergy[0]['hour20']);
          double op21 = double.parse(hourEnergy[0]['hour21']);
          double op22 = double.parse(hourEnergy[0]['hour22']);
          double op23 = double.parse(hourEnergy[0]['hour23']);
          double op24 = double.parse(hourEnergy[0]['hour24']);
          _valueHour = op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11 +
              op12 +
              op13 +
              op14 +
              op15 +
              op16 +
              op17 +
              op18 +
              op19 +
              op20+op21+op22+op23;
        });
      }
    }
  }



  Future<List<Device>> getDevice(String r_id) async {
    final url = API + 'addyourdevice/?r_id=' + r_id;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      if(data.isEmpty){
        return noDevice();

      }
      List<Device> dv =
      data.map((data) => Device.fromJson(data)).toList();
      print('DeviceId-->  ${dv[0].dId}');
      setState(() {

      });
      return dv;
    }else{
      return null;
    }
  }





  Future<List<Device>> getDeviceWeb(String r_id) async {
    final url = API + 'addyourdevice/?r_id=' + r_id;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Device> dv =
      data.map((data) => Device.fromJson(data)).toList();
      print('DeviceId-->  ${dv[0].dId}');
      setState(() {
        completeTask=true;
      });
      return dv;
    }else{
      return null;
    }
  }
  // pickDate() async {
  //   DateTime date = await showDatePicker(
  //     context: context,
  //     initialDate: pickedDate,
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );
  //   if (date != null) {
  //     setState(() {
  //       pickedDate = date;
  //     });
  //   }
  //   String date2 = pickedDate.toString();
  //   setState(() {
  //     cutDate = date2.substring(0, 10);
  //   });
  //
  //   print('pickedDate ${date2}');
  //   print('pickedDate ${cutDate}');
  // }

  thereIsNoData(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            title: Text('Oops !'),
            content: Card(
              child: Text('No Data'),
            ),
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
       return Scaffold(

          appBar: AppBar(
            title: Text('App'),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<PlaceType>>(
                      future: placeValWeb,
                      builder: (context,
                          AsyncSnapshot<List<PlaceType>> snapshot) {
                        if (snapshot.hasData) {
                          // print(snapshot.hasData);
                          // setState(() {
                          //   floorVal = getfloors(snapshot.data[0].p_id);
                          // });
                          if (snapshot.data.length == 0) {
                            return Center(
                                child:
                                Text("No Devices on this place"));
                          }
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 58),
                              child: SizedBox(
                                // width: double.infinity,
                                height: 50.0,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(7, 7)
                                          // offset: Offset(20,20)
                                        )
                                      ],
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      )),
                                  child: DropdownButtonFormField<PlaceType>(
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      enabledBorder:
                                      UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black),
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                    ),
                                    dropdownColor: Colors.white70,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 28,
                                    hint: Text('Select Place'),
                                    isExpanded: true,
                                    value: pt,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    items: snapshot.data
                                        .map((selectedPlace) {
                                      return DropdownMenuItem<
                                          PlaceType>(
                                        value: selectedPlace,
                                        child:
                                        Text(selectedPlace.pType),
                                      );
                                    }).toList(),
                                    onChanged:
                                        (PlaceType selectedPlace) {
                                      setState(() {
                                        fl = null;
                                        pt = selectedPlace;
                                        floorValWeb = getfloorsWeb(
                                            selectedPlace.pId);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            margin: new EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<FloorType>>(
                      future: floorValWeb,
                      builder: (context,
                          AsyncSnapshot<List<FloorType>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(
                                child:
                                Text("No Devices on this place"));
                          }
                          return Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(right: 58),
                                  child: SizedBox(
                                    // width: double.infinity,
                                    height: 50.0,
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 10,
                                                offset: Offset(7, 7)
                                              // blurRadius: 30,
                                              // // offset for Upward Effect
                                              // offset: Offset(20,20)
                                            )
                                          ],
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          )),
                                      child: DropdownButtonFormField<
                                          FloorType>(
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.all(15),
                                          focusedBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                          enabledBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(
                                                50),
                                          ),
                                        ),
                                        dropdownColor: Colors.white70,
                                        icon:
                                        Icon(Icons.arrow_drop_down),
                                        iconSize: 28,
                                        hint: Text('Select Floor'),
                                        isExpanded: true,
                                        value: fl,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: snapshot.data
                                            .map((selectedFloor) {
                                          return DropdownMenuItem<
                                              FloorType>(
                                            value: selectedFloor,
                                            child: Text(
                                                selectedFloor.fName),
                                          );
                                        }).toList(),
                                        onChanged:
                                            (FloorType selectedFloor) {
                                          setState(() {
                                            fl = selectedFloor;
                                            flatValWeb = getflatWeb(
                                                selectedFloor.fId);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                margin: new EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                              child:  Text(
                                  "Please select a place to proceed further"));
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<Flat>>(
                      future: flatValWeb,
                      builder: (context,
                          AsyncSnapshot<List<Flat>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(
                                child:
                                Text("No Devices on this place"));
                          }
                          return Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(right: 58),
                                  child: SizedBox(
                                    // width: double.infinity,
                                    height: 50.0,
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 10,
                                                offset: Offset(7, 7)
                                              // blurRadius: 30,
                                              // // offset for Upward Effect
                                              // offset: Offset(20,20)
                                            )
                                          ],
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          )),
                                      child:
                                      DropdownButtonFormField<Flat>(
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.all(15),
                                          focusedBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                          enabledBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(
                                                50),
                                          ),
                                        ),
                                        dropdownColor: Colors.white70,
                                        icon:
                                        Icon(Icons.arrow_drop_down),
                                        iconSize: 28,
                                        hint: Text('Select Floor'),
                                        isExpanded: true,
                                        value: flt,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: snapshot.data
                                            .map((selectedFlat) {
                                          return DropdownMenuItem<Flat>(
                                            value: selectedFlat,
                                            child: Text(
                                                selectedFlat.fltName),
                                          );
                                        }).toList(),
                                        onChanged: (Flat selectedFlat) {
                                          setState(() {
                                            flt = selectedFlat;
                                            selectedflat=selectedFlat.fltId;
                                            roomValWeb=getroomsWeb(selectedflat);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                margin: new EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),

                            ],
                          );
                        } else {
                          return Center(
                              child: Text(
                                  "Please select a place to proceed further"));
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<RoomType>>(
                      future: roomValWeb,
                      builder: (context,
                          AsyncSnapshot<List<RoomType>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(
                                child:
                                Text("No Devices on this place"));
                          }
                          return Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(right: 58),
                                  child: SizedBox(
                                    // width: double.infinity,
                                    height: 50.0,
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 10,
                                                offset: Offset(7, 7)
                                              // blurRadius: 30,
                                              // // offset for Upward Effect
                                              // offset: Offset(20,20)
                                            )
                                          ],
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          )),
                                      child:
                                      DropdownButtonFormField<RoomType>(
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.all(15),
                                          focusedBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                          enabledBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(
                                                50),
                                          ),
                                        ),
                                        dropdownColor: Colors.white70,
                                        icon:
                                        Icon(Icons.arrow_drop_down),
                                        iconSize: 28,
                                        hint: Text('Select Room'),
                                        isExpanded: true,
                                        value: rm2,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: snapshot.data
                                            .map((selectedRoom) {
                                          return DropdownMenuItem<RoomType>(
                                            value: selectedRoom,
                                            child: Text(
                                                selectedRoom.rName),
                                          );
                                        }).toList(),
                                        onChanged: (RoomType selectedRoom) {
                                          setState(() {
                                            rm2 = selectedRoom;
                                            selectedroom=selectedRoom.rId;
                                            deviceValWeb=getDeviceWeb(selectedroom);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                margin: new EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          );
                        } else {
                          return Center(
                              child: Text(
                                  "Please select a place to proceed further"));
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<Device>>(
                      future: deviceValWeb,
                      builder: (context,
                          AsyncSnapshot<List<Device>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(
                                child:
                                Text("No Devices on this place"));
                          }
                          return Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(right: 58),
                                  child: SizedBox(
                                    // width: double.infinity,
                                    height: 50.0,
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 10,
                                                offset: Offset(7, 7)
                                              // blurRadius: 30,
                                              // // offset for Upward Effect
                                              // offset: Offset(20,20)
                                            )
                                          ],
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          )),
                                      child:
                                      DropdownButtonFormField<Device>(
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.all(15),
                                          focusedBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                          enabledBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(
                                                50),
                                          ),
                                        ),
                                        dropdownColor: Colors.white70,
                                        icon:
                                        Icon(Icons.arrow_drop_down),
                                        iconSize: 28,
                                        hint: Text('Select Device'),
                                        isExpanded: true,
                                        value: dv2,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: snapshot.data
                                            .map((selectedDevice) {
                                          return DropdownMenuItem<Device>(
                                            value: selectedDevice,
                                            child: Text(
                                                selectedDevice.dId),
                                          );
                                        }).toList(),
                                        onChanged: (Device selectedDevice) {
                                          setState(() {
                                            // rm2 = selectedRoom;
                                            selecteddeviceId=selectedDevice.dId;

                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                margin: new EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          );
                        } else {
                          return Center(
                              child: Text(
                                  "Please select a place to proceed further"));
                        }
                      }),
                  completeTask?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      DropdownButton(
                          value: chooseValueMinute,
                          onChanged: (index) async {
                            setState(() {
                              chooseValueMinute = index;
                            });

                            await getEnergyTenMinutesWeb(selecteddeviceId);

                          },
                          items: minute.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList()),
                      Text(_valueMinute == null
                          ? pleaseSelect
                          : _valueMinute.toString()),
                    ],
                  ):Text('Wait'),
                  SizedBox(
                    height: 15,
                  ),
                  completeTask?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      DropdownButton(
                          value: chooseValueHour,
                          onChanged: (index) async {
                            setState(() {
                              chooseValueHour = index;
                            });

                            await getEnergyHourWeb(selecteddeviceId);
                          },
                          items: hour.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList()),
                      Text(_valueHour == null ? pleaseSelect : _valueHour.toString()),
                    ],
                  ):Text("Wait"),
                  SizedBox(
                    height: 15,
                  ),
                  completeTask? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () async{
                          await showDatePicker1();

                        },
                        child: Text(cutDate == null ? 'Select Date' : cutDate),
                      ),
                      InkWell(
                        onTap: () {
                          showDatePicker2();
                          // print12();
                        },
                        child: Text(cutDate2 == null ? 'Select Date' : cutDate2),
                      ),
                    ],
                  ):Text("Wait"),
                  completeTask?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () async{

                        },
                        child: Text(finalEnergyValue.toString()),
                      ),
                      ElevatedButton(
                          onPressed: ()async{
                            await differenceCurrentDateToSelectedDate();
                            await findDifferenceBetweenDates();
                            await getEnergyDayWeb(selecteddeviceId);
                          }, child: Text('Click'))
                    ],

                  ):Text("Wait"),

                ],
              ),
            ),
          ),
        );
      }else{
        return Scaffold(

          appBar: AppBar(
            title: const Text('App'),
          ),
          body: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                placeBool==false?   FutureBuilder<List<PlaceType>>(
                    future: placeVal,
                    builder: (context,
                        AsyncSnapshot<List<PlaceType>> snapshot) {
                      if (snapshot.hasData) {
                        // print(snapshot.hasData);
                        // setState(() {
                        //   floorVal = getfloors(snapshot.data[0].p_id);
                        // });
                        if (snapshot.data.length == 0) {
                          return Center(
                              child:
                              Text("No Devices on this place"));
                        }
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 58),
                            child: SizedBox(
                              // width: double.infinity,
                              height: 50.0,
                              child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width /
                                    2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 10,
                                          offset: Offset(7, 7)
                                        // offset: Offset(20,20)
                                      )
                                    ],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    )),
                                child: DropdownButtonFormField<PlaceType>(
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    enabledBorder:
                                    UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black),
                                      borderRadius:
                                      BorderRadius.circular(50),
                                    ),
                                  ),
                                  dropdownColor: Colors.white70,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 28,
                                  hint: Text('Select Place'),
                                  isExpanded: true,
                                  value: pt,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  items: snapshot.data
                                      .map((selectedPlace) {
                                    return DropdownMenuItem<
                                        PlaceType>(
                                      value: selectedPlace,
                                      child:
                                      Text(selectedPlace.pType),
                                    );
                                  }).toList(),
                                  onChanged:
                                      (PlaceType selectedPlace) {
                                    setState(() {
                                      fl = null;
                                      pt = selectedPlace;
                                      placeBool=true;
                                      floorVal = getfloors(
                                          selectedPlace.pId);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          margin: new EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }):

                floorBool == false? FutureBuilder<List<FloorType>>(
                    future: floorVal,
                    builder: (context,
                        AsyncSnapshot<List<FloorType>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Center(
                              child:
                              Text("No Devices on this place"));
                        }
                        return Column(
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(right: 58),
                                child: SizedBox(
                                  // width: double.infinity,
                                  height: 50.0,
                                  child: Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        2,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10,
                                              offset: Offset(7, 7)
                                            // blurRadius: 30,
                                            // // offset for Upward Effect
                                            // offset: Offset(20,20)
                                          )
                                        ],
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    child: DropdownButtonFormField<
                                        FloorType>(
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.all(15),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                        ),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(
                                              50),
                                        ),
                                      ),
                                      dropdownColor: Colors.white70,
                                      icon:
                                      Icon(Icons.arrow_drop_down),
                                      iconSize: 28,
                                      hint: Text('Select Floor'),
                                      isExpanded: true,
                                      value: fl,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      items: snapshot.data
                                          .map((selectedFloor) {
                                        return DropdownMenuItem<
                                            FloorType>(
                                          value: selectedFloor,
                                          child: Text(
                                              selectedFloor.fName),
                                        );
                                      }).toList(),
                                      onChanged:
                                          (FloorType selectedFloor) {
                                        setState(() {
                                          fl = selectedFloor;
                                          floorBool = true;
                                          flatVal = getflat(
                                              selectedFloor.fId);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              margin: new EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      } else {
                        return Center(
                            child: Text(
                                "Please select a place to proceed further"));
                      }
                    }):
              flatBool==false?  FutureBuilder<List<Flat>>(
                    future: flatVal,
                    builder: (context,
                        AsyncSnapshot<List<Flat>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Center(
                              child:
                              Text("No Devices on this place"));
                        }
                        return Column(
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(right: 58),
                                child: SizedBox(
                                  // width: double.infinity,
                                  height: 50.0,
                                  child: Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        2,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10,
                                              offset: Offset(7, 7)
                                            // blurRadius: 30,
                                            // // offset for Upward Effect
                                            // offset: Offset(20,20)
                                          )
                                        ],
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    child:
                                    DropdownButtonFormField<Flat>(
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.all(15),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                        ),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(
                                              50),
                                        ),
                                      ),
                                      dropdownColor: Colors.white70,
                                      icon:
                                      Icon(Icons.arrow_drop_down),
                                      iconSize: 28,
                                      hint: Text('Select Floor'),
                                      isExpanded: true,
                                      value: flt,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      items: snapshot.data
                                          .map((selectedFlat) {
                                        return DropdownMenuItem<Flat>(
                                          value: selectedFlat,
                                          child: Text(
                                              selectedFlat.fltName),
                                        );
                                      }).toList(),
                                      onChanged: (Flat selectedFlat) {
                                        setState(() {
                                          flt = selectedFlat;
                                          selectedflat=selectedFlat.fltId;
                                          flatBool = true;
                                          roomVal=getrooms(selectedflat);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              margin: new EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),

                          ],
                        );
                      } else {
                        return Center(
                            child: Text(
                                "Please select a place to proceed further"));
                      }
                    }):
               roomBool == false? FutureBuilder<List<RoomType>>(
                    future: roomVal,
                    builder: (context,
                        AsyncSnapshot<List<RoomType>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Center(
                              child:
                              Text("No Devices on this place"));
                        }
                        return Column(
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(right: 58),
                                child: SizedBox(
                                  // width: double.infinity,
                                  height: 50.0,
                                  child: Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        2,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10,
                                              offset: Offset(7, 7)
                                            // blurRadius: 30,
                                            // // offset for Upward Effect
                                            // offset: Offset(20,20)
                                          )
                                        ],
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    child:
                                    DropdownButtonFormField<RoomType>(
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.all(15),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                        ),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(
                                              50),
                                        ),
                                      ),
                                      dropdownColor: Colors.white70,
                                      icon:
                                      Icon(Icons.arrow_drop_down),
                                      iconSize: 28,
                                      hint: Text('Select Room'),
                                      isExpanded: true,
                                      value: rm2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      items: snapshot.data
                                          .map((selectedRoom) {
                                        return DropdownMenuItem<RoomType>(
                                          value: selectedRoom,
                                          child: Text(
                                              selectedRoom.rName),
                                        );
                                      }).toList(),
                                      onChanged: (RoomType selectedRoom) {
                                        setState(() {
                                          rm2 = selectedRoom;
                                          selectedroom=selectedRoom.rId;
                                          roomBool = true;
                                          deviceVal=getDevice(selectedroom);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              margin: new EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),


                          ],
                        );
                      } else {
                        return Center(
                            child: Text(
                                "Please select a place to proceed further"));
                      }
                    }):
                FutureBuilder<List<Device>>(
                    future: deviceVal,
                    builder: (context,
                        AsyncSnapshot<List<Device>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Center(
                              child:
                              Text("No Devices on this place"));
                        }
                        return Column(
                          children: [
                            Container(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(right: 58),
                                child: SizedBox(
                                  // width: double.infinity,
                                  height: 50.0,
                                  child: Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        2,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10,
                                              offset: Offset(7, 7)
                                            // blurRadius: 30,
                                            // // offset for Upward Effect
                                            // offset: Offset(20,20)
                                          )
                                        ],
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    child:
                                    DropdownButtonFormField<Device>(
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.all(15),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                        ),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                          BorderRadius.circular(
                                              50),
                                        ),
                                      ),
                                      dropdownColor: Colors.white70,
                                      icon:
                                      Icon(Icons.arrow_drop_down),
                                      iconSize: 28,
                                      hint: Text('Select Device'),
                                      isExpanded: true,
                                      value: dv2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      items: snapshot.data
                                          .map((selectedDevice) {
                                        return DropdownMenuItem<Device>(
                                          value: selectedDevice,
                                          child: Text(
                                              selectedDevice.dId),
                                        );
                                      }).toList(),
                                      onChanged: (Device selectedDevice) {
                                        setState(() {
                                          // rm2 = selectedRoom;
                                          selecteddeviceId=selectedDevice.dId;
                                          completeTask=true;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              margin: new EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                          ],
                        );
                      } else {
                        return Center(
                            child: Text(
                                "Please select a place to proceed further"));
                      }
                    }),
                completeTask?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownButton(
                        value: chooseValueMinute,
                        onChanged: (index) async {
                          setState(() {
                            chooseValueMinute = index;
                          });

                          await getEnergyTenMinutes(selecteddeviceId);

                        },
                        items: minute.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList()),
                    Text(_valueMinute == null
                        ? pleaseSelect
                        : _valueMinute.toString()),
                  ],
                ):Text('Wait'),
                SizedBox(
                  height: 15,
                ),
                completeTask?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownButton(
                        value: chooseValueHour,
                        onChanged: (index) async {
                          setState(() {
                            chooseValueHour = index;
                          });

                          await getEnergyHour(selecteddeviceId);
                        },
                        items: hour.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList()),
                    Text(_valueHour == null ? pleaseSelect : _valueHour.toString()),
                  ],
                ):Text("Wait"),
                SizedBox(
                  height: 15,
                ),
                completeTask? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () async{
                        await showDatePicker1();

                      },
                      child: Text(cutDate == null ? 'Select Date' : cutDate),
                    ),
                    InkWell(
                      onTap: () {
                        showDatePicker2();
                        // print12();
                      },
                      child: Text(cutDate2 == null ? 'Select Date' : cutDate2),
                    ),
                  ],
                ):Text("Wait"),
                completeTask?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () async{

                      },
                      child: Text(finalEnergyValue.toString()),
                    ),
                    ElevatedButton(
                        onPressed: ()async{
                          await differenceCurrentDateToSelectedDate();
                          await findDifferenceBetweenDates();
                          await getEnergyDay(selecteddeviceId);
                        }, child: Text('Click'))
                  ],

                ):Text("Wait"),

              ],
            ),
          ),
        );
      }
        }
    );
  }


  noDevice() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Error ',
      desc: 'No Device',
      // btnCancelOnPress: () {},
      btnOkOnPress: () async {
      Navigator.pop(context);
      },
    )..show();
  }
  DateTime date2;
  DateTime date1;

   showDatePicker1(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2080)
    ).then((date) => {
      setState(() {
        date1=date;
        datefinal = date.toString();
        cutDate = datefinal.substring(0, 10);

      })
    });
  }

   showDatePicker2(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2080)
    ).then((date) => {
      setState(() {
        date2=date;
        datefinal = date.toString();
        cutDate2 = datefinal.substring(0, 10);

      })
    });
  }
  // m-1*30+d date

  differenceCurrentDateToSelectedDate(){
     currentDifference=DateTime.now().difference(date1).inDays;
    print('currentDifference ${currentDifference}');
  }

  void findDifferenceBetweenDates(){
     print(date1);
     print(date2);
      setState(() {
        difference = date1.difference(date2).inDays;
      });

    print('difference $difference');
  }



}
