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
    deviceQueryFunc();
    returnPlaceQuery();
    placeQueryFunc().then((value) =>  floorQueryFunc());
    floorQueryFunc();
    roomQueryFunc();


    fetchPlace().then((value) => getAllFloor()).then((value) => getAllRoom()).then((value) =>     getAllDevice());
      // NewDbProvider.instance.dogs();

    // readData();


    
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
List<dynamic> devicePinNamesData=[];
  var roomQuery;
  var deviceQuery;
  var aa;
  Future returnPlaceQuery(){
    return NewDbProvider.instance.queryAll();
  }
  Future returnFloorQuery(String pId){

    return NewDbProvider.instance.queryFloor();
  }

  Future returnRoomQuery(String fId){

    return NewDbProvider.instance.queryRoom();
  }
  Future returnDeviceQuery(String rId){

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


        }



      } catch (e) {
        print('RoomCatch $e');
        // }

      }
    }
    return Future.value(true);
  }
  List arr=[];
  Future<bool> getAllDevice()async{
    var rId;
    for(int i=0;i<roomQueryRows2.length;i++) {
      //   print(NewDbProvider.instance.dogs());
      rId = roomQueryRows2[i]['r_id'].toString();
      print('roomId  ${rId}');


      // String url="http://10.0.2.2:8000/api/data";
      // String token= await getToken();
      String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';
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
        print('deviceQueryFunc   ${deviceData}');

        await NewDbProvider.instance.insertDeviceModelData(deviceQuery);
      }
    }
    return Future.value(true);
  }



  Future<bool> getAllPinNames()async{
    String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';
    var did;
    print('pinNamesFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++){

      did=deviceQueryRows[i]['d_id'];
      print('didqwe ${did}');
      String url = "http://genorionofficial.herokuapp.com/editpinnames/?d_id="+did;
           // try {
      final   response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',

        });
        if(response.statusCode==200) {
         var  devicePinNamesData=json.decode(response.body);
         DevicePin devicePin=DevicePin.fromJson(devicePinNamesData);

          List listOfPinNames=[devicePinNamesData,];
         print('QWERTY  ${listOfPinNames}');
          for (int i = 0; i < listOfPinNames.length; i++) {

            print('devicePinData ${listOfPinNames}');

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
            print('devicePinNamesInsertQuery    ${devicePinNamesQuery}');
            print('devicePinQueryToJson    ${devicePinNamesQuery.toJson()}');
            await NewDbProvider.instance.insertDevicePinNames(devicePinNamesQuery);
          }
        }
      // print('devicePinDataOutside ${pinData.length}');

      // print('devicePin123 ${pinData}');


    print('index of ddd  $i');
    }


  }


  Future<bool> getSensorData() async {
    // arr=[arr.length-arr.length];
    String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';

    var did;
    print('SensorFunction $deviceQueryRows');
    for(int i=0;i<deviceQueryRows.length;i++) {
      did=deviceQueryRows[i]['d_id'];
      print('insideLoop $did');
      String url = "http://genorionofficial.herokuapp.com/tensensorsdata/?d_id="+did.toString();
      // final url="http://genorionofficial.herokuapp.com/tensensorsdata/?d_id="+did;
      final response = await http.get(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $token',
          });
      int index=0;
if(response.statusCode==200){
  print('sensorResponse  ${response.statusCode}');
  index++;
}      if (response.statusCode ==200) {
       var arr = jsonDecode(response.body);



      print('aarrr ${arr}');


        for (int i = 0; i < arr.length; i++) {
          var sensorQuery = SensorData(
            dId: arr['d_id'],
            sensor1: arr['sensor1'],
            sensor2: arr['sensor2'],
            sensor3: arr['sensor3'],
            sensor4: arr['sensor4'],
            sensor5: arr['sensor5'],
            sensor6: arr['sensor6'],
            sensor7: arr['sensor7'],
            sensor8: arr['sensor8'],
            sensor9: arr['sensor9'],
            sensor10: arr['sensor10'],
          );
          await NewDbProvider.instance.insertSensorData(sensorQuery);
        }
      } else {
        throw Exception(Exception);
      }
    }
  }



  Future<bool> getPinStatusData() async {
    // arr=[arr.length-arr.length];
    String token = '0bcb23b98322c01d95211af236b4a8d029bdd9f3';

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
      int index=0;
      if(response.statusCode==200){
        print('sensorResponse  ${response.statusCode}');
        var pinStatus= jsonDecode(response.body);
        PinStatus devicePinStatus=PinStatus.fromJson(pinStatus);
        List listOfPinStatusValue=[pinStatus];
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
        }
      }



    }
  }




  Future placeQueryFunc()async{
  queryRows =
      await NewDbProvider.instance.queryAll();

}
 Future floorQueryFunc()async{
    floorQueryRows =
    await NewDbProvider.instance.queryFloor();
    setState(() {
      floorQueryData=floorQueryRows;
    });


  }
  roomQueryFunc()async {
    roomQueryRows =
    await NewDbProvider.instance.queryRoom();
    setState(() {
      roomQueryRows2=roomQueryRows;
    });
  }

  deviceQueryFunc()async{
    deviceQueryRows =
    await NewDbProvider.instance.queryDevice();
    // setState(() {
    //   deviceQueryRows =
    //        NewDbProvider.instance.queryDevice();
    // });
   await getAllPinNames();
   await getSensorData();
  }
  Future devicePinNamesQueryFunc()async{
    devicePinNamesQueryRows =
    await NewDbProvider.instance.queryPinNames();
    print('devicePinQueryFunc  ${devicePinNamesQueryRows}');
    setState(() {

    });
    return devicePinNamesQueryRows;

  }

  Future devicePinSensorQueryFunc()async{
    sensorQueryRows =
    await NewDbProvider.instance.querySensor();
    print('devicePinQueryFunc  ${sensorQueryRows}');
    setState(() {

    });
    return sensorQueryRows;

  }


  Future pinVal;
  Future sensorVal;
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
  List<Map<String, dynamic>> sensorQueryRows;
  List<Map<String, dynamic>> sensor2QueryRows;
  List<Map<String, dynamic>> deviceQueryRows2;
  List<Map<String, dynamic>> devicePinNamesQueryRows;
  List<Map<String, dynamic>> devicePinNamesQueryRows2;
  List<Map<String, dynamic>> floorQueryRows2;
  List<Map<String, dynamic>> roomQueryRows2;
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
                  print(roomQueryRows);

                },
                child: const Text(' Room Query'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  deviceQueryRows =
                  await NewDbProvider.instance.queryDevice();

                  print('deviceQueryRows ${deviceQueryRows}');

                },
                child: const Text(' Device Query'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  sensorQueryRows =
                  await NewDbProvider.instance.querySensor();
                  print('sensorQueryRows ${sensorQueryRows}');

                },
                child: const Text(' Sensor'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  // await getAllPinNames();
                  // getAllRoom();
                  devicePinNamesQueryRows =
                  await NewDbProvider.instance.queryPinNames();
                  print('devicePinQueryRowsNames ${devicePinNamesQueryRows}');

                },
                child: const Text(' PinNames'),
                color: Colors.red,
              ),
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
                              floorQueryRows2=aa;
                            });
                            print('Floorqwe  ${floorQueryRows2}');


                             // qwe= ;
                           floorval=returnFloorQuery(placeid);
                                  returnFloorQuery(placeid);
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

                          items: floorQueryRows2.map((selectedFloor) {

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
                              roomQueryRows2=aa;
                              roomVal=returnRoomQuery(floorId);
                            });
                            print('forRoom  ${roomQueryRows2}');



                            returnFloorQuery(floorId);

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

                          items:  roomQueryRows2.map((selectedRoom) {

                            return DropdownMenuItem<String>(
                              value: selectedRoom.toString(),
                              child: Text("${selectedRoom['r_name']}"),
                            );
                          }).toList(),
                          onChanged: (selectedRoom)async {
                            var roomId=selectedRoom.substring(7,14);
                            var  aa= await NewDbProvider.instance.getDeviceByRId(roomId.toString());
                            // print('deviceQueryRows ${deviceQueryRows['dId']}');
                                setState(() {
                                  deviceQueryRows2=aa;
                                  deviceVal=returnDeviceQuery(roomId);
                                });
                            print('DeviceCheck  ${deviceQueryRows2}');
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

                          items: deviceQueryRows2.map((selectedDevice) {

                            return DropdownMenuItem<String>(
                              value: selectedDevice.toString(),
                              child: Text("${selectedDevice['d_id']}"),
                            );
                          }).toList(),
                          onChanged: (selectedDevice)async {


                            devicePinNamesQueryRows=  await NewDbProvider.instance.queryPinNames();

                            var deviceId=selectedDevice.substring(31,49);
                            print('qwedsaqw   $deviceId ');
                            var  aa= await NewDbProvider.instance.getPinNamesByDeviceId(deviceId.toString());
                            var sensor= await NewDbProvider.instance.getSensorByDeviceId(deviceId.toString());
                            print('poiuy ${sensor}');
                            setState(() {
                              devicePinNamesQueryRows2=aa;
                              sensor2QueryRows=sensor;
                              pinVal=devicePinNamesQueryFunc();
                              sensorVal=devicePinSensorQueryFunc();
                            });
                            print('PiNamesCheck   $aa ');
                            print('SensorCheck   $sensor2QueryRows ');
                          },

                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),

              Container(
                // color: Colors.green,
                height: 500,
                width:MediaQuery.of(context).size.width,
                // height:MediaQuery.of(context).size.height,
                child: FutureBuilder(
                    future: pinVal,
                    builder: ( context,  snapshot){
                      if(snapshot.hasData){
                        return Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                                    itemCount: devicePinNamesQueryRows2.length,
                                    itemBuilder: (context,index){
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          semanticContainer:true,
                                          shadowColor: Colors.grey,
                                          child: ListTile(
                                            title: Text(devicePinNamesQueryRows2[index]['d_id']),
                                            trailing: Text(devicePinNamesQueryRows2[index]['pin1Name']),
                                            subtitle: Text(devicePinNamesQueryRows2[index]['pin2Name']),

                                          ),
                                        ),
                                      );

                                    }
                                )),


                          ],
                        );
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
              Container(
                height: 789,
              color: Colors.red,
                child: FutureBuilder(
                  future: sensorVal,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  itemCount: sensor2QueryRows.length,
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        semanticContainer:true,
                                        shadowColor: Colors.grey,
                                        child: ListTile(
                                          title: Text(sensor2QueryRows[index]['d_id']),
                                          trailing: Text(sensor2QueryRows[index]['sensor2'].toString()),
                                          subtitle: Text(sensor2QueryRows[index]['sensor1'].toString()),

                                        ),
                                      ),
                                    );

                                  }
                              )),


                        ],
                      );
                    }else{
                      return Center(child: Text('No Data'),);
                    }
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
