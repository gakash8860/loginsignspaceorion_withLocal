import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginsignspaceorion/dropdown2.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({Key key}) : super(key: key);

  @override
  _DesktopHomeState createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  Future deviceSensorVal;

  TabController tabC ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color:Colors.yellow,
      // color: change_toDark ? Colors.black : Colors.white,
      child: DefaultTabController(
        length: 3,
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
                      // padding: EdgeInsets.only(
                      //   top: 40,
                      //   bottom: 10,
                      //   left: 30,
                      //   right: 30,
                      // ),
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
                                      // widget.fl.fName,

                                      'Hello Floor ',
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
                                      // widget.flat.fltName,
                                      'Hello Flat ',
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
                                future: deviceSensorVal,
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
                                                    child: Text(
                                                      'sensor 1',
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
                                                        'sensor 1',
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
                                                    child: Text(
                                                        'sensor 1',
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
                                                    child: Text(
                                                        'sensor 1',
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
                                  Tab(icon: Icon(Icons.directions_car)),
                                  Tab(icon: Icon(Icons.directions_transit)),
                                  Tab(icon: Icon(Icons.directions_bike)),
                                ],
                                // tabs:
                                // widget.rm.map<Widget>((RoomType rm) {
                                //   rIdForName = rm.rId;
                                //   print('RoomId  $rIdForName');
                                //   print('RoomId  ${rm.rName}');
                                //   return Tab(
                                //     text: rm.rName,
                                //   );
                                // }).toList(),
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
                            )
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
                  if (index < dv.length) {
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
                                  // _createAlertDialogForSSIDAndEmergencyNumber(context);
                                  print('on tap');
                                },
                              )),
                        ],
                      ),
                      // child: Text(dv[index].dId),
                    );
                  } else {
                    return  const TabBarView(
                      children: [
                        Icon(Icons.directions_car),
                        Icon(Icons.directions_transit),
                        Icon(Icons.directions_bike),
                      ],
                    );
                  }
                }),
              )
            ]),
      ),
    );
  }
}
// CustomScrollView(
// // key: key,
//
// // controller: _scrollController,
// slivers: <Widget>[
// //Upper Widget
// SliverToBoxAdapter(
// child: Column(
// children: <Widget>[
// Container(
// height: MediaQuery.of(context).size.height * 0.35,
// width: MediaQuery.of(context).size.width,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.topCenter,
// end: Alignment.bottomCenter,
// colors: [
// Color(0xff669df4),
// Color(0xff4e80f3)
// ]),
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(30),
// bottomRight: Radius.circular(30)),
// ),
// padding: EdgeInsets.only(
// top: 40,
// bottom: 10,
// left: 30,
// right: 30,
// ),
// alignment: Alignment.topLeft,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Column(
// children: <Widget>[
// GestureDetector(
// onLongPress: () {
// // _editFloorNameAlertDialog(context);
// },
// child: Text(
// // widget.fl.fName,
// 'Hello ',
// // + widget.fl.user.first_name,
// style: TextStyle(
// color: Colors.white,
// fontSize: 22,
// fontWeight: FontWeight.bold,
// fontStyle: FontStyle.italic),
// ),
// onTap: () {
// // _createAlertDialogDropDown(context);
// },
// ),
// SizedBox(
// height: 12,
// ),
// GestureDetector(
// onLongPress: () {
// // _editFloorNameAlertDialog(context);
// },
// child: Text(
// // widget.flat.fltName,
// 'Hello ',
// // + widget.fl.user.first_name,
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 22),
// ),
// onTap: () {
// // _createAlertDialogDropDown(context);
// },
// ),
// ],
// ),
// ],
// ),
// SizedBox(
// height: 45,
// ),
// Row(
// // mainAxisAlignment: MainAxisAlignment.start,
// children: <Widget>[
// FutureBuilder(
// future: deviceSensorVal,
// builder: (context, snapshot) {
// if (!snapshot.hasData) {
// return Column(
// children: <Widget>[
// Row(
// children: <Widget>[
// SizedBox(
// width: 8,
// ),
// Column(children: <Widget>[
// Icon(FontAwesomeIcons.fire,
// color: Colors.yellow,
// ),
// SizedBox(
// height: 32,
// ),
// Row(
// children: <Widget>[
// Container(
// child: Text(
// 'a',
// style: TextStyle(
// fontSize: 14,
// color: Colors
//     .white70)),
// ),
// ],
// ),
// ]),
// SizedBox(
// width: 35,
// ),
// Column(children: <Widget>[
// Icon(
// FontAwesomeIcons
//     .temperatureLow,
// color: Colors.orange,
// ),
// SizedBox(
// height: 30,
// ),
// Row(
// children: <Widget>[
// Container(
// child: Text(
// 'a',
// style: TextStyle(
// fontSize: 14,
// color: Colors
//     .white70)),
// ),
// ],
// ),
// ]),
// SizedBox(
// width: 45,
// ),
// Column(children: <Widget>[
// Icon(
// FontAwesomeIcons.wind,
// color: Colors.white,
// ),
// SizedBox(
// height: 30,
// ),
// Row(
// children: <Widget>[
// Container(
// child: Text(
// 'a',
// style: TextStyle(
// fontSize: 14,
// color: Colors
//     .white70)),
// ),
// ],
// ),
// ]),
// SizedBox(
// width: 42,
// ),
// Column(children: <Widget>[
// Icon(
// FontAwesomeIcons.cloud,
// color: Colors.orange,
// ),
// SizedBox(
// height: 30,
// ),
// Row(
// children: <Widget>[
// Container(
// child: Text(
// 'a',
// style: TextStyle(
// fontSize: 14,
// color: Colors
//     .white70)),
// ),
// ],
// ),
// ]),
// ],
// ),
// SizedBox(
// height: 22,
// ),
// ],
// );
// } else {
// return Center(
// child: Text('Loading...'),
// );
// }
// },
// ),
// ],
// )
// ],
// ),
// )
// ],
// ),
// ),
//
// //Room Tabs
// SliverAppBar(
// automaticallyImplyLeading: false,
// // centerTitle: true,
// floating: true,
// pinned: true,
// backgroundColor: Colors.white,
//
// title: Container(
// alignment: Alignment.bottomLeft,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SingleChildScrollView(
// scrollDirection: Axis.horizontal,
// child: Row(
// children: [
//
// Padding(
// padding: const EdgeInsets.only(
// right: 10, bottom: 2),
// child: GestureDetector(
// // color: Colors.black,
// child: Icon(
// Icons.add,
// color: Colors.black,
// ),
// onTap: () {
// // _createAlertDialogForAddRoom(context);
// },
// ),
// )
// ],
// ),
// ),
//
// // SizedBox(height: 45,),
// ],
// ),
// ),
// ),
//
//
// ]),