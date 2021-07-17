import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginsignspaceorion/TemporaryUser/EnterPhoneNumber.dart';
import 'package:loginsignspaceorion/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:loginsignspaceorion/dropdown1.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:loginsignspaceorion/signUp.dart';
import 'dart:async';
import 'dropdown2.dart';
import 'login_Screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';


//
// Future  pt;
// Future <FloorType> fl;
// Future<RoomType> rm;
// Future <Device> dv;
// DropDown1 down=new DropDown1();
Box placeBox;
Box floorBox;
Box roomBox;
Box deviceBox;
List roomData;
List floorData;
List placeData;
List deviceData;
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
      '/main': (ctx) =>  HomePage(pt: places.last, fl: floors.last, rm: rm, dv: dv,),
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

  Permission permission;
  PageController pageController = PageController(initialPage: 0);
  DropDown1 down=new DropDown1();

  List<PlaceType> place;
  List<FloorType> floor;







  Timer timer;
  @override
  void initState() {
    super.initState();
    getUid();


    openPlaceBox();
    openFloorBox();
    openRoomBox();
    openDeviceBox();
    getAllPlace().then((data){
      data=data;
    }).then((value) => getAllFloor().then((data){
      data=data;
    })).then((value) => getAllRoom().then((data){
      data=data;
    } )).then((value) =>getAllDevice().then((data){
      data=data;
    } ));

    // print('GetUi Variable-->   ${getUidVariable}');
    Timer.periodic(Duration(seconds: 5), (timer) {_checkInternetConnectivity();

    });


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

  Future openPlaceBox()async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    placeBox=await Hive.openBox('place');
    setState(() {
      // places[0]=placeBox.values.first;
    });
    // print('openPlaceBox ${placeBox.values.last}');
    return;
  }

  Future putData(data)async{
    await placeBox.clear();
    for(var d in data){
      // print('D-->  $d');
      placeBox.add(d);
    }

  }

  Future<bool> getAllPlace()async{
    await openPlaceBox();
    String token= await getToken();
    // String url="http://genorionofficial.herokuapp.com/getallfloors/?p_id=2513962";
    String url="http://genorionofficial.herokuapp.com/getallplaces/";
    var response;
    try{
      response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      // print('Response ${response.body}');

      // var _jsonDecode23=jsonDecode(response.body);
      // print('PlaceResponse ${_jsonDecode23.toString()}');
      // await putData(_jsonDecode23);
      //

      placeData = jsonDecode(response.body);
      await putData(placeData);
      print("Place-->  ${placeData}");
      places = placeData.map((data) => PlaceType.fromJson(data)).toList();
      places= openPlaceBox() as List<PlaceType>;
      print("Place123-->  ${places.toString()}");
    }catch(e){
      print('PlaceCatch $e');

    }

    var myMap=placeBox.toMap().values.toList();
    if(myMap.isEmpty){
      placeData.add('empty');

    }else{
      placeData=myMap;
    }
    // ignore: deprecated_member_use

    // print('PlaceId  ${places[0].pId.toString()}');
    // ignore: deprecated_member_use
    floorData=List(placeData.length-placeData.length);
    return Future.value(true);
  }

  var pId;




  Future openFloorBox()async{

    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    floorBox=await Hive.openBox('floor');

    return;
  }
  Future<bool> getAllFloor()async{
    var myMap;
    var pId;
    await openFloorBox();

    // print('floorlength ${floorData.length}');
    for(int i=0;i<placeData.length;i++){
      // Box poop;
      pId=placeData[i]['p_id'].toString();
      print('dataPlace $pId');
      // print('floorlength ${floorData.length}');
      String token= await getToken();
      print('placeBox ${placeBox.length}');
      final url="http://genorionofficial.herokuapp.com/getallfloors/?p_id="+pId;
      var response;
      try{
        response= await http.get(Uri.parse(url),headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',

        });
        // print('Response ${response.body}');
        // List _jsonDecode=jsonDecode(response.body);
        // print('FloorDecode  $floorData');
        // // floor=_jsonDecode.map((data) => FloorType.fromJson(data)).toList();
        // await putFloorData(_jsonDecode);


        floorData = jsonDecode(response.body);
        await putFloorData(floorData);
        print("Floor-->  ${floorData}");
        floors = floorData.map((data) => FloorType.fromJson(data)).toList();
        print("Floor123-->  ${floors.toString()}");




      }catch(e){
        print('Floor Catch $e');

      }

      myMap=floorBox.toMap().values.toList();
      if(myMap.isEmpty){
        floorData.add('empty');
        print('adding Floor zero ${floorData.toString()}');

      }else{
        floorData=floorData+myMap;


      }

    }
    print('FloorMap  ${myMap.toString()}');
    print('TooString  ${floorData.length.toString()}');
    // ignore: deprecated_member_use
    roomData=List(floorData.length-floorData.length);
    print('FloorIdPrint  ${floorData[0]['f_id']}');
    return Future.value(true);
  }
  Future putFloorData(data)async{
    await floorBox.clear();
    for(var d in data){
      print('Floor Main-->  $d');
      floorBox.add(d);
    }

  }



  Future openRoomBox()async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    roomBox=await Hive.openBox('room');

    return;
  }
  Future<bool> getAllRoom()async{
    await openRoomBox();
    print('dataFloorBox ${floorBox.length.toString()}');
    var fId;
    var myMap;
    for(int i=0;i<floorData.length;i++) {
      fId = floorData[i]['f_id'].toString();
      print('dataFloor Id $fId');


      // String url="http://10.0.2.2:8000/api/data";
      String token= await getToken();
      String url = "http://genorionofficial.herokuapp.com/getallrooms/?f_id=" + fId;
      var response;
      try {
        response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',

        });
        // print('Response ${response.body}');
        // List _jsonDecode = jsonDecode(response.body);
        // print('RoomResponse  $roomData');
        //
        // await putRoomData(_jsonDecode);


        roomData = jsonDecode(response.body);
        await putRoomData(roomData);
        print("room-->  ${placeData}");
        rm = roomData.map((data) => RoomType.fromJson(data)).toList();
        print("room123-->  ${rm.toString()}");


      } catch (e) {
        print('RoomCatch $e');
      }

      myMap = roomBox.toMap().values.toList();
      if (myMap.isEmpty) {
        roomData.add('empty');
      } else {
        roomData = roomData+myMap;
        print('adding room from else ${roomData.toString()}');
      }
    }
    print('MyRoomMap ${myMap.toString()}');
    print('RoomLength ${roomData.length}');
    print('RoomBox ${roomBox.length}');
    deviceData=List(roomData.length-roomData.length);
    // print('RoomIdPrint  ${roomData[0]['r_id']}');
    return Future.value(true);
  }
  Future putRoomData(data)async{
    await roomBox.clear();
    for(var d in data){
      print('Room main-->  $d');
      roomBox.add(d);
    }

  }








  Future openDeviceBox()async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    deviceBox=await Hive.openBox('device');

    return;
  }
  var rId;
  Future<bool> getAllDevice()async{
    await openDeviceBox();
    var myMap;
    // String url="http://10.0.2.2:8000/api/data";
    String token= await getToken();
    for(int i=0;i<roomData.length;i++) {
      rId = roomData[i]['r_id'].toString();


      String url = "http://genorionofficial.herokuapp.com/getalldevices/?r_id=" + rId;
      var response;
      try {
        response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',

        });
        // print('Response ${response.body}');
        // List _jsonDecode = jsonDecode(response.body);
        // print('DeviceResponse  $_jsonDecode');
        //
        // await putDeviceData(_jsonDecode);



        deviceData = jsonDecode(response.body);
        await putDeviceData(deviceData);
        print("deviceData-->  ${deviceData}");
        dv = deviceData.map((data) => Device.fromJson(data)).toList();
        print("devcice123-->  ${dv.toString()}");

      } catch (e) {
        print('DeviceCatch $e');
      }


      myMap = deviceBox.toMap().values.toList();
      if (myMap.isEmpty) {
        deviceBox.add('empty');
      } else {
        deviceData = myMap;
        print('addingdevicefromelse ${deviceData.toString()}');
      }
    }
    print('MyDeviceMap ${myMap.toString()}');
    print('DeviceLength ${deviceData.length}');
    print('DeviceBox ${deviceBox.length}');
    // print("${deviceData[0]['d_id']}");
    return Future.value(true);
  }

  Future putDeviceData(data)async{
    await deviceBox.clear();
    for(var d in data){
      print('DeviceD-->  $d');
      deviceBox.add(d);
    }
    // await deviceBox.clear();

  }


  getUid() async{
    final url=await 'http://genorionofficial.herokuapp.com/getuid/';
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
      print('GetUi Variable-->   ${getUidVariable}');
    }else{
      print(response.statusCode);
    }
  }
  _checkInternetConnectivity()async{
    var result = await Connectivity().checkConnectivity();
    if(result==ConnectionState.none){
      return _showDialog();
    }
  }

  void _showDialog() {
    // dialog implementation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("No Internet"),
        content: Text("Check your internet connection"),
        actions: <Widget>[FlatButton(child: Text("EXIT"), onPressed: () {})],
      ),
    );
  }
  void  read() async {
    final storage = new FlutterSecureStorage();

    token = await storage.read(key: "token");

    openPlaceBox().then((value) => openFloorBox().then((value) => openRoomBox()));
    await    getAllPlace().then((data){
      data=data;
    }).then((value) => getAllFloor().then((data){
      data=data;
    })).then((value) => getAllRoom().then((data){
      data=data;
    } )).then((value) =>getAllDevice().then((data){
      data=data;
    } ));
    print(token);
    if (token != null) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (
      //           context,
      //           ) =>
      //           Container(
      //             child: HomePage(
      //                 ),
      //           )),
      // );

      Navigator.popAndPushNamed(context, '/main');
    }
    // return AlertDialog(
    //   title: Text(token),
    //   content: Text('Do you really want to exit'),
    //   actions: [
    //     FlatButton(
    //       child: Text(token),
    //       onPressed: () => exit(0),
    //     ),
    //   ],
    // );
  }

  /* _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return _showDialog("No Internet", "Check Your Internet");
    }
  }*/

  // pass = await storage.read(key: "p")
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
