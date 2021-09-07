import 'dart:convert';
import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:loginsignspaceorion/ModelsForSubUser/allmodels.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/SQLITE_database/localDatabaseForSubUser/subuserSqlite.dart';
import 'package:loginsignspaceorion/Setting_Page.dart';
import 'package:loginsignspaceorion/SubAccessPage/subaccesslist.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/schedulePin/schedulPin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../ProfilePage.dart';
import '../dropdown1.dart';
import '../dropdown2.dart';
import '../main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import '../utility.dart';

void main() =>
    runApp(MaterialApp(
      home: SubAccessSinglePage(),
    ));

class SubAccessSinglePage extends StatefulWidget {
  List<SubUserRoomType> rmSubUser;
  SubUserPlaceType ptSubUser;
  SubUserFloorType flSubUser;
  SubUserFlatType flatSubUser;


  SubAccessSinglePage(
      {Key key, this.flSubUser, this.rmSubUser, this.ptSubUser, this.flatSubUser})
      : super(key: key);

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
  List allPlaceData;
  var placeId;
  List roomTab;
  Future futureSubUser;
  String token = "774945db6cd2eec12fe92227ab9b811c888227c6";
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
  SubUserFloorType fl;
  SubUserFlatType flat;
  SubUserPlaceType pt;
  Future floorval;
  List allSubUserOwnerName = [];
  Future flatVal;
  var mainUserEmail;
  var flatId;

  get index => null;
  List<SubUserRoomType> room;
  List namesDataList;

  List userData;
  bool val2 = false;
  bool val1 = true;
  DateTime pickedDate;
  TimeOfDay time;
  TimeOfDay time23;
  @override
  void initState() {
    super.initState();
    getSubUsers();
    placeQueryFuncSend();
    lengthRoomTab();

    loadImageFromPreferences();

    pickedDate= DateTime.now();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   placeQueryFuncSend();
  // }


  lengthRoomTab() async {
    // roomTab=await SubUserDataBase.subUserInstance.queryRoomSubUser();
    userData = await NewDbProvider.instance.userQuery();
    mainUserEmail = userData[0]['email'].toString();
    print('mainUserEmail $mainUserEmail');
    allPlaceId = await NewDbProvider.instance.querySubUser();
    placeRows = await SubUserDataBase.subUserInstance.queryPlaceSubUser();
    print('allSubUserOwnerName ${allSubUserOwnerName}');
    print('allSubUserOwnerName ${allPlaceData}');
    getFloorData = await SubUserDataBase.subUserInstance.queryFloorSubUser();
    getFlatData = await SubUserDataBase.subUserInstance.queryFlatSubUser();

    print('roomTab ${roomTab}');
  }


  Future<void> getSubUsers() async {
    String token = await getToken();
    // await openSubUserBox();
    final url = API+'subfindsubdata/?email=gakash8860@gmail.com';
    // final url ='http://genorion1.herokuapp.com/subfindsubdata/?email='+mainUserEmail.toString();
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      // await subUserBox.clear();
      List subUserDecode = jsonDecode(response.body);
      if (allPlaceId.length == subUserDecode.length) {
        for (int i = 0; i < subUserDecode.length; i++) {
          var data = SubAccessPage(
            email: subUserDecode[i]['email'].toString(),
            ownerName: subUserDecode[i]['owner_name'].toString(),
            pId: subUserDecode[i]['p_id'],
            name: subUserDecode[i]['name'].toString(),
            user: subUserDecode[i]['user'],
          );
          await NewDbProvider.instance.updateSubUserModelData(data);
        }
      } else {
        await NewDbProvider.instance.deleteSubUserModelData();
        for (int i = 0; i < subUserDecode.length; i++) {
          var data = SubAccessPage(
            email: subUserDecode[i]['email'].toString(),
            ownerName: subUserDecode[i]['owner_name'].toString(),
            pId: subUserDecode[i]['p_id'],
            name: subUserDecode[i]['name'].toString(),
            user: subUserDecode[i]['user'],
          );
          await NewDbProvider.instance.insertSubUserModelData(data);
        }
      }
      allPlaceId = await NewDbProvider.instance.querySubUser();
      getPlaceName();
      print('tempResponse ${subUserDecode}');
      print('subUserDecode ${allPlaceId}');
      setState(() {
        subUserDecodeList = subUserDecode;
        placeId = subUserDecodeList[0]['p_id'].toString();
      });
      print('subUserDecode ${placeId}');
      print('Number1123->  ${subUserDecodeList}');
    } catch (e) {
      // print('Status Exception $e');

    }

  }


  Future placeQueryFuncSend() async {
    placeRows = await SubUserDataBase.subUserInstance.queryPlaceSubUser();
    print('queryPlaceSubUser ${placeRows}');
    var pids = SubUserPlaceType(
        pId: placeRows[0]['p_id'].toString(),
        pType: placeRows[0]['p_type'].toString(),
        user: placeRows[0]['user']
    );

      setState(() {
        pt = pids;
      });
    print('aaadfdfknd ${pt.pType}');

   await floorQueryFunc();
  }

  List resultFloor;

  Future floorQueryFunc() async {
    floorQueryRows = await SubUserDataBase.subUserInstance.queryFloorSubUser();
    floorQueryData = floorQueryRows;
    var pId = placeRows[0]['p_id'].toString();
    print('placeId $pId');
    resultFloor = await SubUserDataBase.subUserInstance.getFloorById(pId);
    print(' checkResult123456 ${resultFloor.first}');
    var floor = SubUserFloorType(
        fId: resultFloor[0]['f_id'].toString(),
        fName: resultFloor[0]['f_name'].toString(),
        user: resultFloor[0]['user'],
        pId: resultFloor[0]['p_id'].toString()
    );
    fl = floor;

    // floors=floorQueryRows;
    print('floorLocalData ${fl.fName}');

    await flatQueryFunc();
  }

  List resultFlat;

  Future flatQueryFunc() async {
    flatQueryRows2 = await SubUserDataBase.subUserInstance.queryFlatSubUser();
    print("Query $flatQueryRows2");


    floorTypeSingle = floorQueryRows;
    var fId = resultFloor[0]['f_id'].toString();
    print(fId);
    resultFlat =
    await SubUserDataBase.subUserInstance.getFlatById(fId.toString());
    print('checkFlat123SubUser  ${resultFlat}');
    var flat12 = SubUserFlatType(
        fId: resultFlat[0]['f_id'].toString(),
        fltName: resultFlat[0]['flt_name'].toString(),
        fltId: resultFlat[0]['flt_id'].toString(),
        user: resultFlat[0]['user']
    );
    flat = flat12;

    await roomQueryFunc();
  }

  List resultRoom;
  List<SubUserRoomType> room123;

  Future<List<SubUserRoomType>> roomQueryFunc() async {
    roomQueryRows = await SubUserDataBase.subUserInstance.queryRoomSubUser();
    print('qqqq ${roomQueryRows}');
    var id = resultFlat[0]['flt_id'].toString();
    resultRoom = await SubUserDataBase.subUserInstance.getRoomById(id);
    print('roomResult $resultRoom');
    room123 = List.generate(resultRoom.length, (index) =>
        SubUserRoomType(
          rId: resultRoom[index]['r_id'].toString(),
          fltId: resultRoom[index]['flt_id'].toString(),
          rName: resultRoom[index]['r_name'].toString(),
          user: resultRoom[index]['user'],
        ));
    setState(() {
      room=room123;
    });
    await deviceQueryFunc();
    return room;
  }

  deviceQueryFunc() async {
    deviceQueryRows =
    await SubUserDataBase.subUserInstance.queryDeviceSubUser();
    print('maindeviceQuery $deviceQueryRows');
    var roomId = resultRoom[0]['r_id'];
    // dv=deviceQueryRows;
    List deviceResult = await SubUserDataBase.subUserInstance.getDeviceByRId(
        roomId.toString());
    print('dvlouye ${deviceResult}');
    dv = List.generate(deviceResult.length, (index) =>
        SubUserDeviceType(
            dId: deviceResult[index]['d_id'].toString(),
            rId: deviceResult[index]['r_id'].toString(),
            user: deviceResult[index]['user']
        ));
  }

  List placeData;
  Future getPlaceName() async {
    for (int i = 0; i < allPlaceId.length; i++) {
      print('lengthof ${allPlaceId.length}');
      var pId = allPlaceId[i]['p_id'].toString();
      print('placeId $pId');
      final url =
          API+'getyouplacename/?p_id=' +
              pId.toString();
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print("GetPlaceName  ${response.statusCode}");
        print("GetPlaceNameResponseBody  ${response.body}");

         placeData = jsonDecode(response.body);
        // placeName = placeData[0]["p_type"];
        for (int i = 0; i < placeData.length; i++) {
          var placeQuery = SubUserPlaceType(
            pId: placeData[i]['p_id'],
            pType: placeData[i]['p_type'].toString(),
            user: placeData[i]['user'],
          );
          print('PlaceQuery ${placeData}');
           SubUserDataBase.subUserInstance.insertPlaceModelData(placeQuery);
        }
        placeRows = await SubUserDataBase.subUserInstance.queryPlaceSubUser();
        getAllFloorForSubUser();
      }
    }

  }

  Future getAllFloorForSubUser() async {
    var placeId;
    for (int i = 0; i < placeRows.length; i++) {
      placeId = placeRows[i]['p_id'].toString();
      final url = API+'getallfloorsbyonlyplaceidp_id/?p_id=' + placeId;

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
          for (int i = 0; i < floorData.length; i++) {
            var floorQueryForSubUser = SubUserFloorType(
                fId: floorData[i]['f_id'],
                fName: floorData[i]['f_name'].toString(),
                pId: floorData[i]['p_id'],
                user: floorData[i]['user']
            );
            await SubUserDataBase.subUserInstance.insertSubUserFloorModelData(
                floorQueryForSubUser);
          }
          getFloorData =
          await SubUserDataBase.subUserInstance.queryFloorSubUser();
        }
        print('getALlFloorData ${getFloorData}');
      }
    }

    getAllFlatForSubUser();
  }

  Future getAllFlatForSubUser() async {
    for (int i = 0; i < getFloorData.length; i++) {
      var fId = getFloorData[i]['f_id'].toString();

      final url =
          API+'getallflatbyonlyflooridf_id/?f_id=' +
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
          List listFlatData = jsonDecode(response.body);
          print('flatSubUser ${listFlatData}');
          // flatId = listFlatData[0]['flt_id'];
          // flatName = listFlatData[0]['flt_name'];
          print('flatSubUser ${listFlatData}');
          for (int i = 0; i < listFlatData.length; i++) {
            var flatQueryForSubUser = SubUserFlatType(
                fId: listFlatData[i]['f_id'],
                fltId: listFlatData[i]['flt_id'],
                fltName: listFlatData[i]['flt_name'],
                user: listFlatData[i]['user']
            );
            await SubUserDataBase.subUserInstance.insertSubUserFlatModelData(
                flatQueryForSubUser);
          }
          getFlatData =
          await SubUserDataBase.subUserInstance.queryFlatSubUser();
        }
      }
    }
    getAllRoomForSubUser();
  }

  Future getAllRoomForSubUser() async {
    for (int i = 0; i < getFlatData.length; i++) {
      var flatId = getFlatData[i]['flt_id'].toString();
      final url = API+'getallroomsbyonlyflooridf_id/?flt_id=' + flatId;
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
          print('responseRoomUser${roomTab}');
          // rm=roomTab.map((data) => SubUserRoomType.fromJson(data));
          // tabState=roomTab[0]['r_id'];
          for (int i = 0; i < roomTab.length; i++) {
            var roomQuery = SubUserRoomType(
                rId: roomTab[i]['r_id'],
                rName: roomTab[i]['r_name'].toString(),
                fltId: roomTab[i]['flt_id'],
                user: roomTab[i]['user']
            );
            await SubUserDataBase.subUserInstance.insertSubUserRoomModelData(
                roomQuery);
          }
          roomTab = await SubUserDataBase.subUserInstance.queryRoomSubUser();
          print('RoomSubUser ${response.body}');
        }
        await getAllDeviceForSubUser();
      }
    }
  }

  Future getAllDeviceForSubUser() async {
    for (int i = 0; i < roomTab.length; i++) {
      var rId = roomTab[i]['r_id'].toString();
      // print('tabbar1 ${tabState}');
      final url = API+'getalldevicesbyonlyroomidr_id/?r_id=' + rId;
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
          for (int i = 0; i < deviceSubUser.length; i++) {
            var deviceQuerySubUser = SubUserDeviceType(
                user: deviceSubUser[i]['user'],
                rId: deviceSubUser[i]['r_id'],
                dId: deviceSubUser[i]['d_id']
            );
            await SubUserDataBase.subUserInstance.insertSubUserDeviceModelData(
                deviceQuerySubUser);
          }

          // dv = deviceSubUser.map((data) => SubUserDeviceType.fromJson(data))
          //     .toList();
          // print('deviceId ${widget.dv[index].dId}');

        }
        deviceQueryRows =
        await SubUserDataBase.subUserInstance.queryDeviceSubUser();
      }
      getPinStatusData();
    }
  }

  Future<void> getPinStatusData() async {
    var dId;
    print('PinStatusFunction $deviceQueryRows');
    for (int i = 0; i < deviceQueryRows.length; i++) {
      dId = deviceQueryRows[i]['d_id'].toString();
      print('insideLoop $dId');
      String url = API+"getpostdevicePinStatus/?d_id=" + dId.toString();
      final response = await http.get(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $token',
          });

      if (response.statusCode == 200) {
        print('PinStatusResponse  ${response.statusCode}');
        var pinStatus = jsonDecode(response.body);
        // var pinStatus2=pinStatus;
        List listOfPinStatusValue = [pinStatus,];
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
          await SubUserDataBase.subUserInstance
              .insertSubUserDevicePinStatusData(pinQuery);
          // await SubUserDataBase.subUserInstance.updatePinStatusData(pinQuery);
          var check = await SubUserDataBase.subUserInstance
              .queryDevicePinStatusSubUser();
          print('checkData${check}');
        }
        getAllPinNames();

        String a=listOfPinStatusValue[i]['pin20Status'].toString();
        print('aaaaaaaaaa ${a}');
          int aa= int.parse(a);
        print('double $aa');
        // int aa=int.parse(a);

        int ms = ((DateTime.now().millisecondsSinceEpoch)/1000).round() + 19700;
        if (aa.compareTo(ms) > 0) {
          print('ifelse');
          statusOfDevice = 1;
        } else {
          print('ifelse2');
          statusOfDevice = 0;
        }
      }
    }
  }

  Future<void> getAllPinNames() async {
    String token = await getToken();
    var did;
    print('pinNamesFunction $deviceQueryRows');
    for (int i = 0; i < deviceQueryRows.length; i++) {
      did = deviceQueryRows[i]['d_id'].toString();
      print('diddevice $did');
      String url = API+"editpinnames/?d_id=" + did;
      // try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if (response.statusCode == 200) {
        var devicePinNamesData = json.decode(response.body);
        List listOfPinNames = [devicePinNamesData,];
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
          await SubUserDataBase.subUserInstance.insertSubUserDevicePinNames(
              devicePinNamesQuery);
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
    for (int i = 0; i < deviceQueryRows.length; i++) {
      did = deviceQueryRows[i]['d_id'].toString();
      print('insideLoop $did');
      String url = API+"tensensorsdata/?d_id=" +
          did.toString();
      final response = await http.get(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $token',
          });
      if (response.statusCode == 200) {
        print('sensorResponse  ${response.statusCode}');
      }
      var arr = jsonDecode(response.body);
      List listOfPinSensor = [arr,];
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

  SharedPreferences preferences;

  loadImageFromPreferences() async {
    preferences = await SharedPreferences.getInstance();
    final _imageKeyValue = preferences.getString(IMAGE_KEY);
    if (_imageKeyValue != null) {
      final imageString = await Utility.getImagefrompreference();
      setState(() {
        setImage = Utility.imageFrom64BaseString(imageString);
      });
    }
  }

  Image setImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            if (viewportConstraints.maxWidth > 600) {
              return Container();
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: GestureDetector(
                    child: Text(pt.pType.toString()),
                    onTap: () async {
                      _createAlertDialogDropDown(context);
                    },
                  ),
                  backgroundColor: Colors.blueAccent,
                  actions: [

                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: CircularProfileAvatar(
                        '',
                        child: setImage == null
                            ? Image.asset('assets/images/blank.png')
                            : setImage,
                        radius: 27.5,
                        elevation: 5,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePage(
                                      ))).then((value) =>
                              loadImageFromPreferences());
                        },
                        cacheImage: true,
                      ),
                    ),
                  ],
                ),
                // drawer: Theme(
                //   data: Theme.of(context).copyWith(
                //     canvasColor: change_toDark ? Colors.black : Colors
                //         .white, //This will change the drawer background to blue.
                //     //other styles
                //   ),
                //   child: Drawer(
                //     child: Container(
                //       width: double.maxFinite,
                //       color: change_toDark ? Colors.black : Colors.white,
                //       height: 100,
                //       child: ListView(
                //         children: <Widget>[
                //           Container(
                //             width: double.infinity,
                //             //padding: const EdgeInsets.all(20),
                //             decoration: BoxDecoration(
                //                 gradient: LinearGradient(
                //                     begin: Alignment.topCenter,
                //                     end: Alignment.bottomCenter,
                //                     colors: [
                //                       Color(0xff669df4),
                //                       Color(0xff4e80f3)
                //                     ]),
                //                 borderRadius: BorderRadius.only(
                //                   bottomRight: Radius.circular(30),
                //                   bottomLeft: Radius.circular(30),
                //                 )),
                //             child: Center(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: <Widget>[
                //                   Container(
                //                     margin: EdgeInsets.only(
                //                         top: 10, bottom: 10),
                //                   ),
                //                   CircularProfileAvatar(
                //                     '',
                //                     child: setImage == null
                //                         ? Image.asset('assets/images/blank.png')
                //                         : setImage,
                //                     radius: 60,
                //                     elevation: 5,
                //                     onTap: () {
                //                       Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                               builder: (context) =>
                //                                   ProfilePage(
                //                                     // fl: widget.fl,
                //                                   )));
                //                     },
                //                     cacheImage: true,
                //                   ),
                //                   SizedBox(
                //                     height: 8,
                //                   ),
                //                   Text('Hello  ', style: TextStyle(
                //
                //                     // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                //                       fontSize: 20,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white
                //                   ),),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           ListTile(
                //             leading: Icon(Icons.schedule),
                //             title: Text(
                //               'Schedule Pin',
                //               style: TextStyle(
                //                 color: change_toDark ? Colors.white : Colors
                //                     .black,
                //               ),
                //             ),
                //             onTap: () {
                //               Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduledPin()));
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                body: Container(
                  width: double.maxFinite,
                  child: DefaultTabController(
                    length: room.length,
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
                                                  child: GestureDetector(
                                                    child: Row(
                                                      children: [
                                                        Text('Floor -',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 22,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontStyle: FontStyle
                                                                  .italic),),
                                                        Text(
                                                          fl.fName.toString(),
                                                          // getFloorData[0]['f_name'].toString(),
                                                          // 'Hello ',
                                                          // + widget.fl.user.first_name,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
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
                                                  ),
                                                  onTap: () {
                                                    _createAlertDialogDropDown(
                                                        context);
                                                  },
                                                ),
                                                SizedBox(width: 10,),
                                                // GestureDetector(
                                                //   child: Icon(Icons.add),
                                                //   onTap: () async {
                                                //
                                                //     // _createAlertDialogForFloor(context);
                                                //   },
                                                // )
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
                                                            flat.fltName
                                                                .toString(),
                                                            // getFlatData[0]['flt_name'].toString(),
                                                            // 'Hello ',
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
                                                        _createAlertDialogDropDown(
                                                            context);
                                                      },
                                                    ),
                                                    SizedBox(width: 35),
                                                    // GestureDetector(
                                                    //     onTap: () async {
                                                    //
                                                    //     },
                                                    //     child: Icon(Icons.add)),
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
                                        FutureBuilder(
                                          future: deviceSensorVal,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Sensors- ',
                                                        style: TextStyle(

                                                          // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Colors.white
                                                        ),),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Column(children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons.fire,
                                                          color: Colors.yellow,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  sensorData[0]['sensor1']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors
                                                                          .white70)),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                      SizedBox(
                                                        width: 35,
                                                      ),
                                                      Column(children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .temperatureLow,
                                                          color: Colors.orange,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  sensorData[0][
                                                                  'sensor2']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors
                                                                          .white70)),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                      SizedBox(
                                                        width: 45,
                                                      ),
                                                      Column(children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons.wind,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  sensorData[0][
                                                                  'sensor3']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors
                                                                          .white70)),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                      SizedBox(
                                                        width: 42,
                                                      ),
                                                      Column(children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .cloud,
                                                          color: Colors.orange,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  sensorData[0][
                                                                  'sensor4']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors
                                                                          .white70)),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),

                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 22,
                                                  ),
                                                  Text(
                                                    sensorData[0]['d_id'].toString(),
                                                    style: TextStyle(color: Colors.white70),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Center(
                                                child: Text('Loading...'),
                                              );
                                            }
                                          },
                                        ),
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
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 30,
                                          child: Text(
                                            'Rooms->', style: TextStyle(

                                            // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                                              fontSize: 14,
                                              fontWeight: FontWeight
                                                  .bold,
                                              color: Colors
                                                  .black
                                          ),)),
                                      TabBar(
                                        indicatorColor: Colors.blueAccent,
                                        controller: tabC,
                                        labelColor: Colors.blueAccent,
                                        indicatorWeight: 2.0,
                                        isScrollable: true,
                                        tabs: room.map<Widget>((
                                            SubUserRoomType rm) {
                                          return Tab(
                                            text: rm.rName,
                                          );
                                        }).toList(),
                                        onTap: (index) async {
                                          tabState =
                                          await room[index].rId.toString();

                                          setState(() {
                                            getDevicesByDeviceId(tabState);
                                          });




                                          // deviceSensorVal = devicePinSensorLocalUsingDeviceId(dv[index].dId);
                                          // print('tabStateDevice ${dv[index].dId}');

                                        },
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context,
                              index) {
                            print('asdfirst ${dv.length}');
                            if (index < dv.length) {
                              dv.length == null ? Text('loading') : dv.length ==
                                  null;
                              print('asdf ${dv.length}');
                              Text(
                                "Loading",
                                style: TextStyle(fontSize: 44),
                              );

                              return Container(
                                child: Column(
                                  children: [
                                    subUserDeviceContainer(
                                        dv[index].dId, index),
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
                              );
                            } else {
                              return null;
                            }
                          }),
                        )
                      ],
                    ),
                  ),
                ),
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

    // print('getDataFunction $deviceIdForSensor');
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
        await SubUserDataBase.subUserInstance.updateSubUserDevicePinStatusData(
            pinStatus);
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

  deviceContainer(String dId, index) async {
    allPlaceData =
    await SubUserDataBase.subUserInstance.allPlaceModelData();
    print('allPlaceData  ${allPlaceData}');

    getData(dId);
    // await devicePinSensorLocalUsingDeviceId(dId);
    // setState(() {
    //   deviceSensorVal = devicePinSensorLocalUsingDeviceId(dId);
    // });
    // devicePinNameLocalUsingDeviceId(dId);
    catchReturn =
    await SubUserDataBase.subUserInstance.getPinStatusByDeviceId(dId);
    print('checkCatchReturn ${catchReturn}');
    namesDataList12 =
    await SubUserDataBase.subUserInstance.getPinNamesByDeviceId(dId);
    print('namesDataList12 ${namesDataList12}');
    responseDataPinStatusForSubUser = [
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
    setState(() {
      responseDataPinStatusForSubUser = [
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

  dataUpdate(String dId) async {
    final String url =
        'http://genorion1.herokuapp.com/getpostdevicePinStatus/?d_id=' + dId;
    String token = await getToken();
    Map data = {
      'put': 'yes',
      "d_id": dId,
      'pin1Status': responseDataPinStatusForSubUser[0],
      'pin2Status': responseDataPinStatusForSubUser[1],
      'pin3Status': responseDataPinStatusForSubUser[2],
      'pin4Status': responseDataPinStatusForSubUser[3],
      'pin5Status': responseDataPinStatusForSubUser[4],
      'pin6Status': responseDataPinStatusForSubUser[5],
      'pin7Status': responseDataPinStatusForSubUser[6],
      'pin8Status': responseDataPinStatusForSubUser[7],
      'pin9Status': responseDataPinStatusForSubUser[8],
      'pin10Status': responseDataPinStatusForSubUser[9],
      'pin11Status': responseDataPinStatusForSubUser[10],
      'pin12Status': responseDataPinStatusForSubUser[11],
      // 'pin13Status': m,
      // 'pin14Status': n,
      // 'pin15Status': o,
      // 'pin16Status': p,
      // 'pin17Status': q,
      // 'pin18Status': r,
      // 'pin19Status': s,
    };
    http.Response response =
    await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 201) {
      print("Data Updated  ${response.body}");
      // print(switch_1);
      // print(switch_2);


    await getData(dId);
      //jsonDecode only for get method
      //return place_type.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update data');
    }
  }

  var localResponse;
  var getVariable;
  var rIdForName;
  int counter = 0;

  getIp() async {
    print('no');
    while (counter <= dv.length - 1) {
      print('yes');
      final url = 'http://genorion1.herokuapp.com/addipaddress/?d_id=' +
          dv[counter].dId.toString();
      String token = await getToken();
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print('Status test--> ${response.statusCode}');
        getVariable = jsonDecode(response.body);

//      to update the list of Ip Address of each Device

        print("getIpVariable-->  $getVariable");
        // print("getIpVariable-->  ${getIpVariable}");
      }
      counter++;
    }

    counter = 0;
  }

  IpAddress ip12;
  var ip;
  List namesDataLocal;
  allPinNames(String dId)async{

    namesDataLocal =await  SubUserDataBase.subUserInstance.getPinNamesByDeviceId(dId);

    print('names123654 ${namesDataLocal[0]['pin1Name']}');
  }
  // ignore: missing_return
  Future<IpAddress> fetchIp(String dId) async {
    while (counter <= dv.length) {
      String token = await getToken();
      final url = 'http://genorion1.herokuapp.com/addipaddress/?d_id=' + dId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      if (response.statusCode == 200) {
        ip = IpAddress
            .fromJson(jsonDecode(response.body))
            .ipaddress;
        print('IPCheck  ${ip.toString()}');
      }
      counter++;
    }
    counter = 0;
  }

  localUpdate(String dId) async {
    localResponse = http.get(Uri.parse('http://' +
        ip +
        '/d_id:' +
        dId +
        ':' +
        (responseDataPinStatusForSubUser[0]).toString() +
        (responseDataPinStatusForSubUser[1]).toString() +
        (responseDataPinStatusForSubUser[2]).toString() +
        (responseDataPinStatusForSubUser[3]).toString() +
        (responseDataPinStatusForSubUser[4]).toString() +
        (responseDataPinStatusForSubUser[5]).toString() +
        (responseDataPinStatusForSubUser[6]).toString() +
        (responseDataPinStatusForSubUser[7]).toString() +
        (responseDataPinStatusForSubUser[8]).toString() +
        (responseDataPinStatusForSubUser[9]).toString() +
        (responseDataPinStatusForSubUser[10]).toString() +
        (responseDataPinStatusForSubUser[11]).toString()));
    if (localResponse == 200) {
      print("Successfully Updated");
      print(localResponse);
    } else {
      print("Res12  $localResponse");
      print("Device not Available at LocalHost");
    }
  }

  var recipents = "9911757588";
  var message = "d_id:";
  var messageIOS = "This_is%20time";

  void messageSms(BuildContext context, String dId) {
    if (Platform.isAndroid) {
      launch("sms:" +
          recipents +
          "?body=" +
          message +
          dId +
          ":" +
          responseDataPinStatusForSubUser[0].toString() +
          responseDataPinStatusForSubUser[1].toString() +
          responseDataPinStatusForSubUser[2].toString() +
          responseDataPinStatusForSubUser[3].toString() +
          responseDataPinStatusForSubUser[4].toString() +
          responseDataPinStatusForSubUser[5].toString() +
          responseDataPinStatusForSubUser[6].toString() +
          responseDataPinStatusForSubUser[7].toString() +
          responseDataPinStatusForSubUser[8].toString() +
          responseDataPinStatusForSubUser[9].toString() +
          responseDataPinStatusForSubUser[10].toString() +
          responseDataPinStatusForSubUser[11].toString() +
          ":");
    } else if (Platform.isIOS) {
      launch("sms:" + recipents + "&body=" + messageIOS);
    }
  }

  _createAlertDialogForlocalUpdateAndMessage(BuildContext context, String dId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  'Your Internet Connection is not working... ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Are you Connected On ?? ',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            content: Container(
              // height: MediaQuery
              //     .of(context)
              //     .size
              //     .height - 120,
              child: Column(
                children: [
                  TextButton(
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 54,),
                        Text(
                          'Local Update',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      localUpdate(dId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowSubUser()));
                    },
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 54,),
                        Text(
                          'Message',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      messageSms(context, dId);
                      // _showDialogForDeleteRoomWithAllDevices(rId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowTempUser()));
                    },
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 54,),
                        Text(
                          'Edit Floor Name',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  String textSelected = "";
  String _alarmTimeString;
  var cutDate;
  String _dateString = "";

  pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
    String date2 = pickedDate.toString();
    setState(() {
      cutDate = date2.substring(0, 10);
    });

    print('pickedDate ${date2}');
    print('pickedDate ${cutDate}');
  }

  TimeOfDay pickedTime;
  var cutTime;
  pickTime(index) async {
    time23 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(data: ThemeData(), child: child);
        });
    // print(time23);
    String time12;
    if (time23 != null) {
      setState(() {
        time = time23;
        print('Time ${time}');

      });
      time12=time.toString();
      cutTime=time12.substring(10,15);
      print('cutTime ${cutTime}');
    }
  }
  int checkSwitch;
  int sliderValue;
  Future schedulingDevicePin(String dId, index) async {
    final url = 'http://genorion1.herokuapp.com/schedulingpinsalltheway/';
    String token = await getToken();
    var postData;
    if (index == 0) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate.toString(),
        "timing1": cutTime.toString(),
        "pin1Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 1) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate.toString(),
        "timing1": _alarmTimeString.toString(),
        "pin2Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 2) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate.toString(),
        "timing1": _alarmTimeString,
        "pin2Status": checkSwitch,
        "d_id": dId.toString(),
      };
    } else if (index == 3) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin4Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 4) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin5Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 5) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin6Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 6) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin7Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 7) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin8Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 8) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin9Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 9) {
      postData = {

        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin10Status": sliderValue,
        "d_id": dId,
      };
    } else if (index == 10) {
      postData = {

        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin11Status": sliderValue,
        "d_id": dId,
      };
    }else if (index == 11) {
      postData = {

        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin12Status": sliderValue,
        "d_id": dId,
      };
    }
    final response = await http.post(url, body: jsonEncode(postData), headers: {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print("SchedulingStatus ${response.statusCode}");
      print("SchedulingStatus ${response.body}");
    }
  }
  _showDialog(String dId) {
    // dialog implementation
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Alert"),
            content: Text("Would to like to turn off all the appliances ?"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    for (int i = 0; i < responseDataPinStatusForSubUser.length; i++) {
                      setState(() {
                        // responseGetData[newIndex - 1]=0 ;
                        if (responseDataPinStatusForSubUser[i] > 0) {
                          responseDataPinStatusForSubUser[i] = 0;
                          print('AllChange ${responseDataPinStatusForSubUser.toString()}');
                        }

                      });

                    }
                    await dataUpdate(dId);


                    var result = await Connectivity().checkConnectivity();
                    if (result == ConnectivityResult.wifi) {
                      print("True2-->   $result");
                      // await localUpdate(dId);
                      await dataUpdate(dId);
                    } else if (result == ConnectivityResult.mobile) {
                      await dataUpdate(dId);
                      await NewDbProvider.instance.getPinStatusByDeviceId(dId);
                    } else {
                      messageSms(context, dId);
                    }

                    Navigator.of(context).pop();
                  }),
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
    );
  }

  Box scheduledPinBox2;
  Future openSchedulePinBox()async{

    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    scheduledPinBox2=await Hive.openBox('scheduledPinStatusByDeviceId');
    print('tempUserBox  ${scheduledPinBox2.values.toString()}');
    return;
  }

  var pinDecode;
  List listOfScheduledPins=[];
  Future getScheduledPins(String dId)async{
    await openSchedulePinBox();
    String token = await getToken();
    // String token = "be43f6166fce6faef0525c610402b332debdb232";
    final url=API+'scheduledatagetbyid/?d_id='+dId;
    try{
      final response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      });
      await scheduledPinBox2.clear();
      if(response.statusCode>0){
        print('ScheduledPins  ${response.statusCode}');
        print('ScheduledPins  ${response.body}');
        if(response.statusCode==200){
          pinDecode = jsonDecode(response.body);
          setState(() {
            listOfScheduledPins = pinDecode;

            putScheduledPins(listOfScheduledPins);
          });
        }
      }
    }catch(e){

    }
    var myMap=scheduledPinBox2.toMap().values.toList();
    if(myMap.isEmpty){
      scheduledPinBox2.add('empty');

    }else{
      setState(() {
        listOfScheduledPins=myMap ;
      });


    }


  }
  Future putScheduledPins(data)async{
    await scheduledPinBox2.clear();
    for(var d in data){

      scheduledPinBox2.add(d);
    }

  }
  String on="On";
  String off="Off";
  _createAlertDialogForPinSchedule(BuildContext context, String dId) {
    return showDialog(

        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Device Id ${dId}'),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child:FutureBuilder(
                  future: getScheduledPins(dId),
                  builder: ( context,  snapshot){
                    print('snapShot ${snapshot.connectionState}');
                    if(snapshot.connectionState ==ConnectionState.done){
                      if(listOfScheduledPins==null){
                        return Column(
                          children: [
                            SizedBox(height: 250,),
                            Center(child: Text('Sorry we cannot find any Temp User please add',style: TextStyle(fontSize: 18),)),
                          ],
                        );
                      }else{
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(height: 25,),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: listOfScheduledPins.length,
                                      itemBuilder: (context,index){
                                        allPinNames(listOfScheduledPins[index]['d_id']);
                                        if(listOfScheduledPins[index]['pin1Status']==1){

                                        }
                                        print('length ${listOfScheduledPins.length}');
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Card(
                                            semanticContainer:true,
                                            shadowColor: Colors.orange,
                                            child: Container(
                                              color: Colors.blueGrey,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(listOfScheduledPins[index]['d_id'].toString()==null?"Loading":listOfScheduledPins[index]['d_id'].toString()),
                                                    trailing: Text(listOfScheduledPins[index]['date1'].toString()==null?"Loading":listOfScheduledPins[index]['date1'].toString()),
                                                    subtitle: Text(listOfScheduledPins[index]['timing1'].toString()),

                                                    onTap: (){
                                                      print('printSubUser ${listOfScheduledPins[index]['name']}');

                                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>TempUserDetails(tempUserPlaceName: tempUserDecodeList[index]['p_id'],
                                                      //   tempUserFloorName: tempUserDecodeList[index]['f_id'] ,)));

                                                    },
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        // color: Colors.redAccent,
                                                        height: 54,
                                                        child: ListView.builder(
                                                            itemCount: 1,
                                                            itemBuilder: (context,index){
                                                              if(listOfScheduledPins[index]['pin1Status']==1){
                                                                return Row(
                                                                  children: [
                                                                    SizedBox(width: 14,),
                                                                    Text(namesDataLocal[index]['pin1Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(on,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin1Status']==0){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin1Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(off,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin2Status']==1){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin2Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(on,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin2Status']==0){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin2Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(off,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin3Status']==1){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin3Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(on,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin3Status']==0){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin3Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(off,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              } else if(listOfScheduledPins[index]['pin4Status']==0){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin4Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(off,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin4Status']==1){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin4Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(on,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin5Status']==1){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin5Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(on,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin5Status']==0){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin5Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(off,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin6Status']==0){
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin6Name'].toString()),
                                                                    SizedBox(width: 14,),
                                                                    Text(off,style: TextStyle(fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin6Status']==1) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin6Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(on,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin7Status']==1) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin7Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(on,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin7Status']==0) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin7Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(off,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin8Status']==0) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin8Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(off,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin8Status']==1) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin8Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(on,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin9Status']==1) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin9Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(on,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin9Status']==0) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin8Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(off,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin10Status']==0) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin10Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(off,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin10Status']==1) {
                                                                return Row(
                                                                  children: [
                                                                    Text(
                                                                        namesDataLocal[index]['pin10Name']
                                                                            .toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(on,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin11Status']==1) {
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin11Name'].toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(on,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin11Status']==0) {
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin11Name'].toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(off,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin12Status']==0) {
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin12Name'].toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(off,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else if(listOfScheduledPins[index]['pin12Status']==1) {
                                                                return Row(
                                                                  children: [
                                                                    Text(namesDataLocal[index]['pin12Name'].toString()),
                                                                    SizedBox(
                                                                      width: 14,),
                                                                    Text(on,
                                                                      style: TextStyle(
                                                                          fontSize: 22),),
                                                                  ],
                                                                );
                                                              }else{return null;}
                                                            }),
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     Text('Pin 1 -> '),
                                                      //     Text(listOfScheduledPins[index]['pin1Status'].toString()==1? "On ":listOfScheduledPins[index]['pin1Status'].toString(),textAlign: TextAlign.end,),
                                                      //     SizedBox(width: 14,),
                                                      //     Text('Pin 2 -> '),
                                                      //     Text(listOfScheduledPins[index]['pin2Status'].toString(),textAlign: TextAlign.end,),
                                                      //     SizedBox(width: 8,),
                                                      //     Text('Pin 3 -> '),
                                                      //     Text(listOfScheduledPins[index]['pin3Status'].toString(),textAlign: TextAlign.end,),
                                                      //     // SizedBox(width: 14,),
                                                      //     // Text('Pin 4 -> '),
                                                      //     // Text(listOfScheduledPins[index]['pin4Status'].toString(),textAlign: TextAlign.end,),
                                                      //   ],
                                                      // ),
                                                      // Row(
                                                      //   children: [
                                                      //     Text('Pin 4 ->'),
                                                      //     Text(listOfScheduledPins[index]['pin4Status'].toString(),textAlign: TextAlign.end,),
                                                      //     SizedBox(width: 10,),
                                                      //     Text('Pin 5 -> '),
                                                      //     Text(listOfScheduledPins[index]['pin5Status'].toString(),textAlign: TextAlign.end,),
                                                      //     SizedBox(width: 10,),
                                                      //     Text('Pin 6 -> '),
                                                      //     Text(listOfScheduledPins[index]['pin6Status'].toString(),textAlign: TextAlign.end,),
                                                      //     // SizedBox(width: 14,),
                                                      //     // Text('Pin 8 -> '),
                                                      //     // Text(listOfScheduledPins[index]['pin8Status'].toString(),textAlign: TextAlign.end,),
                                                      //
                                                      //   ],
                                                      // ),
                                                      // Row(
                                                      //   children: [
                                                      //     Text('Pin 7 ->'),
                                                      //     Text(listOfScheduledPins[index]['pin7Status'].toString(),textAlign: TextAlign.end,),
                                                      //     SizedBox(width: 8,),
                                                      //     Text('Pin 8 ->'),
                                                      //     Text(listOfScheduledPins[index]['pin8Status'].toString(),textAlign: TextAlign.end,),
                                                      //     SizedBox(width: 8,),
                                                      //     Text('Pin 9 ->'),
                                                      //     Text(listOfScheduledPins[index]['pin9Status'].toString(),textAlign: TextAlign.end,),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );


                                        //   Column(
                                        //   children: <Widget>[
                                        //     SizedBox(height: 100,),
                                        //     Text('Sub User List',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        //     SizedBox(height: 15,),
                                        //     Row(
                                        //       children: [
                                        //         SizedBox(width: 55,),
                                        //         Text('Number 1',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                        //         SizedBox(width: 15,),
                                        //         Container(
                                        //           height: 45,
                                        //           width: 195,
                                        //           child:Padding(
                                        //             padding: const EdgeInsets.all(8.0),
                                        //             child: Text(subUserDecode[0]['email'].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                        //           ),
                                        //           decoration: BoxDecoration(
                                        //             color: Colors.white,
                                        //             border: Border.all(
                                        //               color: Colors.black38 ,
                                        //               width: 5.0 ,
                                        //             ),
                                        //             borderRadius: BorderRadius.circular(20),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //
                                        //
                                        //   ],
                                        //
                                        //   // trailing: Text("Place Id->  ${statusData[index]['d_id']}"),
                                        //   // subtitle: Text("${statusData[index]['id']}"),
                                        //
                                        // );
                                      }
                                  )),


                            ],
                          ),
                        );
                      }
                    }else{
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          semanticsLabel: 'Loading...',
                        ),
                      );
                    }

                  }

              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  subUserDeviceContainer(String dId, int index) {

    deviceContainer(dId, index);
    return Column(
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 1.95,
          color: Colors.redAccent,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        'Turn Off All Appliances',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: _switchValue ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        child: Icon(Icons.schedule),
                        onTap: () {

                          _createAlertDialogForPinSchedule(context,dId);
                          // _createAlertDialogForPin17(context, dId);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        child: Container(
                          // color:textSelected==dId.toString()?Colors.green:Colors.red,
                          child: Icon(textSelected == dId.toString()
                              ? Icons.update
                              : Icons.sensors),
                        ),

                        onTap: () {
                          print('check123${textSelected}');

                          setState(() {
                            textSelected = dId.toString();
                            deviceSensorVal = devicePinSensorLocalUsingDeviceId(
                                dId);
                          });
                          print('check123${textSelected == dId}');
                          print('_hasBeenPressed ${textSelected}');
                        },
                      ),
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
                      value: responseDataPinStatusForSubUser[index] == 0
                          ? val2
                          : val1,
                      //boolean value
                      // value: val1,
                      onChanged: (val) async {
                        _showDialog(dId);
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
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 1.32,
                // color: Colors.amber,
                child: GridView.count(
                    crossAxisSpacing: 8,
                    childAspectRatio: 2 / 1.8,
                    mainAxisSpacing: 4,
                    physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    crossAxisCount: 2,
                    children:
                    List.generate(
                        responseDataPinStatusForSubUser.length - 3, (index) {
                      print('Something');
                      // print('catch return --> $catchReturn');

                      return Container(
                        // color: Colors.green,
                          height: 2030,
                          child: Column(
                              children: [
                              GestureDetector(
                              onLongPress: () async {
                      _alarmTimeString =
                      DateFormat('HH:mm').format(DateTime.now());
                      cutDate = DateFormat('dd-MM-yyyy').format(
                      DateTime.now());
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
                      padding: const EdgeInsets.all(
                      32),
                      child: Column(children: [
                      // ignore: deprecated_member_use
                      Container(
                      width: 145,
                      child: GestureDetector(
                      child: Text(cutDate
                          .toString() == null
                      ? _dateString
                          : cutDate.toString()
                          .toString()),
                      onTap: () {
                      pickDate();
                      }

                      ),
                      ),

                      FlatButton(
                      onPressed: () async {
                      pickTime(index);
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
                      _alarmTimeString,
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
                      labels: ['Off', 'On'],
                      onToggle: (index) {
                      print(
                      'switched to: $index');
                      checkSwitch = index;
                      // changeIndex(index);
                      // setState(() {
                      //
                      // });
                      },
                      ),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      ),

                      FloatingActionButton.extended(
                      onPressed: () async {
                      await schedulingDevicePin(dId, index);
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
                      print('12365 ${responseDataPinStatusForSubUser[index]}');
                      setState(() {
                      if (responseDataPinStatusForSubUser[index] == 0) {
                      responseDataPinStatusForSubUser[index] =
                      1;
                      } else {
                      responseDataPinStatusForSubUser[index] = 0;
                      }
                      print('yooooooooo ${responseDataPinStatusForSubUser[index]}');
                      });

                      // if Internet is not available then _checkInternetConnectivity = true
                      var result = await Connectivity()
                          .checkConnectivity();
                      if (result == ConnectivityResult.none) {
                        print('yooo1');
                        messageSms(context, dId);
                      }
                      if (result == ConnectivityResult.wifi && statusOfDevice == 1) {
                        print('yooo2');
                        print("True2-->   $result");
                        localUpdate(dId);
                        dataUpdate(dId);
                      } else if (result == ConnectivityResult.mobile && result ==ConnectivityResult.none && statusOfDevice == 1) {
                        dataUpdate(dId);
                      } else if(result==ConnectivityResult.wifi && result ==ConnectivityResult.none && statusOfDevice == 1){
                        _createAlertDialogForlocalUpdateAndMessage(context,dId);

                      }
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
                      )
                      ,
                      );
                    })),
              ),
              Flexible(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 45,
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
                      List.generate(
                          responseDataPinStatusForSubUser.length - 9, (index) {
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
                                                  padding: const EdgeInsets.all(
                                                      32),
                                                  child: Column(children: [
                                                    // ignore: deprecated_member_use
                                                    FlatButton(
                                                      onPressed: () async {
                                                        // pickTime(index);
                                                        // s
                                                        print(
                                                            "index --> $index");
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
                                                      trailing: Icon(
                                                          Icons.timer),
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
                                                    FloatingActionButton
                                                        .extended(
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
                                                  onChanged: (double newValue) async {
                                                    print('index of data $index --> ${responseDataPinStatusForSubUser[newIndex - 1]}');
                                                    print(
                                                        'index of $index --> ${newIndex -
                                                            1}');

                                                    setState(() {
                                                      // if (responseGetData[newIndex-1] != null) {
                                                      //   responseGetData[newIndex-1] = widget.Slider_get.round();
                                                      // }

                                                      print("Round-->  ${newValue.round()}");
                                                      var roundVar = newValue.round();
                                                      print("Round 2-->  $roundVar");
                                                      responseDataPinStatusForSubUser[newIndex - 1] = roundVar;
                                                      print("Response Round-->  ${responseDataPinStatusForSubUser[newIndex - 1]}");
                                                    });
                                                    await dataUpdate(dId);

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
                                                '${namesDataList[index + 9]
                                                    .toString()} ',
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

  Future getDevicesByDeviceId(String rId) async {
    // deviceSubUser= await SubUserDataBase.subUserInstance.getDeviceByRoomId(rId);
    dv = await SubUserDataBase.subUserInstance.getDeviceByRoomId(rId);
    return dv;
  }

  Future placeVal;
  List<Map<String, dynamic>> placeRows;
  List placeQueryData;
  List floorQueryData;
  List floorQueryData2;
  List<Map<String, dynamic>> floorQueryRows;
  List<Map<String, dynamic>> roomQueryRows;
  List<Map<String, dynamic>> pinStatusQueryRows;
  List<Map<String, dynamic>> sensorQueryRows;
  List<Map<String, dynamic>> sensor2QueryRows;
  List<Map<String, dynamic>> deviceQueryRows2;
  List<Map<String, dynamic>> devicePinNamesQueryRows;
  List<Map<String, dynamic>> devicePinNamesQueryRows2;
  List<Map<String, dynamic>> floorQueryRows2;
  List<Map<String, dynamic>> flatQueryRows2;
  List<Map<String, dynamic>> roomQueryRows2;

  Future placeQueryFunc() async {
    placeRows = await SubUserDataBase.subUserInstance.queryPlaceSubUser();
    print('qwe123 $placeRows');
  }

  Future returnPlaceQuery() async {
    placeVal = await placeQueryFunc();
    return SubUserDataBase.subUserInstance.queryPlaceSubUser();
  }

  Future returnFloorQuery(String pId) {
    return SubUserDataBase.subUserInstance.queryFloorSubUser();
  }

  Future returnFlatQuery(String fId) {
    return SubUserDataBase.subUserInstance.queryFlatSubUser();
  }

  var place;
  var floor;
  var flat123;

  _createAlertDialogDropDown(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Place'),
            content: Container(
              height: 390,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FutureBuilder(
                          future: returnPlaceQuery(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          offset: Offset(20, 20))
                                    ],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    )),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  dropdownColor: Colors.white70,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 28,
                                  hint: Text('Select Place'),
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  items: placeRows.map((selectedPlace) {
                                    print('aaaadsds ${placeRows}');
                                    return DropdownMenuItem(
                                      value: selectedPlace.toString(),
                                      child: Column(
                                        children: [
                                          Text("${selectedPlace['p_type']
                                              .toString()}"),
                                          Text("${allPlaceId[0]['owner_name']
                                              .toString()}"),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (selectedPlace) async {
                                    print('checkqwe123c ${selectedPlace
                                        .toString()}');

                                    var placeId = selectedPlace.substring(
                                        7, 14);
                                    var placeName = selectedPlace.substring(
                                        24, 31);
                                    place = SubUserPlaceType(
                                        pId: placeId,
                                        pType: placeName,
                                        user: getUidVariable2
                                    );


                                    var aa = await SubUserDataBase
                                        .subUserInstance.getFloorById(
                                        placeId.toString());
                                    print('AA  ${aa}');

                                    floorval =
                                        returnFloorQuery(placeId.toString());
                                    floorQueryRows2 = await aa;
                                    returnFloorQuery(placeId);
                                    setState(() {
                                      floorQueryRows2 = aa;
                                      floorval = returnFloorQuery(placeId);
                                      returnFloorQuery(placeId);
                                    });
                                    print('Floorqwe  ${floorQueryRows2}');

                                    // qwe= ;
                                  },
                                  // items:snapshot.data
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FutureBuilder(
                          future: floorval,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          offset: Offset(20, 20))
                                    ],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    )),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),

                                  dropdownColor: Colors.white70,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 28,
                                  hint: Text('Select Floor'),
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  items: floorQueryRows2.map((selectedFloor) {
                                    return DropdownMenuItem(
                                      value: selectedFloor.toString(),
                                      child: Text("${selectedFloor['f_name']}"),
                                    );
                                  }).toList(),
                                  onChanged: (selectedFloor) async {
                                    print('Floor selected $selectedFloor');

                                    var floorId = selectedFloor.substring(
                                        7, 14);
                                    var floorName = selectedFloor.substring(
                                        24, 32);
                                    var placeId = selectedFloor.substring(
                                        39, 46);
                                    floor = SubUserFloorType(
                                        fId: floorId,
                                        fName: floorName,
                                        pId: placeId,
                                        user: getUidVariable2
                                    );

                                    var getFlat = await SubUserDataBase
                                        .subUserInstance.getFlatById(
                                        floorId.toString());
                                    print('GetFlat    ${getFlat}');
                                    flatVal = returnFlatQuery(floorId);
                                    flatQueryRows2 = getFlat;
                                    setState(() {
                                      flatVal = returnFlatQuery(floorId);
                                      flatQueryRows2 = getFlat;
                                    });
                                    print('forRoom  ${roomQueryRows2}');

                                    returnFloorQuery(floorId);
                                  },
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FutureBuilder(
                          future: flatVal,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          offset: Offset(20, 20))
                                    ],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    )),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  dropdownColor: Colors.white70,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 28,
                                  hint: Text('Select Flat'),
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  items: flatQueryRows2.map((selectedFlat) {
                                    return DropdownMenuItem(
                                      value: selectedFlat.toString(),
                                      child: Text(
                                          "${selectedFlat['flt_name']}"),
                                    );
                                  }).toList(),
                                  onChanged: (selectedFlat) async {
                                    flatId = selectedFlat.substring(9, 16);
                                    var flatName = selectedFlat.substring(
                                        28, 35);
                                    var floorId = selectedFlat.substring(
                                        39, 46);
                                    print('flatName $selectedFlat');
                                    // print('flatName $user');
                                    // int user2 =int.parse(user);
                                    // int user2=int.parse(user.toString());
                                    flat123 = SubUserFlatType(
                                        fId: floorId,
                                        fltId: flatId,
                                        fltName: flatName,
                                        user: getUidVariable2
                                    );
                                    flat = flat123;
                                    print(flatId);

                                    var aa = await SubUserDataBase
                                        .subUserInstance.getRoomById(
                                        flatId.toString());
                                    print('AA  ${aa}');
                                    setState(() {
                                      // roomQueryRows2=aa;
                                      // roomVal=returnRoomQuery(flatId);
                                    });
                                    print('forRoom  ${roomQueryRows2}');

                                    // returnFloorQuery(floorId);
                                  },
                                  // items:snapshot.data
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  // elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    List result = await SubUserDataBase.subUserInstance
                        .getRoomById(flatId.toString());
                    print("SubmitAllDetails  ${result}");
                    List<SubUserRoomType> roomList = List.generate(
                        result.length,
                            (index) =>
                            SubUserRoomType(
                              rId: result[index]['r_id'].toString(),
                              fltId: result[index]['flt_id'].toString(),
                              rName: result[index]['r_name'].toString(),
                              user: result[index]['user'],
                            )
                    );
                    setState(() {
                      pt = place;
                      fl = floor;
                      flat = flat123;
                      room = roomList;
                    });

                    await Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) =>
                        SubAccessSinglePage(
                          ptSubUser: pt,
                          flSubUser: fl,
                          flatSubUser: flat,
                          rmSubUser: room,)));
                  },
                ),
              )
            ],
          );
        });
  }


}
