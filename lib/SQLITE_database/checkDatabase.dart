// // ignore_for_file: deprecated_member_use, missing_return, duplicate_ignore, unnecessary_brace_in_string_interps
//
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:loginsignspaceorion/models/modeldefine.dart';
// import 'package:http/http.dart' as http;
// import '../home.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'NewDatabase.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//   const MyApp({Key key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   Timer timer;
//   List floorData=[];
//    PlaceType placeType;
//   NewDbProvider dbProvider;
//   List copyFloorData;
//   FloorType floorType;
//   Future floorval;
//   Future flatVal;
//   Future pinVal;
//   Future sensorVal;
//   var ff;
//   List qwe;
//   List<Map<String, dynamic>> queryRows;
//   List placeQueryData;
//   List floorQueryData;
//   List flatQueryData;
//   List floorQueryData2;
//   List<Map<String, dynamic>> floorQueryRows;
//   List<Map<String, dynamic>> flatQueryRows;
//   List<Map<String, dynamic>> roomQueryRows;
//   List<Map<String, dynamic>> deviceQueryRows;
//   List<Map<String, dynamic>> pinStatusQueryRows;
//   List<Map<String, dynamic>> sensorQueryRows;
//   List<Map<String, dynamic>> sensor2QueryRows;
//   List<Map<String, dynamic>> deviceQueryRows2;
//   List<Map<String, dynamic>> devicePinNamesQueryRows;
//   List<Map<String, dynamic>> devicePinNamesQueryRows2;
//   List<Map<String, dynamic>> floorQueryRows2;
//   List<Map<String, dynamic>> roomQueryRows2;
//   List<Map<String, dynamic>> flatQueryRows2;
//
//   Future roomVal;
//   Future deviceVal;
//
//   @override
//   void initState() {
//     super.initState();
//     allAwaitFunction();
//     // timer=Timer.periodic(Duration(seconds: 1), (timer) {
//     //   fetchPlace();
//     //   print('uuu');
//     // });
//     // allAwaitFunction();
//   }
//
//
//   allAwaitFunction()async{
//     fetchPlace().then((value) =>   placeQueryFunc()).then((value) => getAllFloor())
//         .then((value) => floorQueryFunc()).then((value) => getAllFlat()).then((value) => flatQueryFunc()).then((value) => getAllRoom())
//         .then((value) => roomQueryFunc()).then((value) => getAllDevice().then((value) => deviceQueryFunc()));
//     // // .then((value) => getAllDevice()).then((value) => deviceQueryFunc()).then((value) => getPinStatusData())
//     //     .then((value) => devicePinStatusQueryFunc()).then((value) => getAllPinNames()).then((value) => devicePinNamesQueryFunc())
//     //     .then((value) => getSensorData()).then((value) => devicePinSensorQueryFunc());
//
//     await placeQueryFunc();
//     await floorQueryFunc();
//     await flatQueryFunc();
//     await roomQueryFunc();
//
//
//
//
//
//
//
//
//
//
//     await deviceQueryFunc();
//     await devicePinSensorQueryFunc();
//     await devicePinStatusQueryFunc();
//     await devicePinNamesQueryFunc();
//     //  fetchPlace();
//     // await placeQueryFunc();
//     // await returnPlaceQuery();
//     //
//     //  getAllFloor();
//     //  await floorQueryFunc();
//     //
//     //  getAllRoom();
//     // await roomQueryFunc();
//     //
//     //  getAllDevice();
//     // await deviceQueryFunc();
//     //  getSensorData();
//     // await devicePinSensorQueryFunc();
//     //  getPinStatusData();
//     // await devicePinStatusQueryFunc();
//     //  getAllPinNames();
//     // await devicePinNamesQueryFunc();
//
//
//   }
//
//   List placeData;
//   List roomData;
//   List deviceData;
//   var fido;
//   _launchURL() async {
//     const url = 'https://genorionofficial.herokuapp.com/tempuserautodelete';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//   Future<bool> fetchPlace() async {
//     // await openPlaceBox();
//
//     String token = 'ce134736e9c80e75cbdd6c7262533b32c7e7d0f3';
//     final url = 'http://genorion1.herokuapp.com/addyourplace/';
//     final response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Token $token',
//     });
//
//     try {
//       if (response.statusCode > 0) {
//         print(response.statusCode);
//         if (response.statusCode == 200){
//           List placeData = jsonDecode(response.body);
//           for (int i = 0; i < placeData.length; i++) {
//
//             var placeQuery = PlaceType(
//                 pId: placeData[i]['p_id'],
//                 pType: placeData[i]['p_type'],
//                 user: placeData[i]['user']
//             );
//             NewDbProvider.instance.insertPlaceModelData(placeQuery);
//
//
//           }
//         }
//
//
//
//         // places = placeData.map((data) => PlaceType.fromJson(data)).toList();
// print(placeData);
//       }
//     } catch (e) {}
//
//
//   }
//
//
//
//
//   List<FloorType> floors;
//   Future<bool> getAllFloor()async{
//     var pId;
//
//     for(int i=0;i<queryRows.length;i++){
//       // Box poop;
//       pId=queryRows[i]['p_id'].toString();
//       print(pId);
//       String token = 'ce134736e9c80e75cbdd6c7262533b32c7e7d0f3';
//       final url="http://genorion1.herokuapp.com/addyourfloor/?p_id="+pId;
//       final  response= await http.get(Uri.parse(url),headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Token $token',
//
//         });
//       if(response.statusCode>0){
//         print('FloorResponse  ${response.statusCode}');
//          floorData = json.decode(response.body);
//         for(int i=0;i<floorData.length;i++){
//
//           var floorQuery=FloorType(
//             fId: floorData[i]['f_id'],
//             fName: floorData[i]['f_name'].toString(),
//             pId: floorData[i]['p_id'],
//             user: floorData[i]['user']
//           );
//         await  NewDbProvider.instance.insertFloorModelData(floorQuery);
//         }
//       }
//
//
//         floors = floorData.map((data) => FloorType.fromJson(data)).toList();
//
//
//     }
//
//
//     // roomData=List(floorData.length-floorData.length);
//     // return Future.value(true);
//   }
//
//
//
//
//
//
//
//   Future<bool> getAllFlat()async{
// var fId;
//
//     String token='ce134736e9c80e75cbdd6c7262533b32c7e7d0f3';
//     for(int i=0;i<floorData.length;i++){
//       fId=floorData[i]['f_id'].toString();
//       String url='http://genorion1.herokuapp.com/addyourflat/?f_id='+fId;
//       final  response= await http.get(Uri.parse(url),headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Token $token',
//
//       });
//       if(response.statusCode>0){
//
//        List flatData = jsonDecode(response.body);
//         for(int i=0;i<flatData.length;i++){
//
//           var flatQuery=Flat(
//               fId: flatData[i]['f_id'],
//               fltId: flatData[i]['flt_id'],
//               fltName: flatData[i]['flt_name'],
//               user: flatData[i]['user']
//           );
//           await  NewDbProvider.instance.insertFlatModelData(flatQuery);
//           print('FlatFlatQuery  ${flatQuery.fltName}');
//         }
//
//       }
//
//
//       // floors = floorData.map((data) => FloorType.fromJson(data)).toList();
//
//
//     }
//     }
//
//
//     // roomData=List(floorData.length-floorData.length);
//     // return Future.value(true);
//
//
//
//   Future<bool> getAllRoom()async{
//     var fId;
//     for(int i=0;i<flatQueryData.length;i++) {
//       //   print(NewDbProvider.instance.dogs());
//       fId = flatQueryData[i]['flt_id'].toString();
//       print('flt_id  ${fId}');
//
//
//       // String url="http://10.0.2.2:8000/api/data";
//       // String token= await getToken();
//       String token='ce134736e9c80e75cbdd6c7262533b32c7e7d0f3';
//       String url = "http://genorion1.herokuapp.com/addroom/?flt_id="+fId;
//       var response;
//       try {
//         response = await http.get(Uri.parse(url), headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Token $token',
//
//         });
//         roomData = jsonDecode(response.body);
//
//         for(int i=0;i<roomData.length;i++){
//
//
//           roomQuery=RoomType(
//               rId: roomData[i]['r_id'],
//               rName: roomData[i]['r_name'].toString(),
//               fltId: roomData[i]['flt_id'],
//               user: roomData[i]['user']
//           );
//
//           await NewDbProvider.instance.insertRoomModelData(roomQuery);
//
//
//         }
//
//
//
//       } catch (e) {
//         print('RoomCatch $e');
//         // }
//
//       }
//     }
//     return Future.value(true);
//   }
//   List arr=[];
//   Future<bool> getAllDevice()async{
//     var rId;
//     for(int i=0;i<roomQueryRows2.length;i++) {
//       //   print(NewDbProvider.instance.dogs());
//       rId = roomQueryRows2[i]['r_id'].toString();
//       print('roomId  ${rId}');
//
//
//       // String url="http://10.0.2.2:8000/api/data";
//       // String token= await getToken();
//       String token = 'ce134736e9c80e75cbdd6c7262533b32c7e7d0f3';
//       String url = "http://genorion1.herokuapp.com/addyourdevice/?r_id=" +
//           rId;
//       var response;
//       // try {
//       response = await http.get(Uri.parse(url), headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Token $token',
//
//       });
//       deviceData = jsonDecode(response.body);
//       // print('deviceData  ${deviceData}');
//       for (int i = 0; i < deviceData.length; i++) {
//         var deviceQuery = Device(
//             user: deviceData[i]['user'],
//             rId: deviceData[i]['r_id'],
//             dId: deviceData[i]['d_id']
//
//         );
//         print('deviceQueryFunc   ${deviceData}');
//
//         await NewDbProvider.instance.insertDeviceModelData(deviceQuery);
//       }
//     }
//     return Future.value(true);
//   }
//   Future<bool> getAllPinNames()async{
//     String token = 'ce134736e9c80e75cbdd6c7262533b32c7e7d0f3';
//     var did;
//     print('pinNamesFunction $deviceQueryRows');
//     for(int i=0;i<deviceQueryRows.length;i++){
//
//       did=deviceQueryRows[i]['d_id'];
//       print('didqwe ${did}');
//       String url = "http://genorion1.herokuapp.com/getpostdevicePinStatus/?d_id="+did;
//       // try {
//       final   response = await http.get(Uri.parse(url), headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Token $token',
//
//       });
//       if(response.statusCode==200) {
//         var  devicePinNamesData=json.decode(response.body);
//         DevicePin devicePin=DevicePin.fromJson(devicePinNamesData);
//
//         List listOfPinNames=[devicePinNamesData,];
//         print('QWERTY  ${listOfPinNames}');
//         for (int i = 0; i < listOfPinNames.length; i++) {
//
//           print('devicePinData ${listOfPinNames}');
//
//           var devicePinNamesQuery = DevicePin(
//             id: listOfPinNames[i]['id'],
//             dId: listOfPinNames[i]['d_id'].toString(),
//             pin1Name: listOfPinNames[i]['pin1Name'].toString(),
//             pin2Name: listOfPinNames[i]['pin2Name'].toString(),
//             pin3Name: listOfPinNames[i]['pin3Name'].toString(),
//             pin4Name: listOfPinNames[i]['pin4Name'].toString(),
//             pin5Name: listOfPinNames[i]['pin5Name'].toString(),
//             pin6Name: listOfPinNames[i]['pin6Name'].toString(),
//             pin7Name: listOfPinNames[i]['pin7Name'].toString(),
//             pin8Name: listOfPinNames[i]['pin8Name'].toString(),
//             pin9Name: listOfPinNames[i]['pin9Name'].toString(),
//             pin10Name: listOfPinNames[i]['pin10Name'].toString(),
//             pin11Name: listOfPinNames[i]['pin11Name'].toString(),
//             pin12Name: listOfPinNames[i]['pin12Name'].toString(),
//           );
//           print('devicePinNamesInsertQuery    ${devicePinNamesQuery}');
//           print('devicePinQueryToJson    ${devicePinNamesQuery.toJson()}');
//           await NewDbProvider.instance.insertDevicePinNames(devicePinNamesQuery);
//         }
//       }
//     }
//
//
//   }
//   Future<bool> getSensorData() async {
//     // arr=[arr.length-arr.length];
//     String token = 'ce134736e9c80e75cbdd6c7262533b32c7e7d0f3';
//
//     var did;
//     print('SensorFunction $deviceQueryRows');
//     for(int i=0;i<deviceQueryRows.length;i++) {
//       did=deviceQueryRows[i]['d_id'];
//       print('insideLoop $did');
//       String url = "http://genorion1.herokuapp.com/tensensorsdata/?d_id="+did.toString();
//       // final url="http://genorionofficial.herokuapp.com/tensensorsdata/?d_id="+did;
//       final response = await http.get(Uri.parse(url),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Token $token',
//           });
//       if(response.statusCode==200){
//         print('sensorResponse  ${response.statusCode}');
//
//       }
//       var arr = jsonDecode(response.body);
//       List listOfPinSensor=[arr,];
//       for (int i = 0; i < listOfPinSensor.length; i++) {
//         var sensorQuery = SensorData(
//           dId: listOfPinSensor[i]['d_id'],
//           sensor1: listOfPinSensor[i]['sensor1'],
//           sensor2: listOfPinSensor[i]['sensor2'],
//           sensor3: listOfPinSensor[i]['sensor3'],
//           sensor4: listOfPinSensor[i]['sensor4'],
//           sensor5: listOfPinSensor[i]['sensor5'],
//           sensor6: listOfPinSensor[i]['sensor6'],
//           sensor7: listOfPinSensor[i]['sensor7'],
//           sensor8: listOfPinSensor[i]['sensor8'],
//           sensor9: listOfPinSensor[i]['sensor9'],
//           sensor10: listOfPinSensor[i]['sensor10'],
//         );
//         print('deviceSensorJson    ${sensorQuery.toJson()}');
//         await NewDbProvider.instance.insertSensorData(sensorQuery);
//       }
//
//     }
//   }
//   Future<bool> getPinStatusData() async {
//     // arr=[arr.length-arr.length];
//     String token = 'ce134736e9c80e75cbdd6c7262533b32c7e7d0f3';
//
//     var did;
//     print('PinStatusFunction $deviceQueryRows');
//     for(int i=0;i<deviceQueryRows.length;i++) {
//       did=deviceQueryRows[i]['d_id'];
//       print('insideLoop $did');
//       String url = "http://genorion1.herokuapp.com/getpostdevicePinStatus/?d_id="+did.toString();
//       // final url="http://genorionofficial.herokuapp.com/tensensorsdata/?d_id="+did;
//       final response = await http.get(Uri.parse(url),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Token $token',
//           });
//       int index=0;
//       if(response.statusCode==200){
//         print('PinStatusResponse  ${response.statusCode}');
//         var pinStatus= jsonDecode(response.body);
//         PinStatus devicePinStatus=PinStatus.fromJson(pinStatus);
//         List listOfPinStatusValue=[pinStatus];
//         for (int i = 0; i < listOfPinStatusValue.length; i++) {
//           var pinQuery = PinStatus(
//             dId: listOfPinStatusValue[i]['d_id'],
//             pin1Status: listOfPinStatusValue[i]['pin1Status'],
//             pin2Status: listOfPinStatusValue[i]['pin2Status'],
//             pin3Status: listOfPinStatusValue[i]['pin3Status'],
//             pin4Status: listOfPinStatusValue[i]['pin4Status'],
//             pin5Status: listOfPinStatusValue[i]['pin5Status'],
//             pin6Status: listOfPinStatusValue[i]['pin6Status'],
//             pin7Status: listOfPinStatusValue[i]['pin7Status'],
//             pin8Status: listOfPinStatusValue[i]['pin8Status'],
//             pin9Status: listOfPinStatusValue[i]['pin9Status'],
//             pin10Status: listOfPinStatusValue[i]['pin10Status'],
//             pin11Status: listOfPinStatusValue[i]['pin11Status'],
//             pin12Status: listOfPinStatusValue[i]['pin12Status'],
//             pin13Status: listOfPinStatusValue[i]['pin13Status'],
//             pin14Status: listOfPinStatusValue[i]['pin14Status'],
//             pin15Status: listOfPinStatusValue[i]['pin15Status'],
//             pin16Status: listOfPinStatusValue[i]['pin16Status'],
//             pin17Status: listOfPinStatusValue[i]['pin17Status'],
//             pin18Status: listOfPinStatusValue[i]['pin18Status'],
//             pin19Status: listOfPinStatusValue[i]['pin19Status'],
//             pin20Status: listOfPinStatusValue[i]['pin20Status'],
//           );
//           await NewDbProvider.instance.insertPinStatusData(pinQuery);
//         }
//       }
//
//
//
//     }
//   }
//
//
// List<dynamic> devicePinNamesData=[];
//   var roomQuery;
//   var deviceQuery;
//   var aa;
//   Future returnPlaceQuery(){
//     return NewDbProvider.instance.queryPlace();
//   }
//   Future returnFloorQuery(String pId){
//
//     return NewDbProvider.instance.queryFloor();
//   }
//
//   Future returnRoomQuery(String fId){
//
//     return NewDbProvider.instance.queryRoom();
//   }
//   Future returnFlatQuery(String fId){
//
//     return NewDbProvider.instance.queryFlat();
//   }
//   Future returnDeviceQuery(String rId){
//
//     return NewDbProvider.instance.queryDevice();
//   }
//
//
//
//
//
//
//
//
//   Future placeQueryFunc()async{
//   queryRows =
//       await NewDbProvider.instance.queryPlace();
//
// }
//  Future floorQueryFunc()async{
//     floorQueryRows =
//     await NewDbProvider.instance.queryFloor();
//     setState(() {
//       floorQueryData=floorQueryRows;
//     });
//
//
//   }
//   Future flatQueryFunc()async{
//     flatQueryRows =
//     await NewDbProvider.instance.queryFlat();
//     setState(() {
//       flatQueryData=flatQueryRows;
//     });
//
//
//   }
//   Future roomQueryFunc()async {
//     roomQueryRows =
//     await NewDbProvider.instance.queryRoom();
//     setState(() {
//       roomQueryRows2=roomQueryRows;
//     });
//   }
//
//   deviceQueryFunc()async{
//     deviceQueryRows =
//     await NewDbProvider.instance.queryDevice();
//   print('func  ${deviceQueryRows}');
//    await getAllPinNames();
//    await getSensorData();
//    await getPinStatusData();
//   }
//   Future devicePinNamesQueryFunc()async{
//     devicePinNamesQueryRows =
//     await NewDbProvider.instance.queryPinNames();
//     print('devicePinQueryFunc  ${devicePinNamesQueryRows}');
//     setState(() {
//
//     });
//     return devicePinNamesQueryRows;
//
//   }
//
//   Future devicePinSensorQueryFunc()async{
//     sensorQueryRows =
//     await NewDbProvider.instance.querySensor();
//     print('devicePinQueryFunc  ${sensorQueryRows}');
//     setState(() {
//
//     });
//     return sensorQueryRows;
//
//   }
//   Future devicePinStatusQueryFunc()async{
//     pinStatusQueryRows= await NewDbProvider.instance.queryPinStatus();
//     return pinStatusQueryRows;
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // ignore: prefer_const_literals_to_create_immutables
//             children: <Widget>[
//               FlatButton(
//                 onPressed: () async {
//                  // await getAllRoom();
//                   queryRows =
//                   await NewDbProvider.instance.queryPlace();
//                         print(queryRows);
//
//                 },
//                 child: const Text('Place Query'),
//                 color: Colors.red,
//               ),
//
//
//               FlatButton(
//                 onPressed: () async {
//
//                    floorQueryRows =
//                   await NewDbProvider.instance.queryFloor();
//                    setState(() {
//                      floorQueryData=floorQueryRows;
//                    });
//                    // int index=0;
//                   print(floorQueryData);
//                    getAllRoom();
//                 },
//                 child: const Text(' Floor Query'),
//                 color: Colors.red,
//               ),
//               FlatButton(
//                 onPressed: () async {
//
//                   flatQueryRows =
//                   await NewDbProvider.instance.queryFlat();
//                   // setState(() {
//                   //   floorQueryData=floorQueryRows;
//                   // });
//                   // int index=0;
//                   print(flatQueryRows);
//                   // getAllRoom();
//                 },
//                 child: const Text(' Flat Query'),
//                 color: Colors.red,
//               ),
//
//               FlatButton(
//                 onPressed: () async {
//                   // getAllRoom();
//                   roomQueryRows =
//                   await NewDbProvider.instance.queryRoom();
//                   print(roomQueryRows);
//
//                 },
//                 child: const Text(' Room Query'),
//                 color: Colors.red,
//               ),
//               FlatButton(
//                 onPressed: () async {
//                   deviceQueryRows =
//                   await NewDbProvider.instance.queryDevice();
//
//                   print('deviceQueryRows ${deviceQueryRows}');
//
//                 },
//                 child: const Text(' Device Query'),
//                 color: Colors.red,
//               ),
//               FlatButton(
//                 onPressed: () async {
//                   sensorQueryRows =
//                   await NewDbProvider.instance.querySensor();
//                   print('sensorQueryRows ${sensorQueryRows}');
//
//                 },
//                 child: const Text(' Sensor'),
//                 color: Colors.red,
//               ),
//               FlatButton(
//                 onPressed: () async {
//                   // await getAllPinNames();
//                   // getAllRoom();
//                   devicePinNamesQueryRows =
//                   await NewDbProvider.instance.queryPinNames();
//                   print('devicePinQueryRowsNames ${devicePinNamesQueryRows}');
//
//                 },
//                 child: const Text(' PinNames'),
//                 color: Colors.red,
//               ),
//               FlatButton(
//                 onPressed: () async {
//                 int aa= await  NewDbProvider.instance.updatePLaceNameLocal(PlaceType(
//                     pId: 4.toString(),
//                     pType: "check"
//                   ));
//                   // NewDbProvider.instance.insertFaltu({
//                   // NewDbProvider.faltuId:4,
//                   // NewDbProvider.faltuName:"aa",
//                   // });
//                   // var aa=await NewDbProvider.instance.queryFaltu();
//                   //
//                   print(aa);
//
//                 },
//                 child: const Text('Place Name Update'),
//                 color: Colors.red,
//               ),
//
//               FlatButton(
//                 onPressed: () async {
//                   pinStatusQueryRows= await NewDbProvider.instance.queryPinStatus();
//                   print(pinStatusQueryRows);
//
//                 },
//                 child: const Text(' Pin Status'),
//                 color: Colors.red,
//               ),
//
//               SizedBox(height:30),
//               FutureBuilder(
//                   future: returnPlaceQuery(),
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width * 2,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black,
//                                   blurRadius: 30,
//                                   offset: Offset(20, 20))
//                             ],
//                             border: Border.all(
//                               color: Colors.black,
//                               width: 0.5,
//                             )),
//                         child: DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(15),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.black),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                           dropdownColor: Colors.white70,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 28,
//                           hint: Text('Select Place'),
//                           isExpanded: true,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//
//                           items: queryRows.map((selectedPlace) {
//
//                             return DropdownMenuItem<String>(
//                               value: selectedPlace.toString(),
//                               child: Text("${selectedPlace['p_type']}"),
//                             );
//                           }).toList(),
//                           onChanged: (selectedPlace)async {
//                             floorval=null;
//                             floorQueryRows2=null;
//                             print('Floorqwe  ${floorQueryRows2}');
//                             var placeid=selectedPlace.substring(7,14);
//
//                              aa= await NewDbProvider.instance.getFloorById(placeid.toString());
//                             print('AA  ${aa}');
//                             floorval=null;
//                             setState(() {
//                               floorQueryRows2=aa;
//                               floorval=returnFloorQuery(placeid);
//                               returnFloorQuery(placeid);
//                             });
//                             print('Floorqwe  ${floorQueryRows2}');
//
//
//                              // qwe= ;
//
//                                 },
//                           // items:snapshot.data
//                         ),
//                       );
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   }),
//               SizedBox(height:20),
//               FutureBuilder(
//                   future: floorval,
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width * 2,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black,
//                                   blurRadius: 30,
//                                   offset: Offset(20, 20))
//                             ],
//                             border: Border.all(
//                               color: Colors.black,
//                               width: 0.5,
//                             )),
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(15),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.black),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//
//                           dropdownColor: Colors.white70,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 28,
//                           hint: Text('Select Floor'),
//                           isExpanded: true,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           items: floorQueryRows2.map((selectedFloor) {
//                             return DropdownMenuItem(
//                               value: selectedFloor.toString(),
//                               child: Text("${selectedFloor['f_name']}"),
//                             );
//                           }).toList(),
//                           onChanged: (selectedFloor)async {
//                             print('Floor selected $selectedFloor');
//                             var floorId=selectedFloor.substring(7,14);
//                               var getFlat= await NewDbProvider.instance.getFlatByFId(floorId.toString());
//                               print(getFlat);
//                             setState(() {
//                               flatVal=returnFlatQuery(floorId);
//                               flatQueryRows2=getFlat;
//
//                             });
//                             print('forRoom  ${roomQueryRows2}');
//
//
//
//                             returnFloorQuery(floorId);
//
//                           },
//                           // items:snapshot.data
//                         ),
//                       );
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   }),
//               SizedBox(height:20),
//               FutureBuilder(
//                   future: flatVal,
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width * 2,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black,
//                                   blurRadius: 30,
//                                   offset: Offset(20, 20))
//                             ],
//                             border: Border.all(
//                               color: Colors.black,
//                               width: 0.5,
//                             )),
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(15),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.black),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//
//                           dropdownColor: Colors.white70,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 28,
//                           hint: Text('Select Flat'),
//                           isExpanded: true,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           items: flatQueryRows2.map((selectedFlat) {
//                             return DropdownMenuItem(
//                               value: selectedFlat.toString(),
//                               child: Text("${selectedFlat['flt_name']}"),
//                             );
//                           }).toList(),
//                           onChanged: (selectedFlat)async {
//                             print('Flat selected $selectedFlat');
//                             var flatId=selectedFlat.substring(9,16);
//                             print(flatId);
//                             var  aa= await NewDbProvider.instance.getRoomById(flatId.toString());
//                             print('AA  ${aa}');
//                             setState(() {
//                               roomQueryRows2=aa;
//                               roomVal=returnRoomQuery(flatId);
//                             });
//                             print('forRoom  ${roomQueryRows2}');
//
//
//
//                             // returnFloorQuery(floorId);
//
//                           },
//                           // items:snapshot.data
//                         ),
//                       );
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   }),
//
//               SizedBox(height:20),
//               FutureBuilder(
//                   future: roomVal,
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width * 2,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black,
//                                   blurRadius: 30,
//                                   offset: Offset(20, 20))
//                             ],
//                             border: Border.all(
//                               color: Colors.black,
//                               width: 0.5,
//                             )),
//                         child: DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(15),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.black),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                           dropdownColor: Colors.white70,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 28,
//                           hint: Text('Select Room'),
//                           isExpanded: true,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//
//                           items:  roomQueryRows2.map((selectedRoom) {
//
//                             return DropdownMenuItem<String>(
//                               value: selectedRoom.toString(),
//                               child: Text("${selectedRoom['r_name']}"),
//                             );
//                           }).toList(),
//                           onChanged: (selectedRoom)async {
//                             var roomId=selectedRoom.substring(7,14);
//                             print('roomId ${roomId}');
//                             var  aa= await NewDbProvider.instance.getDeviceByRId(roomId.toString());
//                             print('deviceQueryRows ${aa}');
//                                 setState(() {
//                                   deviceQueryRows2=aa;
//                                   deviceVal=returnDeviceQuery(roomId);
//                                 });
//                             print('DeviceCheck  ${aa}');
//                             },
//                           // items:snapshot.data
//                         ),
//                       );
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   }),
//               SizedBox(height:20),
//               FutureBuilder(
//                   future: deviceVal,
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width * 2,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black,
//                                   blurRadius: 30,
//                                   offset: Offset(20, 20))
//                             ],
//                             border: Border.all(
//                               color: Colors.black,
//                               width: 0.5,
//                             )),
//                         child: DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(15),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.black),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                           dropdownColor: Colors.white70,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 28,
//                           hint: Text('Select Device'),
//                           isExpanded: true,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//
//                           items: deviceQueryRows.map((selectedDevice) {
//
//                             return DropdownMenuItem<String>(
//                               value: selectedDevice.toString(),
//                               child: Text("${selectedDevice['d_id']}"),
//                             );
//                           }).toList(),
//                           onChanged: (selectedDevice)async {
//
//
//                             devicePinNamesQueryRows=  await NewDbProvider.instance.queryPinNames();
//                             pinStatusQueryRows= await NewDbProvider.instance.queryPinStatus();
//                             var deviceId=selectedDevice.substring(31,49);
//                             print('qwedsaqw   $deviceId ');
//                             var  aa= await NewDbProvider.instance.getPinNamesByDeviceId(deviceId.toString());
//                             var sensor= await NewDbProvider.instance.getSensorByDeviceId(deviceId.toString());
//                             var pinstatus=await NewDbProvider.instance.getPinStatusByDeviceId(deviceId.toString());
//                             print('poiuy ${sensor}');
//                             setState(() {
//                               devicePinNamesQueryRows2=aa;
//                               sensor2QueryRows=sensor;
//                               pinVal=devicePinNamesQueryFunc();
//                               sensorVal=devicePinSensorQueryFunc();
//
//                             });
//                             print('PiNamesCheck   $devicePinNamesQueryRows2 ');
//                             print('SensorCheck   $sensor2QueryRows ');
//                           },
//
//                         ),
//                       );
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   }),
//               FutureBuilder(
//                   future: pinVal,
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width * 2,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black,
//                                   blurRadius: 30,
//                                   offset: Offset(20, 20))
//                             ],
//                             border: Border.all(
//                               color: Colors.black,
//                               width: 0.5,
//                             )),
//                         child: DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(15),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.black),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                           dropdownColor: Colors.white70,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 28,
//                           hint: Text('Select Device'),
//                           isExpanded: true,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//
//                           items: devicePinNamesQueryRows2.map((selectedDevice) {
//
//                             return DropdownMenuItem<String>(
//                               value: selectedDevice.toString(),
//                               child: Text("${selectedDevice['pin1name']}"),
//                             );
//                           }).toList(),
//                           onChanged: (selectedDevice)async {
//
//
//                             // devicePinNamesQueryRows=  await NewDbProvider.instance.queryPinNames();
//                             // pinStatusQueryRows= await NewDbProvider.instance.queryPinStatus();
//                             // var deviceId=selectedDevice.substring(31,49);
//                             // print('qwedsaqw   $pinStatusQueryRows ');
//                             // var  aa= await NewDbProvider.instance.getPinNamesByDeviceId(deviceId.toString());
//                             // var sensor= await NewDbProvider.instance.getSensorByDeviceId(deviceId.toString());
//                             // // print('poiuy ${sensor}');
//                             // setState(() {
//                             //   devicePinNamesQueryRows2=aa;
//                             //   sensor2QueryRows=sensor;
//                             //   pinVal=devicePinNamesQueryFunc();
//                             //   sensorVal=devicePinSensorQueryFunc();
//                             //
//                             // });
//                             // print('PiNamesCheck   $aa ');
//                             // print('SensorCheck   $sensor2QueryRows ');
//                           },
//
//                         ),
//                       );
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   }),
//               Container(
//                 height: 789,
//               color: Colors.red,
//                 child: FutureBuilder(
//                   future: sensorVal,
//                   builder: (context,snapshot){
//                     if(snapshot.hasData){
//                       return Column(
//                         children: [
//                           Expanded(
//                               child: ListView.builder(
//                                   itemCount: sensor2QueryRows.length,
//                                   itemBuilder: (context,index){
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Card(
//                                         semanticContainer:true,
//                                         shadowColor: Colors.grey,
//                                         child: ListTile(
//                                           title: Text(sensor2QueryRows[index]['sensor1'].toString()),
//                                           trailing: Text(sensor2QueryRows[index]['sensor2'].toString()),
//                                           subtitle: Text(sensor2QueryRows[index]['sensor1'].toString()),
//
//                                         ),
//                                       ),
//                                     );
//
//                                   }
//                               )),
//
//
//                         ],
//                       );
//                     }else{
//                       return Center(child: Text('No Data'),);
//                     }
//                   },
//                 ),
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
