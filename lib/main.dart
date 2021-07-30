// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginsignspaceorion/SQLITE_database/testingHome.dart';
import 'package:loginsignspaceorion/TemporaryUser/EnterPhoneNumber.dart';
import 'package:loginsignspaceorion/dropdown1.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:loginsignspaceorion/signUp.dart';
import 'dart:async';
import 'SQLITE_database/NewDatabase.dart';
import 'dropdown2.dart';
import 'login_Screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box placeBox;
Box floorBox;
Box roomBox;
Box deviceBox;
List roomData;
List floorData;
List placeData;
List placeTypeSingle;
List floorTypeSingle;
List roomTypeSingle;
List deviceData;
List<Device> dvdata;
List<Map<String, dynamic>> roomQueryRows;
List<PlaceType> placeType;
List<RoomType> room;
final storage = new FlutterSecureStorage();

Future<String> getToken() async {
  final token = await storage.read(key: "token");
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
      '/main': (ctx) =>  HomeTest(pt: pt, fl: fl,rm: room,dv: dvdata,),
      // '/main': (ctx) =>   HomePage(pt: placeData.last,fl: floorData.first,rm: rm,),
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

  Future roomVal;
  Future deviceVal;



  Permission permission;
  PageController pageController = PageController(initialPage: 0);
  DropDown1 down=new DropDown1();

  // List<PlaceType> place;
  // List<FloorType> floor;







  Timer timer;
  @override
  void initState() {
    super.initState();
    // allAwaitFunction();
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

  requestPermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print("Granted");
    }
  }


  getUid() async{
    final url= 'http://genorionofficial.herokuapp.com/getuid/';
    String token = await getToken();
    final response =
    await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
    if(response.statusCode==200){
      getUidVariable=response.body ;
      getUidVariable2=int.parse(getUidVariable);

    }else{
      print(response.statusCode);
    }
  }

  allAwaitFunction()async{
  fetchPlace().then((value) =>   placeQueryFunc()).then((value) => getAllFloor())
      .then((value) => floorQueryFunc()).then((value) => getAllRoom())
      .then((value) => roomQueryFunc()).then((value) => getAllDevice()).then((value) => deviceQueryFunc()).then((value) => getPinStatusData())
      .then((value) => devicePinStatusQueryFunc()).then((value) => getAllPinNames()).then((value) => devicePinNamesQueryFunc())
      .then((value) => getSensorData()).then((value) => devicePinSensorQueryFunc());

    await placeQueryFunc();
    await floorQueryFunc();
    await roomQueryFunc();
    await deviceQueryFunc();
    await devicePinSensorQueryFunc();
    await devicePinStatusQueryFunc();
    await devicePinNamesQueryFunc();
  }



  Future<List<PlaceType>> fetchPlace() async {
    // await openPlaceBox();
    String token = await getToken();
    final url = 'http://genorionofficial.herokuapp.com/getallplaces/';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

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

      final url="http://genorionofficial.herokuapp.com/getallfloors/?p_id="+pId;
      final  response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if(response.statusCode>0){

        floorData = jsonDecode(response.body);
        for(int i=0;i<floorData.length;i++){
          var floorQuery=FloorType(
              fId: floorData[i]['f_id'],
              fName: floorData[i]['f_name'].toString(),
              pId: floorData[i]['p_id'],
              user: floorData[i]['user']
          );
          await  NewDbProvider.instance.insertFloorModelData(floorQuery);
        }
      }


      floors = floorData.map((data) => FloorType.fromJson(data)).toList();
      // floorData=floorData+floors;


    }
    print('lastFloor ${floors.first.toJson()}');

  }


  Future<void> getAllRoom()async{
    String token = await getToken();
    var fId;
    for(int i=0;i<floorQueryRows.length;i++) {
      //   print(NewDbProvider.instance.dogs());
      fId = floorQueryRows[i]['f_id'].toString();
      print('fId123  $fId');


      // String url="http://10.0.2.2:8000/api/data";
      // String token= await getToken();

      String url = "http://genorionofficial.herokuapp.com/getallrooms/?f_id="+fId;
      var response;
      try {
        response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',

        });
        roomData = jsonDecode(response.body);
        print('roomData123 $roomData');

        for(int i=0;i<roomData.length;i++){


          roomQuery=RoomType(
              rId: roomData[i]['r_id'],
              rName: roomData[i]['r_name'].toString(),
              fId: roomData[i]['f_id'],
              user: roomData[i]['user']
          );

          await NewDbProvider.instance.insertRoomModelData(roomQuery);


        }



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
      //   print(NewDbProvider.instance.dogs());
      rId = roomQueryRows2[i]['r_id'].toString();
      print('roomId  $rId');
      String url = "http://genorionofficial.herokuapp.com/getalldevices/?r_id=" +
          rId;
      var response;
      // try {
      response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      deviceData = jsonDecode(response.body);
      // print('deviceData  ${deviceData}');
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
      print('did $did');
      String url = "http://genorionofficial.herokuapp.com/editpinnames/?d_id="+did;
      // try {
      final   response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if(response.statusCode==200) {
        var  devicePinNamesData=json.decode(response.body);
        // DevicePin devicePin=DevicePin.fromJson(devicePinNamesData);

        List listOfPinNames=[devicePinNamesData];

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
  Future<void> getSensorData() async {
    // arr=[arr.length-arr.length];
    String token = await getToken();

    var did;
    print('SensorFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++) {
      did=deviceQueryRows[i]['d_id'];
      print('insideLoop $did');
      String url = "http://genorionofficial.herokuapp.com/tensensorsdata/?d_id="+did.toString();
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
      }

    }
  }

  Future<void> getPinStatusData() async {
    // arr=[arr.length-arr.length];
    String token = await getToken();

    var did;
    print('PinStatusFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++) {
      did=deviceQueryRows[i]['d_id'];
      print('insideLoop $did');
      String url = "http://genorionofficial.herokuapp.com/getpostdevicePinStatus/?d_id="+did.toString();
      // final url="http://genorionofficial.herokuapp.com/tensensorsdata/?d_id="+did;
      final response = await http.get(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $token',
          });

      if(response.statusCode==200){
        print('PinStatusResponse  ${response.statusCode}');
        var pinStatus= jsonDecode(response.body);
        // PinStatus devicePinStatus=PinStatus.fromJson(pinStatus);
        List listOfPinStatusValue=[pinStatus];
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
            // pin16Status: listOfPinStatusValue[i]['pin16Status'],
            // pin17Status: listOfPinStatusValue[i]['pin17Status'],
            // pin18Status: listOfPinStatusValue[i]['pin18Status'],
            // pin19Status: listOfPinStatusValue[i]['pin19Status'],
            // pin20Status: listOfPinStatusValue[i]['pin20Status'],
          );
          await NewDbProvider.instance.insertPinStatusData(pinQuery);
        }
      }



    }
  }


  List<dynamic> devicePinNamesData=[];
  var roomQuery;
  var deviceQuery;
  var aa;









  Future placeQueryFunc()async{
    // placeTypeSingle=  await NewDbProvider.instance.queryPlace();
    queryRows = await NewDbProvider.instance.queryPlace();
    placeTypeSingle=queryRows;

    var pids=PlaceType(
      pId: placeTypeSingle[0]['p_id'].toString(),
      pType: placeTypeSingle[0]['p_type'].toString(),
      user: placeTypeSingle[0]['user']
    );

    pt=pids;
    print('checkPlaces123654 ${pt}');

  }
  Future floorQueryFunc()async{
    // floorTypeSingle=    await NewDbProvider.instance.queryFloor();
    floorQueryRows = await NewDbProvider.instance.queryFloor();
    await NewDbProvider.instance.getPinStatusByDeviceId('DIDM12932021AAAAAA');
    floorQueryData=floorQueryRows;
    floorTypeSingle=floorQueryRows;
    var floor=FloorType(
      fId: floorTypeSingle[0]['f_id'].toString(),
      fName: floorTypeSingle[0]['f_name'].toString(),
      user: floorTypeSingle[0]['user'],
      pId: floorTypeSingle[0]['p_id'].toString()
    );
    fl=floor;

    // floors=floorQueryRows;
    print('floorLocalData ${fl.fName}');



  }
  Future<List<RoomType>> roomQueryFunc()async {
    roomQueryRows = await NewDbProvider.instance.queryRoom();
    List roomTypeSingle=roomQueryRows;
    var id=roomTypeSingle[0]['f_id'].toString();
    roomQueryRows2=roomQueryRows;
    List result= await NewDbProvider.instance.getRoomById(id);
    print('listofroomUsingFloor ${result}');
    room= List.generate(result.length, (index) => RoomType(
      rId: result[index]['r_id'].toString(),
      fId: result[index]['f_id'].toString(),
      rName:result[index]['r_name'].toString(),
      user: result[index]['user'],
    ));
return room;
  }

  deviceQueryFunc()async{
    deviceQueryRows =
    await NewDbProvider.instance.queryDevice();
    print('maindeviceQuery $deviceQueryRows');
    List dv1= deviceQueryRows;
    var roomId=dv1[0]['r_id'];
    // dv=deviceQueryRows;
    List result= await NewDbProvider.instance.getDeviceByRId(roomId.toString());
    print('dvlouye ${result}');
    dvdata= List.generate(result.length, (index) => Device(
        dId: dv1[index]['d_id'].toString(),
        rId: dv1[index]['r_id'].toString(),
        user: dv1[index]['user']
    ));

    // var deviceQuery=Device(
    //   dId: dv1[0]['d_id'].toString(),
    //   rId: dv1[0]['r_id'].toString(),
    //   user: dv1[0]['user']
    // );
    // final device=deviceQuery;
    // dvdata=[device];

  }
  Future devicePinNamesQueryFunc()async{
    devicePinNamesQueryRows =
    await NewDbProvider.instance.queryPinNames();
    print('devicePinQueryFunc  $devicePinNamesQueryRows');

    return devicePinNamesQueryRows;

  }

  Future devicePinSensorQueryFunc()async{
    sensorQueryRows =
    await NewDbProvider.instance.querySensor();
    print('deviceSensorQueryFunc  $sensorQueryRows');

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
            padding: const EdgeInsets.all(20),
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
                    // ignore: deprecated_member_use
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
                        // ignore: deprecated_member_use
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
                        // ignore: deprecated_member_use
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

  backPopPage(context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Do you want to exit'),
      actions: [
        FlatButton(
          child: Text('Yes'),
          onPressed: () => exit(0),
        ),
        // ignore: deprecated_member_use
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
      {@required this.imageURL,
        @required this.tittle,
        @required this.description});
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
