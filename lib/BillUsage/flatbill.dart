import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/BillUsage/total_usage.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import '../main.dart';


class FlatBill extends StatefulWidget {
  const FlatBill({Key key}) : super(key: key);

  @override
  _FlatBillState createState() => _FlatBillState();
}

class _FlatBillState extends State<FlatBill> {
  String chooseValueHour;
  String chooseValueDay;
  List onlyDayEnergyList ;
  Future placeVal;
  DateTime pickedDate;
  var finalEnergyValue;
  DateTime pickedDate2;
  PlaceType pt;
  FloorType fl;
  DateTime date2;
  DateTime date1;
  String datefinal;
  var currentDifference;
  var currentDate;
  var difference;
  String cutDate;
  String cutDate2;
  Map<String,double> dataMap={};
  Flat flt;
  List<RoomType> rm;
  double _valueMinute;
  var pleaseSelect = 'Please Select';
  RoomType rm2;
  int length=0;
  Device dv2;
  String chooseValueMinute;
  // List tenMinuteEnergy;
  List<Device> dv;
  var selectedflat;
  var selectedroom;

  Future floorVal;
  List<dynamic> allFlatId;
  var allDeviceId=List.empty(growable: true);
  var singleRoomDeviceId=List.empty(growable: true);
  Future flatVal;
  Future roomVal;
  List allRoomId;
  List minute = [
    '10 minute',
    '20 minute',
    '30 minute',
    '40 minute',
    '50 minute',
    '60 minute'
  ];
  String r_id;
  List dataResponse=List.empty(growable: true);

  List tenMinuteEnergy;
  List tenMinuteEnergyForSameRoomDevice;
  List hourMinuteEnergy;

  double total=0.0;

  double totalValue;

  bool completeTask=false;

  double changeValue;
  double _valueHour=0.0;
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
  int lengthHour;
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
      allFlatId=List.from(data);
      print('allFlatId $allFlatId');
      print('allFlatId ${allFlatId.length}');

      return flatData;
    }
  }

  Future getrooms(String flt_id) async {
        final url = API + 'addroom/?flt_id=' + flt_id;
        String token = await getToken();
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
        if (response.statusCode == 200) {
          List<dynamic> data = jsonDecode(response.body);
          print('allRoomData $data');

          setState(() {

            allRoomId=List.from(data);
            print('allRoomData ${allRoomId.length}');

          });
          await getDevice();

      }
  }

var singleRoomId;
  var singleRoomName;
  var listOfEnergy10Minutes= List.empty(growable: true);
List<dynamic>datawe=[];
  Future getDevice() async {

    String token = await getToken();
    for(int i=0;i<allRoomId.length;i++){
      r_id=allRoomId[i]['r_id'];
      print('going to getDevice');
      print( allRoomId[i]['r_id']);
      final url = API + 'addyourdevice/?r_id=' + r_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        datawe=jsonDecode(response.body);
        dataResponse.addAll(jsonDecode(response.body))  ;
        print('dataweallDeviceIdDeviceIddata-->  ${datawe}');
        print('allDeviceIdDeviceIddata-->  ${dataResponse.length}');
       await totalEnergyAccordingRoom();


          // if(dataResponse[i]['r_id']==dataResponse[i+1]['r_id']){
          //   print('going to getDevicedataResponse ${dataResponse[i]['r_id']}');
          //   singleRoomId=dataResponse[i]['r_id'];
          //   singleRoomId=dataResponse[i]['r_id'];
          //   await getDeviceSingleRoom(singleRoomId);
          //   break;
          // }


      }else{
        return null;
      }
    }
    allDeviceId=List.from(dataResponse);

    // print('allDeviceIdDeviceIdtenMinuteEnergy-->  ${tenMinuteEnergy}');


    print('allDeviceIdDeviceId14785-->  ${allDeviceId}');
    print('allDeviceIdDeviceId14785-->  ${allDeviceId.length}');


    await getEnergyTenMinutes();

  }
  double total14=0.0;
  Future totalEnergyAccordingRoom()async{

    String token = await getToken();
    for(int j=0;j<datawe.length;j++){
      final url1 = API + 'pertenminuteenergy?d_id='+datawe[j]['d_id'];
      final response1= await http.get(url1,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if(response1.statusCode==200){
        List<dynamic>data =jsonDecode(response1.body);
        print('energyData ${data.length}');
        print('energyData ${data}');
        if(data.isEmpty){
          listOfEnergy10Minutes.add(0);
        }
        for(int k=0;k<data.length;k++){
          total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40'])+double.parse(data[k]['enrgy50'])+double.parse(data[k]['enrgy60']);
          print('pororro $total14');
          // listOfEnergy10Minutes.add(total);
        }

        print('roomaccrodinfsol $listOfEnergy10Minutes ');

      }



    }
  }


  Future getDeviceSingleRoom(String r_id)async{
    String token = await getToken();
    final url = API + 'addyourdevice/?r_id=' + r_id;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if(response.statusCode==200){
      singleRoomDeviceId.addAll(jsonDecode(response.body));
      print('SingleRoomDevice  ${singleRoomDeviceId}');
      await getEnergyTenMinute1();
    }
  }

  Future getDeviceEnergyForSameRoom()async{
    double totalValue=0.0;
    String token = await getToken();
    tenMinuteEnergyForSameRoomDevice=List.empty(growable: true);
    var dId;
    for(int i=0;i<allDeviceId.length;i++){
      if(allDeviceId[i]['r_id']==allDeviceId[i+1]['r_id']){
        dId=allDeviceId[i]['d_id'];
        final url = API + 'pertenminuteenergy?d_id=' + dId;
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
        print('ppppeeer ${response.statusCode}');
        if(response.statusCode==200){
          tenMinuteEnergyForSameRoomDevice.addAll(jsonDecode(response.body));
          print('ppppeeer ${tenMinuteEnergyForSameRoomDevice}');
          setState(() {
            length=tenMinuteEnergyForSameRoomDevice.length;
          });

        }
      }else if(allDeviceId[i]['r_id']==allDeviceId[i-1]['r_id']){
        dId=allDeviceId[i]['d_id'];
        final url = API + 'pertenminuteenergy?d_id=' + dId;
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
        print('ppppeeer ${response.statusCode}');
        if(response.statusCode==200){
          tenMinuteEnergyForSameRoomDevice.addAll(jsonDecode(response.body));
          print('ppppeeerelse ${tenMinuteEnergyForSameRoomDevice}');
          if(chooseValueMinute == '10 minute'){
            for(int i=0;i<tenMinuteEnergyForSameRoomDevice.length;i++){
              setState(() {

                double  changeValue=double.parse(tenMinuteEnergyForSameRoomDevice[i]['enrgy10']);
                totalValue=totalValue+changeValue;
                tenMinuteTotalUsage=totalValue.toStringAsFixed(2);

                dataMap.putIfAbsent(allDeviceId[i]['r_id'], () => totalValue);
              });
            }
            print('totalansdataMap $dataMap');
          }
        }
      }
    }

  }

  Future getDataMap()async{
    List roomCheck=List.empty(growable: true);
    List tenMinuteEnergy=List.empty(growable: true);
    var rId;
    var dId;
    String token = await getToken();
    for(int i=0;i<allRoomId.length;i++){
      rId=allRoomId[i]['r_id'];
      final url = API + 'addyourdevice/?r_id=' + rId;
      String token = await getToken();
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('allDeviceIdDeviceIddata-->  ${dataResponse}');
      if(response.statusCode==200){
        roomCheck.addAll(jsonDecode(response.body));
        print('roomCheckallDeviceIdDeviceId14785-->  ${roomCheck}');


        for(int j=0;j<roomCheck.length;j++){
          dId=roomCheck[i]['d_id'];
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
            tenMinuteEnergy= tenMinuteEnergy.toSet().toList();

            print('tenMinuteRoomdata2tenMinuteEnergy $tenMinuteEnergy');



          }


        }


      }

    }
  }




Future getEnergyTenMinute1()async{
  tenMinuteEnergyForSameRoomDevice= List.empty(growable: true);
  var dId;
  double totalValue=0.0;
  String token = await getToken();
  for(int i=0;i<singleRoomDeviceId.length;i++){

    dId=singleRoomDeviceId[i]['d_id'];
    print('deviceIdEnergyRoom $dId');
    final url = API + 'pertenminuteenergy?d_id=' + dId;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('tenMinuteEnergy ${response.statusCode}');
    if (response.statusCode == 200){
      tenMinuteEnergyForSameRoomDevice.addAll(jsonDecode(response.body));
      print('tenMinuteEnergyForSameRoomDevice $tenMinuteEnergyForSameRoomDevice');


      // dataMap.putIfAbsent(allRoomId[i]['r_name'], () => changeValue);

    }


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



  var tenMinuteTotalUsage;

  sumOfEnergyTenMinutes()async{
    dataMap={};
    double totalValue1=0.0;
    int i=0;
    // while(i<allDeviceId.length){
    //   if(allDeviceId[0]['r_id']==allDeviceId[1]['r_id']){
    //     print('yeah');
    //     i++;
    //   }
    //   i++;
    // }
    setState(() {
      length=tenMinuteEnergy.length;
    });
    if(chooseValueMinute == '10 minute'){
      for(int i=0;i<tenMinuteEnergy.length;i++){
        setState(() {


          changeValue=double.parse(tenMinuteEnergy[i]['enrgy10']);
          totalValue=totalValue+changeValue;
          _valueMinute = totalValue;
          tenMinuteTotalUsage=totalValue.toStringAsFixed(2);

          // dataMap.putIfAbsent(allRoomId[i]['r_name'], () => changeValue);

        });

      }
      print('totalans $totalValue');
    }
    if(chooseValueMinute == '20 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          totalValue=totalValue+op1+op2;
          _valueMinute = totalValue;
          tenMinuteTotalUsage=totalValue.toStringAsFixed(2);
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1+op2);
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '30 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i]['enrgy30']);
          totalValue=totalValue+op1+op2+op3;
          _valueMinute = totalValue;
          tenMinuteTotalUsage=totalValue.toStringAsFixed(2);
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1+op2+op3);
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }
    if(chooseValueMinute == '40 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i]['enrgy40']);
          totalValue=totalValue+op1+op2+op3+op4;
          _valueMinute = totalValue;
          tenMinuteTotalUsage=totalValue.toStringAsFixed(2);
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1+op2+op3+op4);
        });

      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '50 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i]['enrgy40']);
          double op5=double.parse(tenMinuteEnergy[i]['enrgy50']);
          totalValue=totalValue+op1+op2+op3+op4+op5;
          _valueMinute = totalValue;
          tenMinuteTotalUsage=totalValue.toStringAsFixed(2);
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1+op2+op3+op4+op5);
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '60 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i]['enrgy40']);
          double op5=double.parse(tenMinuteEnergy[i]['enrgy50']);
          double op6=double.parse(tenMinuteEnergy[i]['enrgy60']);
          totalValue=totalValue+op1+op2+op3+op4+op5+op6;
          _valueMinute = totalValue;
          tenMinuteTotalUsage=totalValue.toStringAsFixed(2);
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1+op2+op3+op4+op5+op6);
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }


  }


  Future getEnergyHour() async {
    var dId;
    hourEnergy=List.empty(growable: true);
    String token = await getToken();
    for(int i=0;i<allDeviceId.length;i++) {
       dId=allDeviceId[i]['d_id'];
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
    dataMap={

    };
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
          dataMap.putIfAbsent(hourEnergy[i]['d_id'], () => double.parse(hourEnergy[i]['hour1']));
          print('sasa $dataMap');
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1+op2);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20+op21);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20+op21+op22);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20+op21+op22+op23);
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
          dataMap.putIfAbsent(tenMinuteEnergy[i]['d_id'], () => op1 + op2+op3+op4+op5+op6+op7+op8+op9+op10+op11+op12+op13+op14+op15+op16+op17+op18+op19+op20+op21+op22+op23+op24);
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
        title: Text('FLat Bill'),
      ),
      body:SingleChildScrollView(
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
                                    hint: Text('Select Flat'),
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
                                    onChanged: (Flat selectedFlat)async {
                                      setState(() {
                                        flt = selectedFlat;
                                        selectedflat=selectedFlat.fltId;

                                      });
                                      await getrooms(selectedflat);
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
              ):AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('Please wait ',  )
                  ],
              ),
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
              ):AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('Please wait ',  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
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
              Container(
                child: Center(
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 60),
                      child: Text('Total Usage',style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed:() async{
                     await totalUsageFuncRoom();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalUsage(
                        totalEnergy: tenMinuteTotalUsage.toString(),
                        chooseValueMinute:chooseValueMinute.toString(),
                        deviceId: dataMap,
                      )));
                      // Navigator.of(context)
                      //     .pushReplacementNamed(TotalUsage.routeName);
                    },
                  ),
                ),
              ),
            ],
          ),

    ),
      ) ,

    );
  }

  totalUsageFuncRoom(){
    dataMap={};
    for(int i=0;i<listOfEnergy10Minutes.length;i++){
      dataMap.putIfAbsent(allRoomId[i]['r_name'], () => listOfEnergy10Minutes[i]);
    }
  }

}
