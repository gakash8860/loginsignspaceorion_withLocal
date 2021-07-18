// ignore_for_file: deprecated_member_use, missing_return, duplicate_ignore, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import '../home.dart';
import 'NewDatabase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer;
  List floorData;
   PlaceType placeType;
  NewDbProvider dbProvider;
  List copyFloorData;
  FloorType floorType;
  Future floorval;


  @override
  void initState() {
    super.initState();
    placeQueryFunc();
    fetchPlace().then((value) => getAllFloor()).then((value) => getAllRoom()).then((value) =>     getAllDevice());
      // NewDbProvider.instance.dogs();
    // readData();

    returnPlaceQuery();
    // timer=Timer.periodic(Duration(milliseconds: 5), (timer) { fetchPlace();});
  }
  List placeData;
  var fido;
  Future<List<PlaceType>> fetchPlace() async {
    // await openPlaceBox();
    String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';
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
          setState(() {
             fido = PlaceType(
                pId: placeData[i]['p_id'],
                pType: placeData[i]['p_type'],
                user: placeData[i]['user']
            );

          });

    NewDbProvider.instance.insertPlaceModelData(fido);

          // NewDbProvider.instance.insertPlaceData({
          //   NewDbProvider.columnPlaceName: placeData[i]['p_type'],
          //   NewDbProvider.columnPlaceId: placeData[i]['p_id']
          // });

          // }
        }
         // NewDbProvider.instance.queryAll();

        places = placeData.map((data) => PlaceType.fromJson(data)).toList();

      }
    } catch (e) {}


  }



List copy=[];
  List<FloorType> floors;
  Future<bool> getAllFloor()async{
    var pId;

    for(int i=0;i<placeData.length;i++){
      // Box poop;
      pId=placeData[i]['p_id'].toString();
      // print(pId);
      String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';
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
          // NewDbProvider.instance.insertFloorData({
          //
          //   NewDbProvider.columnFloorName: floorData[i]['f_name'].toString(),
          //   NewDbProvider.columnFloorId: floorData[i]['f_id'],
          //   NewDbProvider.columnFloorPlaceId: floorData[i]['p_id']
          // });
        }
      }


        floors = floorData.map((data) => FloorType.fromJson(data)).toList();
      // floorData=floorData+floors;


    }


    // roomData=List(floorData.length-floorData.length);
    // return Future.value(true);
  }



List roomData;
List deviceData;
List devicePinData;
  var roomQuery;
  var deviceQuery;
  var aa;
  Future returnPlaceQuery(){
    return NewDbProvider.instance.queryAll();
  }
  Future returnFloorQuery(String pId){

    return NewDbProvider.instance.queryFloor();
  }

  Future returnRoomQuery(String pId){

    return NewDbProvider.instance.queryRoom();
  }
  Future returnDeviceQuery(){

    return NewDbProvider.instance.queryDevice();
  }

Future roomVal;
Future deviceVal;
  Future<bool> getAllRoom()async{
var fId;
    for(int i=0;i<floorQueryData.length;i++) {
    //   print(NewDbProvider.instance.dogs());
      fId = floorQueryData[i]['f_id'].toString();
print('fId  ${fId}');


      // String url="http://10.0.2.2:8000/api/data";
      // String token= await getToken();
      String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';
      String url = "http://genorionofficial.herokuapp.com/getallrooms/?f_id="+fId;
      var response;
      try {
        response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',

        });
        roomData = jsonDecode(response.body);

        for(int i=0;i<roomData.length;i++){


           roomQuery=RoomType(
            rId: roomData[i]['r_id'],
            rName: roomData[i]['r_name'].toString(),
            fId: roomData[i]['f_id'],
            user: roomData[i]['user']
          );

          await NewDbProvider.instance.insertRoomModelData(roomQuery);

          // NewDbProvider.instance.insertRoomData({
          //
          //   NewDbProvider.columnRoomName: roomData[i]['r_name'].toString(),
          //   NewDbProvider.columnRoomId: roomData[i]['r_id'],
          //   NewDbProvider.columnRoomFloorId: roomData[i]['f_id'],
          //   // NewDbProvider.columnFloorPlaceId: floorData[i]['p_id']
          // });
        }

        //
        // for(int i=0;i<floorData.length;i++) {
        //   // NewDbProvider.instance.insertRoomData({
        //   //
        //   //   NewDbProvider.columnRoomName: roomData[i]['r_name'].toString(),
        //   //   NewDbProvider.columnRoomId: roomData[i]['r_id'],
        //   //   NewDbProvider.columnRoomFloorId: roomData[i]['f_id'],
        //   //   // NewDbProvider.columnFloorPlaceId: floorData[i]['p_id']
        //   // });
        //   // }
        //   // rm = roomData.map((data) => RoomType.fromJson(data)).toList();
        //   // print("room123-->  ${rm.toString()}");
        // }

      } catch (e) {
        print('RoomCatch $e');
        // }

      }
    }

    // deviceData=List(roomData.length-roomData.length);
    // print('RoomIdPrint  ${roomData[0]['r_id']}');
    return Future.value(true);
  }

  Future<bool> getAllDevice()async{
    var rId;
    for(int i=0;i<anotherRoomQueryRows123.length;i++) {
      //   print(NewDbProvider.instance.dogs());
      rId = anotherRoomQueryRows123[i]['r_id'].toString();
      print('roomId  ${rId}');


      // String url="http://10.0.2.2:8000/api/data";
      // String token= await getToken();
      String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';
      String url = "http://genorionofficial.herokuapp.com/getalldevices/?r_id="+rId;
      var response;
      // try {
        response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',

        });
      List  deviceData = jsonDecode(response.body);
          // print('deviceData  ${deviceData}');
        for(int i=0;i<deviceData.length;i++){
        var  deviceQuery=Device(
            user: deviceData[i]['user'],
            rId:  deviceData[i]['r_id'],
            dId: deviceData[i]['d_id']

          );
          print('deviceQuery   ${deviceData[i]['d_id'].runtimeType}' );

          await NewDbProvider.instance.insertDeviceModelData(deviceQuery);




          // NewDbProvider.instance.insertRoomData({
          //
          //   NewDbProvider.columnRoomName: roomData[i]['r_name'].toString(),
          //   NewDbProvider.columnRoomId: roomData[i]['r_id'],
          //   NewDbProvider.columnRoomFloorId: roomData[i]['f_id'],
          //   // NewDbProvider.columnFloorPlaceId: floorData[i]['p_id']
          // });
        }

        //
        // for(int i=0;i<floorData.length;i++) {
        //   // NewDbProvider.instance.insertRoomData({
        //   //
        //   //   NewDbProvider.columnRoomName: roomData[i]['r_name'].toString(),
        //   //   NewDbProvider.columnRoomId: roomData[i]['r_id'],
        //   //   NewDbProvider.columnRoomFloorId: roomData[i]['f_id'],
        //   //   // NewDbProvider.columnFloorPlaceId: floorData[i]['p_id']
        //   // });
        //   // }
        //   // rm = roomData.map((data) => RoomType.fromJson(data)).toList();
        //   // print("room123-->  ${rm.toString()}");
        // }

      // } catch (e) {
      //   print('RoomCatch $e');
      //   // }
      //
      // }
    }

    // deviceData=List(roomData.length-roomData.length);
    // print('RoomIdPrint  ${roomData[0]['r_id']}');
    return Future.value(true);
  }



  Future<bool> getAllPinStatus()async{
    String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';
    var did;
    for(int i=0;i<deviceQueryRows.length;i++){
      did=deviceQueryRows[i]['d_id'];
      String url = "http://genorionofficial.herokuapp.com/getpostdevicePinStatus/?d_id="+did;
      var response;
      // try {
        response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',

        });
        var devicePinData = jsonDecode(response.body);

      print('devicePin ${devicePinData}');
        for(int i=0;i<devicePinData.length;i++){


         var devicePinQuery=DevicePin(
              pin1Name: devicePinData['pin1Status'].toString(),
              // pin2Name: devicePinData['pin2Status'],
              // pin3Name: devicePinData['pin3Status'],
              // pin4Name: devicePinData['pin4Status'],
              // pin5Name: devicePinData['pin5Status'],
              // pin6Name: devicePinData['pin6Status'],
              // pin7Name: devicePinData['pin7Status'],
              // pin8Name: devicePinData['pin8Status'],
              // pin9Name: devicePinData['pin9Status'],
              // pin10Name: devicePinData['pin10Status'],
              // pin11Name: devicePinData['pin11Status'],
              // pin12Name: devicePinData['pin12Status'],
          );

          await NewDbProvider.instance.insertDevicePin(devicePinQuery);

          // NewDbProvider.instance.insertRoomData({
          //
          //   NewDbProvider.columnRoomName: roomData[i]['r_name'].toString(),
          //   NewDbProvider.columnRoomId: roomData[i]['r_id'],
          //   NewDbProvider.columnRoomFloorId: roomData[i]['f_id'],
          //   // NewDbProvider.columnFloorPlaceId: floorData[i]['p_id']
          // });
        }

        //
        // for(int i=0;i<floorData.length;i++) {
        //   // NewDbProvider.instance.insertRoomData({
        //   //
        //   //   NewDbProvider.columnRoomName: roomData[i]['r_name'].toString(),
        //   //   NewDbProvider.columnRoomId: roomData[i]['r_id'],
        //   //   NewDbProvider.columnRoomFloorId: roomData[i]['f_id'],
        //   //   // NewDbProvider.columnFloorPlaceId: floorData[i]['p_id']
        //   // });
        //   // }
        //   // rm = roomData.map((data) => RoomType.fromJson(data)).toList();
        //   // print("room123-->  ${rm.toString()}");
        // }

      // } catch (e) {
      //   print('RoomCatch $e');
      //   // }
      //
      // }
    }
    print('did12 ${did}');

  }
placeQueryFunc()async{
  queryRows =
      await NewDbProvider.instance.queryAll();

}

  var ff;
  List qwe;
readData()async{
  List<Map<String, dynamic>> queryRows =
      await NewDbProvider.instance.queryAll();
  ff=queryRows;
  // print(ff[0]['p_type']);
}
  List<Map<String, dynamic>> queryRows;
List placeQueryData;
List floorQueryData;
List floorQueryData2;
  List<Map<String, dynamic>> floorQueryRows;
  List<Map<String, dynamic>> roomQueryRows;
  List<Map<String, dynamic>> deviceQueryRows;
  List<Map<String, dynamic>> deviceQueryRows2;
  List<Map<String, dynamic>> devicePinQueryRows;
  List<Map<String, dynamic>> anotherFloorQueryRows;
  List<Map<String, dynamic>> anotherFloorQueryRows123;
  List<Map<String, dynamic>> anotherRoomQueryRows123;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[

              // FlatButton(
              //   onPressed: () async {
              //     int i = await NewDbProvider.instance.insertPlaceData({
              //       NewDbProvider.columnPlaceName: 'Place2',
              //       NewDbProvider.columnPlaceId: '702'
              //     });
              //     print(
              //         'insert id is $i   ->  ${NewDbProvider.columnPlaceId.toString()}');
              //     print(
              //         'insert id is $i   ->  ${NewDbProvider.columnPlaceName.toString()}');
              //   },
              //   child: const Text('insert'),
              //   color: Colors.red,
              // ),
              FlatButton(
                onPressed: () async {
                  // int rowEffected = await NewDbProvider.instance.delete(fl);
                  // print(rowEffected);
                },
                child: const Text('delete'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                 // await getAllRoom();
                  queryRows =
                  await NewDbProvider.instance.queryAll();


                },
                child: const Text('Place Query'),
                color: Colors.red,
              ),


              FlatButton(
                onPressed: () async {

                   floorQueryRows =
                  await NewDbProvider.instance.queryFloor();
                   setState(() {
                     floorQueryData=floorQueryRows;
                   });
                   // int index=0;
                  print(floorQueryData);
                   getAllRoom();
                },
                child: const Text(' Floor Query'),
                color: Colors.red,
              ),

              FlatButton(
                onPressed: () async {
                  // getAllRoom();
                  roomQueryRows =
                  await NewDbProvider.instance.queryRoom();
                  // setState(() {
                  //   floorQueryData=floorQueryRows;
                  // });
                  // int index=0;
                  print(roomQueryRows);

                },
                child: const Text(' Room Query'),
                color: Colors.red,
              ),
              // FlatButton(
              //   onPressed: () async {
              //     // anotherFloorQueryRows =
              //     // await NewDbProvider.instance.queryAnotherFloor();
              //     // setState(() {
              //     //   floorQueryData=floorQueryRows;
              //     // });
              //     // int index=0;
              //     // print(anotherFloorQueryRows);
              //
              //   },
              //   child: const Text(' Floor Query2'),
              //   color: Colors.red,
              // ),
              //
              SizedBox(height:30),
              FutureBuilder(
                  future: returnPlaceQuery(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 2,
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
                        child: DropdownButtonFormField<String>(
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
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),

                          items: queryRows.map((selectedPlace) {

                            return DropdownMenuItem<String>(
                              value: selectedPlace.toString(),
                              child: Text("${selectedPlace['p_type']}"),
                            );
                          }).toList(),
                          onChanged: (selectedPlace)async {
                            var placeid=selectedPlace.substring(7,14);

                             aa= await NewDbProvider.instance.getFloorById(placeid.toString());
                            print('AA  ${aa}');
                            setState(() {
                              anotherFloorQueryRows123=aa;
                            });
                            print('Floorqwe  ${anotherFloorQueryRows123}');


                             // qwe= ;
                           floorval=returnFloorQuery(placeid);
                            // anotherFloorQueryRows=floor as List<Map<String, dynamic>>;
                            // print(floor);
                            // aa= floorQueryRows;
                            // for(int i=0;i<floorQueryRows.length;i++){
                            //   if(placeid==floorQueryRows[i]['p_id'].toString()){
                            //
                            //     var floorQuery=FloorType(
                            //         fId: floorQueryRows[i]['f_id'],
                            //         fName: floorQueryRows[i]['f_name'].toString(),
                            //         pId: floorQueryRows[i]['p_id'].toString(),
                            //         user: floorQueryRows[i]['user']
                            //     );
                            //     await  NewDbProvider.instance.insertAnotherTableData(floorQuery);
                            //
                            //     print(floorQuery.fName);
                            //   }else{
                            //     // print('mm');
                            //   }
                            // }
                                returnFloorQuery(placeid);
                            // setState(() {
                            //   // var pt = selectedPlace ;
                            //   // fl = null;
                            //   // pt = selectedPlace;
                            //   // print('place Selected');
                            //   // print('After Place Selected ${pt.pId}');
                            //   // // pt=  DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(pt.pId));
                            //   floorval =
                            //       returnFloorQuery(placeid);
                            //
                            // });
                          },
                          // items:snapshot.data
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              SizedBox(height:20),
              FutureBuilder(
                  future: floorval,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 2,
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
                        child: DropdownButtonFormField<String>(
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
                          hint: Text('Select Floor'),
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),

                          items: anotherFloorQueryRows123.map((selectedFloor) {

                            return DropdownMenuItem<String>(
                              value: selectedFloor.toString(),
                              child: Text("${selectedFloor['f_name']}"),
                            );
                          }).toList(),
                          onChanged: (selectedPlace)async {
                            print('Floor selected $selectedPlace');
                            var floorId=selectedPlace.substring(7,14);

                          var  aa= await NewDbProvider.instance.getRoomById(floorId.toString());
                            print('AA  ${aa}');
                            setState(() {
                              anotherRoomQueryRows123=aa;
                              roomVal=returnRoomQuery(floorId);
                            });
                            print('forRoom  ${anotherRoomQueryRows123}');


                            // qwe= ;

                            // anotherFloorQueryRows=floor as List<Map<String, dynamic>>;
                            // print(floor);
                            // aa= floorQueryRows;
                            // for(int i=0;i<floorQueryRows.length;i++){
                            //   if(placeid==floorQueryRows[i]['p_id'].toString()){
                            //
                            //     var floorQuery=FloorType(
                            //         fId: floorQueryRows[i]['f_id'],
                            //         fName: floorQueryRows[i]['f_name'].toString(),
                            //         pId: floorQueryRows[i]['p_id'].toString(),
                            //         user: floorQueryRows[i]['user']
                            //     );
                            //     await  NewDbProvider.instance.insertAnotherTableData(floorQuery);
                            //
                            //     print(floorQuery.fName);
                            //   }else{
                            //     // print('mm');
                            //   }
                            // }
                            returnFloorQuery(floorId);
                            // setState(() {
                            //   // var pt = selectedPlace ;
                            //   // fl = null;
                            //   // pt = selectedPlace;
                            //   // print('place Selected');
                            //   // print('After Place Selected ${pt.pId}');
                            //   // // pt=  DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(pt.pId));
                            //   floorval =
                            //       returnFloorQuery(placeid);
                            //
                            // });
                          },
                          // items:snapshot.data
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),

              SizedBox(height:20),
              FutureBuilder(
                  future: roomVal,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 2,
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
                        child: DropdownButtonFormField<String>(
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
                          hint: Text('Select Room'),
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),

                          items: anotherRoomQueryRows123==null?Text('No Devices'): anotherRoomQueryRows123.map((selectedPlace) {

                            return DropdownMenuItem<String>(
                              value: selectedPlace.toString(),
                              child: Text("${selectedPlace['r_name']}"),
                            );
                          }).toList(),
                          onChanged: (selectedRoom)async {
                            await getAllDevice();
                            deviceQueryRows= await NewDbProvider.instance.queryDevice();
                            print('selectedRoom $selectedRoom');

                            var deviceId=selectedRoom.substring(7,14);
                            print('selectedRoom $deviceId');


                            var  aa= await NewDbProvider.instance.getDeviceByRId(deviceId.toString());
                            print('DeviceCheck  ${deviceQueryRows}');
                            // print('deviceQueryRows ${deviceQueryRows['dId']}');
                                setState(() {
                                  deviceQueryRows2=aa;
                                  deviceVal=returnDeviceQuery();
                                });
                            },
                          // items:snapshot.data
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              SizedBox(height:20),
              FutureBuilder(
                  future: deviceVal,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 2,
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
                        child: DropdownButtonFormField<String>(
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
                          hint: Text('Select Device'),
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),

                          items: deviceQueryRows2.map((selectedPlace) {

                            return DropdownMenuItem<String>(
                              value: selectedPlace.toString(),
                              child: Text("${selectedPlace['d_id']}"),
                            );
                          }).toList(),
                          onChanged: (selectedPlace)async {
                            await getAllDevice();
                            deviceQueryRows=  await NewDbProvider.instance.queryDevice();
                            // print(deviceQueryRows[]['d_id']);
                            getAllPinStatus();

                            // devicePinQueryRows=  await NewDbProvider.instance.queryDevicePin();
                            // print('devicePinQueryRows  ${devicePinQueryRows}');
                          },
                          // items:snapshot.data
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
