import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

void main()=>runApp(MaterialApp(
  home :CheckStack()
));

class CheckStack extends StatefulWidget {
  const CheckStack({Key key}) : super(key: key);

  @override
  _CheckStackState createState() => _CheckStackState();
}

class _CheckStackState extends State<CheckStack> {
  String token ="16661fcd5d214e43471bc304899f41c2ec2b811c";
  PlaceType pt;
  FloorType fl;
  Future placeVal;
  Future flatVal;
  Future floorVal;
  Future roomVal;
  Flat flt;
  bool placeBool = false;
  bool floorBool = false;
  bool flatBool = false;

  var selectedflat;
  var selectedroom;

  List allRoomId;

  RoomType rm2;

  @override
  void initState(){
    super.initState();
    placeVal = getplaces();
  }


  Future<List<PlaceType>> getplaces() async {
    // String token = await getToken();
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
    }
  }


  Future<List<FloorType>> getfloors(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    // String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<FloorType> floors =
      data.map((data) => FloorType.fromJson(data)).toList();
      print(floors);
      return floors;
    }
  }
  Future<List<Flat>> getflat(String fId) async {
    final url = API + 'addyourflat/?f_id=' + fId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Flat> flatData = data.map((data) => Flat.fromJson(data)).toList();
      print(flatData);
      return flatData;
    }
  }
  Future<List<RoomType>> getrooms(String flt_id) async {
    final url = API + 'addroom/?flt_id=' + flt_id;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<RoomType> rooms =
      data.map((data) => RoomType.fromJson(data)).toList();
      print(rooms);
      allRoomId = List.from(data);
      print('allRoomId $allRoomId');

      return rooms;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              placeBool==false? FutureBuilder<List<PlaceType>>(
                  future: placeVal,
                  builder: (context,
                      AsyncSnapshot<List<PlaceType>> snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.hasData);
                      // setState(() {
                      //   floorVal = getfloors(snapshot.data[0].p_id);
                      // });
                      if (snapshot.data.length == 0) {
                        return Center(
                            child:
                            Text("No Devices on this place"));
                      }
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 58),
                          child: SizedBox(
                            // width: double.infinity,
                            height: 50.0,
                            child: Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width /
                                  2,
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
                                    borderSide: BorderSide(
                                        color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  enabledBorder:
                                  UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black),
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
                                items: snapshot.data
                                    .map((selectedPlace) {
                                  return DropdownMenuItem<
                                      PlaceType>(
                                    value: selectedPlace,
                                    child:
                                    Text(selectedPlace.pType),
                                  );
                                }).toList(),
                                onChanged:
                                    (PlaceType selectedPlace) {
                                  setState(() {
                                    placeBool=true;
                                    fl = null;
                                    pt = selectedPlace;
                                    floorVal = getfloors(
                                        selectedPlace.pId);
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
                  }):
              floorBool==false ?FutureBuilder<List<FloorType>>(
               future: floorVal,
            builder: (context,
                AsyncSnapshot<List<FloorType>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                      child:
                      Text("No Devices on this place"));
                }
                return Column(
                  children: [
                    Container(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(right: 58),
                        child: SizedBox(
                          // width: double.infinity,
                          height: 50.0,
                          child: Container(
                            width: MediaQuery.of(context)
                                .size
                                .width /
                                2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 10,
                                      offset: Offset(7, 7)
                                    // blurRadius: 30,
                                    // // offset for Upward Effect
                                    // offset: Offset(20,20)
                                  )
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                )),
                            child: DropdownButtonFormField<
                                FloorType>(
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.all(15),
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white),
                                  borderRadius:
                                  BorderRadius.circular(
                                      10),
                                ),
                                enabledBorder:
                                UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white),
                                  borderRadius:
                                  BorderRadius.circular(
                                      50),
                                ),
                              ),
                              dropdownColor: Colors.white70,
                              icon:
                              Icon(Icons.arrow_drop_down),
                              iconSize: 28,
                              hint: Text('Select Flat'),
                              isExpanded: true,
                              value: fl,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              items: snapshot.data
                                  .map((selectedFloor) {
                                return DropdownMenuItem<
                                    FloorType>(
                                  value: selectedFloor,
                                  child: Text(
                                      selectedFloor.fName),
                                );
                              }).toList(),
                              onChanged:
                                  (FloorType selectedFloor) {
                                setState(() {
                                  floorBool = true;
                                  fl = selectedFloor;
                                  flatVal = getflat(
                                      selectedFloor.fId);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      margin: new EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              } else {
                return Center(
                    child: Text(
                        "Please select a place to proceed further"));
              }
            }):
              flatBool==false?    FutureBuilder<List<Flat>>(
          future: flatVal,
          builder: (context,
              AsyncSnapshot<List<Flat>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                    child:
                    Text("No Devices on this place"));
              }
              return Column(
                children: [
                  Container(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(right: 58),
                      child: SizedBox(
                        // width: double.infinity,
                        height: 50.0,
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 10,
                                    offset: Offset(7, 7)
                                  // blurRadius: 30,
                                  // // offset for Upward Effect
                                  // offset: Offset(20,20)
                                )
                              ],
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              )),
                          child:
                          DropdownButtonFormField<Flat>(
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.all(15),
                              focusedBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(
                                    10),
                              ),
                              enabledBorder:
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(
                                    50),
                              ),
                            ),
                            dropdownColor: Colors.white70,
                            icon:
                            Icon(Icons.arrow_drop_down),
                            iconSize: 28,
                            hint: Text('Select Floor'),
                            isExpanded: true,
                            value: flt,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            items: snapshot.data
                                .map((selectedFlat) {
                              return DropdownMenuItem<Flat>(
                                value: selectedFlat,
                                child: Text(
                                    selectedFlat.fltName),
                              );
                            }).toList(),
                            onChanged: (Flat selectedFlat) {
                              setState(() {
                                flt = selectedFlat;
                                selectedflat = selectedFlat.fltId;
                                flatBool = true;
                                roomVal = getrooms(selectedflat);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    margin: new EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                  ),

                ],
              );
            } else {
              return Center(
                  child: Text(
                      "Please select a place to proceed further"));
            }
          }):FutureBuilder<List<RoomType>>(
                  future: roomVal,
                  builder: (context, AsyncSnapshot<List<RoomType>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0) {
                        return Center(
                            child: Text("No Devices on this place"));
                      }
                      return Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(7, 7)
                                // blurRadius: 30,
                                // // offset for Upward Effect
                                // offset: Offset(20,20)
                              )
                            ],
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            )),
                        child: DropdownButtonFormField<RoomType>(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          dropdownColor: Colors.white70,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 28,
                          hint: Text('Select Room'),
                          isExpanded: true,
                          value: rm2,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          items: snapshot.data.map((selectedRoom) {
                            return DropdownMenuItem<RoomType>(
                              value: selectedRoom,
                              child: Text(selectedRoom.rName),
                            );
                          }).toList(),
                          onChanged: (RoomType selectedRoom) async {
                            setState(() {
                              rm2 = selectedRoom;
                              selectedroom = selectedRoom.rId;
                            });
                            // await getDevice(selectedroom);
                            // setState(() {
                            //   completeTask = true;
                            // });
                          },
                        ),
                      );
                    } else {
                      return Center(
                          child: Text(
                              "Please select a place to proceed further"));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
