import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import 'package:loginsignspaceorion/home.dart';
import 'SQLITE_database/testingHome.dart';
import 'models/modeldefine.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dropdown2.dart';


var placeResponse;
var floorResponse;

var roomResponse;
var deviceResponse;

void main() => runApp(MaterialApp(
  home: DropDown1(),
));
String roomResponse2;
SharedPreferences placeResponsePreference;
SharedPreferences floorResponsePreference;
SharedPreferences roomResponsePreference;
class DropDown1 extends StatefulWidget {
  const DropDown1({Key key}) : super(key: key);
  @override
  _DropDown1State createState() => _DropDown1State();
}

class _DropDown1State extends State<DropDown1> {
  final storage = new FlutterSecureStorage();
  var floorval, ptfuture;
  bool isVisible=false;
  var futureRoom;
  List<RoomType> rm;
  List<Device> dv;
  FloorType fl;
  PlaceType pt;
  SharedPreferences roomPrefrences;
  bool visible = true;
  int pla_Variable = 1;

  TextEditingController editingController=new TextEditingController();
  TextEditingController floorEditingController=new TextEditingController();
  TextEditingController roomEditingController=new TextEditingController();
  TextEditingController deviceEditingController=new TextEditingController();


  var snackbar;
  bool _isInAsyncCall = false;





  @override
  void initState(){
    super.initState();
    roomResponse=send_RoomName(roomEditingController.text);
    getToken();
    getUid();
  }
  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }
  // ignore: missing_return
  Future <PlaceType> place_Name(String data) async {
    String token = await getToken();
    final url = 'http://genorionofficial.herokuapp.com/addyourplace/';
    var postData={
      "user":getUidVariable2 ,
      "p_type":data
    };
    final response = await http.post(url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode >0) {
      print(response.statusCode);
      print(response.body);

      placeResponse=jsonDecode(response.body);

      print(' Place Response--> $placeResponse');

      print(' Place--> $postData');
      setState(() {
        setPlaceValue();
      });
      // DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(postData));
      // placeResponsePreference.setInt('p_id', placeResponse);

      return PlaceType.fromJson(postData);
    } else {
      throw Exception('Failed to create Place.');
    }


  }


  Future<FloorType> send_FloorName(String data) async {
    String token = await getToken();
    final url = 'http://genorionofficial.herokuapp.com/addyourfloor/';
    var postData={
      "user":getUidVariable2  ,
      "p_id":placeResponse,
      "f_name":data
    };
    final response = await http.post(url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',

      },
      body: jsonEncode(postData),
    );

    if (response.statusCode >0) {
      print(response.statusCode);
      // print(response.body);
      floorResponse=jsonDecode(response.body);
      print(' Floor Response--> ${floorResponse}');
      print(' postData FLoor--> ${postData}');

      setState(() {
        setFloorValue();
      });

      return FloorType.fromJson(postData);
    } else {
      throw Exception('Failed to create Floor.');
    }

  }

  Future<RoomType> send_RoomName(String data) async {
    String token =await getToken();
    final url = 'http://genorionofficial.herokuapp.com/addroom/';
    var postData={
      "user":getUidVariable2  ,
      "r_name":data,
      "f_id":floorResponse,
    };
    final response = await http.post(url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',

      },
      body: jsonEncode(postData),
    );

    if (response.statusCode >0) {
      print(response.statusCode);
      print(response.body);
      roomResponse=jsonDecode(response.body);
      setState(() {
        tabbarState=roomResponse;
        setRoomValue();
        // // final  roomResponse2=roomResponse;
        //   // roomResponsePreference.setInt('r_id', roomResponse2);
      });
      print(' Room- Tabb-> ${tabbarState}');
      print(' Room- Response-> ${roomResponse}');


      return RoomType.fromJson(postData);
    } else {

      throw Exception('Failed to create Room.');
    }
  }


  Future<Device> send_DeviceId(String data) async {
    print(roomResponse2);
    // placeType.createState().roomResponse;
    String token =await getToken();
    final url = 'http://genorionofficial.herokuapp.com/addyourdevice/';
    var postData={
      "user":getUidVariable2,
      "r_id":roomResponse,
      "d_id":data
    };
    final response = await http.post(url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',

      },
      body: jsonEncode(postData),
    );

    if (response.statusCode >0) {
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
  getUid() async{
    final url=await 'http://genorionofficial.herokuapp.com/getuid/';
    String token = await getToken();
    final response =
    await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
    if(response.statusCode==200){
      getUidVariable=response.body ;
      getUidVariable2=int.parse(getUidVariable);
      print('GetUi Variable-->   ${getUidVariable}');
    }else{
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

  getsetPlaceValue()async{
    placeResponsePreference= await SharedPreferences.getInstance();
    String placeValue=placeResponsePreference.getString("placeValue");
    return placeValue;
  }
  setPlaceValue()async{
    placeResponsePreference = await SharedPreferences.getInstance();
    placeResponsePreference.setString("placeValue", placeResponse);
    print('Setting  $placeResponsePreference');
  }

  getFloorValue()async{
    floorResponsePreference= await SharedPreferences.getInstance();
    String floorValue=floorResponsePreference.getString("floorValue");
    return floorValue;
  }

  setFloorValue()async{
    floorResponsePreference= await SharedPreferences.getInstance();
    floorResponsePreference.setString("floorValue",floorResponse);
  }



  getRoomValue()async{
    roomResponsePreference= await SharedPreferences.getInstance();
    String floorValue=floorResponsePreference.getString("roomValue");
    return floorValue;
  }

  setRoomValue()async{
    floorResponsePreference= await SharedPreferences.getInstance();
    floorResponsePreference.setString("roomValue",floorResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('GenOrion'),
          actions: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DropDown2())).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>super.widget)));
            }, child: Text('Your places',style: TextStyle(
                color: Colors.black
            ),))
          ],

        ),
        body: isVisible?Container(color: Colors.blueAccent,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),),):ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          progressIndicator:CircularProgressIndicator() ,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.lightBlueAccent])),
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

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Place Name',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
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

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Floor Name',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Room Name',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
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

                    pt=  await place_Name(editingController.text);
                    print('After Await  ${placeResponse}');
                    fl = await send_FloorName(floorEditingController.text);
                    RoomType room= await send_RoomName(roomEditingController.text);
                    // await send_DeviceId(deviceEditingController.text);


                    // setValue();
                    // placeResponsePreference.setInt('pId', placeResponse);
                    // floorResponsePreference.setInt('fId', floorResponse);
                    // roomResponsePreference.setInt('rId', roomResponse2);




                    setState((){
                      // pt.pId =placeResponse;
                      // fl=floorResponse ;
                      rm = [room];
                      tabbarState=rm[0].rId;
                      tabbarState=roomResponse;
                      // dv=[deviceResponse] ;
                      isVisible=true;
                    });

                    print('On Press tabbar --> $tabbarState');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context)=>  HomePage(
                    //           // pt: pt,
                    //           fl: fl,
                    //           rm: rm,
                    //           dv: dv,
                    //         )));
                  },
                ),


              ],
            ),
          ),
        ));
  }
}

