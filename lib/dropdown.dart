import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dropdown2.dart';
import 'home.dart';
import 'main.dart';
import 'models/modeldefine.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: DropDown(),
    ));

class DropDown extends StatefulWidget {
  static const routeName = '/DropDown';

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  //ScrollController _scrollController;
  Timer timer;
  Future placeVal;
  Future placeValWeb;

  // List _place = ["Home", "Hotel", "Office", "Others", "Add"];
  Future floorVal;
  Future floorValWeb;
  Future flatVal;
  Future flatValWeb;

  // List _placef = ["Ground Floor", "1st Floor", "2nd Floor", "3rd Floor"];
  final storage = new FlutterSecureStorage();
  PlaceType pt;
  FloorType fl;
  Flat flt;
  List<RoomType> rm;
  List<Device> dv;

  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }

  var tokenWeb;

  Future getTokenWeb() async {
    final pref = await SharedPreferences.getInstance();
    tokenWeb = pref.getString('tokenWeb');
    return tokenWeb;
  }

  // ignore: missing_return
  Future<List<Device>> getDevices(String pId, String fId) async {
    final url = API + 'getalldevices/?r_id=2436955';
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Device> devices = data
          .map((data) => Device.fromJson(data))
          .toList()
          .where((element) => ((element.rId == fId) && (element.rId == pId)))
          .toList();
      // print(devices);
      return devices;
    }
    // else(response.statusCode == 401){
    //   throw "Not Authorised";
    // }
  }

  Future<List<PlaceType>> getplaces() async {
    String token = await getToken();
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = API + 'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
          data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }
  }

  Future<List<PlaceType>> getplacesWeb() async {
    await getTokenWeb();
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = API + 'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode > 0) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
          data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }
  }

  // Future<Device> _switchchange() async{
  //   var url='https://gemorion1.herokuapp.com/devicePinStatus/';
  //   String token=await getToken();
  //   final response = await http.get(url, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Token $token',
  //   });
  //   if(response.statusCode==200){
  //       List<dynamic> data=jsonDecode(response.body);
  //       List<Device> device=data.map((data)=>)
  //   }
  // }
  // ignore: missing_return
  Future<List<FloorType>> getfloors(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getToken();
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

  Future<List<FloorType>> getfloorsWeb(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getTokenWeb();
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

  Future<List<Flat>> getflatWeb(String fId) async {
    final url = API + 'addyourflat/?f_id=' + fId;
    String token = await getTokenWeb();
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

  // ignore: missing_return
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
      return rooms;
    }
  }

  Future<List<RoomType>> getroomsWeb(String flt_id) async {
    final url = API + 'addroom/?flt_id=' + flt_id;
    String token = await getTokenWeb();
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
      return rooms;
    }
  }


  Future<List<Device>> getDeviceWeb(String r_id) async {
    final url = API + 'addyourdevice/?r_id=' + r_id;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Device> dv =
          data.map((data) => Device.fromJson(data)).toList();
      print(dv);
      return dv;
    }
  }

  _showDialog(tittle, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tittle),
          content: Text(text),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'))
          ],
        );
      },
    );
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return _showDialog("No Internet", "Check Your Internet");
    }
  }

  @override
  void initState() {
    super.initState();
    placeVal = getplaces();
    getUid();
    placeValWeb = getplacesWeb();
    print(placeVal);
    //  timer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   _checkInternetConnectivity();
    // });
    // floorVal = getfloors();
  }

  getUid() async {
    final url = await API + 'getuid/';
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      getUidVariable = response.body;
      getUidVariable2 = int.parse(getUidVariable);

      print('GetUi Variable Integer-->   ${getUidVariable2}');
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('GenOrion'),
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              if (viewportConstraints.maxWidth > 600) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.blue,
                          Colors.blueGrey,
                          Colors.blueAccent
                        ])),
                    child: Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          FutureBuilder<List<PlaceType>>(
                              future: placeValWeb,
                              builder: (context,
                                  AsyncSnapshot<List<PlaceType>> snapshot) {
                                if (snapshot.hasData) {
                                  // print(snapshot.hasData);
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
                                                fl = null;
                                                pt = selectedPlace;
                                                floorValWeb = getfloorsWeb(
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
                              }),
                          SizedBox(
                            height: 45,
                          ),
                          FutureBuilder<List<FloorType>>(
                              future: floorValWeb,
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
                                                hint: Text('Select Floor'),
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
                                                    fl = selectedFloor;
                                                    flatValWeb = getflatWeb(
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
                              }),
                          SizedBox(
                            height: 45,
                          ),
                          FutureBuilder<List<Flat>>(
                              future: flatValWeb,
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
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(12),
                                          shape: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          onPressed: () async {
                                            rm = await getroomsWeb(flt.fltId);
                                            dv= await getDeviceWeb(rm[0].rId);
                                            //print(pt.p_type);
                                            // print(rm[1]);
                                            //  print(rm[0].r_name);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (
                                                context,
                                              ) =>
                                                      Container(
                                                        child: HomeTest(
                                                            pt: pt,
                                                            fl: fl,
                                                            flat: flt,
                                                            rm: rm,
                                                            dv: dv),
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
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
              } else {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.blue,
                          Colors.blueGrey,
                          Colors.blueAccent
                        ])),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
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
                                        child:
                                            Text("No Devices on this place"));
                                  }
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(41.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 50.0,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              2,
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
                                          child: DropdownButtonFormField<
                                              PlaceType>(
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
                              }),
                         
                          FutureBuilder<List<FloorType>>(
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
                                          padding: const EdgeInsets.all(41.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 50.0,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  2,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 30,
                                                        // offset for Upward Effect
                                                        offset: Offset(20, 20))
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
                                                hint: Text('Select Floor'),
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
                              }),
                          FutureBuilder<List<Flat>>(
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
                                          padding: const EdgeInsets.all(41.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 50.0,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  2,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 30,
                                                        // offset for Upward Effect
                                                        offset: Offset(20, 20))
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
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(12),
                                          shape: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          onPressed: () async {
                                            rm = await getrooms(flt.fltId);

                                            //print(pt.p_type);
                                            // print(rm[1]);
                                            //  print(rm[0].r_name);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (
                                                context,
                                              ) =>
                                                      Container(
                                                        child: HomeTest(
                                                            pt: pt,
                                                            fl: fl,
                                                            flat: flt,
                                                            rm: rm,
                                                            dv: dv),
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
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
            })),
        onWillPop: () => showDialog<bool>(
          context: context,
          builder: (c) => poppages(c),
        ),
      ),
    );
  }
}

poppages(c) {
  // Future.delayed(Duration.zero, () {Navigator.pushAndRemoveUntil(c, ModalRoute.of(c), (Route<dynamic> route) => false);});
  return AlertDialog(
    title: Text('Warning'),
    content: Text('Do you want to exit'),
    actions: [
      // ignore: deprecated_member_use
      FlatButton(
        child: Text('Yes'),
        onPressed: () => exit(0),
      ),
      // ignore: deprecated_member_use
      FlatButton(
        child: Text('No'),
        onPressed: () => Navigator.pop(c, false),
      ),
    ],
  );
}
