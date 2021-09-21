import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/dropDown.dart';
import 'package:loginsignspaceorion/widget/circularprogress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SQLITE_database/testinghome2.dart';
import 'changeFont.dart';
import 'main.dart';

import 'dropdown2.dart';

// var placeResponse;
var floorResponse;
// var flatResponse;
//
// var roomResponse;
// var deviceResponse;

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
  bool isVisible = false;
  var futureRoom;
  TextEditingController editingController = new TextEditingController();
  TextEditingController editingControllerWeb = new TextEditingController();
  TextEditingController floorEditingController = new TextEditingController();
  TextEditingController floorEditingControllerWeb = new TextEditingController();
  TextEditingController flatEditingController = new TextEditingController();
  TextEditingController flatEditingControllerWeb = new TextEditingController();
  TextEditingController roomEditingController = new TextEditingController();
  TextEditingController roomEditingControllerWeb = new TextEditingController();
  TextEditingController deviceEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getToken();
    getUid();
    print(getUidVariable);
    // roomResponse=send_RoomName(roomEditingController.text);
  }
  var tokenWeb;
  getTokenWeb()async{
    final pref= await SharedPreferences.getInstance();
    tokenWeb=pref.getString('tokenWeb');
    print('token $tokenWeb');
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
  getUidWeb() async{
    final url=await API+'getuid/';
    final response =
    await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $tokenWeb',
        });
    if(response.statusCode==200){
      getUidVariable=response.body;
      getUidVariable2=int.parse(getUidVariable);

      print('GetUi Variable Integer-->   ${getUidVariable2}');
    }else{
      print(response.statusCode);
    }
  }



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
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.lightBlueAccent])),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  if (viewportConstraints.maxWidth > 600) {
                    return Center(
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 75,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                width: 300,
                                child: TextFormField(
                                  autofocus: true,
                                  controller: editingControllerWeb,
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
                                  controller: floorEditingControllerWeb,
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
                                  controller: flatEditingControllerWeb,
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
                                  controller: roomEditingControllerWeb,
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
                                //
                                await getTokenWeb();
                                await getUidWeb();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Indicator(
                                              placeName: editingControllerWeb.text,
                                              floorName:
                                                  floorEditingControllerWeb.text,
                                              flatName:
                                                  flatEditingControllerWeb.text,
                                              roomName:
                                                  roomEditingControllerWeb.text,
                                            )));
                                // pt = await placeName(editingController.text);
                                // print('After Await  $placeResponse');
                                // fl = await sendFloorName(floorEditingController.text);
                                // flat = await sendFlatName(flatEditingController.text);
                                // room = [await sendRoomName(roomEditingController.text)];
                                //
                                // setState(() {
                                //   rm = room;
                                //   //
                                //   tabbarState = roomResponse;
                                //   // dv=[deviceResponse] ;
                                //   // isVisible = true;
                                // });
                                //
                                // print('On Press tabbar --> $tabbarState');
                                // Navigator.of(context).pushNamed(HomeTest.routeName);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'GenOrion',
                          style: TextStyle(
                              fontFamily:
                                  fonttest == null ? 'RobotoMono' : fonttest),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DropDown()));
                              },
                              child: Text(
                                'Your places',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily:
                                      fonttest == null ? changeFont : fonttest,
                                ),
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
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontFamily: fonttest == null
                                            ? 'RobotoMono'
                                            : fonttest),
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
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontFamily: fonttest == null
                                            ? 'RobotoMono'
                                            : fonttest),
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
                                        fontFamily: fonttest == null
                                            ? 'RobotoMono'
                                            : fonttest,
                                        fontSize: 18,
                                        color: Colors.black54),
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
                                        fontFamily: fonttest == null
                                            ? 'RobotoMono'
                                            : fonttest,
                                        fontSize: 18,
                                        color: Colors.black54),
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
                                SizedBox(height: 15),
                                ElevatedButton(
                                  child: Text('Submit'),
                                  onPressed: () async {
                                    //
                                    // pt = await placeName(editingController.text);
                                    // print('After Await  $placeResponse');
                                    // fl = await sendFloorName(floorEditingController.text);
                                    //
                                    // flat = await sendFlatName(flatEditingController.text);
                                    // rm = [await sendRoomName(roomEditingController.text)];
                                    //
                                    // setState(() {
                                    //   isVisible=true;
                                    //   // tabbarState=rm[0].rId;
                                    //   tabbarState = roomResponse;
                                    //   // dv=[deviceResponse] ;
                                    //
                                    // });

                                    print('On Press tabbar --> $tabbarState');

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Indicator(
                                                  placeName:
                                                      editingController.text,
                                                  floorName:
                                                      floorEditingController
                                                          .text,
                                                  flatName:
                                                      flatEditingController
                                                          .text,
                                                  roomName:
                                                      roomEditingController
                                                          .text,
                                                )));
                                    // isVisible=false;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    // var result =   Connectivity().checkConnectivity();
                    // if (result ==ConnectivityResult.none||result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
                    //   return Scaffold(
                    //     appBar: AppBar(
                    //       title: Text('GenOrion',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest),),
                    //       actions: [
                    //         TextButton(
                    //             onPressed: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) =>
                    //                           DropDown()));
                    //               // Navigator.push(
                    //               //     context,
                    //               //     MaterialPageRoute(
                    //               //         builder: (context) =>
                    //               //             super.widget)));
                    //
                    //             },
                    //             child: Text(
                    //               'Your places',
                    //               style: TextStyle(color: Colors.black,fontFamily: fonttest==null?changeFont:fonttest,),
                    //             ))
                    //       ],
                    //     ),
                    //     body: Container(
                    //       decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //               begin: Alignment.topCenter,
                    //               end: Alignment.bottomCenter,
                    //               colors: [Colors.blue, Colors.lightBlueAccent])),
                    //       width: double.maxFinite,
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 30,
                    //       ),
                    //       child: ConstrainedBox(
                    //         constraints: BoxConstraints(
                    //           minHeight: viewportConstraints.maxHeight,
                    //         ),
                    //         child: ClipPath(
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: <Widget>[
                    //               SizedBox(
                    //                 height: 35,
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(12.0),
                    //                 child: TextFormField(
                    //                   autofocus: true,
                    //                   controller: editingController,
                    //                   textInputAction: TextInputAction.next,
                    //                   autovalidateMode:
                    //                   AutovalidateMode.onUserInteraction,
                    //                   style: TextStyle(
                    //                       fontSize: 18, color: Colors.black54,fontFamily: fonttest==null?'RobotoMono':fonttest),
                    //                   decoration: InputDecoration(
                    //                     prefixIcon: Icon(Icons.place),
                    //                     filled: true,
                    //                     fillColor: Colors.white,
                    //                     hintText: 'Enter Place Name',
                    //                     contentPadding:
                    //                     const EdgeInsets.all(15),
                    //                     focusedBorder: OutlineInputBorder(
                    //                       borderSide:
                    //                       BorderSide(color: Colors.white),
                    //                       borderRadius:
                    //                       BorderRadius.circular(50),
                    //                     ),
                    //                     enabledBorder: UnderlineInputBorder(
                    //                       borderSide:
                    //                       BorderSide(color: Colors.white),
                    //                       borderRadius:
                    //                       BorderRadius.circular(50),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(height: 15),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(12.0),
                    //                 child: TextFormField(
                    //                   autofocus: true,
                    //                   controller: floorEditingController,
                    //                   textInputAction: TextInputAction.next,
                    //                   autovalidateMode:
                    //                   AutovalidateMode.onUserInteraction,
                    //                   style: TextStyle(
                    //                       fontSize: 18, color: Colors.black54,fontFamily: fonttest==null?'RobotoMono':fonttest),
                    //                   decoration: InputDecoration(
                    //                     prefixIcon: Icon(Icons.place),
                    //                     filled: true,
                    //                     fillColor: Colors.white,
                    //                     hintText: 'Enter Floor Name',
                    //                     contentPadding:
                    //                     const EdgeInsets.all(15),
                    //                     focusedBorder: OutlineInputBorder(
                    //                       borderSide:
                    //                       BorderSide(color: Colors.white),
                    //                       borderRadius:
                    //                       BorderRadius.circular(50),
                    //                     ),
                    //                     enabledBorder: UnderlineInputBorder(
                    //                       borderSide:
                    //                       BorderSide(color: Colors.white),
                    //                       borderRadius:
                    //                       BorderRadius.circular(50),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(height: 15),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(12.0),
                    //                 child: TextFormField(
                    //                   autofocus: true,
                    //                   controller: flatEditingController,
                    //                   textInputAction: TextInputAction.next,
                    //                   autovalidateMode:
                    //                   AutovalidateMode.onUserInteraction,
                    //                   style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,
                    //                       fontSize: 18, color: Colors.black54),
                    //                   decoration: InputDecoration(
                    //                     prefixIcon: Icon(Icons.place),
                    //                     filled: true,
                    //                     fillColor: Colors.white,
                    //                     hintText: 'Enter Flat Name',
                    //                     contentPadding:
                    //                     const EdgeInsets.all(15),
                    //                     focusedBorder: OutlineInputBorder(
                    //                       borderSide:
                    //                       BorderSide(color: Colors.white),
                    //                       borderRadius:
                    //                       BorderRadius.circular(50),
                    //                     ),
                    //                     enabledBorder: UnderlineInputBorder(
                    //                       borderSide:
                    //                       BorderSide(color: Colors.white),
                    //                       borderRadius:
                    //                       BorderRadius.circular(50),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(height: 15),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(12.0),
                    //                 child: TextFormField(
                    //                   controller: roomEditingController,
                    //                   autofocus: true,
                    //                   textInputAction: TextInputAction.next,
                    //                   autovalidateMode:
                    //                   AutovalidateMode.onUserInteraction,
                    //                   style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,
                    //                       fontSize: 18, color: Colors.black54),
                    //                   decoration: InputDecoration(
                    //                     prefixIcon: Icon(Icons.place),
                    //                     filled: true,
                    //                     fillColor: Colors.white,
                    //                     hintText: 'Enter Room Name',
                    //                     contentPadding:
                    //                     const EdgeInsets.all(15),
                    //                     focusedBorder: OutlineInputBorder(
                    //                       borderSide:
                    //                       BorderSide(color: Colors.white),
                    //                       borderRadius:
                    //                       BorderRadius.circular(50),
                    //                     ),
                    //                     enabledBorder: UnderlineInputBorder(
                    //                       borderSide:
                    //                       BorderSide(color: Colors.white),
                    //                       borderRadius:
                    //                       BorderRadius.circular(50),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(height: 15),
                    //               ElevatedButton(
                    //                 child: Text('Submit'),
                    //                 onPressed: () async {
                    //                   //
                    //                   // pt = await placeName(editingController.text);
                    //                   // print('After Await  $placeResponse');
                    //                   // fl = await sendFloorName(floorEditingController.text);
                    //                   //
                    //                   // flat = await sendFlatName(flatEditingController.text);
                    //                   // rm = [await sendRoomName(roomEditingController.text)];
                    //                   //
                    //                   // setState(() {
                    //                   //   isVisible=true;
                    //                   //   // tabbarState=rm[0].rId;
                    //                   //   tabbarState = roomResponse;
                    //                   //   // dv=[deviceResponse] ;
                    //                   //
                    //                   // });
                    //
                    //
                    //                   print('On Press tabbar --> $tabbarState');
                    //
                    //                   Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (context) => Indicator(
                    //                             placeName: editingController.text,
                    //                             floorName: floorEditingController.text,
                    //                             flatName: flatEditingController.text,
                    //                             roomName: roomEditingController.text,
                    //                           )));
                    //                   // isVisible=false;
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // }else{
                    //   return Center(child: CircularProgressIndicator(backgroundColor: Colors.red,));
                    // }

                  }
                }),
              ));
  }
}
