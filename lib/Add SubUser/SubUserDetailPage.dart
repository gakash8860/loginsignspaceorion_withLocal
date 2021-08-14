import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';
import '../dropdown2.dart';
import '../main.dart';

class SubUserDetails extends StatefulWidget {
  final subUserPlaceId;
  final subUserEmail;
  final subUserName;

  const SubUserDetails(
      {Key key, this.subUserPlaceId, this.subUserEmail, this.subUserName})
      : super(key: key);

  @override
  _SubUserDetailsState createState() => _SubUserDetailsState();
}

class _SubUserDetailsState extends State<SubUserDetails> {
  var placeName;
  Timer timer;

  Box subUserDetailsBox;

  List singleSubUserDecodeList = [];

  String assignSubUserPlaceId;

  @override
  void initState() {
    super.initState();
    getSinglePlaceName();
    getSingleSubUsers();
    // timer= Timer.periodic(Duration(milliseconds: 1), (timer) { getSinglePlaceName();});
  }

  Future getSinglePlaceName() async {
    String token = await getToken();
    final url = 'http://genorionofficial.herokuapp.com/getyouplacename/?p_id=' +
        widget.subUserPlaceId.toString();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('getSinglePlaceName${response.statusCode}');
      print('getSinglePlaceName${response.body}');
      var placeDecode = jsonDecode(response.body);
      setState(() {
        placeName = placeDecode;
      });
      print('placeName${placeName}');
    }
  }

  Future placeVal;

  Future<List<PlaceType>> getplaces() async {
    String token = await getToken();
    print('token123 $token');
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = 'http://genorionofficial.herokuapp.com/getallplaces/';

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



  Future openSingleSubUserDetailsBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    subUserDetailsBox = await Hive.openBox('subUser');
    print('subUserBox  ${subUserDetailsBox.values.toString()}');
    return;
  }

  Future putSingleSubUser(data) async {
    await subUserDetailsBox.clear();
    for (var d in data) {
      subUserDetailsBox.add(d);
    }
  }

  Future<bool> getSingleSubUsers() async {
    await openSingleSubUserDetailsBox();
    print('placeName11 ${widget.subUserPlaceId}');
    String token = await getToken();
    final url =
        'http://genorionofficial.herokuapp.com/subuserpalceaccess/?email=' +
            widget.subUserEmail.toString();
    var response;
    try {
      response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      var subUserDecode = jsonDecode(response.body);
      setState(() {
        singleSubUserDecodeList = subUserDecode;
      });
      print('singleSubUserDecodeList ${singleSubUserDecodeList}');
      print('Number1123->  ${singleSubUserDecodeList[0]['p_id']}');

      await putSingleSubUser(singleSubUserDecodeList);
    } catch (e) {
      // print('Status Exception $e');

    }

    var myMap = subUserDetailsBox.toMap().values.toList();
    if (myMap.isEmpty) {
      subUserDetailsBox.add('empty');
    } else {
      singleSubUserDecodeList = myMap;
    }
    return Future.value(true);
  }

  Future _assignPlace() async {
    String token = await getToken();
    final url = 'http://genorionofficial.herokuapp.com/subuserpalceaccess/';
    var postData = {
      "user": getUidVariable,
      "email": widget.subUserEmail.toString(),
      "p_id": assignSubUserPlaceId,
      "name": widget.subUserName
    };
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(postData));
    if (response.statusCode > 0) {
      if (response.statusCode == 201) {
        final snackBar = SnackBar(
          content: Text('Place Assigned'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSubUser()));
      }

      print('assignPlace ${response.statusCode}');
      print('assignPlace ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SubUser Details'),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              placeVal = getplaces();
            },
            child: Text('Add Place'),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getSingleSubUsers,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.lightBlueAccent])),
            child: Container(
              // color: Colors.green,
              // height: 789,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                  future: getSingleSubUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (singleSubUserDecodeList.contains('empty')) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 250,
                            ),
                            Center(
                                child: Text(
                              'Sorry we cannot find any sub User please add',
                              style: TextStyle(fontSize: 18),
                            )),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: singleSubUserDecodeList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          semanticContainer: true,
                                          shadowColor: Colors.grey,
                                          child: ListTile(
                                            title: Text(
                                                singleSubUserDecodeList[index]
                                                    ['name']),
                                            trailing: Text(placeName),
                                          ),
                                        ),
                                      );


                                    }),),
                            Flexible(
                              child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FutureBuilder<List<PlaceType>>(
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
                                                                  offset: Offset(20,20)
                                                              )],
                                                              border: Border.all(
                                                                color: Colors.black,
                                                                width: 0.5,
                                                              )
                                                          ),
                                                          child: DropdownButtonFormField<PlaceType>(
                                                            decoration:InputDecoration(
                                                              contentPadding: const EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.white),
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),enabledBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.black),
                                                              borderRadius: BorderRadius.circular(50),
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
                                                            items: snapshot.data.map((selectedPlace) {
                                                              return DropdownMenuItem<PlaceType>(
                                                                value: selectedPlace,
                                                                child: Text(selectedPlace.pType),
                                                              );
                                                            }).toList(),
                                                            onChanged: ( selectedPlace) {
                                                              assignSubUserPlaceId=selectedPlace.pId;
                                                              print('selectedPlace ${assignSubUserPlaceId}');
                                                              setState(() {
                                                                // fl = null;
                                                                // pt = selectedPlace;
                                                                // floorVal =
                                                                //     getfloors(selectedPlace.pId);
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
                                                              color: Colors.white, width: 1),
                                                          borderRadius:
                                                          BorderRadius.circular(50)),
                                                      onPressed: () async {
                                                        _assignPlace();

                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );

                                            } else {
                                              SizedBox(height: 45,);
                                              return Center(child: Text('Add User'));
                                            }
                                          }
                                      ),
                                    );


                                  }),),
                          ],
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          semanticsLabel: 'Loading...',
                        ),
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
