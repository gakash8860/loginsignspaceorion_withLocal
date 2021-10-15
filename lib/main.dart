// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginsignspaceorion/BillUsage/bill_estimation.dart';
import 'package:loginsignspaceorion/BillUsage/total_usage.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/TemporaryUser/EnterPhoneNumber.dart';
import 'package:loginsignspaceorion/dropDown.dart';
import 'package:loginsignspaceorion/dropdown1.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:loginsignspaceorion/signUp.dart';
import 'package:loginsignspaceorion/utility.dart';
import 'package:loginsignspaceorion/wrongpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'Manage Theme/darkmodeandFont.dart';
import 'ProfilePage.dart';
import 'SQLITE_database/NewDatabase.dart';
import 'Setting_Page.dart';
import 'SubAccessPage/singlePageForSubAccess.dart';
import 'changeFont.dart';
import 'dropdown2.dart';
import 'login_Screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';


var API = 'http://127.0.0.1:8000/';
// var API = 'https://genorion1.herokuapp.com/';
List roomData;
List floorData;
List placeData;
List placeTypeSingle;
List floorTypeSingle;
List flatTypeSingle;
List roomTypeSingle;
List deviceData;
List<Device> dvdata;
var userDataVariable;
List<FloorType> lisOfFloor;
List<Map<String, dynamic>> roomQueryRows;
List<PlaceType> placeType;
List<RoomType>  room;
final storage = new FlutterSecureStorage();
var statusOfDevice;

Future<String> getToken() async {
  final token = await storage.read(key: "token");
  print(token);
  return token;
}

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MaterialApp(
    theme: ThemeData(
      // primarySwatch: Colors.grey,
      fontFamily: 'Jaldi',
    ),
    debugShowCheckedModeBanner: false,
    home: GettingStartedScreen(),
    routes:{
      LoginScreen.routeName: (ctx) => LoginScreen(),
      SignUpScreen1.routeName: (ctx) => SignUpScreen1(),
      DropDown1.routeName:(ctx) => DropDown1(),
      DropDown.routeName:(ctx) => DropDown(),
      WrongPassword.routeName:(ctx) => WrongPassword(),
      SubAccessSinglePage.routeName:(ctx) => SubAccessSinglePage(),
      TotalUsage.routeName:(ctx) => TotalUsage(),
      BillEstimation.routeName:(ctx) => BillEstimation(),
      DarkModeAndFont.routeName:(ctx) => DarkModeAndFont(),
      HomeTest.routeName:(ctx) => HomeTest(),

      '/main': (ctx) =>  HomeTest(pt: pt, fl: fl,flat: flt,rm: room,dv: dvdata,),

      // '/main': (ctx) =>  DropDown2(),
    },
  ));
}

// HomePage(pt: placeData[0]['p_id'], fl: floorData[0]['f_id'], rm: roomData[0]['r_id'], dv: deviceData[0]['d_id']),

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int currentPage = 0;
  var token;
  List floorData;
  NewDbProvider dbProvider;
  List copyFloorData;
  FloorType floorType;
  Future floorval;
  Future pinVal;
  Future sensorVal;
  var ff;
  List qwe;
  List<Map<String, dynamic>> queryRows;
  List placeQueryData;
  List floorQueryData;
  List floorQueryData2;
  List<Map<String, dynamic>> floorQueryRows;
  List<Map<String, dynamic>> flatQueryRows;
  List<Map<String, dynamic>> roomQueryRows;
  List<Map<String, dynamic>> deviceQueryRows;
  List<Map<String, dynamic>> pinStatusQueryRows;
  List<Map<String, dynamic>> sensorQueryRows;
  List<Map<String, dynamic>> sensor2QueryRows;
  List<Map<String, dynamic>> deviceQueryRows2;
  List<Map<String, dynamic>> devicePinNamesQueryRows;
  List<Map<String, dynamic>> devicePinNamesQueryRows2;
  List<Map<String, dynamic>> floorQueryRows2;
  List<Map<String, dynamic>> roomQueryRows2;
  List flatQueryData;
  Future roomVal;
  Future deviceVal;
  Permission permission;
  PageController pageController = PageController(initialPage: 0);
  DropDown1 down=new DropDown1();
  Timer timer;


  @override
  void initState() {
    super.initState();
    requestPermission();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      if(pageController.hasClients){
        pageController.animateToPage(currentPage, duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });

    read();
  }
  var font;
  _getFont()async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    font= pref.getString('font');
    if(font!=null){
      fonttest=font;
    }
    print('number147859Main ${font}');
  }
  _getTheme()async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    changeDark=pref.getBool('darkmode');
    change_toDark=changeDark;
  }
  requestPermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print("Granted");
    }
  }


  getUid() async{
    final url= API+'getuid/';
    String token = await getToken();
    final response =
    await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
    if(response.statusCode==200){
      print('UiD ${response.body}');
      getUidVariable=response.body ;
      getUidVariable2=int.parse(getUidVariable);
      getUserDetailsSql();
    }else{
      print(response.statusCode);
    }
  }

  allAwaitFunction()async{
    getUid();

    getUserDataOfflineSql();
   await loadImageFromPreferences();
    fetchPlace().then((value) =>   placeQueryFunc()).then((value) => getAllFloor())
      .then((value) => floorQueryFunc()).then((value) => getAllFlat().then((value) => flatQueryFunc())).then((value) => getAllRoom())
      .then((value) => roomQueryFunc()).then((value) => getAllDevice()).then((value) => deviceQueryFunc()).then((value) => getPinStatusData())
      .then((value) => devicePinStatusQueryFunc()).then((value) => getAllPinNames()).then((value) => devicePinNamesQueryFunc())
      .then((value) => getSensorData()).then((value) => devicePinSensorQueryFunc());

    await placeQueryFunc();
    await floorQueryFunc();
    await flatQueryFunc();
    await roomQueryFunc();
    getImage();
    await deviceQueryFunc();
    await devicePinSensorQueryFunc();
    await devicePinStatusQueryFunc();
    await devicePinNamesQueryFunc();

  }

  getUserDataOfflineSql() async {
   List data = await NewDbProvider.instance.userQuery();
    print('qqqqqq $data');
    var userQuery = User(
        lastName: data.first['last_name'].toString(),
        firstName: data.first['first_name'].toString(),
        email: data.first['email'].toString());
    setState(() {
      email = userQuery.email;
      firstName = userQuery.firstName;
      lastName = userQuery.lastName;
    });
    print('asasa ${lastName}');
  }

  Future<List<PlaceType>> fetchPlace() async {
    // await openPlaceBox();
    String token = await getToken();
    final url = API+'addyourplace/';
    final response = await http.get(url,
        headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    }
    );

    try {
      if (response.statusCode > 0) {
        placeData = jsonDecode(response.body);
        for (int i = 0; i < placeData.length; i++) {

          var placeQuery = PlaceType(
              pId: placeData[i]['p_id'],
              pType: placeData[i]['p_type'],
              user: placeData[i]['user']
          );
          NewDbProvider.instance.insertPlaceModelData(placeQuery);


        }


        places = placeData.map((data) => PlaceType.fromJson(data)).toList();


      }
    } catch (e) {}
    return places;
// return PlaceType.fromJson(true);

  }





  Future<void> getAllFloor()async{
    String token = await getToken();
    var pId;

    for(int i=0;i<placeData.length;i++){
      // Box poop;
      pId=placeData[i]['p_id'].toString();
      // print(pId);

      final url=API+"addyourfloor/?p_id="+pId;
      final  response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if(response.statusCode>0){

        floorData = jsonDecode(response.body);
        print('floorData12 ${floorData}');
        for(int i=0;i<floorData.length;i++){
          var floorQuery=FloorType(
              fId: floorData[i]['f_id'],
              fName: floorData[i]['f_name'].toString(),
              pId: floorData[i]['p_id'],
              user: floorData[i]['user']
          );
          print('floorData12 ${floorQuery}');
          await  NewDbProvider.instance.insertFloorModelData(floorQuery);
        }
      }


      floors = floorData.map((data) => FloorType.fromJson(data)).toList();
      // floorData=floorData+floors;


    }
    print('lastFloor ${floorData.iterator.current}');

  }


  Future<void> getAllFlat()async{
    var fId;

    String token=await getToken();
    for(int i=0;i<floorQueryRows.length;i++){
      fId=floorQueryRows[i]['f_id'].toString();
      print("AllFlatFloorId $fId");
      String url=API+'addyourflat/?f_id='+fId;
      final  response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if(response.statusCode>0){

        List flatData = jsonDecode(response.body);
        print('flatData ${flatData}');
        for(int i=0;i<flatData.length;i++){

          var flatQuery=Flat(
              fId: flatData[i]['f_id'],
              fltId: flatData[i]['flt_id'],
              fltName: flatData[i]['flt_name'],
              user: flatData[i]['user']
          );
          await  NewDbProvider.instance.insertFlatModelData(flatQuery);
          print('FlatFlatQuery  ${flatQuery.fltName}');
        }

      }


      // floors = floorData.map((data) => FloorType.fromJson(data)).toList();


    }
  }
  Future<void> getAllRoom()async{
    var fId;
    for(int i=0;i<flatQueryRows.length;i++) {
      //   print(NewDbProvider.instance.dogs());
      fId = flatQueryRows[i]['flt_id'].toString();
      print('flt_id  ${fId}');


      // String url="http://10.0.2.2:8000/api/data";
      // String token= await getToken();
      String token=await getToken();
      String url = API+"addroom/?flt_id="+fId;
      var response;
      try {
        response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
        roomData = jsonDecode(response.body);
        // roomData.sort();

        // if(roomData.length==roomQueryRows.length){
        //   for(int i=0;i<roomData.length;i++){
        //     roomQuery=RoomType(
        //         rId: roomData[i]['r_id'],
        //         rName: roomData[i]['r_name'].toString(),
        //         fltId: roomData[i]['flt_id'],
        //         user: roomData[i]['user']
        //     );
        //     await NewDbProvider.instance.updateRoom(roomQuery);
        //   }
        // }else{
        //   await NewDbProvider.instance.deleteRoomModel();
        //
        //   for(int i=0;i<roomData.length;i++){
        //     roomQuery=RoomType(
        //         rId: roomData[i]['r_id'],
        //         rName: roomData[i]['r_name'].toString(),
        //         fltId: roomData[i]['flt_id'],
        //         user: roomData[i]['user']
        //     );
        //     await NewDbProvider.instance.insertRoomModelData(roomQuery);
        //   }
        // }
        for(int i=0;i<roomData.length;i++){
          roomQuery=RoomType(
              rId: roomData[i]['r_id'],
              rName: roomData[i]['r_name'].toString(),
              fltId: roomData[i]['flt_id'],
              user: roomData[i]['user']
          );
          await NewDbProvider.instance.insertRoomModelData(roomQuery);
        }
       rm = roomData.map((data) => RoomType.fromJson(data)).toList();
        print('checkRoomData $roomData');

      } catch (e) {
        print('RoomCatch $e');
        // }

      }
    }
    return Future.value(true);
  }

  List arr=[];
  Future<void> getAllDevice()async{
    String token = await getToken();
    var rId;
    for(int i=0;i<roomQueryRows.length;i++) {
      rId = roomQueryRows2[i]['r_id'].toString();
      print('roomId  $rId');
      String url = API+"addyourdevice/?r_id=" +
          rId;
      var response;
      // try {
      response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      deviceData = jsonDecode(response.body);
      print('deviceData  ${deviceData}');
      for (int i = 0; i < deviceData.length; i++) {
        var deviceQuery = Device(
            user: deviceData[i]['user'],
            rId: deviceData[i]['r_id'],
            dId: deviceData[i]['d_id']

        );
        print('deviceQueryFunc   $deviceData}');

        await NewDbProvider.instance.insertDeviceModelData(deviceQuery);

      }
    }
    return Future.value(true);
  }
  Future<void> getAllPinNames()async{
    String token = await getToken();
    var did;
    print('pinNamesFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++){

      did=deviceQueryRows[i]['d_id'];
      print('diddevice $did');
      String url = API+"editpinnames/?d_id="+did;
      // try {
      final   response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if(response.statusCode==200) {
        var  devicePinNamesData=json.decode(response.body);
        // DevicePin devicePin=DevicePin.fromJson(devicePinNamesData);

        List listOfPinNames=[devicePinNamesData,];

        print('QWERTY  $listOfPinNames');
        for (int i = 0; i < listOfPinNames.length; i++) {

          print('devicePinData $listOfPinNames}');

          var devicePinNamesQuery = DevicePin(
            id: listOfPinNames[i]['id'],
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
              await NewDbProvider.instance.insertDevicePinNames(devicePinNamesQuery);
          var check= await NewDbProvider.instance.getPinNamesByDeviceId(listOfPinNames[i]['d_id']);
          print('check456 ${check}');
        }


      }
    }


  }

  Future<void> getUserDetailsSql()async{
    String token = await getToken();
    print(getUidVariable);
    String url=API+"getthedataofuser/?id="+getUidVariable;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });


    if (response.statusCode >0) {
      print('responseStatus ${response.statusCode}');
      userDataVariable=jsonDecode(response.body);
      print('response $userDataVariable');

      var userQuery=User(
        email: userDataVariable['email'],
        firstName: userDataVariable['first_name'],
        lastName: userDataVariable['last_name'],
      );
      await NewDbProvider.instance.insertUserDetailsModelData(userQuery);
      print('userQuery  ${userQuery.firstName}' );
      // await NewDbProvider.instance.close();



    }


  }






  Future<void> getSensorData() async {
    // arr=[arr.length-arr.length];
    String token = await getToken();

    var did;
    print('SensorFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++) {
      did=deviceQueryRows[i]['d_id'];
      print('insideLoop $did');
      String url = API+"tensensorsdata/?d_id="+did.toString();
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
      print('arrsensorData  ${arr}');
      List listOfPinSensor=[arr,];
      print('sensorData  ${listOfPinSensor}');
      for (int i = 0; i < listOfPinSensor.length; i++) {
        var sensorQuery = SensorData(
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
        await NewDbProvider.instance.insertSensorData(sensorQuery);
        await NewDbProvider.instance.updateSensorData(sensorQuery);
      }

    }
  }

  Future<void> getPinStatusData() async {
    String token = await getToken();
    var did;
    print('PinStatusFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++) {
      did=deviceQueryRows[i]['d_id'];
      print('insideLoop $did');
      String url = API+"getpostdevicePinStatus/?d_id="+did.toString();
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
          var pinQuery = PinStatus(
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
            pin16Status: listOfPinStatusValue[i]['pin16Status'],
            pin17Status: listOfPinStatusValue[i]['pin17Status'],
            pin18Status: listOfPinStatusValue[i]['pin18Status'],
            pin19Status: listOfPinStatusValue[i]['pin19Status'],
            pin20Status: listOfPinStatusValue[i]['pin20Status'],
          );
          await NewDbProvider.instance.insertPinStatusData(pinQuery);
          await NewDbProvider.instance.updatePinStatusData(pinQuery);
          print('check1234567}');
        }


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


  List<dynamic> devicePinNamesData=[];
  var roomQuery;
  var deviceQuery;
  var aa;




  getImage() async {
    String token = await getToken();
    final url =
        API+'testimages123/?user=' + getUidVariable;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('statusCode ${response.statusCode}');
      print('statusCode ${response.body}');
      var imageData = json.decode(response.body);
      print('statusCode ${response.body}');
      Utility.saveImage(imageData['file']).then((value) => loadImageFromPreferences());
      // setImage=Utility.imageFrom64BaseString(imageData['file']);
      // setImage=convertImage;

      print('ConvertImagesetImage ${setImage}');
      print('ConvertImage ${imageData['file']}');
    }
  }


  loadImageFromPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final _imageKeyValue = preferences.getString(IMAGE_KEY);
    if (_imageKeyValue != null) {
      final imageString = await Utility.getImagefrompreference();
      setState(() {
        setImage = Utility.imageFrom64BaseString(imageString);
      });
    }
  }

  Future placeQueryFunc()async{
    placeTypeSingle=  await NewDbProvider.instance.queryPlace();
    queryRows = await NewDbProvider.instance.queryPlace();
    placeTypeSingle=queryRows;

    var pids=PlaceType(
      pId: queryRows[0]['p_id'].toString(),
      pType: queryRows[0]['p_type'].toString(),
      user: queryRows[0]['user']
    );

    pt=pids;
    print('checkPlaces123654 ${placeTypeSingle.last}');

  }
List resultFloor;
  Future floorQueryFunc()async{
    floorTypeSingle=    await NewDbProvider.instance.queryFloor();
    floorQueryRows = await NewDbProvider.instance.queryFloor();
    floorQueryData=floorQueryRows;
    floorTypeSingle=floorQueryRows;
    var pId=placeTypeSingle[0]['p_id'].toString();
    print('placeId $pId');
    resultFloor= await NewDbProvider.instance.getFloorById(pId);

    var floor=FloorType(
      fId: resultFloor[0]['f_id'].toString(),
      fName: resultFloor[0]['f_name'].toString(),
      user: resultFloor[0]['user'],
      pId: resultFloor[0]['p_id'].toString()
    );
    fl=floor;

    // floors=floorQueryRows;
    print('floorLocalData ${fl.fName}');



  }
  List resultFlat;
  Future flatQueryFunc()async{
    flatTypeSingle=    await NewDbProvider.instance.queryFlat();
    flatQueryRows = await NewDbProvider.instance.queryFlat();
      print("Query $flatQueryRows");
      flatQueryData=flatQueryRows;

    floorTypeSingle=floorQueryRows;
    var fId=resultFloor[0]['f_id'].toString();
    print(fId);
    resultFlat= await NewDbProvider.instance.getFlatByFId(fId.toString());
    print('checkFlat123  ${resultFlat}');
    var flat=Flat(
      fId: resultFlat[0]['f_id'].toString(),
      fltName: resultFlat[0]['flt_name'].toString(),
      fltId: resultFlat[0]['flt_id'].toString(),
      user: resultFlat[0]['user']
    );
    flt=flat;


  }
  List resultRoom;
  Future<List<RoomType>> roomQueryFunc()async {
    roomQueryRows = await NewDbProvider.instance.queryRoom();
    print('qqqq ${roomQueryRows}');

    var id=resultFlat[0]['flt_id'].toString();

    roomQueryRows2=roomQueryRows;
     resultRoom= await NewDbProvider.instance.getRoomById(id);
    print('roomResult $resultRoom');
    room= List.generate(resultRoom.length, (index) => RoomType(
      rId: resultRoom[index]['r_id'].toString(),
      fltId: resultRoom[index]['flt_id'].toString(),
      rName:resultRoom[index]['r_name'].toString(),
      user: resultRoom[index]['user'],
    ));
return room;
  }
List deviceResult;
  Future<List<Device>> deviceQueryFunc()async{
    deviceQueryRows = await NewDbProvider.instance.queryDevice();
    print('maindeviceQuery $deviceQueryRows');
    List dv1= deviceQueryRows;
    var roomId=resultRoom[0]['r_id'];
    // dv=deviceQueryRows;
     deviceResult= await NewDbProvider.instance.getDeviceByRId(roomId.toString());
    print('dvlouye ${deviceResult}');
    dvdata= List.generate(deviceResult.length, (index) => Device(
        dId: deviceResult[index]['d_id'].toString(),
        rId: deviceResult[index]['r_id'].toString(),
        user: deviceResult[index]['user']
    ));
    return dvdata;

  }
  Future devicePinNamesQueryFunc()async{
    devicePinNamesQueryRows =
    await NewDbProvider.instance.queryPinNames();
    print('devicePinQueryFunc  $devicePinNamesQueryRows');

    return devicePinNamesQueryRows;

  }

  Future devicePinSensorQueryFunc()async{
    sensorQueryRows = await NewDbProvider.instance.querySensor();
    print('deviceSensorQueryFunc  $sensorQueryRows');
    // var deviceId= deviceResult[0]['d_id'];
    // List result= await NewDbProvider.instance.getSensorByDeviceId(deviceId);
    // var sensorDataSend= SensorData(
    //   sensor1: result[0]['sensor1'],
    //   sensor2: result[0]['sensor2'],
    //   sensor3: result[0]['sensor3'],
    //   sensor4: result[0]['sensor4'],
    // );
    // sensorData= sensorDataSend;
    return sensorQueryRows;

  }
  Future devicePinStatusQueryFunc()async{
    pinStatusQueryRows= await NewDbProvider.instance.queryPinStatus();
    print('devicePinStatusLocal  $pinStatusQueryRows');
    return pinStatusQueryRows;


  }


  //
  // _checkInternetConnectivity()async{
  //   var result = await Connectivity().checkConnectivity();
  //   if(result==ConnectionState.none){
  //     return _showDialog();
  //   }
  // }

  // void _showDialog() {
  //   // dialog implementation
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("No Internet"),
  //       content: Text("Check your internet connection"),
  //       actions: <Widget>[FlatButton(child: Text("EXIT"), onPressed: () {})],
  //     ),
  //   );
  // }
  void  read() async {
    final storage = new FlutterSecureStorage();
   await _getFont();
   // await _getTheme();
    await allAwaitFunction();
    token = await storage.read(key: "token");

    print(token);
    if (token != null) {


      Navigator.popAndPushNamed(context, '/main');
    }

  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();

  }

  onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          if(viewportConstraints.maxWidth>600){
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            onPageChanged: onPageChanged,
                            controller: pageController,
                            itemCount: slideList.length,
                            itemBuilder: (ctx, i) => SlideItem(i),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(bottom: 35),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int i = 0; i < slideList.length; i++)
                                      if (i == currentPage)
                                        SlideDots(true)
                                      else
                                        SlideDots(false)
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          width: 300,
                          child: FlatButton(
                            child: Text(
                              'Getting Started',
                              style: TextStyle(fontSize: 18),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(500),
                            ),
                            color: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.all(15),
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(SignUpScreen1.routeName);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Have an account',
                              style: TextStyle(fontSize: 18),
                            ),
                            FlatButton(
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Temporary User',
                              style: TextStyle(fontSize: 14),
                            ),

                            FlatButton(
                              child: Text(
                                'Click Here !',
                                style: TextStyle(fontSize: 14),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EnterPhoneNumber()));
                              },
                            )
                          ],
                        )

                      ],
                    )
                  ],
                ),
              ),
            );
          }else{
            return WillPopScope(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: Text(
                    'GenOrion',
                    style: TextStyle(letterSpacing: 0.5, fontFamily: 'Volvo-Regular'),
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              PageView.builder(
                                scrollDirection: Axis.horizontal,
                                onPageChanged: onPageChanged,
                                controller: pageController,
                                itemCount: slideList.length,
                                itemBuilder: (ctx, i) => SlideItem(i),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.topStart,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 35),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        for (int i = 0; i < slideList.length; i++)
                                          if (i == currentPage)
                                            SlideDots(true)
                                          else
                                            SlideDots(false)
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                'Getting Started',
                                style: TextStyle(fontSize: 18),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(500),
                              ),
                              color: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.all(15),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SignUpScreen1.routeName);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Have an account',
                                  style: TextStyle(fontSize: 18),
                                ),
                                FlatButton(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(LoginScreen.routeName);
                                  },
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Temporary User',
                                  style: TextStyle(fontSize: 14),
                                ),
                                FlatButton(
                                  child: Text(
                                    'Click Here !',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EnterPhoneNumber()));
                                  },
                                )
                              ],
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onWillPop: () =>
                  showDialog(context: context, builder: (c) => backPopPage(context)),
            );
          }
        }

      ),
    );
  }

  backPopPage(context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Do you want to exit'),
      actions: [
        FlatButton(
          child: Text('Yes'),
          onPressed: () => exit(0),
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () => Navigator.pop(context, false),
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('ThemeData', ThemeData));
  }
}

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(slideList[index].imageURL),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          slideList[index].tittle,
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20)
      ],
    );
  }
}

class Slide {
  final String imageURL;
  final String tittle;
  final String description;

  Slide(
      {
      this.imageURL,
      this.tittle,
      this.description});
}

final slideList = [
  Slide(
      imageURL: 'assets/images/genLogo.png',
      tittle: 'Welcome to GenOrion',
      description: 'GenOrion is a part of SpaceStation Automation Pvt. Ltd.'
          'Developing smart switching and control systems for Automation.'),
  Slide(
      imageURL: 'assets/images/slide1.jpg',
      tittle: 'GenOrion',
      description: 'GenOrion is a part of SpaceStation Automation Pvt. Ltd.'
          'Developing smart switching and control systems for Automation.'),
  Slide(
      imageURL: 'assets/images/qwe.png',
      tittle: 'Proposed Solutions by our product',
      description:
      'The system can work with or without the internet on the same network.'
          'Capable of working with old manual switching as well as new.'
          'Users can control devices by manual switching too.'),
];

class SlideDots extends StatelessWidget {
  final bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
