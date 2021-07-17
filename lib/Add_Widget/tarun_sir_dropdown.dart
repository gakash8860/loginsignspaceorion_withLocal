// import 'dart:async';
// import 'dart:convert';
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:loginsignspaceorion/models/modeldefine.dart';
// import 'dart:io';
// import '../home.dart';
//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
//
// void main() => runApp(MaterialApp(
//       home: DropDown(),
//     ));
//
// class DropDown extends StatefulWidget {
//   @override
//   _DropDownState createState() => _DropDownState();
// }
//
// class _DropDownState extends State<DropDown> {
//   //ScrollController _scrollController;
//   Timer timer;
//   Future placeVal;
//   // List _place = ["Home", "Hotel", "Office", "Others", "Add"];
//   Future floorVal;
//   // List _placef = ["Ground Floor", "1st Floor", "2nd Floor", "3rd Floor"];
//   final storage = new FlutterSecureStorage();
//   PlaceType pt;
//   FloorType fl;
//   List<RoomType> rm;
//   List<Device> dv;
//
//   Future<String> getToken() async {
//     final token = await storage.read(key: "token");
//     return token;
//   }
//
//   // ignore: missing_return
//   Future<List<Device>> getDevices(String pId, String fId) async {
//     final url = 'https://genorion.herokuapp.com/device/';
//     String token = await getToken();
//     final response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Token $token',
//     });
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       List<Device> devices = data
//           .map((data) => Device.fromJson(data))
//           .toList()
//           .where((element) => ((element.r_id.f_id.f_id == fId) &&
//               (element.r_id.f_id.p_id.p_id == pId)))
//           .toList();
//       // print(devices);
//       return devices;
//     }
//     // else(response.statusCode == 401){
//     //   throw "Not Authorised";
//     // }
//   }
//
//   // ignore: missing_return
//   Future<List<place_type>> getplaces() async {
//     final url = 'https://genorion.herokuapp.com/place/';
//     String token = await getToken();
//     final response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Token $token',
//     });
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       List<place_type> places =
//           data.map((data) => place_type.fromJson(data)).toList();
//       // print(places);
//       // floorVal = getfloors(places[0].p_id);
//
//       return places;
//     }
//   }
//   // Future<Device> _switchchange() async{
//   //   var url='https://gemorion1.herokuapp.com/devicePinStatus/';
//   //   String token=await getToken();
//   //   final response = await http.get(url, headers: {
//   //     'Content-Type': 'application/json',
//   //     'Accept': 'application/json',
//   //     'Authorization': 'Token $token',
//   //   });
//   //   if(response.statusCode==200){
//   //       List<dynamic> data=jsonDecode(response.body);
//   //       List<Device> device=data.map((data)=>)
//   //   }
//   // }
//   // ignore: missing_return
//   Future<List<Floor>> getfloors(String pId) async {
//     var query = {'p_id': pId};
//     final url = Uri.https('genorion.herokuapp.com', '/floor/', query);
//     String token = await getToken();
//     final response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Token $token',
//     });
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       List<Floor> floors = data.map((data) => Floor.fromJson(data)).toList();
//       print(floors);
//       return floors;
//     }
//   }
//
//   // ignore: missing_return
//   Future<List<Room>> getrooms(String fId) async {
//     var query = {'f_id': fId};
//     final url = Uri.https('genorion.herokuapp.com', '/room/', query);
//     String token = await getToken();
//     final response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Token $token',
//     });
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       List<Room> rooms = data.map((data) => Room.fromJson(data)).toList();
//       print(rooms);
//       return rooms;
//     }
//   }
//
//   _showDialog(tittle, text) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(tittle),
//           content: Text(text),
//           actions: <Widget>[
//             // ignore: deprecated_member_use
//             FlatButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok'))
//           ],
//         );
//       },
//     );
//   }
//
//   _checkInternetConnectivity() async {
//     var result = await Connectivity().checkConnectivity();
//     if (result == ConnectivityResult.none) {
//       return _showDialog("No Internet", "Check Your Internet");
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     placeVal = getplaces();
//
//     //  timer = Timer.periodic(Duration(seconds: 5), (timer) {
//     //   _checkInternetConnectivity();
//     // });
//     // floorVal = getfloors(placeVal[0].p_id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: WillPopScope(
//         child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             appBar: AppBar(
//               title: Text('GenOrion'),
//               automaticallyImplyLeading: false,
//               elevation: 0,
//             ),
//             body: Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomCenter,
//                         colors: [Colors.blue, Colors.blueGrey,Colors.blueAccent])),
//                 child: Center(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       SizedBox(
//                         height: 30,
//                       ),
//                       FutureBuilder<List<place_type>>(
//                           future: placeVal,
//                           builder: (context,
//                               AsyncSnapshot<List<place_type>> snapshot) {
//                             if (snapshot.hasData) {
//                              // print(snapshot.hasData);
//                               // setState(() {
//                               //   floorVal = getfloors(snapshot.data[0].p_id);
//                               // });
//                               if (snapshot.data.length == 0) {
//                                 return Center(
//                                     child: Text("No Devices on this place"));
//                               }
//                               return Container(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(41.0),
//                                   child: SizedBox(
//                                     width: double.infinity,
//                                     height: 50.0,
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width*2,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         boxShadow: [BoxShadow(
//                                           color: Colors.black,
//                                           blurRadius: 30,
//                                           offset: Offset(20,20)
//                                         )],
//                                         border: Border.all(
//                                           color: Colors.black,
//                                           width: 0.5,
//                                         )
//                                       ),
//                                       child: DropdownButtonFormField<place_type>(
//                                         decoration:InputDecoration(
//                                           contentPadding: const EdgeInsets.all(15),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.white),
//                                             borderRadius: BorderRadius.circular(10),
//                                           ),enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(color: Colors.black),
//                                           borderRadius: BorderRadius.circular(50),
//                                         ),
//                                         ),
//                                         dropdownColor: Colors.white70,
//                                         icon: Icon(Icons.arrow_drop_down),
//                                         iconSize: 28,
//                                         hint: Text('Select Place'),
//                                         isExpanded: true,
//                                         value: pt,
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         items: snapshot.data.map((selectedPlace) {
//                                           return DropdownMenuItem<place_type>(
//                                             value: selectedPlace,
//                                             child: Text(selectedPlace.p_type),
//                                           );
//                                         }).toList(),
//                                         onChanged: (place_type selectedPlace) {
//                                           setState(() {
//                                             fl = null;
//                                             pt = selectedPlace;
//                                             floorVal =
//                                                 getfloors(selectedPlace.p_id);
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 margin: new EdgeInsets.symmetric(
//                                     vertical: 10, horizontal: 10),
//                               );
//                             } else {
//                               return CircularProgressIndicator();
//                             }
//                           }
//                           ),
//                       FutureBuilder<List<Floor>>(
//                           future: floorVal,
//                           builder:
//                               (context, AsyncSnapshot<List<Floor>> snapshot) {
//                             if (snapshot.hasData) {
//                               if (snapshot.data.length == 0) {
//                                 return Center(
//                                     child: Text("No Devices on this place"));
//                               }
//                               return Column(
//                                 children: [
//                                   Container(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(41.0),
//                                       child: SizedBox(
//                                         width: double.infinity,
//                                         height: 50.0,
//                                         child: Container(
//                                           width: MediaQuery.of(context).size.width*2,
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               boxShadow: [BoxShadow(
//                                                   color: Colors.black,
//                                                   blurRadius: 30,
//                                                   // offset for Upward Effect
//                                                   offset: Offset(20,20)
//                                               )],
//                                               border: Border.all(
//                                                 color: Colors.black,
//                                                 width: 0.5,
//                                               )
//                                           ),
//                                           child: DropdownButtonFormField<Floor>(
//                                             decoration:InputDecoration(
//                                               contentPadding: const EdgeInsets.all(15),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(color: Colors.white),
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(color: Colors.white),
//                                               borderRadius: BorderRadius.circular(50),
//                                             ),
//                                             ),
//                                             dropdownColor: Colors.white70,
//                                             icon: Icon(Icons.arrow_drop_down),
//                                             iconSize: 28,
//                                             hint: Text('Select Floor'),
//                                             isExpanded: true,
//                                             value: fl,
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                             items: snapshot.data
//                                                 .map((selectedFloor) {
//                                               return DropdownMenuItem<Floor>(
//                                                 value: selectedFloor,
//                                                 child: Text(selectedFloor.f_name),
//                                               );
//                                             }).toList(),
//                                             onChanged: (FloorType selectedFloor) {
//                                               setState(() {
//                                                 fl = selectedFloor;
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     margin: new EdgeInsets.symmetric(
//                                         vertical: 10, horizontal: 10),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.all(8),
//                                     // ignore: deprecated_member_use
//                                     child: FlatButton(
//                                       child: Text(
//                                         'Next',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       padding: EdgeInsets.all(12),
//                                       shape: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Colors.white, width: 1),
//                                           borderRadius:
//                                               BorderRadius.circular(50)),
//                                       onPressed: () async {
//                                         await CircularProgressIndicator();
//                                         rm = await getrooms(fl.f_id);
//                                         dv = await getDevices(pt.p_id, fl.f_id);
//
//                                         //print(pt.p_type);
//                                         // print(rm[1]);
//                                         //  print(rm[0].r_name);
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (
//                                             context,
//                                           ) =>
//                                                   Container(
//                                                     child: HomePage(
//                                                         pt: pt,
//                                                         fl: fl,
//                                                         rm: rm,
//                                                         dv: dv),
//                                                   )),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             } else {
//                               return Center(
//                                   child: Text(
//                                       "Please select a place to proceed further"));
//                             }
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//         onWillPop: () => showDialog<bool>(
//           context: context,
//           builder: (c) => poppages(c),
//         ),
//       ),
//     );
//   }
// }
//
// poppages(c) {
//   // Future.delayed(Duration.zero, () {Navigator.pushAndRemoveUntil(c, ModalRoute.of(c), (Route<dynamic> route) => false);});
//   return AlertDialog(
//     title: Text('Warning'),
//     content: Text('Do you want to exit'),
//     actions: [
//       // ignore: deprecated_member_use
//       FlatButton(
//         child: Text('Yes'),
//         onPressed: () => exit(0),
//       ),
//       // ignore: deprecated_member_use
//       FlatButton(
//         child: Text('No'),
//         onPressed: () => Navigator.pop(c, false),
//       ),
//     ],
//   );
// }