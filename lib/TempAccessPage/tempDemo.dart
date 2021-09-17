import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';

import '../ProfilePage.dart';
import '../changeFont.dart';

class TempDemo extends StatefulWidget {
  const TempDemo({Key key}) : super(key: key);

  @override
  _TempDemoState createState() => _TempDemoState();
}

class _TempDemoState extends State<TempDemo> {
  var deviceSensorVal;

  TabController tabC;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
            child: Row(
              children: [
                Text('Assigned by Ankit ',style: TextStyle(fontSize: 14),),
                SizedBox(width:151),
                Text('Home',),
              ],
            )

        ),
      ),
      body: Container(
        width: double.maxFinite,
        child: DefaultTabController(
          length: 3,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.41,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
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
                        left: 28,
                        right: 30,
                      ),
                      // alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onLongPress: () {
                                          // _editFloorNameAlertDialog(context);
                                        },
                                        child: GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 351.0),
                                            child: Row(
                                              children: [
                                                Text('Floor - ',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight
                                                        .bold,
                                                    // fontStyle: FontStyle.italic
                                                  ),),
                                                Text(
                                                  // fl.fName.toString(),
                                                  // getFloorData[0]['f_name'].toString(),
                                                  'Floor 1 ',
                                                  // + widget.fl.user.first_name,
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize: 22,
                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                    // fontWeight: FontWeight.bold,
                                                    // fontStyle: FontStyle
                                                    //     .italic
                                                  ),
                                                ),
                                                Icon(Icons.arrow_drop_down),
                                                SizedBox(width: 10,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          // _createAlertDialogDropDown(
                                          //     context);
                                        },
                                      ),
                                      // SizedBox(width: 10,),
                                      // // GestureDetector(
                                      // //   child: Icon(Icons.add),
                                      // //   onTap: () async {
                                      // //
                                      // //     // _createAlertDialogForFloor(context);
                                      // //   },
                                      // // )
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 12,
                                  // ),

                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onLongPress: () {

                                        },
                                        child: Row(
                                          children: [

                                            Text('Flat - ', style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontWeight: FontWeight
                                                    .bold,

                                                fontFamily: fonttest==null?changeFont:fonttest,
                                                fontSize: 22),),

                                            Text(
                                              // flat.fltName.toString(),
                                              // getFlatData[0]['flt_name'].toString(),
                                              'Flat 1 ',
                                              // + widget.fl.user.first_name,
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontFamily: fonttest==null?changeFont:fonttest,
                                                  // fontWeight: FontWeight.bold,
                                                  // fontStyle: FontStyle
                                                  //     .italic,
                                                  fontSize: 22),
                                            ),
                                            Icon(Icons
                                                .arrow_drop_down),
                                            SizedBox(width: 250,),
                                            Row(
                                              children: [
                                                SizedBox(width: 28,),
                                                Container(
                                                  // color:Colors.red,
                                                  child: CircularProfileAvatar(
                                                    '',
                                                    child: setImage == null
                                                        ? Image.asset('assets/images/genLogo.png')
                                                        : setImage,
                                                    radius: 47.5,
                                                    // elevation: 5,
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProfilePage()));
                                                      //     .then((value) =>
                                                      // loadImageFromPreferences()
                                                      //     ? _deleteImage()
                                                      //     : loadImageFromPreferences());
                                                    },
                                                    cacheImage: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          // _createAlertDialogDropDown(
                                          //     context);
                                        },
                                      ),
                                      SizedBox(width: 35),
                                      // GestureDetector(
                                      //     onTap: () async {
                                      //
                                      //     },
                                      //     child: Icon(Icons.add)),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FutureBuilder(
                            future: deviceSensorVal,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.center,
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
                                                child: Text('2.65',
                                                    // sensorData[index]['sensor1'].toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
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
                                            FontAwesomeIcons.temperatureLow,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Text('45.36',
                                                    // sensorData[index][
                                                    // 'sensor2']
                                                    //     .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
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
                                                child: Text('41.25',
                                                    // sensorData[index]['sensor3'].toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
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
                                                child: Text('45.2',
                                                    // sensorData[index]['sensor4'].toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
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
                                            FontAwesomeIcons.idBadge,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                child: Text('DIDM********A****C',
                                                    // sensorData[index]['sensor4'].toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Column(
              //     children: <Widget>[
              //       Container(
              //         height: MediaQuery
              //             .of(context)
              //             .size
              //             .height * 0.41,
              //         width: MediaQuery
              //             .of(context)
              //             .size
              //             .width,
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //               begin: Alignment.topCenter,
              //               end: Alignment.bottomCenter,
              //               colors: [
              //                 Color(0xff669df4),
              //                 Color(0xff4e80f3)
              //               ]),
              //           borderRadius: BorderRadius.only(
              //               bottomLeft: Radius.circular(30),
              //               bottomRight: Radius.circular(30)),
              //         ),
              //         padding: EdgeInsets.only(
              //           top: 40,
              //           bottom: 10,
              //           left: 28,
              //           right: 30,
              //         ),
              //         // alignment: Alignment.topLeft,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Row(
              //               mainAxisAlignment:
              //               MainAxisAlignment.spaceBetween,
              //               children: <Widget>[
              //
              //                 Column(
              //                   children: <Widget>[
              //                     Row(
              //                       children: [
              //                         GestureDetector(
              //                           onLongPress: () {
              //                             // _editFloorNameAlertDialog(context);
              //                           },
              //                           child: GestureDetector(
              //                             child: Row(
              //                               children: [
              //                                 Text('Floor - ',
              //                                   style: TextStyle(
              //                                       color: Colors
              //                                           .white,
              //                                       fontFamily: fonttest==null?changeFont:fonttest,
              //                                       fontSize: 22,
              //                                       fontWeight: FontWeight
              //                                           .bold,
              //                                       // fontStyle: FontStyle
              //                                       //     .italic
              //                                   ),),
              //                                 Text(
              //                                   // fl.fName.toString(),
              //                                   // getFloorData[0]['f_name'].toString(),
              //                                   'Floor 3 ',
              //                                   // + widget.fl.user.first_name,
              //                                   style: TextStyle(
              //                                       color: Colors
              //                                           .white,
              //                                       fontSize: 22,
              //                                       fontFamily: fonttest==null?changeFont:fonttest,
              //                                       // fontWeight: FontWeight.bold,
              //                                       // fontStyle: FontStyle
              //                                       //     .italic
              //                                   ),
              //                                 ),
              //                                 Icon(Icons
              //                                     .arrow_drop_down),
              //                                 SizedBox(width: 10,),
              //                               ],
              //                             ),
              //                           ),
              //                           onTap: () {
              //                             _createAlertDialogDropDown(
              //                                 context);
              //                           },
              //                         ),
              //                         SizedBox(width: 10,),
              //                         // GestureDetector(
              //                         //   child: Icon(Icons.add),
              //                         //   onTap: () async {
              //                         //
              //                         //     // _createAlertDialogForFloor(context);
              //                         //   },
              //                         // )
              //                       ],
              //                     ),
              //                     SizedBox(
              //                       height: 12,
              //                     ),
              //
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment
              //                           .start,
              //                       children: <Widget>[
              //                         Row(
              //                           children: <Widget>[
              //                             GestureDetector(
              //                               onLongPress: () {
              //
              //                               },
              //                               child: Row(
              //                                 children: [
              //                                   Text('Flat - ',
              //                                     style: TextStyle(
              //                                         color: Colors
              //                                             .white,
              //                                         fontWeight: FontWeight
              //                                             .bold,
              //                                         fontFamily: fonttest==null?changeFont:fonttest,
              //                                         fontSize: 22),),
              //                                   Text(
              //                                     // flat.fltName.toString(),
              //                                     // getFlatData[0]['flt_name'].toString(),
              //                                     'Flat 2 ',
              //                                     // + widget.fl.user.first_name,
              //                                     style: TextStyle(
              //                                         color: Colors
              //                                             .white,
              //                                         fontFamily: fonttest==null?changeFont:fonttest,
              //                                         // fontWeight: FontWeight.bold,
              //                                         // fontStyle: FontStyle
              //                                         //     .italic,
              //                                         fontSize: 22),
              //                                   ),
              //                                   Icon(Icons
              //                                       .arrow_drop_down),
              //                                   SizedBox(width: 10,),
              //                                 ],
              //                               ),
              //                               onTap: () {
              //                                 _createAlertDialogDropDown(
              //                                     context);
              //                               },
              //                             ),
              //                             SizedBox(width: 35),
              //                             // GestureDetector(
              //                             //     onTap: () async {
              //                             //
              //                             //     },
              //                             //     child: Icon(Icons.add)),
              //                           ],
              //                         )
              //
              //                       ],
              //                     ),
              //
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             SizedBox(
              //               height: 45,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 FutureBuilder(
              //                   future: deviceSensorVal,
              //                   builder: (context, snapshot) {
              //                     if (!snapshot.hasData) {
              //                       return Column(
              //                         crossAxisAlignment: CrossAxisAlignment.center,
              //                         // mainAxisAlignment: MainAxisAlignment.center,
              //                         children: <Widget>[
              //                           Row(
              //                             children: <Widget>[
              //                               SizedBox(
              //                                 width: 8,
              //                               ),
              //                               Column(children: <Widget>[
              //                                 Icon(
              //                                   FontAwesomeIcons.fire,
              //                                   color: Colors.yellow,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 32,
              //                                 ),
              //                                 Row(
              //                                   children: <Widget>[
              //                                     Container(
              //                                       child: Text(' 14.1',
              //                                           // sensorData[index]['sensor1'].toString(),
              //                                           style: TextStyle(
              //                                               fontSize: 14,
              //                                               color: Colors
              //                                                   .white70)),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ]),
              //                               SizedBox(
              //                                 width: 35,
              //                               ),
              //                               Column(children: <Widget>[
              //                                 Icon(
              //                                   FontAwesomeIcons.temperatureLow,
              //                                   color: Colors.orange,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 30,
              //                                 ),
              //                                 Row(
              //                                   children: <Widget>[
              //                                     Container(
              //                                       child: Text('43.1',
              //                                           // sensorData[index][
              //                                           // 'sensor2']
              //                                           //     .toString(),
              //                                           style: TextStyle(
              //                                               fontSize: 14,
              //                                               color: Colors
              //                                                   .white70)),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ]),
              //                               SizedBox(
              //                                 width: 45,
              //                               ),
              //                               Column(children: <Widget>[
              //                                 Icon(
              //                                   FontAwesomeIcons.wind,
              //                                   color: Colors.white,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 30,
              //                                 ),
              //                                 Row(
              //                                   children: <Widget>[
              //                                     Container(
              //                                       child: Text('45.6',
              //                                           // sensorData[index]['sensor3'].toString(),
              //                                           style: TextStyle(
              //                                               fontSize: 14,
              //                                               color: Colors
              //                                                   .white70)),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ]),
              //                               SizedBox(
              //                                 width: 42,
              //                               ),
              //                               Column(children: <Widget>[
              //                                 Icon(
              //                                   FontAwesomeIcons.cloud,
              //                                   color: Colors.orange,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 30,
              //                                 ),
              //                                 Row(
              //                                   children: <Widget>[
              //                                     Container(
              //                                       child: Text('41.3',
              //                                           // sensorData[index]['sensor4'].toString(),
              //                                           style: TextStyle(
              //                                               fontSize: 14,
              //                                               color: Colors
              //                                                   .white70)),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ]),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: 22,
              //                           ),
              //                         ],
              //                       );
              //                     } else {
              //                       return Center(
              //                         child: Text('Loading...'),
              //                       );
              //                     }
              //                   },
              //                 ),
              //               ],
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
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
                              padding:
                              const EdgeInsets.only(right: 10, bottom: 2),
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
                                tabs: [
                                  Text('Room 1',),
                                  Text('Room 2',),
                                  Text('Room 3',),
                                ],
                                // tabs: rm.map<Widget>((RoomType rm) {
                                //   rIdForName = rm.rId;
                                //   print('RoomId  $rIdForName');
                                //   print('RoomId  ${rm.rName}');
                                //   return Tab(
                                //     text: rm.rName,
                                //   );
                                // }).toList(),
                                onTap: (index) async {

                                  // getDevices(tabbarState);
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
                  return deviceContainer2();
                  // if (index < dv.length) {
                  //   Text(
                  //     "Loading",
                  //     style: TextStyle(fontSize: 44),
                  //   );
                  //
                  //   return Container(
                  //     child: Column(
                  //       children: [
                  //         deviceContainer2(),
                  //         // Container(
                  //         //     //
                  //         //     // color: Colors.green,
                  //         //     height: 35,
                  //         //     child: GestureDetector(
                  //         //       child: RichText(
                  //         //         text: TextSpan(children: [
                  //         //           TextSpan(
                  //         //               text: dv[index].dId,
                  //         //               style: TextStyle(
                  //         //                   fontSize: 15, color: Colors.black)),
                  //         //           TextSpan(text: "   "),
                  //         //           WidgetSpan(
                  //         //               child: Icon(
                  //         //             Icons.settings,
                  //         //             size: 18,
                  //         //           ))
                  //         //         ]),
                  //         //       ),
                  //         //       onTap: () {
                  //         //         // _createAlertDialogForSSIDAndEmergencyNumber(
                  //         //         //     context);
                  //         //         print('on tap');
                  //         //       },
                  //         //     )),
                  //       ],
                  //     ),
                  //     // child: Text(dv[index].dId),
                  //   );
                  // } else {
                  //   return null;
                  // }
                }),
              )

              // SliverList(
              //   delegate: SliverChildBuilderDelegate((context,
              //       index) {
              //     print('asdfirst ${dv.length}');
              //     if (index < dv.length) {
              //       dv.length == null ? Text('loading') : dv.length ==
              //           null;
              //       print('asdf ${dv.length}');
              //       Text(
              //         "Loading",
              //         style: TextStyle(fontSize: 44),
              //       );
              //
              //       return Container(
              //         child: Column(
              //           children: [
              //             subUserDeviceContainer(
              //                 dv[index].dId, index),
              //             Container(
              //               //
              //               // color: Colors.green,
              //                 height: 35,
              //                 child: GestureDetector(
              //                   child: RichText(
              //                     text: TextSpan(children: [
              //                       TextSpan(
              //                         // text:'aa',
              //                         // text:deviceSubUser[index]['d_id'],
              //                           text: dv[index].dId,
              //                           style: TextStyle(
              //                               fontFamily: fonttest==null?changeFont:fonttest,
              //                               fontSize: 15,
              //                               color: Colors.black)),
              //                       TextSpan(text: "   "),
              //                       WidgetSpan(
              //                           child: Icon(
              //                             Icons.settings,
              //                             size: 18,
              //                           ))
              //                     ]),
              //                   ),
              //                   onTap: () {
              //                     // _createAlertDialogForSSIDAndEmergencyNumber(
              //                     //     context);
              //                     print('on tap');
              //                   },
              //                 )),
              //           ],
              //         ),
              //       );
              //     } else {
              //       return null;
              //     }
              //   }),
              // )
            ],
          ),
        ),
      ),
    );
  }
  deviceContainer2() {
    // deviceContainer(dId);
    // fetchIp(dId);
    return Container(
      height: MediaQuery.of(context).size.height * 4.8,
      // color: Colors.redAccent,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1.2,
            // color: Colors.amber,
            child: GridView.count(
                crossAxisSpacing: 8,
                childAspectRatio: 2 / 1.8,
                mainAxisSpacing: 4,
                physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(
                    9,
                    // responseGetData.length - 3,
                        (index) {
                      print('Something');
                      print('catch return --> $index');

                      return Container(
                        // color: Colors.green,
                        height: 203,
                        child: Padding(
                          padding: const EdgeInsets.all(58.0),
                          child: Container(
                            // alignment: new FractionalOffset(1.0, 0.0),
                            // alignment: Alignment.bottomRight,
                              height: 20,
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 74, vertical: 10),
                              // margin: index / 2 == 0
                              //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                              //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                              // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                              margin: EdgeInsets.only(top: 41,right: 41,bottom: 30),
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
                                            '$index ',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          onPressed: () {
                                            // _createAlertDialogForNameDeviceBox(context,index);
                                            // print('index->  ${names[index]}');
                                            // setState(() {
                                            //   if (names[index] != null) {
                                            //     names[index] =
                                            //         deviceNameEditing.text;
                                            //   }
                                            // });
                                            // _createAlertDialogForNameDeviceBox(
                                            //     context);
                                            //
                                            // addDeviceName(index);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.5,
                                            vertical: 10
                                        ),
                                        child: Switch(
                                          // value: responseGetData[index] == 0
                                          //     ? val2
                                          //     : val1,
                                          value: true,
                                          onChanged: (val) async {
                                            // setState(() {
                                            //   if (responseGetData[index] ==
                                            //       0) {
                                            //     responseGetData[index] = 1;
                                            //   } else {
                                            //     responseGetData[index] = 0;
                                            //   }
                                            //
                                            //   // print('index of $index --> ${listDynamic[index]}');
                                            // });

                                            // if Internet is not available then _checkInternetConnectivity = true
                                            // var result = await Connectivity()
                                            //     .checkConnectivity();
                                            // if (result ==
                                            //     ConnectivityResult.wifi) {
                                            //   print("True2-->   $result");
                                            //   // await localUpdate(dId);
                                            //   await dataUpdate(dId);
                                            // } else if (result ==
                                            //     ConnectivityResult.mobile) {
                                            //   print("mobile-->   $result");
                                            //   // await localUpdate(d_id);
                                            //   await dataUpdate(dId);
                                            // } else {
                                            //   // messageSms(context, dId);
                                            // }
                                          },
                                        ),
                                      ),

                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     SizedBox(width: 45,),
                                  //     GestureDetector(
                                  //         onTap:(){
                                  //           // _createAlertDialogForlocalUpdateAndMessage(context,dId);
                                  //         },
                                  //         child: Icon(changeIcon[index]==null?null:changeIcon[index])),
                                  //   ],
                                  // )
                                ],
                              )),
                        ),
                      );
                    })),
          ),
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height - 45,
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
                      3,
                      // responseGetData.length - 9,
                          (index) {
                        print('Slider Start');
                        // print('catch return --> $catchReturn');
                        var newIndex = index + 10;
                        return Container(
                          // color: Colors.deepOrange,
                          // height: 2030,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Container(
                                  // alignment: new FractionalOffset(1.0, 0.0),
                                    alignment: Alignment.bottomRight,
                                    height: 120,
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal: 1, vertical: 10),
                                    // margin: index % 2 == 0
                                    //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                                    //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                                    // margin: EdgeInsets.fromLTRB(95, 77.5, 7.5, 75),
                                    margin: EdgeInsets.only(top: 41,right: 81,bottom: 70),
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
                                                  '$index ',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                                onPressed: () {
                                                  // print(
                                                  //     'index->  ${names[index]}');
                                                  // setState(() {
                                                  //   if (names[index] != null) {
                                                  //     names[index] =
                                                  //         deviceNameEditing.text;
                                                  //   }
                                                  // });
                                                  // _createAlertDialogForNameDeviceBox(
                                                  //     context);
                                                  //
                                                  // return addDeviceName(index);
                                                },
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
                                                label:'2.4',
                                                // '${widget.Slider_get.round()}',
                                                onChanged:
                                                    (double newValue) async {
                                                  // print('index of data $index --> ${responseGetData[newIndex - 1]}');
                                                  print(
                                                      'index of $index --> ${newIndex - 1}');

                                                  // setState(() {
                                                  //   // if (responseGetData[newIndex-1] != null) {
                                                  //   //   responseGetData[newIndex-1] = widget.Slider_get.round();
                                                  //   // }
                                                  //
                                                  //   print(
                                                  //       "Round-->  ${newValue.round()}");
                                                  //   var roundVar =
                                                  //   newValue.round();
                                                  //   print(
                                                  //       "Round 2-->  $roundVar");
                                                  //   responseGetData[
                                                  //   newIndex - 1] = roundVar;
                                                  //   print(
                                                  //       "Response Round-->  ${responseGetData[newIndex - 1]}");
                                                  // });

                                                  // if Internet is not available then _checkInternetConnectivity = true
                                                  var result =
                                                  await Connectivity()
                                                      .checkConnectivity();
                                                  if (result ==
                                                      ConnectivityResult.wifi) {
                                                    print("True2-->   $result");
                                                    // await localUpdate(dId);
                                                    // await dataUpdate(dId);
                                                  } else if (result ==
                                                      ConnectivityResult.mobile) {
                                                    print("mobile-->   $result");
                                                    // await localUpdate(d_id);
                                                    // await dataUpdate(dId);
                                                  } else {
                                                    // messageSms(context, dId);
                                                  }
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
                              ),
                            ],
                          ),
                        );
                      })),
            ),
          ),
        ],
      ),
    );
  }
}
