import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/BillUsage/total_usage.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  Future placeValWeb;
  DateTime pickedDate;
  var finalEnergyValue;
  DateTime pickedDate2;
  PlaceType pt;
  FloorType fl;
  DateTime date2;
  DateTime date1;
  bool placeBool = false;
  bool floorBool = false;
  bool flatBool = false;
  bool roomBool = false;

  String dateFinal;
  var currentDifference;
  var currentDate;
  var difference;
  TextEditingController billTotalController = TextEditingController();
  String cutDate;
  String cutDate2;
  Map<String,double> dataMap={};
  Flat flt;
  List<RoomType> rm;
  double _valueMinute=0.0;
  var pleaseSelect = 'Please Select';
  RoomType rm2;
  int length=0;
  Device dv2;
  String chooseValueMinute;
  String defaultTime="60 Minutes";
  List<Device> dv;
  var selectedflat;
  List totalValueOfEnergy;
  Future floorVal;
  Future floorValWeb;
  List<dynamic> allFlatId;
  var allDeviceId=List.empty(growable: true);
  var singleRoomDeviceId=List.empty(growable: true);
  Future flatVal;
  Future flatValWeb;
  Future roomVal;
  var tenMinuteTotalUsage;
  double finalTotalValue=0.0;
  var varFinalTotalValue;
  List allRoomId;
  List minute = [
    '10 minute',
    '20 minute',
    '30 minute',
    '40 minute',
    '50 minute',
    '60 minute'
  ];
  var singleRoomId;
  var singleRoomName;
  var listOfEnergy10Minutes= List.empty(growable: true);



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
  double total14;

  int lengthHour;
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
    }else {
      return null;
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
    }else {
      return null;
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
    }else {
      return null;
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
    }else {
      return null;
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
    }else {
      return null;
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
      allFlatId=List.from(data);
      print('allFlatId $allFlatId');
      print('allFlatId ${allFlatId.length}');

      return flatData;
    }else {
      return null;
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
          totalValueOfEnergy=List(allRoomId.length);
          await getDevice();

      }
  }
  Future getroomsWeb(String flt_id) async {
        final url = API + 'addroom/?flt_id=' + flt_id;
        String token = await getTokenWeb();
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
          totalValueOfEnergy=List(allRoomId.length);
          await getDeviceWeb();

        }
  }
  List deviceIdData=[];


  Future getDevice() async {
    String token = await getToken();
    for(int i=0;i<allRoomId.length;i++){
      r_id=allRoomId[i]['r_id'];
      print('going to getDevice $i');
      print( allRoomId[i]['r_id']);
      final url = API + 'addyourdevice/?r_id=' + r_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        deviceIdData=jsonDecode(response.body);
        allDeviceId.addAll(deviceIdData);
        print('dataweallDeviceIdDeviceIddata-->  ${deviceIdData}');
       await totalEnergyAccordingRoom();

        if(deviceIdData.isEmpty){
          print('dataisEmpty');
          total14=0.0;
          dataMap.putIfAbsent(allRoomId[i]['r_name'], () => total14);
          print('dataisEmpty $dataMap');
        }
        totalValueOfEnergy[i]=total14;
        print('785412 ${totalValueOfEnergy}');
        _valueMinute =_valueMinute+total14;
        finalTotalValue=total14+finalTotalValue;
        varFinalTotalValue=finalTotalValue.toStringAsFixed(2);
        dataMap.putIfAbsent(allRoomId[i]['r_name'], () => total14);

        print('741dataisEmpty $dataMap');
      }else{
        return null;
      }
    }
    allDeviceId=List.from(dataResponse);
    print('allDeviceIdDeviceId14785-->  ${allDeviceId}');
    print('allDeviceIdDeviceId14785-->  ${allDeviceId.length}');


    await getEnergyTenMinutes();

  }
  Future getDeviceWeb() async {
    String token = await getTokenWeb();
    for(int i=0;i<allRoomId.length;i++){
      r_id=allRoomId[i]['r_id'];
      print('going to getDevice $i');
      print( allRoomId[i]['r_id']);
      final url = API + 'addyourdevice/?r_id=' + r_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        deviceIdData=jsonDecode(response.body);
        allDeviceId.addAll(deviceIdData);
        print('dataweallDeviceIdDeviceIddata-->  ${deviceIdData}');
        await totalEnergyAccordingRoomWeb();

        if(deviceIdData.isEmpty){
          print('dataisEmpty');
          total14=0.0;
          dataMap.putIfAbsent(allRoomId[i]['r_name'], () => total14);
          print('dataisEmpty $dataMap');
        }
        totalValueOfEnergy[i]=total14;
        print('785412 ${totalValueOfEnergy}');
        _valueMinute =_valueMinute+total14;
        finalTotalValue=total14+finalTotalValue;
        varFinalTotalValue=finalTotalValue.toStringAsFixed(2);
        dataMap.putIfAbsent(allRoomId[i]['r_name'], () => total14);

        print('741dataisEmpty $dataMap');
      }else{
        return null;
      }
    }
    // allDeviceId=List.from(dataResponse);
    print('allDeviceIdDeviceId14785-->  ${allDeviceId}');
    print('allDeviceIdDeviceId14785-->  ${allDeviceId.length}');


    await getEnergyTenMinutesWeb();

  }



  Future totalEnergyAccordingRoom()async{
    List<dynamic>data=[];
    total14=0.0;
    String token = await getToken();
    for(int j=0;j<deviceIdData.length;j++){
      print('forLoopdataweallDeviceIdDeviceIddata--> $j sa ${deviceIdData[j]['d_id']}');
      final url1 = API + 'pertenminuteenergy?d_id='+deviceIdData[j]['d_id'];
      final response1= await http.get(url1,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if(response1.statusCode==200){
        data =jsonDecode(response1.body);
        print('energyData ${data.length}');
        print('energyData ${data}');


        if(chooseValueMinute=='10 minute'){
          print('goingtotenmintes');
          print('goingtotenmintes $_valueMinute');
          for(int k=0;k<data.length;k++){
            setState(() {
              total14=total14+double.parse(data[k]['enrgy10']);
              // _valueMinute =_valueMinute+total14;

            });

            print('resultgoingtotenmintes $total14');
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }


        else if(chooseValueMinute=='20 minute'){
          print('20goingtotenmintes');
          for(int k=0;k<data.length;k++){
            setState(() {
              total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20']);
              print('20goingtotenmintes $total14');
              // _valueMinute =_valueMinute+total14;
              print('20goingtotenmintes $_valueMinute');
            });

            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }

        else if(chooseValueMinute=='30 minute'){
          for(int k=0;k<data.length;k++){
            setState(() {
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30']);
            print('30goingtotenmintes $total14');
            // _valueMinute =_valueMinute+total14;
            });
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        else if(chooseValueMinute=='40 minute'){
          for(int k=0;k<data.length;k++){
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40']);
            print('40goingtotenmintes $total14');
            // _valueMinute =_valueMinute+total14;
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        else if(chooseValueMinute=='50 minute'){
          for(int k=0;k<data.length;k++){
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40'])+double.parse(data[k]['enrgy50']);
            print('50goingtotenmintes $total14');
            // _valueMinute =_valueMinute+total14;
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        else if(chooseValueMinute=='60 minute'){
          for(int k=0;k<data.length;k++){
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40'])+double.parse(data[k]['enrgy50'])+double.parse(data[k]['enrgy60']);
            print('60goingtotenmintes $total14');
            // _valueMinute =_valueMinute+total14;
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        else {
          for (int k = 0; k < data.length; k++) {
            total14 = total14 + double.parse(data[k]['enrgy10']) +
                double.parse(data[k]['enrgy20']) +
                double.parse(data[k]['enrgy30']) +
                double.parse(data[k]['enrgy40']) +
                double.parse(data[k]['enrgy50']) +
                double.parse(data[k]['enrgy60']);
            print('pororro $total14');
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        // int ko=0;
        // while(ko<j){
        //   dataMap.putIfAbsent(allRoomId[ko]['r_name'], () => total14);
        //   ko+1;
        // }


        // total14=0.0;

        print('dataMapKroomaccrodinfsol $dataMap ');

      }

    }
  }

  Future totalEnergyAccordingRoomWeb()async{
    total14=0.0;
    List<dynamic>data=[];
    String token = await getTokenWeb();
    print('totalEnergyAccordingRoomdataweallDeviceIdDeviceIddata-->  ${deviceIdData}');

    for(int j=0;j<deviceIdData.length;j++){
      print('forLoopdataweallDeviceIdDeviceIddata-->  ${deviceIdData}');
      final url1 = API + 'pertenminuteenergy?d_id='+deviceIdData[j]['d_id'];
      final response1= await http.get(url1,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if(response1.statusCode==200){
        data =jsonDecode(response1.body);
        print('energyData ${data.length}');
        print('energyData ${data}');


        if(chooseValueMinute=='10 minute'){
          print('goingtotenmintes');
          print('goingtotenmintes $_valueMinute');
          for(int k=0;k<data.length;k++){
            setState(() {
              total14=total14+double.parse(data[k]['enrgy10']);
              // _valueMinute =_valueMinute+total14;

            });

            print('resultgoingtotenmintes $total14');
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }


        else if(chooseValueMinute=='20 minute'){
          print('20goingtotenmintes');
          for(int k=0;k<data.length;k++){
            setState(() {
              total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20']);
              print('20goingtotenmintes $total14');
              // _valueMinute =_valueMinute+total14;
              print('20goingtotenmintes $_valueMinute');
            });

            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }

        else if(chooseValueMinute=='30 minute'){
          for(int k=0;k<data.length;k++){
            setState(() {
              total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30']);
              print('30goingtotenmintes $total14');
              // _valueMinute =_valueMinute+total14;
            });
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        else if(chooseValueMinute=='40 minute'){
          for(int k=0;k<data.length;k++){
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40']);
            print('40goingtotenmintes $total14');
            // _valueMinute =_valueMinute+total14;
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        else if(chooseValueMinute=='50 minute'){
          for(int k=0;k<data.length;k++){
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40'])+double.parse(data[k]['enrgy50']);
            print('50goingtotenmintes $total14');
            // _valueMinute =_valueMinute+total14;
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        else if(chooseValueMinute=='60 minute'){
          for(int k=0;k<data.length;k++){
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40'])+double.parse(data[k]['enrgy50'])+double.parse(data[k]['enrgy60']);
            print('60goingtotenmintes $total14');
            // _valueMinute =_valueMinute+total14;
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        else {
          for (int k = 0; k < data.length; k++) {
            total14 = total14 + double.parse(data[k]['enrgy10']) +
                double.parse(data[k]['enrgy20']) +
                double.parse(data[k]['enrgy30']) +
                double.parse(data[k]['enrgy40']) +
                double.parse(data[k]['enrgy50']) +
                double.parse(data[k]['enrgy60']);
            print('pororro $total14');
            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
        }
        // int ko=0;
        // while(ko<j){
        //   dataMap.putIfAbsent(allRoomId[ko]['r_name'], () => total14);
        //   ko+1;
        // }


        // total14=0.0;

        print('dataMapKroomaccrodinfsol $dataMap ');

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

  Future getEnergyTenMinutesWeb() async {
    tenMinuteEnergy= List.empty(growable: true);
    var dId;
    String token = await getTokenWeb();
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

    await getEnergyHourWeb();

  }




  sumEnergyTenMinutesRoom()async{
    dataMap={};
    setState(() {
      length=tenMinuteEnergy.length;
    });
    for(int i=0;i<allRoomId.length;i++){
      if(chooseValueMinute == '10 minute'){
        for(int i=0;i<tenMinuteEnergy.length;i++){
          setState(() {


            changeValue=double.parse(tenMinuteEnergy[i]['enrgy10']);
            totalValue=totalValue+changeValue;
            _valueMinute = totalValue;
            tenMinuteTotalUsage=totalValue.toStringAsFixed(2);



          });

        }
        print('totalans $totalValue');
      }
      dataMap.putIfAbsent(allRoomId[i]['r_name'], () => totalValueOfEnergy[i]);
      print('totalansPUTdataMap $dataMap');
      dataMap.update(allRoomId[i]['r_name'], (value) => totalValueOfEnergy[i]);
      print('totalansUPDATEdataMap $dataMap');
    }
  }


  sumOfEnergyTenMinutes()async{
    dataMap={};
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

          // dataMap.putIfAbsent(allRoomId[i]['r_name'], (value) => totalValueOfEnergy[i]);
          dataMap.putIfAbsent(allRoomId[0]['r_name'], () => totalValue);

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
  Future getEnergyHourWeb() async {
    var dId;
    hourEnergy=List.empty(growable: true);
    String token = await getTokenWeb();
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
    if(hourEnergy.isEmpty ){
      setState(() {
        pleaseSelect='There is not Data';
      });
      return thereIsNoData(context);

    }
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
        dateFinal = date.toString();
        cutDate = dateFinal.substring(0, 10);

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
        dateFinal = date.toString();
        cutDate2 = dateFinal.substring(0, 10);

      })
    });
  }
  // m-1*30+d date

  differenceCurrentDateToSelectedDate(){
    currentDifference=DateTime.now().difference(date1).inDays;
    print('currentDifference ${currentDifference}');
  }

   findDifferenceBetweenDates(){
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
    if(onlyDayEnergyList.isEmpty ){
      setState(() {
        pleaseSelect='There is not Data';
      });
      return thereIsNoData(context);

    }
    await sumYearData();
    print('beforeSsumData ${onlyDayEnergyList}');


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
  Future getEnergyDayWeb() async {
    print('goingto web');
    var dId;
    List data= List.empty(growable: true);
    onlyDayEnergyList=List.empty(growable: true);
    String token = await getTokenWeb();


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

        total=total+double.parse(onlyDayEnergyList[i]['day${j+currentDifference}']);
        finalEnergyValue=total.toString();
        varFinalTotalValue=finalEnergyValue;
        defaultTime='';
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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Flat Bill'),
          ),
          body:SingleChildScrollView(
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
                              child: Text(
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
                                          await getroomsWeb(selectedflat);
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
                            total14=0.0;
                            varFinalTotalValue="";
                            finalTotalValue=0.0;
                            _valueMinute=0.0;
                            for(int i=0;i<allRoomId.length;i++){
                              totalValueOfEnergy[i]=0;
                              print('qwsaxcdf ${totalValueOfEnergy[i]}');
                            }

                            deviceIdData.removeRange(0,deviceIdData.length);
                            dataMap={};
                            await getroomsWeb(selectedflat);
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
                            await getEnergyDayWeb();
                            await sumYearData();
                          }, child: Text('Click'))
                    ],

                  ):Text("Please Wait"),
                  completeTask
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(tenMinuteTotalUsage == null
                          ? varFinalTotalValue
                          : tenMinuteTotalUsage),

                      // Text('X'),
                      SizedBox(
                        height: 28,
                        width: 75,
                        child: Center(
                          child: TextField(
                            keyboardType:TextInputType.numberWithOptions(decimal: true) ,
                            controller: billTotalController,
                            textAlign: TextAlign.center,
                            textDirection:TextDirection.rtl,
                            decoration:  InputDecoration(
                              // border: OutlineInputBorder(),
                                hintText: 'Enter a rs per unit'),
                          ),
                        ),
                      ),
                    ],
                  )
                      : Container(),
                  SizedBox(
                    height: 15,
                  ),
                  completeTask
                      ? Container(
                    child: Center(
                      child: RaisedButton(
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 60),
                          child: Text(
                            'Total Usage',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () async {
                          await totalAmount(billTotalController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TotalUsage(
                                    totalEnergy:
                                    tenMinuteTotalUsage == null
                                        ? varFinalTotalValue
                                        : tenMinuteTotalUsage,
                                    chooseValueMinute:
                                    chooseValueMinute == null
                                        ? defaultTime
                                        : chooseValueMinute,
                                    deviceId: dataMap,
                                    totalAmountInRs: totalAmountInRs,
                                    totalDays: difference,
                                  )));
                        },
                      ),
                    ),
                  )
                      : Container(),
                ],
              ),

            ),
          ) ,

        );
      }else{
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flat Bill'),
          ),
          body:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                placeBool == false ?FutureBuilder<List<PlaceType>>(
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
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
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
                                borderSide: const BorderSide(
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              enabledBorder:
                              UnderlineInputBorder(
                                borderSide: const BorderSide(
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
                            style: const TextStyle(
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
                                placeBool = true;
                                floorVal = getfloors(
                                    selectedPlace.pId);
                              });
                            },
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }):

              floorBool == false?  FutureBuilder<List<FloorType>>(
                    future: floorVal,
                    builder: (context,
                        AsyncSnapshot<List<FloorType>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return const Center(
                              child:
                              Text("No Devices on this place"));
                        }
                        return Container(
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
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
                                borderSide: const BorderSide(
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(
                                    10),
                              ),
                              enabledBorder:
                              UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(
                                    50),
                              ),
                            ),
                            dropdownColor: Colors.white70,
                            icon:
                            const Icon(Icons.arrow_drop_down),
                            iconSize: 28,
                            hint: Text('Select Floor'),
                            isExpanded: true,
                            value: fl,
                            style: const TextStyle(
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
                        );
                      } else {
                        return const Center(
                            child: Text("Please select a place to proceed further"));
                      }
                    }):

              flatBool == false?  FutureBuilder<List<Flat>>(
                    future: flatVal,
                    builder: (context,
                        AsyncSnapshot<List<Flat>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isEmpty) {
                          return const Center(
                              child:
                              Text("No Devices on this place"));
                        }
                        return Container(
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
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
                                borderSide: const BorderSide(
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(
                                    10),
                              ),
                              enabledBorder:
                              UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(
                                    50),
                              ),
                            ),
                            dropdownColor: Colors.white70,
                            icon:
                            const Icon(Icons.arrow_drop_down),
                            iconSize: 28,
                            hint: const Text('Select Flat'),
                            isExpanded: true,
                            value: flt,
                            style: const TextStyle(
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
                                flatBool = true;
                              });
                              await getrooms(selectedflat);
                              setState(() {
                                completeTask=true;
                              });
                            },
                          ),
                        );
                      } else {
                        return const Center(
                            child: Text(
                                "Please select a place to proceed further"));
                      }
                    }):
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
                          total14=0.0;
                          varFinalTotalValue="";
                          finalTotalValue=0.0;
                          _valueMinute=0.0;
                          for(int i=0;i<allRoomId.length;i++){
                            totalValueOfEnergy[i]=0;
                            print('qwsaxcdf ${totalValueOfEnergy[i]}');
                          }

                          deviceIdData.removeRange(0,deviceIdData.length);
                          dataMap={};
                          await getrooms(selectedflat);
                          // await sumOfEnergyTenMinutes();


                        },
                        items: minute.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList()),
                    Text(_valueMinute == null
                        ? pleaseSelect
                        : _valueMinute.toStringAsFixed(2)),
                  ],
                ):AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Please wait ',  )
                  ],
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 15,
                ),
                completeTask?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () async{
                        await showDatePicker1();

                      },
                      child: Text(cutDate ?? 'Select Date'),
                    ),
                    InkWell(
                      onTap: () {
                        showDatePicker2();
                        // print12();
                      },
                      child: Text(cutDate2 ?? 'Select Date'),
                    ),
                  ],
                ):const Text("Please Wait"),
                completeTask?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () async{

                      },
                      child: Text(finalEnergyValue ?? ""),
                    ),
                    ElevatedButton(
                        onPressed: ()async{
                          await differenceCurrentDateToSelectedDate();
                          await findDifferenceBetweenDates();
                          await getEnergyDay();
                          await sumYearData();
                        }, child: const Text('Click'))
                  ],

                ):const Text("Please Wait"),
                completeTask
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(tenMinuteTotalUsage ?? varFinalTotalValue),

                    // Text('X'),
                    SizedBox(
                      height: 28,
                      width: 75,
                      child: Center(
                        child: TextField(
                          keyboardType:const TextInputType.numberWithOptions(decimal: true) ,
                          controller: billTotalController,
                          textAlign: TextAlign.center,
                          textDirection:TextDirection.rtl,
                          decoration:  const InputDecoration(
                            // border: OutlineInputBorder(),
                              hintText: 'Enter a rs per unit'),
                        ),
                      ),
                    ),
                  ],
                )
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
                completeTask
                    ? Center(
                      child: RaisedButton(
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 60),
                          child: Text(
                            'Total Usage',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () async {
                          await totalAmount(billTotalController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TotalUsage(
                                    totalEnergy:
                                    tenMinuteTotalUsage ?? varFinalTotalValue,
                                    chooseValueMinute:
                                    chooseValueMinute ?? defaultTime,
                                    deviceId: dataMap,
                                    totalAmountInRs: totalAmountInRs,
                                    totalDays: difference,
                                  )));
                        },
                      ),
                    )
                    : Container(),
              ],
            ),
          ) ,

        );
      }
        });
  }
  double totalAmountInRs=0.0;
  totalAmount(String rsValue){
    int rsConversion=int.parse(rsValue);
    double conversion=double.parse(varFinalTotalValue);
    totalAmountInRs=(conversion/1000)*rsConversion;
  }
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

}
