import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/SQLITE_database/testingHome.dart';
import 'package:loginsignspaceorion/home.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'SQLITE_database/testinghome2.dart';
import 'dropdown1.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


// import 'allClasses.dart';
PlaceType pt;
Flat flt;
SensorData sensorData;
FloorType fl;
Flat flat;
RoomType rmtype;
List<RoomType> rm;
List <Device>dv;
var getUidVariable;
int getUidVariable2;
void main()=> runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: DropDown2(),
));

class DropDown2 extends StatefulWidget {
  @override
  _DropDown2State createState() => _DropDown2State();

}

class _DropDown2State extends State<DropDown2> {
  bool darkThemeEnabled=false;
  String _placeval;
  Box placeBox;
  Box floorBox;
  List roomData;
  RoomType rm2;
  final storage = new FlutterSecureStorage();
  List _place=[
    "Home","Hotel","Office","Others","Add"
  ];
  String _placevalf;
  List _placef=[
    "Ground Floor","1st Floor","2nd Floor","3rd Floor"
  ];
  List<PlaceType> places;
  List<FloorType> floors;
  List<RoomType> rooms;
  List placeData;
  List deviceData;


  List floorData;

  // List placeData;
  Future placeVal;
  Future floorval;
  Future roomVal;
  Future deviceVal;


  bool isVisible=false;

  @override
  void initState() {
    super.initState();
    placeVal=fetchPlace();
    // openPlaceBox();
    // openFloorBox();
    getUid();
    print(placeVal);
    // floorval=fetchFloor(placeVal.toString());
    // roomVal=getrooms(roomData.toString());
    // deviceVal=getDevices(deviceData.toString());
    print('roomval------>   ${roomVal}');
    // deviceVal=getDevices("1735111", "5497763");


  }
  @override
  void dispose(){
    super.dispose();
    print('dispose dropdown 2');
  }


  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }

  Future openPlaceBox()async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    placeBox=await Hive.openBox('place');
    return;
  }
  getUid() async{
    final url=await 'http://genorion1.herokuapp.com/getuid/';
    String token = await getToken();
    final response =
    await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
    if(response.statusCode==200){
      getUidVariable=response.body;
      getUidVariable2=int.parse(getUidVariable);

      print('GetUi Variable Integer-->   ${getUidVariable2}');
    }else{
      print(response.statusCode);
    }
  }
  Future<List<PlaceType>> fetchPlace() async {
    await openPlaceBox();
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/getallplaces/';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });


    try{
      if (response.statusCode >0) {
        placeData = jsonDecode(response.body);
        await putPlaceData(placeData);
        print("Place-->  ${placeData}");
        places = placeData.map((data) => PlaceType.fromJson(data)).toList();

        // places = placeData.map((data) {
        //   PlaceType.fromJson(data).toJson();
        //   DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(data));
        // }).toList();

        print('List ${places.toList()}');
      }
    }catch(e){

    }

    var myMap=placeBox.toMap().values.toList();
    if(myMap.isEmpty){
      placeData.add('empty');
      print('adding from 0 ${placeData.toString()}');

    }else{
      placeData=myMap;
      print('adding  ${placeData.toString()}');


      setState(() {
        print('adding147  ${placeData.toString()}');
        // pt.pId=placeData[0]['p_id'];
        print('adding1478  ${placeData.toString()}');
        // pt.pId=placeData[0]['p_id'];
      });


    }


    return places;

  }
  Future putPlaceData(data)async{
    await placeBox.clear();
    for(var d in data){
      print('PutPlaceLoop-->  $d');
      placeBox.add(d);
    }

  }
  Future<List<FloorType>> fetchFloor(String pId) async {
    await openFloorBox();
    var query = {'p_id': pId};
    String token = await getToken();
    final url = Uri.https('genorion1.herokuapp.com', '/getallfloors/', query);
    final response =
    await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
    try{
      if (response.statusCode>0) {
        print('Floor response -->  ${response.body}');
        print('Floor StatusCode -->  ${response.statusCode}');
        floorData = jsonDecode(response.body);
        print("data");
        await putFloorData(floorData);
        floors = floorData.map((data) => FloorType.fromJson(data)).toList();
        print(floors);
      }
    }catch(e){

    }

    var myMap=floorBox.toMap().values.toList();
    if(myMap.isEmpty){
      floorData.add('empty');

    }else{
      print('adding Floor ${floorData.toString()}');
      floorData=myMap;

    }

    return floors;
  }

  Future openFloorBox()async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    floorBox=await Hive.openBox('floor');
    print("Floor Box ${floorBox}");
    return;
  }

  Future putFloorData(data)async{
    await floorBox.clear();
    for(var d in data){
      print('Floor Local-->  $d');
      floorBox.add(d);
    }

  }

  Future<List<RoomType>> getrooms(String fId) async {
    var query = {'f_id': fId};
    final url = Uri.https('genorion1.herokuapp.com', '/getallrooms/', query);
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode >0) {
      print('-----------room function query -- ------ ${query}');
      roomData = jsonDecode(response.body);
      print('Room Response------->>>>      ${roomData}');
      rooms = roomData.map((data) => RoomType.fromJson(data)).toList();
      print('rooomssssss  ${rooms.toList()}');
      return rooms;
    }
  }


  Future<List<Device>> getDevices( String rId) async {
    var query = {'r_id': tabbarState};
    final url = Uri.https('genorion1.herokuapp.com', '/getalldevices/', query);
    // String token = await getToken();
    // String token ='b6625e2b625e920c1828a8244bdea9b84a6a5ae3';
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode >0) {
      print(response.statusCode);
      deviceData= jsonDecode(response.body);
      dv= deviceData
          .map((data) => Device.fromJson(data))
          .toList()
          .where((element) => ((element.rId == rId) &&
          (element.rId.length == rId)))
          .toList();
      print('query Devices function ================================   ${query}');
      print('------Devicessssssssssssssssssssssssssssss-  function----------------------------------------------- ${dv}');
    }
    return dv;
  }







  @override
  Widget build(BuildContext context) {

    return Center(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('GenOrion'),
          actions: <Widget>[
            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>DropDown1()));}, icon: Icon(Icons.add)),
            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>super.widget));}, icon: Icon(Icons.refresh))
          ],
        ),

        body: isVisible?Container(color: Colors.blueAccent,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),),):Center(
          heightFactor: 3,
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.blueGrey,Colors.blueAccent,Colors.blueGrey]
                )
            ),

            child: Center(
              // width: 150,
              // padding: EdgeInsets.all(16.0),
              //
              // margin: new EdgeInsets.symmetric(vertical: 98,horizontal: 98),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
                  SizedBox(height: 30,),
                  FutureBuilder<List<PlaceType>>(
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
                                child: Text("Please Select"));
                          }
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(41.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width*2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          offset: Offset(20,20)
                                      )],
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      )
                                  ),
                                  child: DropdownButtonFormField<PlaceType>(
                                    decoration:InputDecoration(
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
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
                                    onChanged: ( selectedPlace) {
                                      setState(() {
                                        fl = null;
                                        pt = selectedPlace;
                                        print('place Selected');
                                        print('After Place Selected ${pt.pId}');
                                        // pt=  DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(pt.pId));
                                        floorval =
                                            fetchFloor(selectedPlace.pId);
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
                          return CircularProgressIndicator(semanticsLabel: "Loading",);
                        }
                      }
                  ),

                  FutureBuilder<List<FloorType>>(
                      future: floorval,
                      builder:
                          (context, AsyncSnapshot<List<FloorType>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(
                                child: Text("Please Select"));
                          }
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(45.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width*2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          // offset for Upward Effect
                                          offset: Offset(20,20)
                                      )],
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      )
                                  ),
                                  child: DropdownButtonFormField<FloorType>(
                                    decoration:InputDecoration(
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    ),
                                    dropdownColor: Colors.white70,
                                    icon: Icon(Icons.arrow_drop_down),
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
                                      return DropdownMenuItem<FloorType>(
                                        value: selectedFloor,
                                        child: Text(selectedFloor.fName),
                                      );
                                    }).toList(),
                                    onChanged: ( selectedFloor) {
                                      setState(() {
                                        fl = selectedFloor;
                                        print(fl.fId);
                                        roomVal=getrooms(selectedFloor.fId);
                                        // rm2=getDevices(rm2.rId);
                                        // dv=rm2.rId as List<Device>;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // margin: new EdgeInsets.symmetric(
                            //     vertical: 10, horizontal: 10),
                          );
                        } else {
                          return Center(
                              child: Text(
                                  "Loading..."));
                        }
                      }),
                  // SizedBox(height: 10,),
                  // FutureBuilder<List<RoomType>>(
                  //     future: roomVal,
                  //     builder:
                  //         (context, AsyncSnapshot<List<RoomType>> snapshot) {
                  //       if (snapshot.hasData) {
                  //         if (snapshot.data.length == 0) {
                  //           return Center(
                  //               child: Text("Please Select"));
                  //         }
                  //         return Column(
                  //           children: [
                  //             Container(
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(41.0),
                  //                 child: SizedBox(
                  //                   width: double.infinity,
                  //                   height: 50.0,
                  //                   child: Container(
                  //                     width: MediaQuery.of(context).size.width*2,
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.white,
                  //                         boxShadow: [BoxShadow(
                  //                             color: Colors.black,
                  //                             blurRadius: 30,
                  //                             // offset for Upward Effect
                  //                             offset: Offset(20,20)
                  //                         )],
                  //                         border: Border.all(
                  //                           color: Colors.black,
                  //                           width: 0.5,
                  //                         )
                  //                     ),
                  //                     child: DropdownButtonFormField<RoomType>(
                  //                       decoration:InputDecoration(
                  //                         contentPadding: const EdgeInsets.all(15),
                  //                         focusedBorder: OutlineInputBorder(
                  //                           borderSide: BorderSide(color: Colors.white),
                  //                           borderRadius: BorderRadius.circular(10),
                  //                         ),enabledBorder: UnderlineInputBorder(
                  //                         borderSide: BorderSide(color: Colors.white),
                  //                         borderRadius: BorderRadius.circular(50),
                  //                       ),
                  //                       ),
                  //                       dropdownColor: Colors.white70,
                  //                       icon: Icon(Icons.arrow_drop_down),
                  //                       iconSize: 28,
                  //                       hint: Text('Select Room'),
                  //                       isExpanded: true,
                  //                       value: rmtype,
                  //                       style: TextStyle(
                  //                         color: Colors.black,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                       items: snapshot.data
                  //                           .map((selectedFloor) {
                  //                         return DropdownMenuItem<RoomType>(
                  //                           value: selectedFloor,
                  //                           child: Text(selectedFloor.rName),
                  //                         );
                  //                       }).toList(),
                  //                       onChanged: ( selectedFloor) {
                  //                         setState(() {
                  //                           rmtype = selectedFloor;
                  //                           print(rmtype.rId);
                  //                           // roomVal=getrooms(selectedFloor.fId);
                  //                           // rm2=getDevices(rm2.rId);
                  //                           // dv=rm.toList();
                  //                         });
                  //                       },
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               margin: new EdgeInsets.symmetric(
                  //                   vertical: 10, horizontal: 10),
                  //             ),
                  //
                  //           ],
                  //         );
                  //       } else {
                  //         return Center(
                  //             child: Text(
                  //                 "Loading..."));
                  //       }
                  //     }),
                  Padding(
                    padding: EdgeInsets.all(45),
                    child: RaisedButton(
                      child: Text(
                        'Next',
                        style: TextStyle(

                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.all(12),
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.white,
                              width: 1),
                          borderRadius:
                          BorderRadius.circular(50)),
                      onPressed: () async {

                        rm = await getrooms(fl.fId);
                        print('hello   ${rm[0].rId}');
                        setState(() {
                          isVisible=true;
                          // tabbarState=rm[0].rId;

                        });
                        print('State   ${tabbarState}');
                        print('FID-->   ${fl.fId}');
                        dv = await getDevices(tabbarState );

                        print('On Pressed  ${pt.pId}');
                        print('On Pressed place response ${pt.pId}');
                        // print(rm[1]);
                        //  print(rm[0].r_name);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (
                                  context,
                                  ) =>
                                  Container(
                                    // child: HomePage(
                                    //     // pt: pt,
                                    //     fl: fl,
                                    //     rm: rm,
                                    //     dv: dv),
                                  )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}