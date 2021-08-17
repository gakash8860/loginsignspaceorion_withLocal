import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';

import 'package:http/http.dart' as http;

import '../Setting_Page.dart';

// void main() => runApp(MaterialApp(
//   home: SubAccessHome(),
// ));

class SubAccessHome extends StatefulWidget {
  var email;
  var pt;
  FloorType fl;
  Flat flat;
  List<RoomType> rm;
  List<Device> dv;
  SensorData sensorData;

  SubAccessHome({Key key, this.pt, this.email}) : super(key: key);

  @override
  _SubAccessHomeState createState() => _SubAccessHomeState();
}

class _SubAccessHomeState extends State<SubAccessHome> {
  TabController tabC;

  @override
  void initState() {
    super.initState();
    fetchSubUser();
  }

  Future<void> fetchSubUser() async {
    String token = 'ec21799a656ff17d2008d531d0be922963f54378';
    final url =
        'https://genorion1.herokuapp.com/getallplacesbyonlyplaceidp_id/?email=' +
            widget.email;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('SubUserResponse->  ${response.statusCode}');
      print('SubUserResponse->  ${response.body}');
      print(response.body);
      await getAllFloorForSubUser();
    }
// return PlaceType.fromJson(true);
  }

  var varFloorData;
  var fId;

  Future getAllFloorForSubUser() async {
    final url =
        'https://genorion1.herokuapp.com/getallfloorsbyonlyplaceidp_id/?p_id=' +
            widget.pt;
    String token = 'ec21799a656ff17d2008d531d0be922963f54378';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('floorSubUser ${response.statusCode}');

      if (response.statusCode == 200) {
        var varFloorData1 = jsonDecode(response.body);
        print('floorSubUser ${varFloorData}');
        setState(() {
          varFloorData = varFloorData1;
          fId = varFloorData[0]['f_id'];
        });

        await getAllFlatForSubUser();
      }
    }
  }

  var varFlatData;
  var flatId;

  Future getAllFlatForSubUser() async {
    final url =
        'https://genorion1.herokuapp.com/getallflatbyonlyflooridf_id/?f_id=' +
            fId;
    String token = 'ec21799a656ff17d2008d531d0be922963f54378';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('flatSubUser ${response.statusCode}');

      if (response.statusCode == 200) {
        varFlatData = jsonDecode(response.body);
        flatId = varFlatData[0]['flt_id'];
        print('flatSubUser ${varFlatData}');
        await getAllRoomForSubUser();
      }
    }
  }

  List <RoomType>roomTab;

  Future getAllRoomForSubUser() async {
    final url =
        'https://genorion1.herokuapp.com/getallroomsbyonlyflooridf_id/?flt_id=' +
            flatId;
    String token = 'ec21799a656ff17d2008d531d0be922963f54378';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('RoomSubUser ${response.statusCode}');
      print('RoomSubUser ${response.body}');

      if (response.statusCode == 200) {
        roomTab = jsonDecode(response.body);
        print('RoomSubUser ${response.body}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        if (viewportConstraints.maxWidth > 600) {
          return Container(
            color: Colors.red,
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("SubUser"),
            ),
            body: Container(
              width: double.maxFinite,
              color: change_toDark ? Colors.black : Colors.white,
              child: DefaultTabController(
                length: roomTab.length==null?1:roomTab.length,
                // length: widget.rm.length,
                child: CustomScrollView(
                    // key: key,

                    // controller: _scrollController,
                    slivers: <Widget>[
                      //Upper Widget
                      SliverToBoxAdapter(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.35,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            onLongPress: () {
                                              // _editFloorNameAlertDialog(context);
                                            },
                                            child: Text(
                                              varFloorData[0]['f_name']
                                                          .toString() ==
                                                      null
                                                  ? "Loading.."
                                                  : varFloorData[0]['f_name']
                                                      .toString(),

                                              // 'Hello ',
                                              // + widget.fl.user.first_name,
                                              style: TextStyle(
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
                                            onLongPress: () {
                                              // _editFloorNameAlertDialog(context);
                                            },
                                            child: Text(
                                              varFlatData[0]['flt_name']
                                                          .toString() ==
                                                      null
                                                  ? "Loading.."
                                                  : varFlatData[0]['flt_name']
                                                      .toString(),
                                              // widget.flat.fltName,
                                              // 'Hello ',
                                              // + widget.fl.user.first_name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            onTap: () {
                                              // _createAlertDialogDropDown(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      FutureBuilder(
                                        // future: deviceSensorVal,
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
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
                                                            child: Text('aa',
                                                                // sensorData[index]['sensor1'].toString(),
                                                                style: TextStyle(
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
                                                            child: Text('s',
                                                                // sensorData[index]['sensor2'].toString(),
                                                                style: TextStyle(
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
                                                            child: Text('s',
                                                                // sensorData[index]['sensor3'].toString(),
                                                                style: TextStyle(
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
                                                            child: Text('s',
                                                                // sensorData[index]['sensor4'].toString(),
                                                                style: TextStyle(
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, bottom: 2),
                                      child: GestureDetector(
                                        // color: Colors.black,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                        onTap: () {
                                          // _createAlertDialogForAddRoom(context);
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      onLongPress: () {
                                        print('longPress');
                                        // _editRoomNameAlertDialog(context);
                                      },

                                      child: TabBar(
                                        indicatorColor: Colors.blueAccent,
                                        controller: tabC,
                                        labelColor: Colors.blueAccent,
                                        indicatorWeight: 2.0,
                                        isScrollable: true,
                                        tabs: roomTab.map<Widget>((RoomType rm) {
                                          // rIdForName = rm.rId;
                                          // print('RoomId  $rIdForName');
                                          // print('RoomId  ${rm.rName}');
                                          return Tab(
                                            text: rm.rName,
                                          );
                                        }).toList(),
                                        onTap: (index) async {
                                          // print(
                                          //     'Roomsssss RID-->>>>>>>   ${widget.rm[index].rId}');
                                          // tabbarState = widget.rm[index].rId;
                                          // setState(() {
                                          //   tabbarState = widget.rm[index].rId;
                                          //   // devicePinNamesQueryFunc();
                                          // });
                                          // // getDevices(tabbarState);
                                          // print(
                                          //     "tabbarState Tabs->  $tabbarState");
                                          // widget.dv = await NewDbProvider.instance
                                          //     .getDeviceByRoomId(tabbarState);
                                          // getAllRoom();
                                          // // widget.rm =await roomQueryFunc();
                                          // print('getDevices123 }');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // SizedBox(height: 45,),
                            ],
                          ),
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (index < widget.dv.length) {
                            Text(
                              "Loading",
                              style: TextStyle(fontSize: 44),
                            );

                            return Container(
                              child: Column(
                                children: [
                                  // deviceContainer2(widget.dv[index].dId, index),
                                  Container(
                                      //
                                      // color: Colors.green,
                                      height: 35,
                                      child: GestureDetector(
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: widget.dv[index].dId,
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
                              // child: Text(dv[index].dId),
                            );
                          } else {
                            return null;
                          }
                        }),
                      )
                    ]),
              ),
            ),
          );
        }
      })),
    );
  }
}
