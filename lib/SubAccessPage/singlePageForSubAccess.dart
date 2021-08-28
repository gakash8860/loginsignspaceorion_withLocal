import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:loginsignspaceorion/ModelsForSubUser/allmodels.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/SQLITE_database/localDatabaseForSubUser/subuserSqlite.dart';
import 'package:loginsignspaceorion/SubAccessPage/subaccesshomepage.dart';
import 'package:loginsignspaceorion/SubAccessPage/subaccesslist.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../main.dart';

void main()=>runApp(MaterialApp(
  home:SubAccessSinglePage() ,
));

class SubAccessSinglePage extends StatefulWidget {
   SubAccessSinglePage({Key key}) : super(key: key);

  // ignore: non_constant_identifier_names
  var switch1_get;
  var switch1Name;
  var switch2Name;
  var switch3Name;
  var switch4Name;
  var switch5Name;
  var switch6Name;
  var switch7Name;
  var switch8Name;
  var switch9Name;
  var switch10Name;
  var switch11Name;
  var switch12Name;

  // ignore: non_constant_identifier_names
  var Slider_get = 1;

  // ignore: non_constant_identifier_names
  var Slider_get2 = 1;

  // ignore: non_constant_identifier_names
  var Slider_get3 = 1;
  var Slider_get4;

  var Slider_get5;

  var Slider_get6;

  var Slider_get7;

  var Slider_get8;

  var Slider_get9;

  var Slider_get10;
  var Slider_get11;
  var Slider_get12;

  // ignore: non_constant_identifier_names
  var switch2_get,
  // ignore: non_constant_identifier_names
      switch3_get,
  // ignore: non_constant_identifier_names
      switch4_get,
  // ignore: non_constant_identifier_names
      switch5_get,
  // ignore: non_constant_identifier_names
      switch6_get,
  // ignore: non_constant_identifier_names
      switch7_get,
  // ignore: non_constant_identifier_names
      switch8_get,
  // ignore: non_constant_identifier_names
      switch9_get;
  @override
  _SubAccessSinglePageState createState() => _SubAccessSinglePageState();
}

class _SubAccessSinglePageState extends State<SubAccessSinglePage> {
  List allPlaceId;
  var placeId;
  List roomTab;
  Future futureSubUser;
  String token="774945db6cd2eec12fe92227ab9b811c888227c6";
  List<SubUserDeviceType> dv;
  List getFlatData;
  List getFloorData;
  List<Map<String, dynamic>> deviceQueryRows;
  var sensorData;
  bool _switchValue = false;
  List responseDataPinStatusForSubUser;
  TabController tabC;
  var tabState;
  Future deviceSensorVal;
  get index => null;

  List namesDataList ;

  bool val2 = false;
  bool val1 = true;
  @override
  void initState(){
    super.initState();
    getSubUsers();
    getAllFloorForSubUser();
    getAllFlatForSubUser();
  }



  Future<void> getSubUsers()async{
    String token =await getToken();
    // await openSubUserBox();
    final url ='http://genorion1.herokuapp.com/subuserfindall/';
    try{
      final response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      // await subUserBox.clear();
      List  subUserDecode=jsonDecode(response.body);
      print('tempResponse ${subUserDecode}');
        for(int i=0;i<subUserDecode.length;i++){
          var data= SubAccessPage(
            email: subUserDecode[i]['email'].toString(),
            ownerName: subUserDecode[i]['owner_name'].toString(),
            pId: subUserDecode[i]['p_id'],
            name: subUserDecode[i]['name'].toString(),
            user: subUserDecode[i]['user'],
          );
         await NewDbProvider.instance.insertSubUserModelData(data);


        }
     allPlaceId=  await NewDbProvider.instance.querySubUser();
      print('subUserDecode ${allPlaceId}');

      print('subUserDecode ${allPlaceId}');
      setState(() {
        subUserDecodeList=subUserDecode;
        placeId=subUserDecodeList[0]['p_id'].toString();
      });
      print('subUserDecode ${placeId}');
      print('Number1123->  ${subUserDecodeList}');
    }catch(e){
      // print('Status Exception $e');

    }
    getAllFloorForSubUser();
  }

  Future getAllFloorForSubUser() async {
    var placeId;
    for(int i=0;i<allPlaceId.length;i++){
      placeId=allPlaceId[i]['p_id'].toString();
      final url =
          'https://genorion1.herokuapp.com/getallfloorsbyonlyplaceidp_id/?p_id=' + placeId;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      if (response.statusCode > 0) {
        print('floorSubUser ${response.statusCode}');

        if (response.statusCode == 200) {
          List floorData = jsonDecode(response.body);
          print('floorSubUser ${floorData}');
          for(int i=0;i<floorData.length;i++){
            var floorQueryForSubUser=SubUserFloorType(
                fId: floorData[i]['f_id'],
                fName: floorData[i]['f_name'].toString(),
                pId: floorData[i]['p_id'],
                user: floorData[i]['user']
            );
            await  SubUserDataBase.subUserInstance.insertSubUserFloorModelData(floorQueryForSubUser);
          }
          getFloorData= await SubUserDataBase.subUserInstance.queryFloorSubUser();
        }
      }


    }

    getAllFlatForSubUser();

  }

  Future getAllFlatForSubUser() async {

    for(int i=0;i<getFloorData.length;i++){
    var  fId=getFloorData[i]['f_id'].toString();

      final url =
          'https://genorion1.herokuapp.com/getallflatbyonlyflooridf_id/?f_id=' +
              fId;
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print('flatSubUser ${response.statusCode}');

        if (response.statusCode == 200) {
        List  listFlatData = jsonDecode(response.body);
          print('flatSubUser ${listFlatData}');
          // flatId = listFlatData[0]['flt_id'];
          // flatName = listFlatData[0]['flt_name'];
          print('flatSubUser ${listFlatData}');
          for(int i=0;i<listFlatData.length;i++){
            var flatQueryForSubUser=SubUserFlatType(
                fId: listFlatData[i]['f_id'],
                fltId: listFlatData[i]['flt_id'],
                fltName: listFlatData[i]['flt_name'],
                user: listFlatData[i]['user']
            );
            await  SubUserDataBase.subUserInstance.insertSubUserFlatModelData(flatQueryForSubUser);
          }
          getFlatData= await SubUserDataBase.subUserInstance.queryFlatSubUser();
        }
      }
    }
    getAllRoomForSubUser();

  }

  Future getAllRoomForSubUser() async {

    for(int i=0;i< getFlatData.length;i++){
     var flatId=getFlatData[i]['flt_id'].toString();
      final url =
          'https://genorion1.herokuapp.com/getallroomsbyonlyflooridf_id/?flt_id=' +
              flatId;
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print('RoomSubUser ${response.statusCode}');
        print('RoomSubUser ${response.body}');

        if (response.statusCode == 200) {
          roomTab = jsonDecode(response.body);
          // tabState=roomTab[0]['r_id'];
          for(int i=0;i<roomTab.length;i++){
            var  roomQuery=SubUserRoomType(
                rId: roomTab[i]['r_id'],
                rName: roomTab[i]['r_name'].toString(),
                fltId: roomTab[i]['flt_id'],
                user: roomTab[i]['user']
            );
            await SubUserDataBase.subUserInstance.insertSubUserRoomModelData(roomQuery);
          }
          roomData=await SubUserDataBase.subUserInstance.queryRoomSubUser();
          print('RoomSubUser ${response.body}');
        }
        await getAllDeviceForSubUser();
      }
    }


  }
  Future  getAllDeviceForSubUser() async {

    for(int i=0;i<roomData.length;i++){
     var rId=roomData[i]['r_id'].toString();
      // print('tabbar1 ${tabState}');
      final url = 'https://genorion1.herokuapp.com/getalldevicesbyonlyroomidr_id/?r_id=' + rId;
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print('deviceGetSubUser ${response.statusCode}');
        print('deviceGetSubUser ${response.body}');
        if (response.statusCode == 200) {
         List deviceSubUser = jsonDecode(response.body);
          // deviceId=deviceSubUser[index]['d_id'];
          for(int i=0;i<deviceSubUser.length;i++){
            var deviceQuerySubUser=SubUserDeviceType(
                user: deviceSubUser[i]['user'],
                rId: deviceSubUser[i]['r_id'],
                dId: deviceSubUser[i]['d_id']
            );
            await  SubUserDataBase.subUserInstance.insertSubUserDeviceModelData(deviceQuerySubUser);
          }

          dv=deviceSubUser.map((data) => SubUserDeviceType.fromJson(data)).toList();
          // print('deviceId ${widget.dv[index].dId}');

        }
        deviceQueryRows= await SubUserDataBase.subUserInstance.queryDeviceSubUser();
      }
    }
  }

  Future<void> getPinStatusData() async {

    var did;
    print('PinStatusFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++) {
      did=deviceQueryRows[i]['d_id'].toString();
      print('insideLoop $did');
      String url = "https://genorion1.herokuapp.com/getpostdevicePinStatus/?d_id="+did.toString();
      final response = await http.get(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $token',
          });

      if(response.statusCode==200){
        print('PinStatusResponse  ${response.statusCode}');
        var pinStatus= jsonDecode(response.body);
        // var pinStatus2=pinStatus;
        List listOfPinStatusValue=[pinStatus,];
        print('printFunction $listOfPinStatusValue}');
        for (int i = 0; i < listOfPinStatusValue.length; i++) {
          var pinQuery = PinStatusSubUser(
            dId: listOfPinStatusValue[i]['d_id'],
            pin1Status: listOfPinStatusValue[i]['pin1Status'],
            pin2Status: listOfPinStatusValue[i]['pin2Status'],
            pin3Status: listOfPinStatusValue[i]['pin3Status'],
            pin4Status: listOfPinStatusValue[i]['pin4Status'],
            pin5Status: listOfPinStatusValue[i]['pin5Status'],
            pin6Status: listOfPinStatusValue[i]['pin6Status'],
            pin7Status: listOfPinStatusValue[i]['pin7Status'],
            pin8Status: listOfPinStatusValue[i]['pin8Status'],
            pin9Status: listOfPinStatusValue[i]['pin9Status'],
            pin10Status: listOfPinStatusValue[i]['pin10Status'],
            pin11Status: listOfPinStatusValue[i]['pin11Status'],
            pin12Status: listOfPinStatusValue[i]['pin12Status'],
            pin13Status: listOfPinStatusValue[i]['pin13Status'],
            pin14Status: listOfPinStatusValue[i]['pin14Status'],
            pin15Status: listOfPinStatusValue[i]['pin15Status'],
            // pin16Status: listOfPinStatusValue[i]['pin16Status'],
            // pin17Status: listOfPinStatusValue[i]['pin17Status'],
            // pin18Status: listOfPinStatusValue[i]['pin18Status'],
            // pin19Status: listOfPinStatusValue[i]['pin19Status'],
            // pin20Status: listOfPinStatusValue[i]['pin20Status'],
          );
          await SubUserDataBase.subUserInstance.insertSubUserDevicePinStatusData(pinQuery);
          // await SubUserDataBase.subUserInstance.updatePinStatusData(pinQuery);
          print('check1234567}');
        }
        await getAllPinNames();

        // String a=listOfPinStatusValue[i]['pin20Status'].toString();
        // print('aaaaaaaaaa ${a}');
        //   int aa= int.parse(a);
        // print('double $aa');
        // // int aa=int.parse(a);
        //
        // int ms = ((DateTime.now().millisecondsSinceEpoch)/1000).round() + 19700;
        // if (aa.compareTo(ms) > 0) {
        //   print('ifelse');
        //   statusOfDevice = 1;
        // } else {
        //   print('ifelse2');
        //   statusOfDevice = 0;
        // }
      }



    }
  }
  Future<void> getAllPinNames()async{
    String token = await getToken();
    var did;
    print('pinNamesFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++){

      did=deviceQueryRows[i]['d_id'].toString();
      print('diddevice $did');
      String url = "https://genorion1.herokuapp.com/editpinnames/?d_id="+did;
      // try {
      final   response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if(response.statusCode==200) {
        var  devicePinNamesData=json.decode(response.body);
        List listOfPinNames=[devicePinNamesData,];
        print('QWERTY  $listOfPinNames');
        for (int i = 0; i < listOfPinNames.length; i++) {
          print('devicePinData $listOfPinNames}');
          var devicePinNamesQuery = SubUserDevicePinNameType(
            dId: listOfPinNames[i]['d_id'].toString(),
            pin1Name: listOfPinNames[i]['pin1Name'].toString(),
            pin2Name: listOfPinNames[i]['pin2Name'].toString(),
            pin3Name: listOfPinNames[i]['pin3Name'].toString(),
            pin4Name: listOfPinNames[i]['pin4Name'].toString(),
            pin5Name: listOfPinNames[i]['pin5Name'].toString(),
            pin6Name: listOfPinNames[i]['pin6Name'].toString(),
            pin7Name: listOfPinNames[i]['pin7Name'].toString(),
            pin8Name: listOfPinNames[i]['pin8Name'].toString(),
            pin9Name: listOfPinNames[i]['pin9Name'].toString(),
            pin10Name: listOfPinNames[i]['pin10Name'].toString(),
            pin11Name: listOfPinNames[i]['pin11Name'].toString(),
            pin12Name: listOfPinNames[i]['pin12Name'].toString(),
          );
          print('devicePinNamesInsertQuery    ${devicePinNamesQuery.toJson()}');
          print('devicePinQueryToJson    ${devicePinNamesQuery.toJson()}');
          await SubUserDataBase.subUserInstance.insertSubUserDevicePinNames(devicePinNamesQuery);
          // var check= await NewDbProvider.instance.getPinNamesByDeviceId(listOfPinNames[i]['d_id']);
          // print('check456 ${check}');
        }
        getSensorData();

      }
    }


  }

  Future<void> getSensorData() async {
    // arr=[arr.length-arr.length];
    String token = await getToken();

    var did;
    print('SensorFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++) {
      did=deviceQueryRows[i]['d_id'].toString();
      print('insideLoop $did');
      String url = "https://genorion1.herokuapp.com/tensensorsdata/?d_id="+did.toString();
      final response = await http.get(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $token',
          });
      if(response.statusCode==200){
        print('sensorResponse  ${response.statusCode}');

      }
      var arr = jsonDecode(response.body);
      List listOfPinSensor=[arr,];
      print('sensorData  ${listOfPinSensor}');
      for (int i = 0; i < listOfPinSensor.length; i++) {
        var sensorQuery = SubUserSensorData(
          dId: listOfPinSensor[i]['d_id'],
          sensor1: listOfPinSensor[i]['sensor1'],
          sensor2: listOfPinSensor[i]['sensor2'],
          sensor3: listOfPinSensor[i]['sensor3'],
          sensor4: listOfPinSensor[i]['sensor4'],
          sensor5: listOfPinSensor[i]['sensor5'],
          sensor6: listOfPinSensor[i]['sensor6'],
          sensor7: listOfPinSensor[i]['sensor7'],
          sensor8: listOfPinSensor[i]['sensor8'],
          sensor9: listOfPinSensor[i]['sensor9'],
          sensor10: listOfPinSensor[i]['sensor10'],
        );
        print('deviceSensorJson    ${sensorQuery.toJson()}');
        await SubUserDataBase.subUserInstance.insertSubUserSensor(sensorQuery);
        // await NewDbProvider.instance.updateSensorData(sensorQuery);
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Container();
      }else{
        return Scaffold(
          appBar: AppBar(
            title: Text('AppBar'),
          ),
          body:Container(
            width: double.maxFinite,
            child: DefaultTabController(
              length: roomTab.length,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.41,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff669df4),
                                  Color(0xff4e80f3)
                                ]),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          padding: EdgeInsets.only(
                            top: 40,
                            bottom: 10,
                            left: 28,
                            right: 30,
                          ),
                          // alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onLongPress: () {
                                              // _editFloorNameAlertDialog(context);
                                            },
                                            child: Row(
                                              children: [
                                                Text('Floor -',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontStyle: FontStyle
                                                          .italic),),
                                                Text(
                                                  'Hello ',
                                                  // + widget.fl.user.first_name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      // fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle
                                                          .italic),
                                                ),
                                                Icon(Icons
                                                    .arrow_drop_down),
                                                SizedBox(width: 10,),
                                              ],
                                            ),
                                            onTap: () {

                                            },
                                          ),
                                          SizedBox(width: 10,),
                                          GestureDetector(
                                            child: Icon(Icons.add),
                                            onTap: () async {

                                              // _createAlertDialogForFloor(context);
                                            },
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                onLongPress: () {

                                                },
                                                child: Row(
                                                  children: [
                                                    Text('Flat- ',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 22),),
                                                    Text(
                                                      'Hello ',
                                                      // + widget.fl.user.first_name,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white,
                                                          // fontWeight: FontWeight.bold,
                                                          fontStyle: FontStyle
                                                              .italic,
                                                          fontSize: 22),
                                                    ),
                                                    Icon(Icons
                                                        .arrow_drop_down),
                                                    SizedBox(width: 10,),
                                                  ],
                                                ),
                                                onTap: () {

                                                },
                                              ),
                                              SizedBox(width: 35),
                                              GestureDetector(
                                                  onTap: () async {

                                                  },
                                                  child: Icon(Icons.add)),
                                            ],
                                          )

                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 45,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  // FutureBuilder(
                                  //   // future: deviceSensorVal,
                                  //   builder: (context, snapshot) {
                                  //     if (!snapshot.hasData) {
                                  //       return Column(
                                  //         children: <Widget>[
                                  //           Row(
                                  //             children: <Widget>[
                                  //               Text('Sensors- ',
                                  //                 style: TextStyle(
                                  //
                                  //                   // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight
                                  //                         .bold,
                                  //                     color: Colors.white
                                  //                 ),),
                                  //               SizedBox(
                                  //                 width: 8,
                                  //               ),
                                  //               Column(children: <Widget>[
                                  //                 Icon(
                                  //                   FontAwesomeIcons.fire,
                                  //                   color: Colors.yellow,
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 25,
                                  //                 ),
                                  //                 Row(
                                  //                   children: <Widget>[
                                  //                     Container(
                                  //                       child: Text(
                                  //                           sensorData[index]['sensor1'].toString(),
                                  //                           style: TextStyle(
                                  //                               fontSize: 14,
                                  //                               color: Colors
                                  //                                   .white70)),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ]),
                                  //               SizedBox(
                                  //                 width: 35,
                                  //               ),
                                  //               Column(children: <Widget>[
                                  //                 Icon(
                                  //                   FontAwesomeIcons
                                  //                       .temperatureLow,
                                  //                   color: Colors.orange,
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 30,
                                  //                 ),
                                  //                 Row(
                                  //                   children: <Widget>[
                                  //                     Container(
                                  //                       child: Text(
                                  //                           sensorData[index][
                                  //                           'sensor2']
                                  //                               .toString(),
                                  //                           style: TextStyle(
                                  //                               fontSize: 14,
                                  //                               color: Colors
                                  //                                   .white70)),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ]),
                                  //               SizedBox(
                                  //                 width: 45,
                                  //               ),
                                  //               Column(children: <Widget>[
                                  //                 Icon(
                                  //                   FontAwesomeIcons.wind,
                                  //                   color: Colors.white,
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 30,
                                  //                 ),
                                  //                 Row(
                                  //                   children: <Widget>[
                                  //                     Container(
                                  //                       child: Text(
                                  //                           sensorData[index][
                                  //                           'sensor3']
                                  //                               .toString(),
                                  //                           style: TextStyle(
                                  //                               fontSize: 14,
                                  //                               color: Colors
                                  //                                   .white70)),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ]),
                                  //               SizedBox(
                                  //                 width: 42,
                                  //               ),
                                  //               Column(children: <Widget>[
                                  //                 Icon(
                                  //                   FontAwesomeIcons
                                  //                       .cloud,
                                  //                   color: Colors.orange,
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 30,
                                  //                 ),
                                  //                 Row(
                                  //                   children: <Widget>[
                                  //                     Container(
                                  //                       child: Text(
                                  //                           sensorData[index][
                                  //                           'sensor4']
                                  //                               .toString(),
                                  //                           style: TextStyle(
                                  //                               fontSize: 14,
                                  //                               color: Colors
                                  //                                   .white70)),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ]),
                                  //
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 22,
                                  //           ),
                                  //           Text(
                                  //             sensorData[index][
                                  //             'd_id']
                                  //                 .toString(),
                                  //
                                  //           ),
                                  //         ],
                                  //       );
                                  //     } else {
                                  //       return Center(
                                  //         child: Text('Loading...'),
                                  //       );
                                  //     }
                                  //   },
                                  // ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    // centerTitle: true,
                    floating: true,
                    pinned: true,
                    backgroundColor: Colors.white,

                    title: Container(
                      // alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onLongPress: () {
                                    print('longPress');
                                    // _editRoomNameAlertDialog(context);
                                  },
                                  child: TabBar(
                                    indicatorColor: Colors.blueAccent,
                                    controller: tabC,
                                    labelColor: Colors.blueAccent,
                                    indicatorWeight: 2.0,
                                    isScrollable: true,
                                    tabs:  List.generate(roomTab.length,
                                            (index) {
                                          return Container(
                                              height: 30,
                                              child: Text(roomTab[index]['r_name']));
                                        }),
                                    onTap: (index) async {
                                      tabState = await roomTab[index]['r_id'].toString();
                                      // devicePinSensorLocalUsingDeviceId(dv[index].dId);
                                      print('tabState $tabState');
                                      getDevicesByDeviceId(tabState);
                                      dv= await SubUserDataBase.subUserInstance.getDeviceByRoomId(tabState);

                                      deviceSensorVal = devicePinSensorLocalUsingDeviceId(dv[index].dId);
                                      print('tabStateDevice ${dv[index].dId}');

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // SizedBox(height: 45,),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index <dv.length) {
                        dv.length==null? Text('loading'):dv.length==null;
                        print('asdf ${dv.length}');
                        Text(
                          "Loading",
                          style: TextStyle(fontSize: 44),
                        );

                        return Container(
                          child: Column(
                            children: [
                              subUserDeviceContainer(dv[index].dId, index),
                              Container(
                                //
                                // color: Colors.green,
                                  height: 35,
                                  child: GestureDetector(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          // text:'aa',
                                          // text:deviceSubUser[index]['d_id'],
                                            text: dv[index].dId,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black)),
                                        TextSpan(text: "   "),
                                        WidgetSpan(
                                            child: Icon(
                                              Icons.settings,
                                              size: 18,
                                            ))
                                      ]),
                                    ),
                                    onTap: () {
                                      // _createAlertDialogForSSIDAndEmergencyNumber(
                                      //     context);
                                      print('on tap');
                                    },
                                  )),
                            ],
                          ),
                          // child: Text(dv[index].dId),
                        );
                      } else {
                        return null;
                      }
                    }),
                  )
                ],
              ),
            ),
          ) ,
        );
      }
        }
      ),
    );
  }
  List<dynamic> deviceStatus = [];
  var data;
  getData(String dId) async {
    print("Vice Id $dId");
   var deviceIdForSensor = dId;
    // print('getDataFunction $deviceIdForSensor');
    getSensorData();
    final String url =
        'http://genorion1.herokuapp.com/getpostdevicePinStatus/?d_id=' + dId;
    String token = await getToken();
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      var arr = jsonDecode(response.body);
      List listOfPinStatus = [
        arr,
      ];
      print('sensorData  ${listOfPinStatus}');
      for (int i = 0; i < listOfPinStatus.length; i++) {
        var pinStatus = PinStatusSubUser(
          dId: listOfPinStatus[i]['d_id'],
          pin1Status: listOfPinStatus[i]['pin1Status'],
          pin2Status: listOfPinStatus[i]['pin2Status'],
          pin3Status: listOfPinStatus[i]['pin3Status'],
          pin4Status: listOfPinStatus[i]['pin4Status'],
          pin5Status: listOfPinStatus[i]['pin5Status'],
          pin6Status: listOfPinStatus[i]['pin6Status'],
          pin7Status: listOfPinStatus[i]['pin7Status'],
          pin8Status: listOfPinStatus[i]['pin8Status'],
          pin9Status: listOfPinStatus[i]['pin9Status'],
          pin10Status: listOfPinStatus[i]['pin10Status'],
          pin11Status: listOfPinStatus[i]['pin11Status'],
          pin12Status: listOfPinStatus[i]['pin12Status'],
          pin13Status: listOfPinStatus[i]['pin13Status'],
          pin14Status: listOfPinStatus[i]['pin14Status'],
          pin15Status: listOfPinStatus[i]['pin15Status'],
          pin16Status: listOfPinStatus[i]['pin16Status'],
          pin17Status: listOfPinStatus[i]['pin17Status'],
          pin18Status: listOfPinStatus[i]['pin18Status'],
          pin19Status: listOfPinStatus[i]['pin19Status'],
          pin20Status: listOfPinStatus[i]['pin20Status'],
        );
        await SubUserDataBase.subUserInstance.updateSubUserDevicePinStatusData(pinStatus);
        print('devicePinJson    ${pinStatus.toJson()}');
        // String a = listOfPinStatus[i]['pin20Status'].toString();
        // print('ForLoop123 ${a}');
        // int aa = int.parse(a);
        // print('double $aa');
        // // int aa=int.parse(a);
        //
        // int ms =
        // // ((DateTime.now().millisecondsSinceEpoch) / 1000).round() + 19700;
        // ((DateTime.now().millisecondsSinceEpoch) / 1000).round() - 100; // -100 for checking a difference for 100 seconds in current time
        // print('CheckMs ${ms}');
        // print('Checkaa ${aa}');
        // if (aa >= ms) {
        //   print('ifelse');
        //   statusOfDevice = 1;
        // } else {
        //   print('ifelse2');
        //   statusOfDevice = 0;
        // }
      }
      print("DATA-->  $data");
      print('\n');
      deviceStatus = [
        widget.switch1_get = data["pin1Status"],
        widget.switch2_get = data["pin2Status"],
        widget.switch3_get = data["pin3Status"],
        widget.switch4_get = data["pin4Status"],
        widget.switch5_get = data["pin5Status"],
        widget.switch6_get = data["pin6Status"],
        widget.switch7_get = data["pin7Status"],
        widget.switch8_get = data["pin8Status"],
        widget.switch9_get = data["pin9Status"],
        widget.Slider_get = data["pin10Status"],
        widget.Slider_get2 = data["pin11Status"],
        widget.Slider_get3 = data["pin12Status"],
      ];
      for (int i = 0; i < data.length; i++) {}

      print('Switch 1 --> ${widget.switch1_get}');
      print('Switch 2 --> ${widget.switch2_get}');
      print('Switch 3 --> ${widget.switch3_get}');
      print('Switch 4 --> ${widget.switch4_get}');
      print('Switch 5 --> ${widget.switch5_get}');
      print('Switch 6 --> ${widget.switch6_get}');
      print('Switch 7 --> ${widget.switch7_get}');
      print('Switch 8 --> ${widget.switch8_get}');
      print('Switch 9 --> ${widget.switch9_get}');
      print('Switch 10 --> ${widget.Slider_get}');
      print('Switch 11 --> ${widget.Slider_get2}');
      print('Switch 12 --> ${widget.Slider_get3}');
    } else {
      print(response.statusCode);
      throw Exception('Failed to getData.');
    }
    return data;
  }
  var catchReturn;
  Future devicePinSensorLocalUsingDeviceId(String dId) async {
    print('ssse $dId');
    sensorData =
    await SubUserDataBase.subUserInstance.getSensorByDeviceId(dId.toString());
    print('checkSensorData ${sensorData[0]['sensor1']}');
    if (sensorData == null) {
      return Text('No Data');
    }
    return sensorData;
  }
  Future devicePinNameLocalUsingDeviceId(String dId) async {
    print('ssse $dId');
    // await devicePinSensorLocalUsingDeviceId(dId);

    namesDataList =
    await SubUserDataBase.subUserInstance.getPinNamesByDeviceId(dId.toString());
    print('123NameList ${namesDataList}');
    if (namesDataList == null) {
      return Text('No Data');
    }
    return namesDataList;
  }
  var namesDataList12;
  deviceContainer(String dId,index)async{
    getData(dId);
    await devicePinSensorLocalUsingDeviceId(dId);
    deviceSensorVal = devicePinSensorLocalUsingDeviceId(dId);
    devicePinNameLocalUsingDeviceId(dId);
    catchReturn = await SubUserDataBase.subUserInstance.getPinStatusByDeviceId(dId);
    namesDataList12 = await SubUserDataBase.subUserInstance.getPinNamesByDeviceId(dId);
    responseDataPinStatusForSubUser=[
      widget.switch1_get = catchReturn[index]["pin1Status"],
      widget.switch2_get = catchReturn[index]["pin2Status"],
      widget.switch3_get = catchReturn[index]["pin3Status"],
      widget.switch4_get = catchReturn[index]["pin4Status"],
      widget.switch5_get = catchReturn[index]["pin5Status"],
      widget.switch6_get = catchReturn[index]["pin6Status"],
      widget.switch7_get = catchReturn[index]["pin7Status"],
      widget.switch8_get = catchReturn[index]["pin8Status"],
      widget.switch9_get = catchReturn[index]["pin9Status"],
      widget.Slider_get = catchReturn[index]["pin10Status"],
      widget.Slider_get2 = catchReturn[index]["pin11Status"],
      widget.Slider_get3 = catchReturn[index]["pin12Status"],
    ];

    print('nameDataList${namesDataList12}');
    // getSensorData(dId);
    namesDataList = [
      widget.switch1Name = namesDataList12[index]['pin1Name'].toString(),
      widget.switch2Name = namesDataList12[index]['pin2Name'].toString(),
      widget.switch3Name = namesDataList12[index]['pin3Name'].toString(),
      widget.switch4Name = namesDataList12[index]['pin4Name'].toString(),
      widget.switch5Name = namesDataList12[index]['pin5Name'].toString(),
      widget.switch6Name = namesDataList12[index]['pin6Name'].toString(),
      widget.switch7Name = namesDataList12[index]['pin7Name'].toString(),
      widget.switch8Name = namesDataList12[index]['pin8Name'].toString(),
      widget.switch9Name = namesDataList12[index]['pin9Name'].toString(),
      widget.switch10Name = namesDataList12[index]['pin10Name'].toString(),
      widget.switch11Name = namesDataList12[index]['pin11Name'].toString(),
      widget.switch12Name = namesDataList12[index]['pin12Name'].toString(),
    ];
    print('responseDataPinStatusForSubUser ${responseDataPinStatusForSubUser}');
    // namesDataList = [
    //   widget.switch1Name = namesDataList12[index]['pin1Name'].toString(),
    //   widget.switch2Name = namesDataList12[index]['pin2Name'].toString(),
    //   widget.switch3Name = namesDataList12[index]['pin3Name'].toString(),
    //   widget.switch4Name = namesDataList12[index]['pin4Name'].toString(),
    //   widget.switch5Name = namesDataList12[index]['pin5Name'].toString(),
    //   widget.switch6Name = namesDataList12[index]['pin6Name'].toString(),
    //   widget.switch7Name = namesDataList12[index]['pin7Name'].toString(),
    //   widget.switch8Name = namesDataList12[index]['pin8Name'].toString(),
    //   widget.switch9Name = namesDataList12[index]['pin9Name'].toString(),
    //   widget.switch10Name = namesDataList12[index]['pin10Name'].toString(),
    //   widget.switch11Name = namesDataList12[index]['pin11Name'].toString(),
    //   widget.switch12Name = namesDataList12[index]['pin12Name'].toString(),
    // ];
    setState(() {
      responseDataPinStatusForSubUser=[
        widget.switch1_get = catchReturn[index]["pin1Status"],
        widget.switch2_get = catchReturn[index]["pin2Status"],
        widget.switch3_get = catchReturn[index]["pin3Status"],
        widget.switch4_get = catchReturn[index]["pin4Status"],
        widget.switch5_get = catchReturn[index]["pin5Status"],
        widget.switch6_get = catchReturn[index]["pin6Status"],
        widget.switch7_get = catchReturn[index]["pin7Status"],
        widget.switch8_get = catchReturn[index]["pin8Status"],
        widget.switch9_get = catchReturn[index]["pin9Status"],
        widget.Slider_get = catchReturn[index]["pin10Status"],
        widget.Slider_get2 = catchReturn[index]["pin11Status"],
        widget.Slider_get3 = catchReturn[index]["pin12Status"],
      ];
      namesDataList = [
        widget.switch1Name = namesDataList12[index]['pin1Name'].toString(),
        widget.switch2Name = namesDataList12[index]['pin2Name'].toString(),
        widget.switch3Name = namesDataList12[index]['pin3Name'].toString(),
        widget.switch4Name = namesDataList12[index]['pin4Name'].toString(),
        widget.switch5Name = namesDataList12[index]['pin5Name'].toString(),
        widget.switch6Name = namesDataList12[index]['pin6Name'].toString(),
        widget.switch7Name = namesDataList12[index]['pin7Name'].toString(),
        widget.switch8Name = namesDataList12[index]['pin8Name'].toString(),
        widget.switch9Name = namesDataList12[index]['pin9Name'].toString(),
        widget.switch10Name = namesDataList12[index]['pin10Name'].toString(),
        widget.switch11Name = namesDataList12[index]['pin11Name'].toString(),
        widget.switch12Name = namesDataList12[index]['pin12Name'].toString(),
      ];
    });

  }

  subUserDeviceContainer(String dId,int index){
    deviceContainer(dId,index);
    return Column(
      children: [
        Container(

          height: MediaQuery.of(context).size.height * 1.75,
          color: Colors.redAccent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Turn Off All Appliances',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _switchValue ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                        color: statusOfDevice == 1 ? Colors.green : Colors.grey,
                        shape: BoxShape.circle),
                    // child: ...
                  ),
                  Switch(
                    value: responseDataPinStatusForSubUser[index] == 0 ? val2 : val1,
                    //boolean value
                    // value: val1,
                    onChanged: (val) async {
                      // _showDialog(dId);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      child: Icon(Icons.settings_remote),
                      onTap: () {
                        // _createAlertDialogForPin19(context, dId);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1.18,
                // color: Colors.amber,
                child: GridView.count(
                    crossAxisSpacing: 8,
                    childAspectRatio: 2 / 1.8,
                    mainAxisSpacing: 4,
                    physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    crossAxisCount: 2,
                    children:
                    List.generate(responseDataPinStatusForSubUser.length-3, (index) {
                      print('Something');
                      // print('catch return --> $catchReturn');

                      return Container(
                        // color: Colors.green,
                        height: 2030,
                        child: Column(
                          children: [
                            GestureDetector(
                              // onTap:Text(),
                              onLongPress: () async {
                                // _alarmTimeString =
                                //     DateFormat('HH:mm').format(DateTime.now());
                                showModalBottomSheet(
                                    useRootNavigator: true,
                                    context: context,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return Container(
                                                padding: const EdgeInsets.all(32),
                                                child: Column(children: [
                                                  // ignore: deprecated_member_use
                                                  FlatButton(
                                                    onPressed: () async {
                                                      // pickTime(index);
                                                      print("index --> $index");
                                                    },
                                                    child: Text(
                                                      '_alarmTimeString',
                                                      style:
                                                      TextStyle(fontSize: 32),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title:
                                                    Text('What Do You Want ??'),
                                                    trailing: Icon(Icons.timer),
                                                  ),
                                                  ListTile(
                                                    title: ToggleSwitch(
                                                      initialLabelIndex: 0,
                                                      labels: ['On', 'Off'],
                                                      onToggle: (index) {
                                                        print(
                                                            'switched to: $index');

                                                        setState(() {
                                                          // changeIndex(index);
                                                        });
                                                      },
                                                    ),
                                                    // trailing: Icon(Icons.arrow_forward_ios),
                                                  ),
                                                  FloatingActionButton.extended(
                                                    onPressed: () {
                                                      // pickTime(index);
                                                      Navigator.pop(context);

                                                      print('Sceduled');
                                                    },
                                                    icon: Icon(Icons.alarm),
                                                    label: Text('Save'),
                                                  ),
                                                ]));
                                          });
                                    }
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    alignment: new FractionalOffset(1.0, 0.0),
                                    // alignment: Alignment.bottomRight,
                                    height: 120,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 10),
                                    margin: index % 2 == 0
                                        ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                                        : EdgeInsets.fromLTRB(
                                        7.5, 7.5, 15, 7.5),
                                    // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              blurRadius: 10,
                                              offset: Offset(8, 10),
                                              color: Colors.black)
                                        ],
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1,
                                            style: BorderStyle.solid,
                                            color: Color(0xffa3a3a3)),
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Column(
                                      // crossAxisAlignment:
                                      // CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [

                                            Expanded(
                                              child: TextButton(
                                                child: Text(
                                                  // 'index',
                                                  '${namesDataList[index].toString()} ',
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style:
                                                  TextStyle(fontSize: 10),
                                                ),
                                                onPressed: () {
                                                  print('indexpinNames->  $index');
//                                                   setState(() {
//
//                                                     names[index] =pinNames;
//                                                     // pinNameController.text;
// // /                                                    }
//                                                   });

                                                  // _createAlertDialogForNameDeviceBox(
                                                  //     context, index);

                                                  // return addDeviceName(index);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 4.5,
                                                // vertical: 10
                                              ),
                                              child: Switch(
                                                value: responseDataPinStatusForSubUser[index] == 0 ? val2 : val1,

                                                onChanged: (val) async {

                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
              ),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height - 45,
                  // color: Colors.black,
                  // color: Colors.amber,
                  child: GridView.count(
                      crossAxisSpacing: 8,
                      childAspectRatio: 2 / 1.8,
                      mainAxisSpacing: 4,
                      physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      crossAxisCount: 2,
                      children:
                      List.generate(responseDataPinStatusForSubUser.length-9, (index) {
                        print('Slider Start');
                        // print('catch return --> $catchReturn');
                        var newIndex = index + 10;
                        return Container(
                          // color: Colors.green,
                          height: 2030,
                          child: Column(
                            children: [
                              GestureDetector(
                                // onTap:Text(),
                                onLongPress: () async {
                                  // _alarmTimeString = DateFormat('HH:mm')
                                  //     .format(DateTime.now());
                                  showModalBottomSheet(
                                      useRootNavigator: true,
                                      context: context,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24),
                                        ),
                                      ),
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setModalState) {
                                              return Container(
                                                  padding: const EdgeInsets.all(32),
                                                  child: Column(children: [
                                                    // ignore: deprecated_member_use
                                                    FlatButton(
                                                      onPressed: () async {
                                                        // pickTime(index);
                                                        // s
                                                        print("index --> $index");
                                                        // var selectedTime = await showTimePicker(
                                                        //   context: context,
                                                        //   initialTime: TimeOfDay.now(),
                                                        // );
                                                        // if (selectedTime != null) {
                                                        //   final now = DateTime.now();
                                                        //   var selectedDateTime = DateTime(
                                                        //       now.year,
                                                        //       now.month,
                                                        //       now.day,
                                                        //       selectedTime.hour,
                                                        //       selectedTime.minute);
                                                        //   _alarmTime = selectedDateTime;
                                                        //   setModalState(() {
                                                        //     _alarmTimeString =
                                                        //         DateFormat('HH:mm')
                                                        //             .format(selectedDateTime);
                                                        //   });
                                                        // }
                                                      },
                                                      child: Text(
                                                        '_alarmTimeString',
                                                        style:
                                                        TextStyle(fontSize: 32),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                          'What Do You Want ??'),
                                                      trailing: Icon(Icons.timer),
                                                    ),
                                                    ListTile(
                                                      title: ToggleSwitch(
                                                        initialLabelIndex: 0,
                                                        labels: ['On', 'Off'],
                                                        onToggle: (index) {
                                                          print(
                                                              'switched to: $index');

                                                          setState(() {
                                                            // changeIndex(index);
                                                          });
                                                        },
                                                      ),
                                                      // trailing: Icon(Icons.arrow_forward_ios),
                                                    ),
                                                    FloatingActionButton.extended(
                                                      onPressed: () {
                                                        // pickTime(index);
                                                        Navigator.pop(context);

                                                        print('Sceduled');
                                                      },
                                                      icon: Icon(Icons.alarm),
                                                      label: Text('Save'),
                                                    ),
                                                  ]));
                                            });
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      alignment: new FractionalOffset(1.0, 0.0),
                                      // alignment: Alignment.bottomRight,
                                      height: 120,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1, vertical: 10),
                                      margin: index % 2 == 0
                                          ? EdgeInsets.fromLTRB(
                                          15, 7.5, 7.5, 7.5)
                                          : EdgeInsets.fromLTRB(
                                          7.5, 7.5, 15, 7.5),
                                      // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                                      decoration: BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                blurRadius: 10,
                                                offset: Offset(8, 10),
                                                color: Colors.black)
                                          ],
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Color(0xffa3a3a3)),
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 109,
                                                child: Slider(
                                                  // value: 5.0,
                                                  value: double.parse(
                                                      responseDataPinStatusForSubUser[
                                                      newIndex - 2]
                                                          .toString()),
                                                  min: 0,
                                                  max: 10,
                                                  divisions: 500,
                                                  activeColor: Colors.blue,
                                                  inactiveColor: Colors.black,
                                                  label:
                                                  '${double.parse(responseDataPinStatusForSubUser[newIndex - 1].toString())}',
                                                  onChanged:
                                                      (double newValue) async {
                                                    print(
                                                        'index of data $index --> ${responseDataPinStatusForSubUser[newIndex - 1]}');
                                                    print(
                                                        'index of $index --> ${newIndex - 1}');

                                                    setState(() {
                                                      // if (responseGetData[newIndex-1] != null) {
                                                      //   responseGetData[newIndex-1] = widget.Slider_get.round();
                                                      // }

                                                      print(
                                                          "Round-->  ${newValue.round()}");
                                                      var roundVar =
                                                      newValue.round();
                                                      print(
                                                          "Round 2-->  $roundVar");
                                                      responseDataPinStatusForSubUser[newIndex -
                                                          1] = roundVar;
                                                      print(
                                                          "Response Round-->  ${responseDataPinStatusForSubUser[newIndex - 1]}");
                                                    });

                                                    // if Internet is not available then _checkInternetConnectivity = true
                                                    // var result =
                                                    // await Connectivity()
                                                    //     .checkConnectivity();
                                                    // if (result ==
                                                    //     ConnectivityResult
                                                    //         .wifi) {
                                                    //   print(
                                                    //       "True2-->   $result");
                                                    //   await localUpdate(dId);
                                                    //   await dataUpdate(dId);
                                                    // } else if (result ==
                                                    //     ConnectivityResult
                                                    //         .mobile) {
                                                    //   print(
                                                    //       "mobile-->   $result");
                                                    //   // await localUpdate(d_id);
                                                    //   await dataUpdate(dId);
                                                    // } else {
                                                    //   messageSms(context, dId);
                                                    // }
                                                  },
                                                  // semanticFormatterCallback: (double newValue) {
                                                  //   return '${newValue.round()}';
                                                  // }
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: TextButton(
                                              child: Text(
                                                // 'ss',
                                                '${namesDataList[index + 9].toString()} ',
                                                // '${namesDataList[index].toString()} ',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              onPressed: () {
                                                // _createAlertDialogForNameDeviceBox(
                                                //     context, index);

                                                // return addDeviceName(index);
                                              },
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future getDevicesByDeviceId(String rId)async{
    // deviceSubUser= await SubUserDataBase.subUserInstance.getDeviceByRoomId(rId);
    dv= await SubUserDataBase.subUserInstance.getDeviceByRoomId(rId);
    return dv;
  }







}
