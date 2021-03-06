import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/BillUsage/total_usage.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class PlaceBill2 extends StatefulWidget {
  @override
  _PlaceBill2State createState() => _PlaceBill2State();
}

class _PlaceBill2State extends State<PlaceBill2> {
  Future placeVal;
  Future placeValWeb;
  double _valueMinute = 0.0;
  var pleaseSelect = 'Please Select';
  bool fetchingData;
  String fetchingDataShow = "Please Wait We are fetching your data";
  PlaceType pt;
  FloorType fl;
  DateTime pickedDate;
  DateTime pickedDate2;
  bool completeTask = false;
  List allFloorId;
  List allFlatId;
  List totalValueOfEnergy;
  List datawe;
  TextEditingController billTotalController = TextEditingController();
  String chooseValueMinute;
  double total14 = 0.0;
  Map<String, double> dataMap = {};
  List minute = [
    '10 minute',
    '20 minute',
    '30 minute',
    '40 minute',
    '50 minute',
    '60 minute'
  ];
  double changeValue;
  double _valueHour = 0.0;
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
  String chooseValueHour;
  String r_id;
  List dataResponse = List.empty(growable: true);
  List tenMinuteEnergy;
  double total = 0.0;
  double totalValue = 0.0;

  var selectedPlaceId;

  void initState() {
    super.initState();
    placeVal = getplaces();
    placeValWeb = getplacesWeb();
    pickedDate = DateTime.now();
    pickedDate2 = DateTime.now();
  }

  var tokenWeb;

  Future getTokenWeb() async {
    final pref = await SharedPreferences.getInstance();
    tokenWeb = pref.getString('tokenWeb');
    return tokenWeb;
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
    if (response.statusCode == 200) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
          data.map((data) => PlaceType.fromJson(data)).toList();

      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    } else {
      return null;
    }
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
    if (response.statusCode == 200) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
          data.map((data) => PlaceType.fromJson(data)).toList();

      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    } else {
      return null;
    }
  }

  Future getfloors(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      allFloorId = List.from(data);
      print('allFloorId $allFloorId');
      totalValueOfEnergy = List(allFloorId.length);
      await getFlat();
    }
  }

  Future getfloorsWeb(String pId) async {
    print('entry');
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      allFloorId = List.from(data);
      print('allFloorId $allFloorId');
      totalValueOfEnergy = List(allFloorId.length);
      await getFlatWeb();
    }
  }

  List<dynamic> flatIdIteration;

  Future getFlat() async {
    String fId;
    allFlatId = List.empty(growable: true);
    String token = await getToken();
    for (int i = 0; i < allFloorId.length; i++) {
      fId = allFloorId[i]['f_id'];
      final url = API + 'addyourflat/?f_id=' + fId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        flatIdIteration = jsonDecode(response.body);
        // List  data.addAll(jsonDecode(response.body));
        allFlatId.addAll(jsonDecode(response.body));
        print('allFlatId ${i},$flatIdIteration');

        await getrooms();
        if(chooseValueMinute=='10 minute' || chooseValueMinute=='20 minute' || chooseValueMinute=='30 minute' || chooseValueMinute=='40 minute' || chooseValueMinute=='50 minute' || chooseValueMinute=='60 minute'){
        print('goingtoifmonute');
        _valueMinute =_valueMinute+total14;
          finalTotalValue = total14 + finalTotalValue;
          varFinalTotalValue = finalTotalValue.toStringAsFixed(2);
          print('varFinalTotalValue $varFinalTotalValue');
          totalValueOfEnergy[i] = total14;
            fetchingData=true;
            dataMap.putIfAbsent(
              allFloorId[i]['f_name'], () => totalValueOfEnergy[i]);
          setState(() {
            // tenMinuteTotalUsage=total14;
          });

          total14 = 0.0;

          print('totalValueOfEnergy $totalValueOfEnergy');
          print('dataMapTotalValueOfEnergy $dataMap');
        }else{
        finalTotalValue = total14 + finalTotalValue;
        varFinalTotalValue = finalTotalValue.toStringAsFixed(2);
        print('varFinalTotalValue $varFinalTotalValue');
        totalValueOfEnergy[i] = total14;

        dataMap.putIfAbsent(
            allFloorId[i]['f_name'], () => totalValueOfEnergy[i]);
        setState(() {
          // tenMinuteTotalUsage=total14;
        });

        total14 = 0.0;

        print('totalValueOfEnergy $totalValueOfEnergy');
        print('dataMapTotalValueOfEnergy $dataMap');
        }
      } else {
        return null;
      }
    }
  }

  Future getFlatWeb() async {
    String fId;
    allFlatId = List.empty(growable: true);
    String token = await getTokenWeb();
    for (int i = 0; i < allFloorId.length; i++) {
      fId = allFloorId[i]['f_id'];
      final url = API + 'addyourflat/?f_id=' + fId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        flatIdIteration = jsonDecode(response.body);
        // List  data.addAll(jsonDecode(response.body));
        allFlatId.addAll(jsonDecode(response.body));
        print('allFlatId ${i},$flatIdIteration');

        await getroomsWeb();

        if(chooseValueMinute=='10 minute' || chooseValueMinute=='20 minute' || chooseValueMinute=='30 minute' || chooseValueMinute=='40 minute' || chooseValueMinute=='50 minute' || chooseValueMinute=='60 minute'){
          print('goingtoifmonute');
          _valueMinute =_valueMinute+total14;
          finalTotalValue = total14 + finalTotalValue;
          varFinalTotalValue = finalTotalValue.toStringAsFixed(2);
          print('varFinalTotalValue $varFinalTotalValue');
          totalValueOfEnergy[i] = total14;
          fetchingData=true;
          dataMap.putIfAbsent(
              allFloorId[i]['f_name'], () => totalValueOfEnergy[i]);
          setState(() {
            // tenMinuteTotalUsage=total14;
          });

          total14 = 0.0;

          print('totalValueOfEnergy $totalValueOfEnergy');
          print('dataMapTotalValueOfEnergy $dataMap');
        }else{
          finalTotalValue = total14 + finalTotalValue;
          varFinalTotalValue = finalTotalValue.toStringAsFixed(2);
          print('varFinalTotalValue $varFinalTotalValue');
          totalValueOfEnergy[i] = total14;

          dataMap.putIfAbsent(
              allFloorId[i]['f_name'], () => totalValueOfEnergy[i]);
          setState(() {
            // tenMinuteTotalUsage=total14;
          });

          total14 = 0.0;

          print('totalValueOfEnergy $totalValueOfEnergy');
          print('dataMapTotalValueOfEnergy $dataMap');
        }
      } else {
        return null;
      }
    }
  }

  List dataRoom = [];
  List allRoomId;
  List data = List.empty(growable: true);

  Future getrooms() async {
    String flt_id;
    String token = await getToken();

    for (int i = 0; i < flatIdIteration.length; i++) {
      flt_id = flatIdIteration[i]['flt_id'];

      final url = API + 'addroom/?flt_id=' + flt_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        data.addAll(jsonDecode(response.body));
        print('allRoomData45859 ${data}');
        dataRoom = jsonDecode(response.body);
        print('allRoomData ,${i} $dataRoom');

        await getDeviceAccordingRoom();
      }
    }
    setState(() {
      allRoomId = List.from(data);
      print('allRoomData45859 ${allRoomId}');
    });
  }

  Future getroomsWeb() async {
    String flt_id;
    String token = await getTokenWeb();

    for (int i = 0; i < flatIdIteration.length; i++) {
      flt_id = flatIdIteration[i]['flt_id'];

      final url = API + 'addroom/?flt_id=' + flt_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        data.addAll(jsonDecode(response.body));
        print('allRoomData45859 ${data}');
        dataRoom = jsonDecode(response.body);
        print('allRoomData ,${i} $dataRoom');

        await getDeviceAccordingRoomWeb();
      }
    }
    setState(() {
      allRoomId = List.from(data);
      print('allRoomData45859 ${allRoomId}');
    });
  }

  double finalTotalValue = 0.0;
  var varFinalTotalValue;

  Future getDeviceAccordingRoom() async {
    var r_id;
    String token = await getToken();
    for (int i = 0; i < dataRoom.length; i++) {
      r_id = dataRoom[i]['r_id'];
      final url = API + 'addyourdevice/?r_id=' + r_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if(response.statusCode==200) {
        datawe = jsonDecode(response.body);
        print('dataIsNotEmpty$datawe');

        if (datawe.isEmpty) {
          return;
        }
        await totalEnergyAccordingRoom();
      }
      // for (int i = 0; i < allFloorId.length; i++) {
      //   if (datawe.isEmpty) {
      //     total14 = 0.0;
      //     print('dataisEmpty');
      //     print('dataisEmpty $dataMap');
      //   }
      //
      //   dataMap.putIfAbsent(allFloorId[i]['f_name'], () => total14);
      //   print('ererere $dataMap');
      // }
    }
  }

  Future getDeviceAccordingRoomWeb() async {
    var r_id;
    String token = await getTokenWeb();
    for (int i = 0; i < dataRoom.length; i++) {
      r_id = dataRoom[i]['r_id'];
      final url = API + 'addyourdevice/?r_id=' + r_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if(response.statusCode==200) {
        datawe = jsonDecode(response.body);
        print('dataIsNotEmpty$datawe');

        if (datawe.isEmpty) {
          return;
        }
        await totalEnergyAccordingRoomWeb();
      }
    }
  }

  Future totalEnergyAccordingRoom() async {
    String token = await getToken();
    for (int j = 0; j < datawe.length; j++) {
      print('forLoopdataweallDeviceIdDeviceIddata-->  ${datawe}');
      final url1 = API + 'pertenminuteenergy?d_id=' + datawe[j]['d_id'];
      final response1 = await http.get(url1, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response1.statusCode == 200) {
        List<dynamic> data = jsonDecode(response1.body);
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
        else{


          for(int k=0;k<data.length;k++){
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40'])+double.parse(data[k]['enrgy50'])+double.parse(data[k]['enrgy60']);
            print('going to elese pororro $total14');

            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
          // int ko=0;
          // while(ko<j){
          //   dataMap.putIfAbsent(allRoomId[ko]['r_name'], () => total14);
          //   ko+1;
          // }


          // total14=0.0;

          print('dataMapKroomaccrodinfsol $dataMap ');

        }
        // int ko=0;
        // while(ko<j){
        //   dataMap.putIfAbsent(allRoomId[ko]['r_name'], () => total14);
        //   ko+1;
        // }

        // total14=0.0;

        // print('dataMapKroomaccrodinfsol $dataMap ');
      }
    }
  }

  Future totalEnergyAccordingRoomWeb() async {
    String token = await getTokenWeb();
    print(
        'totalEnergyAccordingRoomdataweallDeviceIdDeviceIddata-->  ${datawe}');

    for (int j = 0; j < datawe.length; j++) {
      print('forLoopdataweallDeviceIdDeviceIddata-->  ${datawe}');
      final url1 = API + 'pertenminuteenergy?d_id=' + datawe[j]['d_id'];
      final response1 = await http.get(url1, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response1.statusCode == 200) {
        List<dynamic> data = jsonDecode(response1.body);
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
        else{


          for(int k=0;k<data.length;k++){
            total14=total14+double.parse(data[k]['enrgy10'])+double.parse(data[k]['enrgy20'])+double.parse(data[k]['enrgy30'])+double.parse(data[k]['enrgy40'])+double.parse(data[k]['enrgy50'])+double.parse(data[k]['enrgy60']);
            print('going to elese pororro $total14');

            // dataMap.putIfAbsent(allRoomId[j]['r_name'], () => total14);
          }
          // int ko=0;
          // while(ko<j){
          //   dataMap.putIfAbsent(allRoomId[ko]['r_name'], () => total14);
          //   ko+1;
          // }


          // total14=0.0;

          print('dataMapKroomaccrodinfsol $dataMap ');

        }
        // int ko=0;
        // while(ko<j){
        //   dataMap.putIfAbsent(allRoomId[ko]['r_name'], () => total14);
        //   ko+1;
        // }

        // total14=0.0;

        // print('dataMapKroomaccrodinfsol $dataMap ');
      }
    }
  }

  var allDeviceId = List.empty(growable: true);

  Future getDeviceForBill() async {
    String token = await getToken();
    String r_id;

    int i = 0;
    // while (i < length) {
    for (int i = 0; i < allRoomId.length; i++) {
      r_id = allRoomId[i]['r_id'];
      print('aagye $i  ${r_id}');

      final url = API + 'addyourdevice/?r_id=' + r_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        print('rrrrr ${response.body}');
        dataResponse.addAll(jsonDecode(response.body));
        print('allDeviceIdDeviceIddata-->  ${dataResponse}');
        allDeviceId = List.from(dataResponse);

        print('allDeviceIdDeviceIddataallDeviceId-->  ${allDeviceId.length}');
      }
    }
    await getEnergyTenMinutes();
    // print('allDeviceIdDeviceIdtenMinuteEnergy-->  ${tenMinuteEnergy}');

    //
    // print('allDeviceIdDeviceId14785-->  ${allDeviceId}');
    // print('allDeviceIdDeviceId14785-->  ${allDeviceId.length}');

    // await getEnergyTenMinutes();
  }

  Future getDeviceForBillWeb() async {
    String token = await getTokenWeb();
    String r_id;

    int i = 0;
    // while (i < length) {
    for (int i = 0; i < allRoomId.length; i++) {
      r_id = allRoomId[i]['r_id'];
      print('aagye $i  ${r_id}');

      final url = API + 'addyourdevice/?r_id=' + r_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        print('rrrrr ${response.body}');
        dataResponse.addAll(jsonDecode(response.body));
        print('allDeviceIdDeviceIddata-->  ${dataResponse}');
        allDeviceId = List.from(dataResponse);

        print('allDeviceIdDeviceIddataallDeviceId-->  ${allDeviceId.length}');
      }
    }
    await getEnergyTenMinutesWeb();
    // print('allDeviceIdDeviceIdtenMinuteEnergy-->  ${tenMinuteEnergy}');

    //
    // print('allDeviceIdDeviceId14785-->  ${allDeviceId}');
    // print('allDeviceIdDeviceId14785-->  ${allDeviceId.length}');

    // await getEnergyTenMinutes();
  }

  var tenMinuteTotalUsage;
  int length = 0;

  Future getEnergyTenMinutes() async {
    List dataResponse = List.empty(growable: true);
    tenMinuteEnergy = List.empty(growable: true);
    var dId;
    String token = await getToken();
    for (int i = 0; i < allDeviceId.length; i++) {
      dId = allDeviceId[i]['d_id'];
      print('deviceIdEnergyRoom $dId');
      final url = API + 'pertenminuteenergy?d_id=' + dId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('tenMinuteEnergy ${response.statusCode}');
      if (response.statusCode == 200) {
        dataResponse.addAll(jsonDecode(response.body));
        tenMinuteEnergy = List.from(dataResponse);
        print('tenMinuteRoomData2 $dataResponse');
      }
    }

    print('FinalTenMinuteEnergy  ${tenMinuteEnergy.length}');
  }

  Future getEnergyTenMinutesWeb() async {
    List dataResponse = List.empty(growable: true);
    tenMinuteEnergy = List.empty(growable: true);
    var dId;
    String token = await getTokenWeb();
    for (int i = 0; i < allDeviceId.length; i++) {
      dId = allDeviceId[i]['d_id'];
      print('deviceIdEnergyRoom $dId');
      final url = API + 'pertenminuteenergy?d_id=' + dId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('tenMinuteEnergy ${response.statusCode}');
      if (response.statusCode == 200) {
        dataResponse.addAll(jsonDecode(response.body));
        tenMinuteEnergy = List.from(dataResponse);
        print('tenMinuteRoomData2 $dataResponse');
      }
    }

    print('FinalTenMinuteEnergy  ${tenMinuteEnergy.length}');
  }

  sumOfEnergyTenMinutes() async {
    totalValue = 0.0;
    setState(() {
      length = tenMinuteEnergy.length;
    });
    if (chooseValueMinute == '10 minute') {
      for (int i = 0; i < tenMinuteEnergy.length; i++) {
        setState(() {
          changeValue = double.parse(tenMinuteEnergy[i]['enrgy10']);
          totalValue = totalValue + changeValue;
          _valueMinute = totalValue;
          tenMinuteTotalUsage = totalValue.toStringAsFixed(2);
          fetchingData = true;
          // for(int i=0;i<allFloorId.length;i++){
          //   totalValueOfEnergy[i];
          //     print('10minutetotalvalue ${totalValueOfEnergy[i]} ');
          //   dataMap.putIfAbsent(allFloorId[i]['f_name'], () => totalValueOfEnergy[i]);
          //   // dataMap.putIfAbsent(allFloorId[i]['f_name'], () => totalValue);
          //   dataMap.update(allFloorId[i]['f_name'], (value) => totalValueOfEnergy[i]);
          // }
        });
      }
      print('totalAns $totalValue');
    }
    if (chooseValueMinute == '20 minute') {
      for (int i = 0; i < length; i++) {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[i]['enrgy20']);
          totalValue = totalValue + op1 + op2;
          _valueMinute = totalValue;
          tenMinuteTotalUsage = totalValue.toStringAsFixed(2);
          fetchingData = true;
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if (chooseValueMinute == '30 minute') {
      for (int i = 0; i < length; i++) {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[i]['enrgy30']);
          totalValue = totalValue + op1 + op2 + op3;
          _valueMinute = totalValue;
          tenMinuteTotalUsage = totalValue.toStringAsFixed(2);
          fetchingData = true;
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }
    if (chooseValueMinute == '40 minute') {
      for (int i = 0; i < length; i++) {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[i]['enrgy40']);
          totalValue = totalValue + op1 + op2 + op3 + op4;
          tenMinuteTotalUsage = totalValue.toStringAsFixed(2);
          _valueMinute = totalValue;
          fetchingData = true;
        });
        print('totalans ${tenMinuteEnergy[i][0]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if (chooseValueMinute == '50 minute') {
      for (int i = 0; i < length; i++) {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[i]['enrgy40']);
          double op5 = double.parse(tenMinuteEnergy[i]['enrgy50']);
          totalValue = totalValue + op1 + op2 + op3 + op4 + op5;
          _valueMinute = totalValue;
          tenMinuteTotalUsage = totalValue.toStringAsFixed(2);
          fetchingData = true;
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if (chooseValueMinute == '60 minute') {
      for (int i = 0; i < length; i++) {
        setState(() {
          double op1 = double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2 = double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3 = double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4 = double.parse(tenMinuteEnergy[i]['enrgy40']);
          double op5 = double.parse(tenMinuteEnergy[i]['enrgy50']);
          double op6 = double.parse(tenMinuteEnergy[i]['enrgy60']);
          totalValue = totalValue + op1 + op2 + op3 + op4 + op5 + op6;
          _valueMinute = totalValue;
          tenMinuteTotalUsage = totalValue.toStringAsFixed(2);
          fetchingData = true;
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }
  }

  Future getEnergyHour() async {
    var dId;
    hourEnergy = List.empty(growable: true);
    String token = await getToken();
    for (int i = 0; i < allDeviceId.length; i++) {
      dId = allDeviceId[i]['d_id'];
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

  int lengthHour;

  sumOfEnergyHour() async {
    double totalValue = 0.0;
    if(hourEnergy.isEmpty){
      return thereIsNoData(context);
    }
    setState(() {
      lengthHour = hourEnergy.length;
    });
    if (chooseValueHour == '1 hour') {
      for (int i = 0; i < lengthHour; i++) {
        setState(() {
          var last1Hour = hourEnergy[i]['hour1'];
          changeValue = double.parse(last1Hour);
          totalValue = totalValue + changeValue;
          _valueHour = totalValue;
          print('sasa $last1Hour');
        });
      }
    }
    if (chooseValueHour == '2 hour') {
      for (int i = 0; i < lengthHour; i++) {
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour = _valueHour + op1 + op2;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '3 hour') {
      for (int i = 0; i < lengthHour; i++) {
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour = _valueHour + op1 + op2 + op3;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '4 hour') {
      for (int i = 0; i < lengthHour; i++) {
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour = _valueHour + op1 + op2 + op3 + op4;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '5 hour') {
      for (int i = 0; i < lengthHour; i++) {
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour = _valueHour + op1 + op2 + op3 + op4 + op5;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '6 hour') {
      for (int i = 0; i < lengthHour; i++) {
        setState(() {
          double op1 = double.parse(hourEnergy[i]['hour1']);
          double op2 = double.parse(hourEnergy[i]['hour2']);
          double op3 = double.parse(hourEnergy[i]['hour3']);
          double op4 = double.parse(hourEnergy[i]['hour4']);
          double op5 = double.parse(hourEnergy[i]['hour5']);
          double op6 = double.parse(hourEnergy[i]['hour6']);
          print('sasa ${hourEnergy[i]['hour1']}');
          print('2sasa ${hourEnergy[i]['hour2']}');

          _valueHour = _valueHour + op1 + op2 + op3 + op4 + op5 + op6;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '7 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour + op1 + op2 + op3 + op4 + op5 + op6 + op7;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '8 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour =
              _valueHour + op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '9 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour =
              _valueHour + op1 + op2 + op3 + op4 + op5 + op6 + op7 + op8 + op9;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '10 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '11 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
              op2 +
              op3 +
              op4 +
              op5 +
              op6 +
              op7 +
              op8 +
              op9 +
              op10 +
              op11;
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '12 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '13 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '14 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '15 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '16 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '17 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '18 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '19 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '20 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '21 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '22 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '23 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
    if (chooseValueHour == '24 hour') {
      for (int i = 0; i < lengthHour; i++) {
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

          _valueHour = _valueHour +
              op1 +
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
          print('_valueHour ${_valueHour}');
        });
      }
    }
  }

  DateTime date2;
  DateTime date1;
  String dateFinal;
  var currentDifference;
  var currentDate;
  var difference;
  String cutDate;
  String cutDate2;
  List onlyDayEnergyList = List.empty(growable: true);
  var finalEnergyValue;

  showDatePicker1() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2080))
        .then((date) => {
              setState(() {
                date1 = date;
                dateFinal = date.toString();
                cutDate = dateFinal.substring(0, 10);
              })
            });
  }

  showDatePicker2() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2080))
        .then((date) => {
              setState(() {
                date2 = date;
                dateFinal = date.toString();
                cutDate2 = dateFinal.substring(0, 10);
              })
            });
  }

  differenceCurrentDateToSelectedDate() {
    currentDifference = DateTime.now().difference(date1).inDays;
    print('currentDifference ${currentDifference}');
  }

   findDifferenceBetweenDates() {
    print(date1);
    print(date2);
    setState(() {
      difference = date1.difference(date2).inDays;
    });

    print('difference $difference');
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


  Future getEnergyDay() async {
    var dId;
    List data = List.empty(growable: true);

    String token = await getToken();

    for (int i = 0; i < allDeviceId.length; i++) {
      dId = allDeviceId[i]['d_id'];
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
    onlyDayEnergyList = List.from(data);
    if(onlyDayEnergyList.isEmpty){
      return thereIsNoData(context);
    }
    await sumYearData();
    print('beforeSumData ${onlyDayEnergyList}');
    print('sumData ${onlyDayEnergyList}');
  }

  sumYearData() {
    int i = 0;

    while (i < onlyDayEnergyList.length) {
      for (int j = 1; j <= difference; j++) {
        print(' assays ${onlyDayEnergyList[i]['day${j}']}');
        setState(() {
          total = total + onlyDayEnergyList[i]['day${j + currentDifference}'];
          finalEnergyValue = total.toString();
        });
      }

      i++;
      print('sumDataTotal ${total}');
    }
    total = 0.0;
    print('sumDataTotal_final ${total}');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Place Bill Web'),
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
                      builder:
                          (context, AsyncSnapshot<List<PlaceType>> snapshot) {
                        if (snapshot.hasData) {
                          // print(snapshot.hasData);
                          // setState(() {
                          //   floorVal = getfloors(snapshot.data[0].p_id);
                          // });
                          if (snapshot.data.length == 0) {
                            return Center(
                                child: Text("No Devices on this place"));
                          }
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 58),
                              child: SizedBox(
                                // width: double.infinity,
                                height: 50.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
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
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(50),
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
                                    items: snapshot.data.map((selectedPlace) {
                                      return DropdownMenuItem<PlaceType>(
                                        value: selectedPlace,
                                        child: Text(selectedPlace.pType),
                                      );
                                    }).toList(),
                                    onChanged: (PlaceType selectedPlace) async {
                                      setState(() {
                                        fl = null;
                                        pt = selectedPlace;
                                        selectedPlaceId=selectedPlace.pId;
                                      });
                                      await getfloorsWeb(selectedPlace.pId);
                                      setState(() {
                                        completeTask = true;
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
                  completeTask
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            DropdownButton(
                                value: chooseValueMinute,
                                onChanged: (index) async {
                                  setState(() {
                                    chooseValueMinute = index;
                                    totalValue=0.0;
                                    total14=0.0;
                                    varFinalTotalValue="";
                                    finalTotalValue=0.0;
                                    dataMap={};
                                    _valueMinute=0.0;
                                    fetchingData = false;
                                  });

                                  await getfloorsWeb(selectedPlaceId);
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
                        )
                      : Text(''),
                  const SizedBox(
                    height: 15,
                  ),
                  completeTask
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            DropdownButton(
                                value: chooseValueHour,
                                onChanged: (index) async {
                                  setState(() {
                                    chooseValueHour = index;
                                  });
                                  totalValue = 0.0;
                                  _valueHour = 0.0;
                                  await getEnergyHour();
                                  await sumOfEnergyHour();
                                },
                                items: hour.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList()),
                            Text(_valueHour == null
                                ? pleaseSelect
                                : _valueHour.toStringAsFixed(2)),
                          ],
                        )
                      : Text("Wait"),
                  completeTask
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                await showDatePicker1();
                              },
                              child: Text(
                                  cutDate == null ? 'Select Date' : cutDate),
                            ),
                            InkWell(
                              onTap: () {
                                showDatePicker2();
                                // print12();
                              },
                              child: Text(
                                  cutDate2 == null ? 'Select Date' : cutDate2),
                            ),
                          ],
                        )
                      : Text(""),
                  completeTask
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () async {},
                              child: Text(finalEnergyValue.toString()),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await differenceCurrentDateToSelectedDate();
                                  await findDifferenceBetweenDates();
                                  await getEnergyDay();
                                  await sumYearData();
                                },
                                child: Text('Click'))
                          ],
                        )
                      : Text("Please Wait"),
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
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                                hintText: 'Enter a rs per unit'),
                          ),
                        ),
                      ),
                    ],
                  )
                      : Container(),
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
                          print('navigation $dataMap');
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
                                        ? "60 Minute"
                                        : chooseValueMinute,
                                    deviceId: dataMap,
                                    totalAmountInRs: totalAmountInRs,
                                  )));
                          // Navigator.of(context)
                          //     .pushReplacementNamed(TotalUsage.routeName);
                        },
                      ),
                    ),
                  )
                      : Text('')
                ],
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text('Place Bill'),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: FutureBuilder<List<PlaceType>>(
                        future: placeVal,
                        builder:
                            (context, AsyncSnapshot<List<PlaceType>> snapshot) {
                          if (snapshot.hasData) {
                            // print(snapshot.hasData);
                            // setState(() {
                            //   floorVal = getfloors(snapshot.data[0].p_id);
                            // });
                            if (snapshot.data.length == 0) {
                              return Center(
                                  child: Text("No Devices on this place"));
                            }
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 58),
                                child: SizedBox(
                                  // width: double.infinity,
                                  height: 50.0,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
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
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
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
                                      items: snapshot.data.map((selectedPlace) {
                                        return DropdownMenuItem<PlaceType>(
                                          value: selectedPlace,
                                          child: Text(selectedPlace.pType),
                                        );
                                      }).toList(),
                                      onChanged:
                                          (PlaceType selectedPlace) async {
                                        setState(() {
                                          fl = null;
                                          pt = selectedPlace;
                                          selectedPlaceId=selectedPlace.pId;
                                        });
                                        await getfloors(selectedPlace.pId);
                                        setState(() {
                                          completeTask = true;
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  completeTask
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            DropdownButton(
                                value: chooseValueMinute,
                                onChanged: (index) async {
                                  setState(() {
                                    chooseValueMinute = index;
                                    totalValue=0.0;
                                    total14=0.0;
                                    varFinalTotalValue="";
                                    finalTotalValue=0.0;
                                    dataMap={};
                                    _valueMinute=0.0;
                                    fetchingData = false;
                                  });

                                  await getfloors(selectedPlaceId);
                                  // await getDeviceForBill();
                                  // await sumOfEnergyTenMinutes();
                                },
                                items: minute.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList()),
                            Text(fetchingData == false
                                ? fetchingDataShow.toString()
                                : _valueMinute.toStringAsFixed(2)),
                          ],
                        )
                      : Text(''),
                  SizedBox(
                    height: 15,
                  ),
                  completeTask
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            DropdownButton(
                                value: chooseValueHour,
                                onChanged: (index) async {
                                  setState(() {
                                    chooseValueHour = index;
                                  });
                                  totalValue = 0.0;
                                  _valueHour = 0.0;
                                  await getEnergyHour();
                                  await sumOfEnergyHour();
                                },
                                items: hour.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList()),
                            Text(_valueHour == null
                                ? pleaseSelect
                                : _valueHour.toStringAsFixed(2)),
                          ],
                        )
                      : Text(""),
                  completeTask
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                await showDatePicker1();
                              },
                              child: Text(
                                  cutDate == null ? 'Select Date' : cutDate),
                            ),
                            InkWell(
                              onTap: () {
                                showDatePicker2();
                                // print12();
                              },
                              child: Text(
                                  cutDate2 == null ? 'Select Date' : cutDate2),
                            ),
                          ],
                        )
                      : Text(""),

                  SizedBox(
                    height: 10,
                  ),
                  completeTask
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(finalEnergyValue == null
                                ? ""
                                : finalEnergyValue.toString()),
                            ElevatedButton(
                                onPressed: () async {
                                  await differenceCurrentDateToSelectedDate();
                                  await findDifferenceBetweenDates();
                                  await getEnergyDay();
                                  await sumYearData();
                                },
                                child: Text('Click'))
                          ],
                        )
                      : Text("Please Wait"),
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
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                                hintText: 'Enter a rs per unit'),
                          ),
                        ),
                      ),
                    ],
                  )
                      : Container(),
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
                                print('navigation $dataMap');
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
                                                      ? "60 Minute"
                                                      : chooseValueMinute,
                                              deviceId: dataMap,
                                          totalAmountInRs: totalAmountInRs,
                                            )));
                                // Navigator.of(context)
                                //     .pushReplacementNamed(TotalUsage.routeName);
                              },
                            ),
                          ),
                        )
                      : Text('')
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  double totalAmountInRs = 0.0;

  totalAmount(String rsValue) {
    double rsConversion = double.parse(rsValue);
    double conversion = double.parse(varFinalTotalValue);
    totalAmountInRs = (conversion / 1000) * rsConversion;
  }
}
