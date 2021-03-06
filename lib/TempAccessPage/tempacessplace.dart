import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/TempAccessPage/tempaccessmodels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Setting_Page.dart';
import '../changeFont.dart';
import '../main.dart';

class TempAccessPlacePage extends StatefulWidget {
  var placeId;
  var ownerName;
  TempAccessFloor tempFloor;
  TempAccessPlace tempPlace;
  TempAccessFlat tempFlat;

  List<TempAccessRoom> room;
  List<TempAccessDevice> dv;
  TempAccessPlacePage({Key key, this.placeId,this.ownerName,this.room,this.tempPlace,this.tempFloor,this.tempFlat,this.dv}) : super(key: key);
  // ignore: non_constant_identifier_names
  var switch1_get;
  var switch1Name;
  var switch2Name;
  var switch3Name;
  var switch4Name;
  var switch5Name;
  var switch6Name;
  var switch7Name;
  var switch8Name;
  var switch9Name;
  var switch10Name;
  var switch11Name;
  var switch12Name;

  // ignore: non_constant_identifier_names
  var Slider_get = 1;

  // ignore: non_constant_identifier_names
  var Slider_get2 = 1;

  // ignore: non_constant_identifier_names
  var Slider_get3 = 1;
  var Slider_get4;

  var Slider_get5;

  var Slider_get6;

  var Slider_get7;

  var Slider_get8;

  var Slider_get9;

  var Slider_get10;
  var Slider_get11;
  var Slider_get12;

  // ignore: non_constant_identifier_names
  var switch2_get,
  // ignore: non_constant_identifier_names
      switch3_get,
  // ignore: non_constant_identifier_names
      switch4_get,
  // ignore: non_constant_identifier_names
      switch5_get,
  // ignore: non_constant_identifier_names
      switch6_get,
  // ignore: non_constant_identifier_names
      switch7_get,
  // ignore: non_constant_identifier_names
      switch8_get,
  // ignore: non_constant_identifier_names
      switch9_get;

  @override
  _TempAccessPlacePageState createState() => _TempAccessPlacePageState();
}

class _TempAccessPlacePageState extends State<TempAccessPlacePage> {
  String token="774945db6cd2eec12fe92227ab9b811c888227c6";
  List<TempAccessPlace> place;
  List<TempAccessFloor> floor;
  TempAccessFloor tempFloor;
  TempAccessFlat tempFlat;
  List<TempAccessFlat> flat;
  List<TempAccessRoom> room;
  List<TempAccessDevice> dv;
  TabController tabC;
  bool val1 = true;
  bool _switchValue = false;
  bool val2 = false;

  var textSelected;

  List responseGetData;
  List responseGetDataWeb;

  List deviceStatus;

  List<String> namesDataList;

  var namesDataList12;

  var tabbarState;

  Future deviceSensorVal;

  Future floorVal;

  Future flatVal;

  bool switchOn;

  List<String> namesDataListWeb;

  Future deviceSensorValWeb;
  @override
  void initState() {
    super.initState();
    getPlaceName();
    getPlaceNameWeb();
  }

  var placeName;
  var floorName;
  Future<List<TempAccessPlace>> getplacesForDropDown() async {
    String token = await getToken();
    final url = API+'addyourplace/?p_id=' +
        widget.placeId.toString();

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode>0) {
      print('dropDown ${response.body}');
      print('dropDown ${response.statusCode}');

      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<TempAccessPlace> places =
      data.map((data) => TempAccessPlace.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }
  }
  Future placeVal;
  Future<List<TempAccessFloor>> getFloorsForDropDown() async {
    final url =
        API+'getallfloorsbyonlyplaceidp_id/?p_id=' + widget.placeId.toString();
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode >0) {
      print('dropDownFloor ${response.statusCode}');
      print('dropDownFloor ${response.body}');
      List<dynamic> data = jsonDecode(response.body);
      List<TempAccessFloor> floors = data.map((data) => TempAccessFloor.fromJson(data)).toList();
      print(floors);
      return floors;
    }
  }

  Future<List<TempAccessFlat>> getFlatForDropDown(String fId) async {
    final url =
        API+'getallflatbyonlyflooridf_id/?f_id=' + fId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    List<TempAccessFlat> flat;
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      flat  = data.map((data) => TempAccessFlat.fromJson(data)).toList();
      print('flatdata147 ${flat}');

    }
    return flat;
  }
  Future<List<TempAccessRoom>> getRoomsForDropDown(String flt_Id) async {
    final url = API+'getallroomsbyonlyflooridf_id/?flt_id=' + flt_Id;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode >0) {
      print('roomChanges ${response.statusCode}');
      print('roomChanges ${response.body}');
      List<dynamic> data = jsonDecode(response.body);
      List<TempAccessRoom> rooms = data.map((data) => TempAccessRoom.fromJson(data)).toList();
      print(rooms);
      return rooms;
    }
  }
  Future<List<TempAccessDevice>> getDeviceForDropDown(String rId) async {
    final url = API+'getalldevicesbyonlyroomidr_id/?r_id=' +rId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<TempAccessDevice> devices = data.map((data) => TempAccessDevice.fromJson(data)).toList();
      print(devices);
      return devices;
    }
  }



  _createAlertDialogDropDown(BuildContext context) {
    floorVal = getFloorsForDropDown();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Floor'),
            content: Container(
              height: 390,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child:FutureBuilder<List<TempAccessFloor>>(
                          future: floorVal,
                  builder:
                      (context, AsyncSnapshot<List<TempAccessFloor>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0) {
                        return Center(
                            child: Text("No Devices on this place"));
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
                                  child: DropdownButtonFormField<TempAccessFloor>(
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
                                    value: tempFloor,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    items: snapshot.data.map((selectedFloor) {
                                      return DropdownMenuItem<TempAccessFloor>(
                                        value: selectedFloor,
                                        child: Text(selectedFloor.fName),
                                      );
                                    }).toList(),
                                    onChanged: (TempAccessFloor selectedFloor) async {

                                      setState(() {
                                        // flat[0]=null;

                                        flatVal= getFlatForDropDown(selectedFloor.fId);
                                        floor[0] = selectedFloor;
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child:FutureBuilder<List<TempAccessFlat>>(
                          future: flatVal,
                          builder:
                              (context, AsyncSnapshot<List<TempAccessFlat>> snapshot) {
                            if (snapshot.hasData) {
                              print('im coming');
                              if (snapshot.data.length == 0) {
                                return Center(
                                    child: Text("No Devices on this place"));
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
                                          child: DropdownButtonFormField<TempAccessFlat>(
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
                                            hint: Text('Select Flat'),
                                            isExpanded: true,
                                            value: tempFlat,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            items: snapshot.data
                                                .map((selectedFlat) {
                                              return DropdownMenuItem<TempAccessFlat>(
                                                value: selectedFlat,
                                                child: Text(selectedFlat.fltName),
                                              );
                                            }).toList(),
                                            onChanged: (TempAccessFlat selectedFlat) {
                                              setState(() {
                                                flat[0] = selectedFlat;
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
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  // elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                  room=await getRoomsForDropDown(flat[0].fltId.toString());
                  dv= await  getDeviceForDropDown(room[0].rId.toString());
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TempAccessPlacePage(
                    tempPlace: place[0],
                    tempFloor: floor[0],
                    tempFlat: flat[0],
                    room: room,
                    dv: dv,
                  )));
                  //
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>TempAccessPlacePage(
                  //   tempPlace: place[0],
                  //   tempFloor: floor[0],
                  //   tempFlat: flat[0],
                  //   room: room,
                  // )
                  // ));
                  // dv= a
                  },
                ),
              )
            ],
          );
        });
  }
  var tokenWeb;

  Future getTokenWeb() async {
    final pref = await SharedPreferences.getInstance();
    tokenWeb = pref.getString('tokenWeb');
    return tokenWeb;
  }



  Future getPlaceName() async {
    String token = await getToken();
    final url = API+'getyouplacename/?p_id=' +
        widget.placeId.toString();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print("GetPlaceName  ${response.statusCode}");
      print("GetPlaceNameResponseBody  ${response.body}");
      List<dynamic> data = jsonDecode(response.body);

      var placeData = jsonDecode(response.body);

      print('widgetPlace ${widget.tempPlace}');
      place =
          data.map((data) => TempAccessPlace.fromJson(data)).toList();
      setState(() {
        place =
            data.map((data) => TempAccessPlace.fromJson(data)).toList();
        placeName = placeData[0]["p_type"];
      });
    }
    getFloorForTempUser();
  }

  Future getPlaceNameWeb() async {
   await getTokenWeb();
    final url = API+'getyouplacename/?p_id=' +
        widget.placeId.toString();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode > 0) {
      print("GetPlaceName  ${response.statusCode}");
      print("GetPlaceNameResponseBody  ${response.body}");
      List<dynamic> data = jsonDecode(response.body);

      var placeData = jsonDecode(response.body);

      print('widgetPlace ${widget.tempPlace}');
      place =
          data.map((data) => TempAccessPlace.fromJson(data)).toList();
      setState(() {
        place =
            data.map((data) => TempAccessPlace.fromJson(data)).toList();
        placeName = placeData[0]["p_type"];
      });
    }
    getFloorForTempUserWeb();
  }



  Future getFloorForTempUser() async {
    final url =
        API+'getallfloorsbyonlyplaceidp_id/?p_id=' + widget.placeId.toString();

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('floorSubUser ${response.statusCode}');
      print('floorSubUser ${response.body}');

      if (response.statusCode == 200) {
        List floorData = jsonDecode(response.body);
        print('floorSubUser ${floorData}');
        List<dynamic> data = jsonDecode(response.body);
          setState(() {
            floor = data.map((data) => TempAccessFloor.fromJson(data)).toList();
          });

        getFlatForTempUser();
      }
    }
  }
  Future getFloorForTempUserWeb() async {
    await getTokenWeb();
    final url =
        API+'getallfloorsbyonlyplaceidp_id/?p_id=' + widget.placeId.toString();

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode > 0) {
      print('floorSubUser ${response.statusCode}');
      print('floorSubUser ${response.body}');

      if (response.statusCode == 200) {
        List floorData = jsonDecode(response.body);
        print('floorSubUser ${floorData}');
        List<dynamic> data = jsonDecode(response.body);
          setState(() {
            floor = data.map((data) => TempAccessFloor.fromJson(data)).toList();
          });

        getFlatForTempUserWeb();
      }
    }
  }

  Future getFlatForTempUser() async {

      final url =
          API+'getallflatbyonlyflooridf_id/?f_id=' + floor[0].fId.toString();
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print('flatSubUser ${response.statusCode}');
        print('flatSubUser ${response.body}');
          if(response.statusCode==200){
            List<dynamic> data = jsonDecode(response.body);
            setState(() {
              flat = data.map((data) => TempAccessFlat.fromJson(data)).toList();
            });
          }
        getRoomForTempUser();
      }
  }
  Future getFlatForTempUserWeb() async {
      await getTokenWeb();
      final url =
          API+'getallflatbyonlyflooridf_id/?f_id=' + floor[0].fId.toString();
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $tokenWeb',
      });
      if (response.statusCode > 0) {
        print('flatSubUser ${response.statusCode}');
        print('flatSubUser ${response.body}');
          if(response.statusCode==200){
            List<dynamic> data = jsonDecode(response.body);
            setState(() {
              flat = data.map((data) => TempAccessFlat.fromJson(data)).toList();
            });
          }
        getRoomForTempUserWeb();
      }
  }

  Future getRoomForTempUser() async {
      final url = API+'getallroomsbyonlyflooridf_id/?flt_id=' + flat[0].fltId;
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print('RoomSubUser ${response.statusCode}');
        print('RoomSubUser ${response.body}');
        if(response.statusCode==200){
          List<dynamic> data = jsonDecode(response.body);
          setState(() {
            room = data.map((data) => TempAccessRoom.fromJson(data)).toList();
          });
          // getDeviceForTempUser();
        }

    }
  }
  Future getRoomForTempUserWeb() async {
    await getTokenWeb();
      final url = API+'getallroomsbyonlyflooridf_id/?flt_id=' + flat[0].fltId;
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $tokenWeb',
      });
      if (response.statusCode > 0) {
        print('RoomSubUser ${response.statusCode}');
        print('RoomSubUser ${response.body}');
        if(response.statusCode==200){
          List<dynamic> data = jsonDecode(response.body);
          setState(() {
            room = data.map((data) => TempAccessRoom.fromJson(data)).toList();
          });
          // getDeviceForTempUser();
        }

    }
  }

  Future  getDeviceForTempUser(String rId) async {
      // print('tabbar1 ${tabState}');
      final url = API+'getalldevicesbyonlyroomidr_id/?r_id=' +rId;
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print('deviceGetSubUser ${response.statusCode}');
        print('deviceGetSubUser ${response.body}');
        if(response.statusCode==200){
          List<dynamic> data = jsonDecode(response.body);
          setState(() {
            dv = data.map((data) => TempAccessDevice.fromJson(data)).toList();
          });

        }
      }
      // getPinStatusData();

  }
  Future  getDeviceForTempUserWeb(String rId) async {
    await getTokenWeb();
      // print('tabbar1 ${tabState}');
      final url = API+'getalldevicesbyonlyroomidr_id/?r_id=' +rId;
      // String token = 'ec21799a656ff17d2008d531d0be922963f54378';
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $tokenWeb',
      });
      if (response.statusCode > 0) {
        print('deviceGetSubUser ${response.statusCode}');
        print('deviceGetSubUser ${response.body}');
        if(response.statusCode==200){
          List<dynamic> data = jsonDecode(response.body);
          setState(() {
            dv = data.map((data) => TempAccessDevice.fromJson(data)).toList();
          });

        }
      }
      // getPinStatusData();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: (){
              _createAlertDialogDropDown(context);
            },
            child: Text(place[0].pType,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),)),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Container(
          width: double.maxFinite,
          color: change_toDark ? Colors.black : Colors.white,
          child: DefaultTabController(
            length: room.length,
            child: CustomScrollView(
              // key: key,

              // controller: _scrollController,
                slivers: <Widget>[
                  //Upper Widget
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.41,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff669df4),
                                  Color(0xff4e80f3)
                                ]),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          padding: EdgeInsets.only(
                            top: 40,
                            bottom: 10,
                            left: 30,
                            right: 30,
                          ),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Text(
                                      'Assigned By ',
                                      style: TextStyle(
                                          fontFamily: fonttest==null?changeFont:fonttest,
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      widget.ownerName.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // _createAlertDialogDropDown(context);
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Text(
                                          floor[0].fName.toString(),

                                          // 'Hello ',
                                          // + widget.fl.user.first_name,
                                          style: TextStyle(
                                              fontFamily: fonttest==null?changeFont:fonttest,
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        onTap: () {
                                          // _createAlertDialogDropDown(context);
                                        },
                                      ),

                                      SizedBox(
                                        height: 12,
                                      ),
                                      GestureDetector(
                                        onTap: () async{

                                        },
                                        child: Text(
                                          flat[0].fltName.toString(),
                                          // widget.flat.fltName,
                                          // 'Hello ',
                                          // + widget.fl.user.first_name,
                                          style: TextStyle(
                                              fontFamily: fonttest==null?changeFont:fonttest,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        // onTap: () {
                                        //   // _createAlertDialogDropDown(context);
                                        // },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FutureBuilder(
                                    future: deviceSensorValWeb,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        print('SnapShot ${snapshot}');
                                        return Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Column(children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.fire,
                                                    color: Colors.yellow,
                                                  ),
                                                  SizedBox(
                                                    height: 32,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          // 'aa',
                                                            sensorData['sensor1'].toString(),
                                                            style: TextStyle(
                                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white70)),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                                SizedBox(
                                                  width: 35,
                                                ),
                                                Column(children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .temperatureLow,
                                                    color: Colors.orange,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          // 's',
                                                            sensorData['sensor2'].toString(),
                                                            style: TextStyle(
                                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white70)),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                                SizedBox(
                                                  width: 45,
                                                ),
                                                Column(children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.wind,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          // 's',
                                                            sensorData['sensor3'].toString(),
                                                            style: TextStyle(
                                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white70)),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                                SizedBox(
                                                  width: 42,
                                                ),
                                                Column(children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.cloud,
                                                    color: Colors.orange,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                            sensorData['sensor4'].toString(),
                                                            style: TextStyle(
                                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white70)),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Text(
                                                sensorData['d_id'].toString(),
                                                style: TextStyle(
                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                    fontSize:
                                                    14,
                                                    color: Colors
                                                        .white70)),
                                          ],
                                        );
                                      } else {
                                        return Center(
                                          child: Text('Loading...'),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //Room Tabs
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    // centerTitle: true,
                    floating: true,
                    pinned: true,
                    backgroundColor: Colors.white,

                    title: Container(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                    height: 30  ,
                                    child: Text('Rooms->', style: TextStyle(
                                        fontFamily: fonttest==null?changeFont:fonttest,
                                        // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight
                                            .bold,
                                        color: Colors
                                            .black
                                    ),)),
                                TabBar(
                                  indicatorColor: Colors.blueAccent,
                                  controller: tabC,
                                  labelColor: Colors.blueAccent,
                                  indicatorWeight: 2.0,
                                  isScrollable: true,
                                  tabs:room.map<Widget>((TempAccessRoom rm) {
                                    return Tab(
                                      text: rm.rName,
                                    );
                                  }).toList(),
                                  onTap: (index) async {
                                    tabbarState=room[index].rId.toString();
                                    getDeviceForTempUserWeb(tabbarState);

                                    getDevicesWeb(tabbarState);

                                  },
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      print('asdfirst ${dv.length}');
                      if (index <dv.length) {

                        dv.length==null? Text('loading'):dv.length==null;
                        print('asdf ${dv.length}');
                        Text(
                          "Loading",
                          style: TextStyle(fontSize: 44),
                        );

                        return Container(
                          child: Column(
                            children: [
                              deviceContainerWeb(dv[index].dId, index),
                              Container(
                                //
                                // color: Colors.green,
                                  height: 35,
                                  child: GestureDetector(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          // text:'aa',
                                          // text:deviceSubUser[index]['d_id'],
                                            text: dv[index].dId,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black)),
                                        TextSpan(text: "   "),
                                        WidgetSpan(
                                            child: Icon(
                                              Icons.settings,
                                              size: 18,
                                            ))
                                      ]),
                                    ),
                                    onTap: () {
                                      // _createAlertDialogForSSIDAndEmergencyNumber(
                                      //     context);
                                      print('on tap');
                                    },
                                  )),
                            ],
                          ),
                        );
                      } else {
                        return null;
                      }
                    }),
                  )
                ]),
          ),
        );
      }else{
        return Container(
          width: double.maxFinite,
          color: change_toDark ? Colors.black : Colors.white,
          child: DefaultTabController(
            length: room.length,
            child: CustomScrollView(
              // key: key,

              // controller: _scrollController,
                slivers: <Widget>[
                  //Upper Widget
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.41,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff669df4),
                                  Color(0xff4e80f3)
                                ]),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          padding: EdgeInsets.only(
                            top: 40,
                            bottom: 10,
                            left: 30,
                            right: 30,
                          ),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Text(
                                      'Assigned By ',
                                      style: TextStyle(
                                          fontFamily: fonttest==null?changeFont:fonttest,
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      widget.ownerName.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // _createAlertDialogDropDown(context);
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Text(
                                          floor[0].fName.toString(),

                                          // 'Hello ',
                                          // + widget.fl.user.first_name,
                                          style: TextStyle(
                                              fontFamily: fonttest==null?changeFont:fonttest,
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        onTap: () {
                                          // _createAlertDialogDropDown(context);
                                        },
                                      ),

                                      SizedBox(
                                        height: 12,
                                      ),
                                      GestureDetector(
                                        onTap: () async{

                                        },
                                        child: Text(
                                          flat[0].fltName.toString(),
                                          // widget.flat.fltName,
                                          // 'Hello ',
                                          // + widget.fl.user.first_name,
                                          style: TextStyle(
                                              fontFamily: fonttest==null?changeFont:fonttest,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        // onTap: () {
                                        //   // _createAlertDialogDropDown(context);
                                        // },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FutureBuilder(
                                    future: deviceSensorVal,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        print('SnapShot ${snapshot}');
                                        return Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Column(children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.fire,
                                                    color: Colors.yellow,
                                                  ),
                                                  SizedBox(
                                                    height: 32,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          // 'aa',
                                                            sensorData['sensor1'].toString(),
                                                            style: TextStyle(
                                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white70)),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                                SizedBox(
                                                  width: 35,
                                                ),
                                                Column(children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .temperatureLow,
                                                    color: Colors.orange,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          // 's',
                                                            sensorData['sensor2'].toString(),
                                                            style: TextStyle(
                                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white70)),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                                SizedBox(
                                                  width: 45,
                                                ),
                                                Column(children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.wind,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          // 's',
                                                            sensorData['sensor3'].toString(),
                                                            style: TextStyle(
                                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white70)),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                                SizedBox(
                                                  width: 42,
                                                ),
                                                Column(children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.cloud,
                                                    color: Colors.orange,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                            sensorData['sensor4'].toString(),
                                                            style: TextStyle(
                                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white70)),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Text(
                                                sensorData['d_id'].toString(),
                                                style: TextStyle(
                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                    fontSize:
                                                    14,
                                                    color: Colors
                                                        .white70)),
                                          ],
                                        );
                                      } else {
                                        return Center(
                                          child: Text('Loading...'),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //Room Tabs
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    // centerTitle: true,
                    floating: true,
                    pinned: true,
                    backgroundColor: Colors.white,

                    title: Container(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                    height: 30  ,
                                    child: Text('Rooms->', style: TextStyle(
                                        fontFamily: fonttest==null?changeFont:fonttest,
                                        // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight
                                            .bold,
                                        color: Colors
                                            .black
                                    ),)),
                                TabBar(
                                  indicatorColor: Colors.blueAccent,
                                  controller: tabC,
                                  labelColor: Colors.blueAccent,
                                  indicatorWeight: 2.0,
                                  isScrollable: true,
                                  tabs:room.map<Widget>((TempAccessRoom rm) {
                                    return Tab(
                                      text: rm.rName,
                                    );
                                  }).toList(),
                                  onTap: (index) async {
                                    tabbarState=room[index].rId.toString();
                                    getDeviceForTempUser(tabbarState);

                                    getDevices(tabbarState);

                                  },
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      print('asdfirst ${dv.length}');
                      if (index <dv.length) {

                        dv.length==null? Text('loading'):dv.length==null;
                        print('asdf ${dv.length}');
                        Text(
                          "Loading",
                          style: TextStyle(fontSize: 44),
                        );

                        return Container(
                          child: Column(
                            children: [
                              deviceContainer2(dv[index].dId, index),
                              Container(
                                //
                                // color: Colors.green,
                                  height: 35,
                                  child: GestureDetector(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          // text:'aa',
                                          // text:deviceSubUser[index]['d_id'],
                                            text: dv[index].dId,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black)),
                                        TextSpan(text: "   "),
                                        WidgetSpan(
                                            child: Icon(
                                              Icons.settings,
                                              size: 18,
                                            ))
                                      ]),
                                    ),
                                    onTap: () {
                                      // _createAlertDialogForSSIDAndEmergencyNumber(
                                      //     context);
                                      print('on tap');
                                    },
                                  )),
                            ],
                          ),
                        );
                      } else {
                        return null;
                      }
                    }),
                  )
                ]),
          ),
        );
      }
        }
        ),
    );
  }
  var data;
  getData(String dId) async {
    final String url = API+'getpostdevicePinStatus/?d_id=' + dId;
    String token = await getToken();
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {

      data = jsonDecode(response.body);
      var arr = jsonDecode(response.body);
      List listOfPinStatus = [
        arr,
      ];
      print('sensorData  ${listOfPinStatus}');
      // for (int i = 0; i < listOfPinStatus.length; i++) {
      //
      //   String a = listOfPinStatus[i]['pin20Status'].toString();
      //   print('ForLoop123 ${a}');
      //   int aa = int.parse(a);
      //   int ms = ((DateTime.now().millisecondsSinceEpoch) / 1000).round() - 100; // -100 for checking a difference for 100 seconds in current time
      //   print('CheckMs ${ms}');
      //   print('Checkaa ${aa}');
      //   if (aa >= ms) {
      //     print('ifelse');
      //     statusOfDevice = 1;
      //   } else {
      //     print('ifelse2');
      //     statusOfDevice = 0;
      //   }
      // }
      print("DATA-->  $data");
      print('\n');
      deviceStatus = [
        widget.switch1_get = data["pin1Status"],
        widget.switch2_get = data["pin2Status"],
        widget.switch3_get = data["pin3Status"],
        widget.switch4_get = data["pin4Status"],
        widget.switch5_get = data["pin5Status"],
        widget.switch6_get = data["pin6Status"],
        widget.switch7_get = data["pin7Status"],
        widget.switch8_get = data["pin8Status"],
        widget.switch9_get = data["pin9Status"],
        widget.Slider_get = data["pin10Status"],
        widget.Slider_get2 = data["pin11Status"],
        widget.Slider_get3 = data["pin12Status"],
      ];
      for (int i = 0; i < data.length; i++) {}

      print('Switch 1 --> ${widget.switch1_get}');
      print('Switch 2 --> ${widget.switch2_get}');
      print('Switch 3 --> ${widget.switch3_get}');
      print('Switch 4 --> ${widget.switch4_get}');
      print('Switch 5 --> ${widget.switch5_get}');
      print('Switch 6 --> ${widget.switch6_get}');
      print('Switch 7 --> ${widget.switch7_get}');
      print('Switch 8 --> ${widget.switch8_get}');
      print('Switch 9 --> ${widget.switch9_get}');
      print('Switch 10 --> ${widget.Slider_get}');
      print('Switch 11 --> ${widget.Slider_get2}');
      print('Switch 12 --> ${widget.Slider_get3}');
    } else {
      print(response.statusCode);
      throw Exception('Failed to getData.');
    }
    getPinsName(dId);
    return data;
  }
  getDataWeb(String dId) async {
    final String url = API+'getpostdevicePinStatus/?d_id=' + dId;
     await getTokenWeb();
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {

      data = jsonDecode(response.body);
      var arr = jsonDecode(response.body);
      List listOfPinStatus = [
        arr,
      ];
      print('sensorData  ${listOfPinStatus}');
      // for (int i = 0; i < listOfPinStatus.length; i++) {
      //
      //   String a = listOfPinStatus[i]['pin20Status'].toString();
      //   print('ForLoop123 ${a}');
      //   int aa = int.parse(a);
      //   int ms = ((DateTime.now().millisecondsSinceEpoch) / 1000).round() - 100; // -100 for checking a difference for 100 seconds in current time
      //   print('CheckMs ${ms}');
      //   print('Checkaa ${aa}');
      //   if (aa >= ms) {
      //     print('ifelse');
      //     statusOfDevice = 1;
      //   } else {
      //     print('ifelse2');
      //     statusOfDevice = 0;
      //   }
      // }
      print("DATA-->  $data");
      print('\n');
      deviceStatus = [
        widget.switch1_get = data["pin1Status"],
        widget.switch2_get = data["pin2Status"],
        widget.switch3_get = data["pin3Status"],
        widget.switch4_get = data["pin4Status"],
        widget.switch5_get = data["pin5Status"],
        widget.switch6_get = data["pin6Status"],
        widget.switch7_get = data["pin7Status"],
        widget.switch8_get = data["pin8Status"],
        widget.switch9_get = data["pin9Status"],
        widget.Slider_get = data["pin10Status"],
        widget.Slider_get2 = data["pin11Status"],
        widget.Slider_get3 = data["pin12Status"],
      ];
      for (int i = 0; i < data.length; i++) {}

      print('Switch 1 --> ${widget.switch1_get}');
      print('Switch 2 --> ${widget.switch2_get}');
      print('Switch 3 --> ${widget.switch3_get}');
      print('Switch 4 --> ${widget.switch4_get}');
      print('Switch 5 --> ${widget.switch5_get}');
      print('Switch 6 --> ${widget.switch6_get}');
      print('Switch 7 --> ${widget.switch7_get}');
      print('Switch 8 --> ${widget.switch8_get}');
      print('Switch 9 --> ${widget.switch9_get}');
      print('Switch 10 --> ${widget.Slider_get}');
      print('Switch 11 --> ${widget.Slider_get2}');
      print('Switch 12 --> ${widget.Slider_get3}');
    } else {
      print(response.statusCode);
      throw Exception('Failed to getData.');
    }
    getPinsNameWeb(dId);
    return data;
  }


  Future getPinsName(String dId) async {
    String url = API+"editpinnames/?d_id=" + dId;
    String token = await getToken();
    // try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      namesDataList12 = json.decode(response.body);
      // DevicePin devicePin=DevicePin.fromJson(devicePinNamesData);



      print('QWERTY  $namesDataList12');
      namesDataList = [
        widget.switch1Name = namesDataList12['pin1Name'].toString(),
        widget.switch2Name = namesDataList12['pin2Name'].toString(),
        widget.switch3Name = namesDataList12['pin3Name'].toString(),
        widget.switch4Name = namesDataList12['pin4Name'].toString(),
        widget.switch5Name = namesDataList12['pin5Name'].toString(),
        widget.switch6Name = namesDataList12['pin6Name'].toString(),
        widget.switch7Name = namesDataList12['pin7Name'].toString(),
        widget.switch8Name = namesDataList12['pin8Name'].toString(),
        widget.switch9Name = namesDataList12['pin9Name'].toString(),
        widget.switch10Name = namesDataList12['pin10Name'].toString(),
        widget.switch11Name = namesDataList12['pin11Name'].toString(),
        widget.switch12Name = namesDataList12['pin12Name'].toString(),
      ];
      print('namesDataList  $namesDataList');
    }
  }
  Future getPinsNameWeb(String dId) async {
    String url = API+"editpinnames/?d_id=" + dId;
     await getTokenWeb();
    // try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
     var namesDataList12 = json.decode(response.body);
      // DevicePin devicePin=DevicePin.fromJson(devicePinNamesData);



      print('QWERTY  $namesDataList12');
      namesDataListWeb = [
        widget.switch1Name = namesDataList12['pin1Name'].toString(),
        widget.switch2Name = namesDataList12['pin2Name'].toString(),
        widget.switch3Name = namesDataList12['pin3Name'].toString(),
        widget.switch4Name = namesDataList12['pin4Name'].toString(),
        widget.switch5Name = namesDataList12['pin5Name'].toString(),
        widget.switch6Name = namesDataList12['pin6Name'].toString(),
        widget.switch7Name = namesDataList12['pin7Name'].toString(),
        widget.switch8Name = namesDataList12['pin8Name'].toString(),
        widget.switch9Name = namesDataList12['pin9Name'].toString(),
        widget.switch10Name = namesDataList12['pin10Name'].toString(),
        widget.switch11Name = namesDataList12['pin11Name'].toString(),
        widget.switch12Name = namesDataList12['pin12Name'].toString(),
      ];
      print('namesDataList  $namesDataListWeb');
    }
  }


   var sensorData;
  TempAccessSensor sensors;
  Future<List<TempAccessDevice>> getDevices(String rId) async {
    print('tabbas ${tabbarState}');
    var query = {'r_id': tabbarState};
    final url = API+'addyourdevice/?r_id='+tabbarState;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print(response.statusCode);
      deviceData = jsonDecode(response.body);
      dv = deviceData.map((data) => TempAccessDevice.fromJson(data)).toList();
      print('Room Id query ================================   $query');
      print('------Devicessssssssssssssssssssssssssssss Data $deviceData');

      // getDatafunc2();
      return dv;
    }
  }
  Future<List<TempAccessDevice>> getDevicesWeb(String rId) async {
    print('tabbas ${tabbarState}');
    var query = {'r_id': tabbarState};
    final url = API+'addyourdevice/?r_id='+tabbarState;
    await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode > 0) {
      print(response.statusCode);
      deviceData = jsonDecode(response.body);
      dv = deviceData.map((data) => TempAccessDevice.fromJson(data)).toList();
      print('Room Id query ================================   $query');
      print('------Devicessssssssssssssssssssssssssssss Data $deviceData');

      // getDatafunc2();
      return dv;
    }
    return dv;
  }
  Future getSensorData(String dId) async {
    String token = await getToken();
    final response = await http.get(
        API+'tensensorsdata/?d_id=' + dId.toString(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });

// Appropriate action depending upon the
// server response
    if (response.statusCode > 0) {
      print('SensorTempUser ${response.body}');
      print('SensorStatsCode ${response.statusCode}');
       sensorData = jsonDecode(response.body);
       print('sensordata123 ${sensorData['sensor1']}');
      return sensorData;



    } else {
      throw Exception('Failed to load album');
    }
  }
  Future getSensorDataWeb(String dId) async {
     await getTokenWeb();
    final response = await http.get(
        API+'tensensorsdata/?d_id=' + dId.toString(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $tokenWeb',
        });

// Appropriate action depending upon the
// server response
    if (response.statusCode > 0) {
      print('SensorTempUser ${response.body}');
      print('SensorStatsCode ${response.statusCode}');
       sensorData = jsonDecode(response.body);
       print('sensordata123 ${sensorData['sensor1']}');
      return sensorData;



    } else {
      throw Exception('Failed to load album');
    }
  }
  var catchReturn;
  deviceContainer(String dId, int index) async {
    getData(dId);

    print('namesDataList12 ${namesDataList12}');

    catchReturn = await getData(dId);
    print('catchReturn123 ${catchReturn}');

    print('deviceSensorVal ${deviceSensorVal.toString()}');
    // var sensorData=
    responseGetData = [
      widget.switch1_get = catchReturn["pin1Status"],
      widget.switch2_get = catchReturn["pin2Status"],
      widget.switch3_get = catchReturn["pin3Status"],
      widget.switch4_get = catchReturn["pin4Status"],
      widget.switch5_get = catchReturn["pin5Status"],
      widget.switch6_get = catchReturn["pin6Status"],
      widget.switch7_get = catchReturn["pin7Status"],
      widget.switch8_get = catchReturn["pin8Status"],
      widget.switch9_get = catchReturn["pin9Status"],
      widget.Slider_get = catchReturn["pin10Status"],
      widget.Slider_get2 = catchReturn["pin11Status"],
      widget.Slider_get3 = catchReturn["pin12Status"],
    ];

    print('namesList123 ${namesDataList}');
    // catchReturn =  getData(dId);
    setState(() {

      responseGetData = [
        widget.switch1_get = catchReturn["pin1Status"],
        widget.switch2_get = catchReturn["pin2Status"],
        widget.switch3_get = catchReturn["pin3Status"],
        widget.switch4_get = catchReturn["pin4Status"],
        widget.switch5_get = catchReturn["pin5Status"],
        widget.switch6_get = catchReturn["pin6Status"],
        widget.switch7_get = catchReturn["pin7Status"],
        widget.switch8_get = catchReturn["pin8Status"],
        widget.switch9_get = catchReturn["pin9Status"],
        widget.Slider_get = catchReturn["pin10Status"],
        widget.Slider_get2 = catchReturn["pin11Status"],
        widget.Slider_get3 = catchReturn["pin12Status"],
      ];

    });
    if(responseGetData.contains(1)){
      setState(() {
        switchOn=true;
      });
      print('else ${switchOn}');
      print('else ${responseGetData}');
    }else{
      setState(() {
        switchOn=false;
      });
      print('else ${switchOn}');
      print('else ${responseGetData}');
    }
  }
  deviceDataWeb(String dId, int index) async {

    print('namesDataList12 ${namesDataList12}');

   var catchReturn = await getDataWeb(dId);
    print('catchReturn123 ${catchReturn}');

    print('deviceSensorVal ${deviceSensorVal.toString()}');
    // var sensorData=
    responseGetDataWeb = [
      widget.switch1_get = catchReturn["pin1Status"],
      widget.switch2_get = catchReturn["pin2Status"],
      widget.switch3_get = catchReturn["pin3Status"],
      widget.switch4_get = catchReturn["pin4Status"],
      widget.switch5_get = catchReturn["pin5Status"],
      widget.switch6_get = catchReturn["pin6Status"],
      widget.switch7_get = catchReturn["pin7Status"],
      widget.switch8_get = catchReturn["pin8Status"],
      widget.switch9_get = catchReturn["pin9Status"],
      widget.Slider_get = catchReturn["pin10Status"],
      widget.Slider_get2 = catchReturn["pin11Status"],
      widget.Slider_get3 = catchReturn["pin12Status"],
    ];

    print('namesList123 ${namesDataList}');
    // catchReturn =  getData(dId);
    setState(() {

      responseGetDataWeb = [
        widget.switch1_get = catchReturn["pin1Status"],
        widget.switch2_get = catchReturn["pin2Status"],
        widget.switch3_get = catchReturn["pin3Status"],
        widget.switch4_get = catchReturn["pin4Status"],
        widget.switch5_get = catchReturn["pin5Status"],
        widget.switch6_get = catchReturn["pin6Status"],
        widget.switch7_get = catchReturn["pin7Status"],
        widget.switch8_get = catchReturn["pin8Status"],
        widget.switch9_get = catchReturn["pin9Status"],
        widget.Slider_get = catchReturn["pin10Status"],
        widget.Slider_get2 = catchReturn["pin11Status"],
        widget.Slider_get3 = catchReturn["pin12Status"],
      ];

    });
    if(responseGetDataWeb.contains(1)){
      setState(() {
        switchOn=true;
      });
      print('else ${switchOn}');
      print('else ${responseGetDataWeb}');
    }else{
      setState(() {
        switchOn=false;
      });
      print('else ${switchOn}');
      print('else ${responseGetDataWeb}');
    }
  }

  dataUpdate(String dId) async {
    final String url =
        API+'getpostdevicePinStatus/?d_id=' + dId;
    String token = await getToken();
    Map data = {
      'put': 'yes',
      "d_id": dId,
      'pin1Status': responseGetData[0],
      'pin2Status': responseGetData[1],
      'pin3Status': responseGetData[2],
      'pin4Status': responseGetData[3],
      'pin5Status': responseGetData[4],
      'pin6Status': responseGetData[5],
      'pin7Status': responseGetData[6],
      'pin8Status': responseGetData[7],
      'pin9Status': responseGetData[8],
      'pin10Status': responseGetData[9],
      'pin11Status': responseGetData[10],
      'pin12Status': responseGetData[11],
      // 'pin13Status': m,
      // 'pin14Status': n,
      // 'pin15Status': o,
      // 'pin16Status': p,
      // 'pin17Status': q,
      // 'pin18Status': r,
      // 'pin19Status': s,
    };
    http.Response response =
    await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 201) {
      print("Data Updated  ${response.body}");

      getData(dId);
      //jsonDecode only for get method
      //return place_type.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update data');
    }
  }
  dataUpdateWeb(String dId) async {
    await getTokenWeb();
    final String url =
        API+'getpostdevicePinStatus/?d_id=' + dId;

    Map data = {
      'put': 'yes',
      "d_id": dId,
      'pin1Status': responseGetDataWeb[0],
      'pin2Status': responseGetDataWeb[1],
      'pin3Status': responseGetDataWeb[2],
      'pin4Status': responseGetDataWeb[3],
      'pin5Status': responseGetDataWeb[4],
      'pin6Status': responseGetDataWeb[5],
      'pin7Status': responseGetDataWeb[6],
      'pin8Status': responseGetDataWeb[7],
      'pin9Status': responseGetDataWeb[8],
      'pin10Status': responseGetDataWeb[9],
      'pin11Status': responseGetDataWeb[10],
      'pin12Status': responseGetDataWeb[11],
      // 'pin13Status': m,
      // 'pin14Status': n,
      // 'pin15Status': o,
      // 'pin16Status': p,
      // 'pin17Status': q,
      // 'pin18Status': r,
      // 'pin19Status': s,
    };
    http.Response response =
    await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 201) {
      print("Data Updated  ${response.body}");

      getData(dId);
      //jsonDecode only for get method
      //return place_type.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update data');
    }
  }


  _showDialog(String dId) {
    // dialog implementation
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Alert"),
            content: Text("Would to like to turn off all the appliances ?"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    for (int i = 0; i < responseGetData.length; i++) {
                      setState(() {
                        // responseGetData[newIndex - 1]=0 ;
                        if (responseGetData[i] > 0) {
                          responseGetData[i] = 0;
                          print('AllChange ${responseGetData.toString()}');
                        }

                      });

                    }
                    await dataUpdate(dId);
                    // var result = await Connectivity().checkConnectivity();
                    // if (result == ConnectivityResult.wifi) {
                    //   print("True2-->   $result");
                    //   // await localUpdate(dId);
                    //   await dataUpdate(dId);
                    // } else if (result == ConnectivityResult.mobile) {
                    //   await dataUpdate(dId);
                    //   await NewDbProvider.instance.getPinStatusByDeviceId(dId);
                    // } else {
                    //   messageSms(context, dId);
                    // }

                    Navigator.of(context).pop();
                  }),
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
    );
  }

  deviceContainer2(String dId, int x) {
    deviceContainer(dId, x);
    // fetchIp(dId);
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 1.95,
          // color: Colors.redAccent,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Turn Off All Appliances',
                        style: TextStyle(
                          fontFamily: fonttest==null?changeFont:fonttest,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: _switchValue ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        child:  Container(
                          // color:textSelected==dId.toString()?Colors.green:Colors.red,
                          child: Icon(textSelected==dId.toString()?Icons.update:Icons.sensors),
                        ),

                        onTap: () async {
                          print('check123${textSelected}');
                          deviceSensorVal =   getSensorData(dId);
                          setState(() {
                            textSelected=dId.toString();
                            deviceSensorVal = getSensorData(dId);
                          });
                          print('check123${textSelected==dId}');
                          print('_hasBeenPressed ${textSelected}');
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8),
                    //   child: GestureDetector(
                    //     child: Icon(Icons.schedule),
                    //     onTap: () {
                    //       _createAlertDialogForPinSchedule(context,dId);
                    //       // _createAlertDialogForPin17(context, dId);
                    //     },
                    //   ),
                    // ),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                          color: statusOfDevice == 1 ? Colors.green : Colors.grey,
                          shape: BoxShape.circle),
                      // child: ...
                    ),
                    Switch(
                      value: switchOn,
                      //boolean value
                      onChanged: (val) async {
                        _showDialog(dId);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        child: Icon(Icons.settings_remote),
                        onTap: () {
                          // _createAlertDialogForPin19(context, dId);
                        },
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                // color: Colors.yellow,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 1.32,
                // color: Colors.amber,
                child: GridView.count(
                    crossAxisSpacing: 8,
                    childAspectRatio: 2 / 1.8,
                    mainAxisSpacing: 4,
                    physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    crossAxisCount: 2,
                    children:
                    List.generate(responseGetData.length - 3, (index) {
                      print('Something');
                      print('catch return --> $catchReturn');

                      return Container(
                        // color: Colors.green,
                        height: 2030,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                  alignment: new FractionalOffset(1.0, 0.0),
                                  // alignment: Alignment.bottomRight,
                                  height: 120,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 10),
                                  margin: index % 2 == 0
                                      ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                                      : EdgeInsets.fromLTRB(
                                      7.5, 7.5, 15, 7.5),
                                  // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                                  decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(8, 10),
                                            color: Colors.black)
                                      ],
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Color(0xffa3a3a3)),
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  child: Column(
                                    // crossAxisAlignment:
                                    // CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          // GestureDetector(
                                          //     onTap: () {
                                          //       print(
                                          //           'tabbarstateDelete ${tabbarState}');
                                          //       print(
                                          //           'tabbarstateDelete ${dId}');
                                          //
                                          //       // deleteDevice(tabbarState, dId);
                                          //     },
                                          //     child: Icon(Icons.auto_delete)
                                          // ),
                                          Expanded(
                                            child: TextButton(
                                              child: Text(
                                                // '$index',
                                                '${namesDataList[index]
                                                    .toString()} ',
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style:
                                                TextStyle(fontFamily: fonttest==null?changeFont:fonttest,fontSize: 10),
                                              ),
                                              onPressed: () {
                                                print(
                                                    'indexpinNames->  $index');
//                                                   setState(() {
//
//                                                     names[index] =pinNames;
//                                                     // pinNameController.text;
// // /                                                    }
//                                                   });

                                                // _createAlertDialogForNameDeviceBox(
                                                //     context, index);

                                                // return addDeviceName(index);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4.5,
                                              // vertical: 10
                                            ),
                                            child: Switch(
                                              value:
                                              responseGetData[index] == 0
                                                  ? val2
                                                  : val1,
                                              //boolean value
                                              onChanged: (val) async {
                                                print('12365 ${responseGetData[index]}');
                                                setState(() {
                                                  if (responseGetData[index] == 0) {
                                                    responseGetData[index] =
                                                    1;
                                                  } else {
                                                    responseGetData[index] = 0;
                                                  }
                                                  print('yooooooooo ${responseGetData[index]}');
                                                });
                                                dataUpdate(dId);

                                              },
                                            ),
                                          ),
                                          // Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //       horizontal: 5.5,
                                          //       // vertical: 10
                                          //     ),
                                          //     child: ElevatedButton(
                                          //       onPressed: () {
                                          //         print("Message}");
                                          //         messageSms(context, dId);
                                          //       },
                                          //       child: Text('Click'),
                                          //     )),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      );
                    })),
              ),
              Flexible(
                child: Container(

                  height: MediaQuery
                      .of(context)
                      .size
                      .height *1.92,
                  // color: Colors.black,
                  // color: Colors.amber,
                  child: GridView.count(
                      crossAxisSpacing: 8,
                      childAspectRatio: 2 / 1.8,
                      mainAxisSpacing: 4,
                      physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      crossAxisCount: 2,
                      children:
                      List.generate(responseGetData.length - 9, (index) {
                        print('Slider Start');
                        print('catch return --> $catchReturn');
                        var newIndex = index + 10;
                        return Container(
                          // color: Colors.green,
                          height: 2030,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    alignment: new FractionalOffset(1.0, 0.0),
                                    // alignment: Alignment.bottomRight,
                                    height: 120,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 10),
                                    margin: index % 2 == 0
                                        ? EdgeInsets.fromLTRB(
                                        15, 7.5, 7.5, 7.5)
                                        : EdgeInsets.fromLTRB(
                                        7.5, 7.5, 15, 7.5),
                                    // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              blurRadius: 10,
                                              offset: Offset(8, 10),
                                              color: Colors.black)
                                        ],
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1,
                                            style: BorderStyle.solid,
                                            color: Color(0xffa3a3a3)),
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 109,
                                              child: Slider(
                                                // value: 5.0,
                                                value: double.parse(
                                                    responseGetData[
                                                    newIndex - 1]
                                                        .toString()),
                                                min: 0,
                                                max: 10,
                                                divisions: 500,
                                                activeColor: Colors.blue,
                                                inactiveColor: Colors.black,
                                                label: '${double.parse(
                                                    responseGetData[newIndex -
                                                        1].toString())}',
                                                onChanged:
                                                    (double newValue) async {
                                                  print(
                                                      'index of data $index --> ${responseGetData[newIndex -
                                                          1]}');
                                                  print(
                                                      'index of $index --> ${newIndex -
                                                          1}');

                                                  setState(() {
                                                    // if (responseGetData[newIndex-1] != null) {
                                                    //   responseGetData[newIndex-1] = widget.Slider_get.round();
                                                    // }

                                                    print("Round-->  ${newValue.round()}");
                                                    var roundVar = newValue.round();
                                                    print("Round 2-->  $roundVar");
                                                    responseGetData[newIndex - 1] = roundVar;
                                                    print("Response Round-->  ${responseGetData[newIndex - 1]}");
                                                  });
                                                  await dataUpdate(dId);

                                                },
                                                // semanticFormatterCallback: (double newValue) {
                                                //   return '${newValue.round()}';
                                                // }
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            child: Text(
                                              // index.toString(),
                                              '${namesDataList[index + 9]
                                                  .toString()} ',
                                              // '${namesDataList[index].toString()} ',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,fontSize: 10),
                                            ),
                                            onPressed: () {
                                              // _createAlertDialogForNameDeviceBox(
                                              //     context, index);

                                              // return addDeviceName(index);
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  deviceContainerWeb(String dId, int x) {
    deviceDataWeb(dId, x);
    // fetchIp(dId);
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 1.95,
          // color: Colors.redAccent,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Turn Off All Appliances',
                        style: TextStyle(
                          fontFamily: fonttest==null?changeFont:fonttest,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: _switchValue ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        child:  Container(
                          // color:textSelected==dId.toString()?Colors.green:Colors.red,
                          child: Icon(textSelected==dId.toString()?Icons.update:Icons.sensors),
                        ),

                        onTap: () async {
                          print('check123${textSelected}');
                          deviceSensorValWeb =   getSensorDataWeb(dId);
                          setState(() {
                            textSelected=dId.toString();
                            deviceSensorValWeb = getSensorDataWeb(dId);
                          });
                          print('check123${textSelected==dId}');
                          print('_hasBeenPressed ${textSelected}');
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8),
                    //   child: GestureDetector(
                    //     child: Icon(Icons.schedule),
                    //     onTap: () {
                    //       _createAlertDialogForPinSchedule(context,dId);
                    //       // _createAlertDialogForPin17(context, dId);
                    //     },
                    //   ),
                    // ),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                          color: statusOfDevice == 1 ? Colors.green : Colors.grey,
                          shape: BoxShape.circle),
                      // child: ...
                    ),
                    Switch(
                      value: switchOn,
                      //boolean value
                      onChanged: (val) async {
                        _showDialog(dId);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        child: Icon(Icons.settings_remote),
                        onTap: () {
                          // _createAlertDialogForPin19(context, dId);
                        },
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1.2,
                // color: Colors.amber,
                child: GridView.count(
                    crossAxisSpacing: 8,
                    childAspectRatio: 2 / 1.8,
                    mainAxisSpacing: 4,
                    physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    crossAxisCount: 4,
                    children: List.generate(
                        responseGetDataWeb.length - 3,
                            (index) {
                          print('Something');
                          print('catch return --> $index');

                          return Container(
                            // color: Colors.green,
                            height: 203,
                            child: Padding(
                              padding:  EdgeInsets.all(12.5),
                              child: Container(
                                  width: MediaQuery.of(context).size.width/75,
                                  alignment: new FractionalOffset(1.0, 0.0),
                                  // alignment: Alignment.bottomRight,
                                  height: MediaQuery.of(context).size.height/85,
                                  padding: EdgeInsets.all(12.0),
                                  // margin: index / 2 == 0
                                  //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                                  //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                                  // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height/80,
                                      right: MediaQuery.of(context).size.height/70,
                                      bottom: MediaQuery.of(context).size.height/70
                                  ),
                                  decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(8, 10),
                                            color: Colors.black)
                                      ],
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Color(0xffa3a3a3)),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    // crossAxisAlignment:
                                    // CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [

                                          Expanded(
                                            child: TextButton(
                                              child: Text(
                                                namesDataListWeb[index],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 10),
                                              ),

                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14.5,
                                                vertical: 10
                                            ),
                                            child: Switch(
                                              value: responseGetDataWeb[index] == 0
                                                  ? val2
                                                  : val1,
                                              // value: val1,
                                              onChanged: (val) async {
                                                if (responseGetDataWeb[index] == 0) {
                                                  setState(() {


                                                    responseGetDataWeb[index] = 1;                                              // print('index of $index --> ${listDynamic[index]}');
                                                  });
                                                  responseGetDataWeb[index] = 1;
                                                } else {
                                                  setState(() {


                                                    responseGetDataWeb[index] = 0;                                              // print('index of $index --> ${listDynamic[index]}');
                                                  });
                                                  responseGetDataWeb[index] = 0;
                                                }
                                                await dataUpdateWeb(dId);

                                              },
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 45,),
                                          // GestureDetector(
                                          //     onTap:(){
                                          //       // _createAlertDialogForlocalUpdateAndMessage(context,dId);
                                          //     },
                                          //     child: Icon(changeIcon[index]==null?null:changeIcon[index],size: 25,)),
                                        ],
                                      ),

                                    ],
                                  )),
                            ),
                          );
                        })),
              ),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height /70,
                  // color: Colors.black,
                  // color: Colors.amber,
                  child: GridView.count(
                      crossAxisSpacing: 8,
                      childAspectRatio: 2 / 1.8,
                      mainAxisSpacing: 4,
                      physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(
                        // 3,
                          responseGetDataWeb.length - 9,
                              (index) {
                            print('Slider Start');
                            print('catch return --> $catchReturn');
                            var newIndex = index + 10;
                            return Container(
                              // color: Colors.deepOrange,
                              // height: 2030,
                              child: Column(
                                children: [
                                  Container(
                                    // alignment: new FractionalOffset(1.0, 0.0),
                                      alignment: Alignment.bottomRight,
                                      height: 120,
                                      // padding: EdgeInsets.symmetric(
                                      //     horizontal: 1, vertical: 10),
                                      // margin: index % 2 == 0
                                      //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                                      //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                                      // margin: EdgeInsets.fromLTRB(95, 77.5, 7.5, 75),
                                      // margin: EdgeInsets.only(top: 41,right: 81,bottom: 70),
                                      decoration: BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                blurRadius: 10,
                                                offset: Offset(8, 10),
                                                color: Colors.black)
                                          ],
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Color(0xffa3a3a3)),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  child: Text(
                                                    namesDataListWeb[index+9],
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 109,
                                                child: Slider(
                                                  value: 5.0,
                                                  // value: double.parse(
                                                  //     responseGetData[newIndex - 1]
                                                  //         .toString()),
                                                  min: 0,
                                                  max: 10,
                                                  divisions: 500,
                                                  activeColor: Colors.blue,
                                                  inactiveColor: Colors.black,
                                                  label:
                                                  '${widget.Slider_get.round()}',
                                                  onChanged:
                                                      (double newValue) async {
                                                    print(
                                                        'index of data $index --> ${responseGetDataWeb[newIndex - 1]}');
                                                    print(
                                                        'index of $index --> ${newIndex - 1}');

                                                    setState(() {
                                                      // if (responseGetData[newIndex-1] != null) {
                                                      //   responseGetData[newIndex-1] = widget.Slider_get.round();
                                                      // }

                                                      print(
                                                          "Round-->  ${newValue.round()}");
                                                      var roundVar =
                                                      newValue.round();
                                                      print(
                                                          "Round 2-->  $roundVar");
                                                      responseGetDataWeb[
                                                      newIndex - 1] = roundVar;
                                                      print(
                                                          "Response Round-->  ${responseGetDataWeb[newIndex - 1]}");
                                                    });

                                                  },
                                                  // semanticFormatterCallback: (double newValue) {
                                                  //   return '${newValue.round()}';
                                                  // }
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            );
                          })),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
