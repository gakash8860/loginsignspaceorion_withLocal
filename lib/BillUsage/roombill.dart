import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class RoomBill extends StatefulWidget {
  const RoomBill({Key key}) : super(key: key);

  @override
  _RoomBillState createState() => _RoomBillState();
}

class _RoomBillState extends State<RoomBill> {
  Future placeVal;
  DateTime pickedDate;
  DateTime pickedDate2;
  double _valueHour;
  List hourEnergy;
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
  bool completeTask=false;
  PlaceType pt;
  FloorType fl;
  Flat flt;
  String chooseValueHour;
  String chooseValueDay;
  List<RoomType> rm;
  double _valueMinute;
  var pleaseSelect = 'Please Select';
  RoomType rm2;
  int length=0;
  Device dv2;
  String chooseValueMinute;
  List tenMinuteEnergy;
  var data;
  double total=0.0;
  List<Device> dv;
  var selectedflat;
  var selectedroom;
  var selecteddeviceId;
  Future floorVal;
  List<dynamic> allRoomId;
  var allDeviceId=List.empty(growable: true);
  Future flatVal;
  Future roomVal;
  List minute = [
    '10 minute',
    '20 minute',
    '30 minute',
    '40 minute',
    '50 minute',
    '60 minute'
  ];
  double changeValue=0.0;
  double totalValue;
  int lengthHour;
  DateTime date2;
  DateTime date1;
  String datefinal;
  var currentDifference;
  var currentDate;
  var difference;
  String cutDate;
  String cutDate2;
  var finalEnergyValue;
  List onlyDayEnergyList ;

  void initState() {
    super.initState();
    placeVal = getplaces();
    pickedDate = DateTime.now();
    pickedDate2 = DateTime.now();


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
      allRoomId=List.from(data);
      print('allRoomId $allRoomId');

      return rooms;
    }
  }

  Future getDevice(String r_id) async {
      final url = API + 'addyourdevice/?r_id=' + r_id;
      String token = await getToken();
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        allDeviceId=List.from(data);
        print('allDeviceIdDeviceId-->  ${allDeviceId}');
        print('allDeviceIdDeviceId-->  ${allDeviceId.length}');



        print('allDeviceIdDeviceIdtenMinuteEnergy-->  ${tenMinuteEnergy}');
        await getEnergyTenMinutes();

      }else{
        return null;
      }
  }


  Future getEnergyTenMinutes() async {
    tenMinuteEnergy= List.empty(growable: true);
    var dId;
    String token = await getToken();
    for(int i=0;i<allDeviceId.length;i++){

      dId=allDeviceId[i]['d_id'];
      print('deviceIdEnergyRoom $dId');
      final url = API + 'pertenminuteenergy?d_id=' + dId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('tenMinuteEnergy ${response.statusCode}');
      if (response.statusCode == 200){
        tenMinuteEnergy.addAll(jsonDecode(response.body));


        print('tenMinuteRoomdata2 $tenMinuteEnergy');



      }


    }
await getEnergyHour();


  }

  sumOfEnergyTenMinutes()async{
    setState(() {
      length=tenMinuteEnergy.length;
    });
    if(chooseValueMinute == '10 minute'){
      for(int i=0;i<tenMinuteEnergy.length;i++){
        setState(() {
          changeValue=double.parse(tenMinuteEnergy[i]['enrgy10']);
          totalValue=totalValue+changeValue;
          _valueMinute = totalValue;
        });
      }
      print('totalans $totalValue');
    }
    if(chooseValueMinute == '20 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i][0]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i][0]['enrgy20']);
          totalValue=totalValue+op1+op2;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i][0]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '30 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i][0]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i][0]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i][0]['enrgy30']);
          totalValue=totalValue+op1+op2+op3;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i][0]['enrgy20']}');
      }
      print('totalans $totalValue');
    }
    if(chooseValueMinute == '40 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i][0]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i][0]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i][0]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i][0]['enrgy40']);
          totalValue=totalValue+op1+op2+op3+op4;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i][0]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '50 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i][0]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i][0]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i][0]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i][0]['enrgy40']);
          double op5=double.parse(tenMinuteEnergy[i][0]['enrgy50']);
          totalValue=totalValue+op1+op2+op3+op4+op5;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i][0]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '60 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i][0]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i][0]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i][0]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i][0]['enrgy40']);
          double op5=double.parse(tenMinuteEnergy[i][0]['enrgy50']);
          double op6=double.parse(tenMinuteEnergy[i][0]['enrgy60']);
          totalValue=totalValue+op1+op2+op3+op4+op5+op6;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i][0]['enrgy20']}');
      }
      print('totalans $totalValue');
    }


  }

  Future getEnergyHour() async {
    hourEnergy=List.empty(growable: true);
    var dId;
    String token = await getToken();
    for(int i=0;i<allDeviceId.length;i++) {
      var dId=allDeviceId[i]['d_id'];
      final url = API + 'perhourenergy?d_id=' + dId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('tenMinuteEnergyResponse ${response.statusCode}');
      if (response.statusCode == 200) {

        hourEnergy.addAll(jsonDecode(response.body));
        print('hour $hourEnergy');

      }
    }
  }

  sumOfEnergyHour()async{
    double totalValue=0.0;
    setState(() {
      lengthHour=hourEnergy.length;
    });
    if(chooseValueHour == '1 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          var last1Hour = hourEnergy[i]['hour1'];
          changeValue = double.parse(last1Hour);
          totalValue=totalValue+changeValue;
          _valueHour = totalValue;
          print('sasa $last1Hour');
        });
      }

    }
    if(chooseValueHour == '2 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '3 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '4 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '5 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '6 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '7 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '8 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '9 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '10 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '11 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '12 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '13 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '14 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '15 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '16 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '17 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          double op17 = double.parse(hourEnergy[i]['hour17']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '18 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          double op17 = double.parse(hourEnergy[i]['hour17']);
          double op18 = double.parse(hourEnergy[i]['hour18']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '19 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          double op17 = double.parse(hourEnergy[i]['hour17']);
          double op18 = double.parse(hourEnergy[i]['hour18']);
          double op19 = double.parse(hourEnergy[i]['hour19']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '20 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          double op17 = double.parse(hourEnergy[i]['hour17']);
          double op18 = double.parse(hourEnergy[i]['hour18']);
          double op19 = double.parse(hourEnergy[i]['hour19']);
          double op20 = double.parse(hourEnergy[i]['hour20']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '21 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          double op17 = double.parse(hourEnergy[i]['hour17']);
          double op18 = double.parse(hourEnergy[i]['hour18']);
          double op19 = double.parse(hourEnergy[i]['hour19']);
          double op20 = double.parse(hourEnergy[i]['hour20']);
          double op21 = double.parse(hourEnergy[i]['hour21']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20+op21;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '22 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          double op17 = double.parse(hourEnergy[i]['hour17']);
          double op18 = double.parse(hourEnergy[i]['hour18']);
          double op19 = double.parse(hourEnergy[i]['hour19']);
          double op20 = double.parse(hourEnergy[i]['hour20']);
          double op21 = double.parse(hourEnergy[i]['hour21']);
          double op22 = double.parse(hourEnergy[i]['hour22']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20+op21+op22;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '23 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          double op17 = double.parse(hourEnergy[i]['hour17']);
          double op18 = double.parse(hourEnergy[i]['hour18']);
          double op19 = double.parse(hourEnergy[i]['hour19']);
          double op20 = double.parse(hourEnergy[i]['hour20']);
          double op21 = double.parse(hourEnergy[i]['hour21']);
          double op22 = double.parse(hourEnergy[i]['hour22']);
          double op23 = double.parse(hourEnergy[i]['hour23']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20+op21+op22+op23;
          print('_valueHour ${_valueHour}');
        });

      }

    }
    if(chooseValueHour == '24 hour') {
      for(int i=0;i<lengthHour;i++){
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          double op7 = double.parse(hourEnergy[i]['hour7']);
          double op8 = double.parse(hourEnergy[i]['hour8']);
          double op9 = double.parse(hourEnergy[i]['hour9']);
          double op10 = double.parse(hourEnergy[i]['hour10']);
          double op11 = double.parse(hourEnergy[i]['hour11']);
          double op12 = double.parse(hourEnergy[i]['hour12']);
          double op13 = double.parse(hourEnergy[i]['hour13']);
          double op14 = double.parse(hourEnergy[i]['hour14']);
          double op15 = double.parse(hourEnergy[i]['hour15']);
          double op16 = double.parse(hourEnergy[i]['hour16']);
          double op17 = double.parse(hourEnergy[i]['hour17']);
          double op18 = double.parse(hourEnergy[i]['hour18']);
          double op19 = double.parse(hourEnergy[i]['hour19']);
          double op20 = double.parse(hourEnergy[i]['hour20']);
          double op21 = double.parse(hourEnergy[i]['hour21']);
          double op22 = double.parse(hourEnergy[i]['hour22']);
          double op23 = double.parse(hourEnergy[i]['hour23']);
          double op24 = double.parse(hourEnergy[i]['hour24']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour =_valueHour+ op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20+op21+op22+op23+op24;
          print('_valueHour ${_valueHour}');
        });

      }

    }
  }

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


  Future getEnergyDay() async {
    var dId;
    List data= List.empty(growable: true);
    onlyDayEnergyList=List.empty(growable: true);
    String token = await getToken();


    for(int i=0;i<allDeviceId.length;i++){
      dId=allDeviceId[i]['d_id'];
      final url = API + 'perdaysenergy?d_id=' + dId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('tenMinuteEnergy ${response.statusCode}');
      print('tenMinuteEnergy ${response.body}');
      if (response.statusCode == 200) {
        data.addAll(jsonDecode(response.body));
        print('dayEnergy ${data[0]['d_id']}');


      }
    }
    onlyDayEnergyList=List.from(data);

    await sumYearData();
    print('beforeSsumData ${onlyDayEnergyList}');
    int i=0;

    // while(i<onlyDayEnergyList.length){
    //
    //   for(int j=1;j<onlyDayEnergyList.length;i++){
    //     print('beforeSsumData ${onlyDayEnergyList[i]['d_id']}');
    //     print('JbeforeSsumData ${onlyDayEnergyList[i]['day${j}']}');
    //   }
    //
    //   i++;
    //
    // }
    print('sumData ${onlyDayEnergyList}');

  }

  sumYearData(){
    int i=0;

    while(i<onlyDayEnergyList.length){
      for(int j=1;j<=difference;j++){
        print(' asasadaya ${onlyDayEnergyList[i]['day${j}']}');
        setState(() {
          total=total+onlyDayEnergyList[i]['day${j+currentDifference}'];
          finalEnergyValue=total.toString();
        });
      }


      i++;
      print('sumDatatotal ${total}');
    }
    total=0.0;
    print('sumDatatotal_final ${total}');

  }












  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Bill'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              FutureBuilder<List<PlaceType>>(
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
                  }),
              SizedBox(
                height: 15,
              ),
              FutureBuilder<List<FloorType>>(
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
                  }),
              SizedBox(
                height: 15,
              ),
              FutureBuilder<List<Flat>>(
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
                  }),
              SizedBox(
                height: 15,
              ),
              FutureBuilder<List<RoomType>>(
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
                                    onChanged: (RoomType selectedRoom)async{
                                      setState(() {
                                        rm2 = selectedRoom;
                                        selectedroom=selectedRoom.rId;

                                      });
                                     await getDevice(selectedroom);
                                      setState(() {
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
              completeTask? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownButton(
                      value: chooseValueMinute,
                      onChanged: (index) async {
                        setState(() {
                          chooseValueMinute = index;
                        });
                          totalValue=0.0;
                        await sumOfEnergyTenMinutes();
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
              ):Text("Wait"),
              SizedBox(
                height: 15,
              ),
              completeTask? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownButton(
                      value: chooseValueHour,
                      onChanged: (index) async {
                        setState(() {
                          chooseValueHour = index;
                        });

                        await sumOfEnergyHour();
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
              completeTask?Row(
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
              ):Text("Please Wait"),
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
                        await getEnergyDay();
                        await sumYearData();
                      }, child: Text('Click'))
                ],

              ):Text("Please Wait"),
            ],
          ),
        ),
      ),
    );
  }
}
