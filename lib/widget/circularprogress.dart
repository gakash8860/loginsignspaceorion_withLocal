import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/SQLITE_database/DesktopUi/HomeDesktopUi.dart';
import 'package:loginsignspaceorion/SQLITE_database/DesktopUi/destinationview.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dropdown2.dart';
import '../main.dart';

void main() =>
    runApp(MaterialApp(
      home: Indicator(),
    ));

class Indicator extends StatefulWidget {
  var placeName;
  var floorName;
  var flatName;
  var roomName;

  Indicator(
      {Key key, this.floorName, this.flatName, this.placeName, this.roomName})
      : super(key: key);

  @override
  _IndicatorState createState() => _IndicatorState();
}


class _IndicatorState extends State<Indicator> {
  var tokenWeb;


  @override
  void initState() {
    super.initState();
    getToken();
    getUid();


    checkWebOrNot();

    print(getUidVariable);
    // roomResponse=send_RoomName(roomEditingController.text);
  }


  getUid() async {
    final url = await API + 'getuid/';
    String token = await getToken();
    final response =
    await http.get(url,
        headers: {
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


  getTokenWeb() async {
    final pref = await SharedPreferences.getInstance();
    tokenWeb = pref.getString('tokenWeb');
  }

  Future<void> checkWebOrNot() async {
    await getTokenWeb();
    if (tokenWeb != null) {
      print('goingtoif');
      getUidWeb().then((value) => allAwaitWeb());
    } else {
      print('goingtoelse');
      await allAwait();
    }
  }

  Future<void> getUidWeb() async {
    final url = await API + 'getuid/';
    final response =
    await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $tokenWeb',
        });
    if (response.statusCode == 200) {
      getUidVariable = response.body;
      getUidVariable2 = int.parse(getUidVariable);

      print('GetUi Variable Integer-->   ${getUidVariable2}');
    } else {
      print(response.statusCode);
    }
  }


  var placeResponse;
  var floorResponse;
  var flatResponse;
  var roomResponse;

  Future<PlaceType> placeName() async {
    print(getUidVariable2);
    String token = await getToken();
    final url = API + 'addyourplace/';
    var postData = {
      "user": getUidVariable2,
      "p_type": widget.placeName.toString()
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
      print(response.body);

      placeResponse = jsonDecode(response.body);

      print(' Place Response--> $placeResponse');

      print(' Place--> $postData');
      setState(() {
        // isVisible = true;
        // setPlaceValue();
      });
      return PlaceType.fromJson(postData);
    } else {
      throw Exception('Failed to create Place.');
    }
  }


  Future<PlaceType> placeNameWeb() async {
    print(getUidVariable2);
    await getTokenWeb();
    final url = API + 'addyourplace/';
    var postData = {
      "user": getUidVariable2,
      "p_type": widget.placeName.toString()
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
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
        // isVisible = true;
        // setPlaceValue();
      });
      return PlaceType.fromJson(postData);
    } else {
      throw Exception('Failed to create Place.');
    }
  }

  Future<FloorType> sendFloorName() async {
    String token = await getToken();
    final url = API + 'addyourfloor/';
    var postData = {
      "user": getUidVariable2,
      "p_id": placeResponse,
      "f_name": widget.floorName.toString()
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


  Future<FloorType> sendFloorNameWeb() async {
    await getTokenWeb();
    final url = API + 'addyourfloor/';
    var postData = {
      "user": getUidVariable2,
      "p_id": placeResponse,
      "f_name": widget.floorName.toString()
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
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


  Future<Flat> sendFlatName() async {
    String token = await getToken();
    final url = API + 'addyourflat/';
    var postData = {
      "user": getUidVariable2,
      "f_id": floorResponse,
      "flt_name": widget.flatName.toString()
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


  Future<Flat> sendFlatNameWeb() async {
    await getTokenWeb();
    final url = API + 'addyourflat/';
    var postData = {
      "user": getUidVariable2,
      "f_id": floorResponse,
      "flt_name": widget.flatName.toString()
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
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

  Future<RoomType> sendRoomName() async {
    String token = await getToken();
    final url = API + 'addroom/';
    var postData = {
      "user": getUidVariable2,
      "r_name": widget.roomName.toString(),
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
      });
      print(' Room- Tabb-> $tabbarState');
      print(' Room- Response-> $roomResponse');

      // isVisible=false;

      return RoomType.fromJson(postData);
    } else {
      throw Exception('Failed to create Room.');
    }
  }
  var roomResponseWeb;
  Future<RoomType> sendRoomNameWeb() async {
    await getTokenWeb();
    final url = API + 'addroom/';
    var postData = {
      "user": getUidVariable2,
      "r_name": widget.roomName.toString(),
      "flt_id": flatResponse,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      print('response.body  ${response.body}');
      roomResponseWeb = jsonDecode(response.body);
      setState(() {
         roomResponse;
        // setRoomValue();
        // // final  roomResponse2=roomResponse;
        //   // roomResponsePreference.setInt('r_id', roomResponse2);
      });

      print(' Room- Response-> $roomResponseWeb');
      // isVisible=false;

      return RoomType.fromJson(postData);
    } else {
      throw Exception('Failed to create Room.');
    }
  }

  allAwait() async {
    pt = await placeName();
    print('After Await placeResponse $placeResponse');
    fl = await sendFloorName();
    print('After Await floorResponse $floorResponse');
    flat = await sendFlatName();
    print('After Await flatResponse $flatResponse');
    rm = [await sendRoomName()];

    print('After Await roomResponse  $roomResponse');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeTest(
                  tabbarState:roomResponse ,
                  pt: pt,
                  fl: fl,
                  flat: flat,
                  rm: rm,
                  dv: dv,

                )));
  }

  allAwaitWeb() async {
    PlaceType pt = await placeNameWeb();
    print('After Await  $placeResponse');
    FloorType fl = await sendFloorNameWeb();
    Flat flat = await sendFlatNameWeb();
    List<RoomType> rm = [await sendRoomNameWeb()];

    Navigator.push(

        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeTest(
                  tabbarState: roomResponseWeb,
                  pt: pt,
                  fl: fl,
                  flat: flat,
                  rm: rm,
                )));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(

                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.lightBlueAccent])),
            child: Center(
                child: CircularProgressIndicator(backgroundColor: Colors.red,)))
    );
  }
}
