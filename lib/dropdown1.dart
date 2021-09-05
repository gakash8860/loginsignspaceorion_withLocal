import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'SQLITE_database/testinghome2.dart';
import 'main.dart';
import 'models/modeldefine.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dropdown2.dart';

var placeResponse;
var floorResponse;
var flatResponse;

var roomResponse;
var deviceResponse;

void main() => runApp(MaterialApp(
      home: DropDown1(),
    ));
String roomResponse2;

class DropDown1 extends StatefulWidget {
  static const routeName = '/dropDown1';


  @override
  _DropDown1State createState() => _DropDown1State();
}

class _DropDown1State extends State<DropDown1> {


  final storage = new FlutterSecureStorage();
  var floorval, ptfuture;
  bool isVisible = false;
  var futureRoom;
  List<RoomType> rm;
  List<Device> dv;
  FloorType fl;
  Flat flat;
  PlaceType pt;
  SharedPreferences roomPrefrences;
  bool visible = true;
  var plaVariable = 1;

  TextEditingController editingController = new TextEditingController();
  TextEditingController floorEditingController = new TextEditingController();
  TextEditingController flatEditingController = new TextEditingController();
  TextEditingController roomEditingController = new TextEditingController();
  TextEditingController deviceEditingController = new TextEditingController();

  var snackBar;
  bool _isInAsyncCall = false;

  @override
  void initState() {
    super.initState();
    getToken();
    getUid();
    print(getUidVariable);
    // roomResponse=send_RoomName(roomEditingController.text);
  }

  // ignore: missing_return
  Future<PlaceType> placeName(String data) async {
    print(getUidVariable2);
    String token = await getToken();
    final url = API+'addyourplace/';
    var postData = {"user": getUidVariable2, "p_type": data};
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      print(response.body);

      placeResponse = jsonDecode(response.body);

      print(' Place Response--> $placeResponse');

      print(' Place--> $postData');
      setState(() {
        // setPlaceValue();
      });
      return PlaceType.fromJson(postData);
    } else {
      throw Exception('Failed to create Place.');
    }
  }

  Future<FloorType> sendFloorName(String data) async {
    String token = await getToken();
    final url = API+'addyourfloor/';
    var postData = {
      "user": getUidVariable2,
      "p_id": placeResponse,
      "f_name": data
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      // print(response.body);
      floorResponse = jsonDecode(response.body);
      print(' Floor Response--> $floorResponse');
      print(' postData FLoor--> $postData');

      return FloorType.fromJson(postData);
    } else {
      throw Exception('Failed to create Floor.');
    }
  }

  Future<Flat> sendFlatName(String data) async {
    String token = await getToken();
    final url = API+'addyourflat/';
    var postData = {
      "user": getUidVariable2,
      "f_id": floorResponse,
      "flt_name": data
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      // print(response.body);
      flatResponse = jsonDecode(response.body);
      print(' Flat Response--> $flatResponse');
      print(' postData FLat--> $flatResponse');

      return Flat.fromJson(postData);
    } else {
      throw Exception('Failed to create Floor.');
    }
  }

  Future<RoomType> sendRoomName(String data) async {
    String token = await getToken();
    final url = API+'addroom/';
    var postData = {
      "user": getUidVariable2,
      "r_name": data,
      "flt_id": flatResponse,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      print('response.body  ${response.body}');
      roomResponse = jsonDecode(response.body);
      setState(() {
        tabbarState = roomResponse;
        // setRoomValue();
        // // final  roomResponse2=roomResponse;
        //   // roomResponsePreference.setInt('r_id', roomResponse2);
      });
      print(' Room- Tabb-> $tabbarState');
      print(' Room- Response-> $roomResponse');

      return RoomType.fromJson(postData);
    } else {
      throw Exception('Failed to create Room.');
    }
  }

  Future<Device> sendDeviceId(String data) async {
    print(roomResponse2);
    // placeType.createState().roomResponse;
    String token = await getToken();
    final url = API+'addyourdevice/';
    var postData = {
      "user": getUidVariable2,
      "r_id": roomResponse,
      "d_id": data
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode > 0) {
      // print(roomResponse);
      print(response.statusCode);
      print(response.body);

      // floorResponse=jsonDecode(response.body);
      // print(' Floor--> ${floorResponse}');N.
      // return Device.fromJson(postData);
    } else {
      throw Exception('Failed to create Device.');
    }
  }

  getUid() async {
    final url = API+'getuid/';
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      getUidVariable = response.body;
      getUidVariable2 = int.parse(getUidVariable);
      print('GetUi Variable-->   $getUidVariable');
    } else {
      print(response.statusCode);
    }
  }

  // ignore: non_constant_identifier_names

  // ignore: missing_return

  // _switchChanged() async {
  //   var url = 'https://genorion1234.herokuapp.com/devicePinStatus/?d_id=1';
  //   String token = await getToken();
  //   final response = await http.get(url, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Token $token',
  //   });
  //   if (response.statusCode == 201) {
  //     print(response.body);
  //     return response.body;
  //   } else {
  //     print(response.statusCode);
  //   }
  // }
  // methods(){
  //   setState(() {
  //     place_Name(editingController.text);
  //     floorval = send_FloorName(flooreditingController.text);
  //   futureRoom=  send_RoomName(roomeditingController.text);
  //     // send_RoomName(roomeditingController.text);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isVisible
            ? Container(
                color: Colors.blueAccent,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
              )
            : ModalProgressHUD(
                inAsyncCall: _isInAsyncCall,
                progressIndicator: CircularProgressIndicator(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue, Colors.lightBlueAccent])),
                  child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints viewportConstraints) {
                    if (viewportConstraints.maxWidth > 600) {
                      return Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: ClipPath(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    width: 300,
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: editingController,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Place Name',
                                        contentPadding: const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    width: 300,
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: floorEditingController,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Floor Name',
                                        contentPadding: const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    width: 300,
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: flatEditingController,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Flat Name',
                                        contentPadding: const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    width: 300,
                                    child: TextFormField(
                                      controller: roomEditingController,
                                      autofocus: true,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Room Name',
                                        contentPadding: const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  child: Text('Submit'),
                                  onPressed: () async {
                                    // PlaceType place=  await place_Name(editingController.text);
                                    //   FloorType  floor = await send_FloorName(floorEditingController.text);
                                    //   RoomType  room= await send_RoomName(roomEditingController.text);
                                    //   Device device= await send_DeviceId(deviceEditingController.text);

                                    pt = await placeName(editingController.text);
                                    print('After Await  $placeResponse');
                                    fl = await sendFloorName(floorEditingController.text);
                                    flat = await sendFlatName(flatEditingController.text);
                                    room = [await sendRoomName(roomEditingController.text)];
                                    // await send_DeviceId(deviceEditingController.text);

                                    // setValue();
                                    // placeResponsePreference.setInt('pId', placeResponse);
                                    // floorResponsePreference.setInt('fId', floorResponse);
                                    // roomResponsePreference.setInt('rId', roomResponse2);

                                    setState(() {
                                      rm = room;
                                      // tabbarState=rm[0].rId;
                                      tabbarState = roomResponse;
                                      // dv=[deviceResponse] ;
                                      isVisible = true;
                                    });

                                    print('On Press tabbar --> $tabbarState');
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => HomeTest(
                                    //               pt: pt,
                                    //               fl: fl,
                                    //               flat: flat,
                                    //               rm: rm,
                                    //               dv: dv,
                                    //             )));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('GenOrion'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DropDown2())).then((value) =>
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  super.widget)));
                                },
                                child: Text(
                                  'Your places',
                                  style: TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                        body: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.blue, Colors.lightBlueAccent])),
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight,
                            ),
                            child: ClipPath(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: editingController,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Place Name',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: floorEditingController,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Floor Name',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: flatEditingController,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Flat Name',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: TextFormField(
                                      controller: roomEditingController,
                                      autofocus: true,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Room Name',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  ElevatedButton(
                                    child: Text('Submit'),
                                    onPressed: () async {
                                      // PlaceType place=  await place_Name(editingController.text);
                                      //   FloorType  floor = await send_FloorName(floorEditingController.text);
                                      //   RoomType  room= await send_RoomName(roomEditingController.text);
                                      //   Device device= await send_DeviceId(deviceEditingController.text);

                                      pt = await placeName(
                                          editingController.text);
                                      print('After Await  $placeResponse');
                                      fl = await sendFloorName(
                                          floorEditingController.text);
                                      flat = await sendFlatName(
                                          flatEditingController.text);
                                      room = [
                                        await sendRoomName(
                                            roomEditingController.text)
                                      ];
                                      // await send_DeviceId(deviceEditingController.text);

                                      // setValue();
                                      // placeResponsePreference.setInt('pId', placeResponse);
                                      // floorResponsePreference.setInt('fId', floorResponse);
                                      // roomResponsePreference.setInt('rId', roomResponse2);

                                      setState(() {
                                        rm = room;
                                        // tabbarState=rm[0].rId;
                                        tabbarState = roomResponse;
                                        // dv=[deviceResponse] ;
                                        isVisible = true;
                                      });

                                      print('On Press tabbar --> $tabbarState');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeTest(
                                                    pt: pt,
                                                    fl: fl,
                                                    flat: flat,
                                                    rm: rm,
                                                    dv: dv,
                                                  )));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ));
  }
}
