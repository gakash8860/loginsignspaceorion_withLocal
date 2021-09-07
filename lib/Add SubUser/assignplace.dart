import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/Add%20SubUser/showSubUser.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:http/http.dart'as http;
import '../dropdown2.dart';
import '../main.dart';
void main()=>runApp(MaterialApp(
  home:AssignPlace()
));
class AssignPlace extends StatefulWidget {
  var name;
  var email;
  AssignPlace({Key key,
   this.name,
  this.email,
   }) : super(key: key);

  @override
  _AssignPlaceState createState() => _AssignPlaceState();
}

class _AssignPlaceState extends State<AssignPlace> {
  var assignSubUserPlaceId;
  Future placeValForMobile;
  Future placeVal;
  List<Map<String, dynamic>> placeRows;

  @override
  void initState(){
    super.initState();
    placeValForMobile=returnPlaceQuery();
  }

  Future returnPlaceQuery() async {
    placeVal = await placeQueryFunc();
    return NewDbProvider.instance.queryPlace();
  }

  Future placeQueryFunc() async {
    placeRows = await NewDbProvider.instance.queryPlace();
    print('qwe123 $placeRows');
  }
  Future _assignPlace() async {
    String token = await getToken();
    final url = API + 'subuserpalceaccess/';
    var postData = {
      "user": getUidVariable,
      "email": widget.email,
      "p_id": assignSubUserPlaceId,
      "name": widget.name
    };
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',},
        body: jsonEncode(postData));
    if (response.statusCode > 0) {
      if (response.statusCode == 201) {
        final snackBar = SnackBar(
          content: Text('Place Assigned'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowSubUser()));
      }

      print('assignPlace ${response.statusCode}');
      print('assignPlace ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Place'),
      ),
      body: Center(

        child:   Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.lightBlueAccent])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 140,),
              FutureBuilder(
                  future: placeValForMobile,
                  builder: (context,
                      AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // print(snapshot.hasData);
                      // setState(() {
                      //   floorVal = getfloors(snapshot.data[0].p_id);
                      // });
                      if (snapshot.data.length == 0) {
                        return Center(
                            child: Text(
                                "No Devices on this place"));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 30,
                                      offset: Offset(20, 20))
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                )),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              dropdownColor: Colors.white70,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 28,
                              hint: Text('Select Place'),
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),

                              items: placeRows.map((selectedPlace) {
                                return DropdownMenuItem(
                                  value: selectedPlace.toString(),
                                  child: Text("${selectedPlace['p_type']}"),
                                );
                              }).toList(),
                              onChanged: (selectedPlace) async {

                                var placeId = selectedPlace.substring(7, 14);
                                var placeName = selectedPlace.substring(24, 31);
                                print('checkPlaceName ${placeName.toString()}');
                                assignSubUserPlaceId = placeId.toString();
                                // pt=as.map((data) => PlaceType.fromJson(data)).toList();
                                print("SElectedPlace ${selectedPlace}");


                                // qwe= ;
                              },
                              // items:snapshot.data
                            ),
                          ),
                          SizedBox(
                            height: 80,
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
            ],
          ),
        ),
      ),
    );
  }
}
