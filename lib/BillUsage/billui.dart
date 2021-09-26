import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../main.dart';
import 'package:dio/dio.dart' as dio;
class BillUi extends StatefulWidget {
  const BillUi({Key key}) : super(key: key);

  @override
  _BillUiState createState() => _BillUiState();
}

class _BillUiState extends State<BillUi> {
  String datefinal;
  var difference;
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
  int _valueMinute;
  int _valueHour;
  int _valueDay;
  int changeValue;
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
  @override
  void initState() {
    super.initState();

    pickedDate = DateTime.now();
    pickedDate2 = DateTime.now();

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
      if (chooseValueMinute == '10 minute') {
        setState(() {
          last10Minute = tenMinuteEnergy[0]['enrgy10'];
          changeValue = int.parse(last10Minute);
          _valueMinute = changeValue;
        });
      } else if (chooseValueMinute == '20 minute') {
        setState(() {
          int op1 = int.parse(tenMinuteEnergy[0]['enrgy10']);
          int op2 = int.parse(tenMinuteEnergy[0]['enrgy20']);
          _valueMinute = op1 + op2;
        });
      } else if (chooseValueMinute == '30 minute') {
        setState(() {
          int op1 = int.parse(tenMinuteEnergy[0]['enrgy10']);
          int op2 = int.parse(tenMinuteEnergy[0]['enrgy20']);
          int op3 = int.parse(tenMinuteEnergy[0]['enrgy30']);
          _valueMinute = op1 + op2 + op3;
        });
      } else if (chooseValueMinute == '40 minute') {
        setState(() {
          int op1 = int.parse(tenMinuteEnergy[0]['enrgy10']);
          int op2 = int.parse(tenMinuteEnergy[0]['enrgy20']);
          int op3 = int.parse(tenMinuteEnergy[0]['enrgy30']);
          int op4 = int.parse(tenMinuteEnergy[0]['enrgy40']);
          _valueMinute = op1 + op2 + op3 + op4;
        });
      } else if (chooseValueMinute == '50 minute') {
        setState(() {
          int op1 = int.parse(tenMinuteEnergy[0]['enrgy10']);
          int op2 = int.parse(tenMinuteEnergy[0]['enrgy20']);
          int op3 = int.parse(tenMinuteEnergy[0]['enrgy30']);
          int op4 = int.parse(tenMinuteEnergy[0]['enrgy40']);
          int op5 = int.parse(tenMinuteEnergy[0]['enrgy50']);
          _valueMinute = op1 + op2 + op3 + op4 + op5;
        });
      } else if (chooseValueMinute == '60 minute') {
        setState(() {
          int op1 = int.parse(tenMinuteEnergy[0]['enrgy10']);
          int op2 = int.parse(tenMinuteEnergy[0]['enrgy20']);
          int op3 = int.parse(tenMinuteEnergy[0]['enrgy30']);
          int op4 = int.parse(tenMinuteEnergy[0]['enrgy40']);
          int op5 = int.parse(tenMinuteEnergy[0]['enrgy50']);
          int op6 = int.parse(tenMinuteEnergy[0]['enrgy60']);
          _valueMinute = op1 + op2 + op3 + op4 + op5;
        });
      }

      print('tenMinuteEnergy $tenMinuteEnergy');
      print('tenMinuteEnergy $last10Minute');
    }
  }
int data;
  var onlyDayEnergyList = List(366);
  List<PerDayEnergy> perDayEnergy;
double total=0.0;
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
      print(' asasa ${onlyDayEnergyList[i]}');
      // change=double.parse(onlyDayEnergyList[i].toString());
      total=total+onlyDayEnergyList[i];
      i++;
      print('sumDatatotal ${total}');
    }
     print('sumDatatotal_final ${total}');

     perDayEnergy=data.map((data) => PerDayEnergy.fromJson(data)).toList();
      print('data ${perDayEnergy[0].day1}');
      double sumData=perDayEnergy[0].day1+perDayEnergy[0].day2+perDayEnergy[0].day3;

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
      if (chooseValueHour == '1 hour') {
        setState(() {
          var last10Minute = hourEnergy[0]['hour1'];
          changeValue = int.parse(last10Minute);
          _valueHour = changeValue;
          print('sasa $last10Minute');
        });
      } else if (chooseValueHour == '2 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          _valueHour = op1 + op2;
        });
      } else if (chooseValueHour == '3 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          _valueHour = op1 + op2 + op3;
        });
      } else if (chooseValueHour == '4 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          _valueHour = op1 + op2 + op3 + op4;
        });
      } else if (chooseValueHour == '5 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          _valueHour = op1 + op2 + op3 + op4 + op5;
        });
      } else if (chooseValueHour == '6 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6;
        });
      } else if (chooseValueHour == '7 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7;
        });
      } else if (chooseValueHour == '8 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8;
        });
      } else if (chooseValueHour == '9 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          _valueHour = op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9;
        });
      } else if (chooseValueHour == '10 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          _valueHour =
              op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9 + op10;
        });
      } else if (chooseValueHour == '11 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          _valueHour =
              op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9 + op10 + op11;
        });
      } else if (chooseValueHour == '12 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
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
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
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
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
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
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
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
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
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
      } else if (chooseValueHour == '17 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
          int op17 = int.parse(hourEnergy[0]['hour17']);
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
      } else if (chooseValueHour == '18 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
          int op17 = int.parse(hourEnergy[0]['hour17']);
          int op18 = int.parse(hourEnergy[0]['hour18']);
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
      } else if (chooseValueHour == '19 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
          int op17 = int.parse(hourEnergy[0]['hour17']);
          int op18 = int.parse(hourEnergy[0]['hour18']);
          int op19 = int.parse(hourEnergy[0]['hour19']);
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
      } else if (chooseValueHour == '20 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
          int op17 = int.parse(hourEnergy[0]['hour17']);
          int op18 = int.parse(hourEnergy[0]['hour18']);
          int op19 = int.parse(hourEnergy[0]['hour19']);
          int op20 = int.parse(hourEnergy[0]['hour20']);
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
      } else if (chooseValueHour == '21 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
          int op17 = int.parse(hourEnergy[0]['hour17']);
          int op18 = int.parse(hourEnergy[0]['hour18']);
          int op19 = int.parse(hourEnergy[0]['hour19']);
          int op20 = int.parse(hourEnergy[0]['hour20']);
          int op21 = int.parse(hourEnergy[0]['hour21']);
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
              op20 +
              op21;
        });
      } else if (chooseValueHour == '22 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
          int op17 = int.parse(hourEnergy[0]['hour17']);
          int op18 = int.parse(hourEnergy[0]['hour18']);
          int op19 = int.parse(hourEnergy[0]['hour19']);
          int op20 = int.parse(hourEnergy[0]['hour20']);
          int op21 = int.parse(hourEnergy[0]['hour21']);
          int op22 = int.parse(hourEnergy[0]['hour22']);
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
              op20 +
              op21 +
              op22;
        });
      } else if (chooseValueHour == '23 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
          int op17 = int.parse(hourEnergy[0]['hour17']);
          int op18 = int.parse(hourEnergy[0]['hour18']);
          int op19 = int.parse(hourEnergy[0]['hour19']);
          int op20 = int.parse(hourEnergy[0]['hour20']);
          int op21 = int.parse(hourEnergy[0]['hour21']);
          int op22 = int.parse(hourEnergy[0]['hour22']);
          int op23 = int.parse(hourEnergy[0]['hour23']);
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
              op20 +
              op21 +
              op22 +
              op23;
        });
      } else if (chooseValueHour == '24 hour') {
        setState(() {
          int op1 = int.parse(hourEnergy[0]['hour1']);
          int op2 = int.parse(hourEnergy[0]['hour2']);
          int op3 = int.parse(hourEnergy[0]['hour3']);
          int op4 = int.parse(hourEnergy[0]['hour4']);
          int op5 = int.parse(hourEnergy[0]['hour5']);
          int op6 = int.parse(hourEnergy[0]['hour6']);
          int op7 = int.parse(hourEnergy[0]['hour7']);
          int op8 = int.parse(hourEnergy[0]['hour8']);
          int op9 = int.parse(hourEnergy[0]['hour9']);
          int op10 = int.parse(hourEnergy[0]['hour10']);
          int op11 = int.parse(hourEnergy[0]['hour11']);
          int op12 = int.parse(hourEnergy[0]['hour12']);
          int op13 = int.parse(hourEnergy[0]['hour13']);
          int op14 = int.parse(hourEnergy[0]['hour14']);
          int op15 = int.parse(hourEnergy[0]['hour15']);
          int op16 = int.parse(hourEnergy[0]['hour16']);
          int op17 = int.parse(hourEnergy[0]['hour17']);
          int op18 = int.parse(hourEnergy[0]['hour18']);
          int op19 = int.parse(hourEnergy[0]['hour19']);
          int op20 = int.parse(hourEnergy[0]['hour20']);
          int op21 = int.parse(hourEnergy[0]['hour21']);
          int op22 = int.parse(hourEnergy[0]['hour22']);
          int op23 = int.parse(hourEnergy[0]['hour23']);
          int op24 = int.parse(hourEnergy[0]['hour24']);
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
              op20 +
              op21 +
              op22 +
              op23 +
              op24;
        });
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('App'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DropdownButton(
                    value: chooseValueMinute,
                    onChanged: (index) async {
                      setState(() {
                        chooseValueMinute = index;
                      });

                      await getEnergyTenMinutes('DIDM12932021AAAAAB');
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
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DropdownButton(
                    value: chooseValueHour,
                    onChanged: (index) async {
                      setState(() {
                        chooseValueHour = index;
                      });

                      await getEnergyHour('DIDM12932021AAAAAB');
                    },
                    items: hour.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList()),
                Text(_valueHour == null ? pleaseSelect : _valueHour.toString()),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    showDatePicker1();
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {

                  },
                  child: Text(difference.toString()),
                ),
                ElevatedButton(
                    onPressed: ()async{
                    print12();
                  }, child: Text('Click'))
              ],

            ),
            ElevatedButton(
                onPressed: ()async{
                  await getEnergyDay('DIDM12932021AAAAAB');
                }, child: Text('Click')),
            Text('data'),
          ],
        ),
      ),
    );
  }
  DateRangePickerController _datePickerController = DateRangePickerController();

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

  void print12(){
     print(date1);
     print(date2);
      setState(() {
        difference = date1.difference(date2).inDays;
      });

    print('difference $difference');
  }



}
