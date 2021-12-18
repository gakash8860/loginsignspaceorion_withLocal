// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/Add%20SubUser/showSubUser.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../changeFont.dart';
import '../dropdown2.dart';
import '../main.dart';
import 'assignplace.dart';


void main() =>
    runApp(const MaterialApp(
      home: AddSubUser(),
    ));

class AddSubUser extends StatefulWidget {
  const AddSubUser({Key key}) : super(key: key);



  @override
  _AddSubUserState createState() => _AddSubUserState();
}

class _AddSubUserState extends State<AddSubUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var assignSubUserPlaceId;
  Future placeVal;
  Future placeValForMobile;
  Future placeValWeb;

  @override
void initState(){
  super.initState();
  placeVal=getplaces();
  placeValWeb=getplacesWeb();

}
  var tokenWeb;
  Future getTokenWeb()async{
    final pref= await SharedPreferences.getInstance();
    tokenWeb=pref.getString('tokenWeb');
    return tokenWeb;
  }

  Future addSubUser(String data) async {
    String token = await getToken();
    final url = API + 'subuseraccess/';
    var postData = {
      "emailtest": data,
      "email": data
    };
    final response = await http.post(url,
        body: jsonEncode(postData)
        , headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode > 0) {
      print('error ${response.statusCode}');
      if (response.statusCode == 201) {
        const snackBar =  SnackBar(
          content: Text('SubUser Added'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignPlace(
            email: emailController.text,
            name:nameController.text
        )));
        // placeValForMobile=returnPlaceQuery();
      } else {
        _showDialog(context);
      }

    }
  }


  Future addSubUserWeb(String data) async {
    String token = await getTokenWeb();
    final url = API + 'subuseraccess/';
    var postData = {
      "emailtest": data,
      "email": data
    };
    final response = await http.post(url,
        body: jsonEncode(postData)
        , headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode > 0) {
      print('error ${response.statusCode}');
      print('errorASD ${response.body}');
      if (response.statusCode == 201) {
        final snackBar = const SnackBar(
          content: Text('SubUser Added'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() {
              changeWidget=true;
            });
        // placeValForMobile=returnPlaceQuery();
      } else {
        _showDialog(context);
      }
      print('AddSubUserCode  ${response.statusCode}');
    }
  }


  Future returnPlaceQuery() async {
    placeVal = await placeQueryFunc();
    return NewDbProvider.instance.queryPlace();
  }

  Future placeQueryFunc() async {
    placeRows = await NewDbProvider.instance.queryPlace();
    print('qwe123 $placeRows');
  }

  Future<List<PlaceType>> getplaces() async {
    String token = await getToken();
    print('token123 $token');
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = API + 'getallplaces/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    // if (response.statusCode > 0) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
      data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    // }
  }

  Future<List<PlaceType>> getplacesWeb() async {
    await getTokenWeb();
    final url = API + 'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode ==200) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
      data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }else{
      return null;
    }
  }


  Future _assignPlace() async {
    String token = await getToken();
    final url = API + 'subuserpalceaccess/';
    var postData = {
      "user": getUidVariable,
      "email": emailController.text,
      "p_id": assignSubUserPlaceId,
      "name": nameController.text
    };
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',},
        body: jsonEncode(postData));
    if (response.statusCode > 0) {
      if (response.statusCode == 201) {
        final snackBar = const SnackBar(
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
  Future _assignPlaceWeb() async {
     await getTokenWeb();
    final url = API + 'subuserpalceaccess/';
    var postData = {
      "user": getUidVariable,
      "email": emailController.text,
      "p_id": assignSubUserPlaceId,
      "name": nameController.text
    };
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',},
        body: jsonEncode(postData));
    if (response.statusCode > 0) {
      if (response.statusCode == 201) {
        final snackBar = const SnackBar(
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

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text("Alert"),
            content: const Text("SubUser Already Added, You can direct assign place"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(child: const Text("No"), onPressed: () {
                Navigator.of(context).pop();
              }),

            ],
          ),
    );
  }
  List<Map<String, dynamic>> placeRows;
  bool changeWidget=false;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          if (viewportConstraints.maxWidth > 600) {
            return changeWidget==true? dropDown(context):Scaffold(
              appBar: AppBar(
                title: Center(child: Text('Add SubUser',style: TextStyle(fontFamily: fonttest ?? 'RobotoMono',),)),
              ),
              body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.lightBlueAccent])),
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    // color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: ClipPath(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[

                            Container(
                              width: 300,
                              child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                // validator: nameValid,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                style:
                                const TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(

                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter Email for SubUser',
                                  contentPadding: const EdgeInsets.all(15),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40,),
                            Container(
                              width: 300,
                              child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                // validator: nameValid,
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                style:
                                const TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(

                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter Name for SubUser',
                                  contentPadding: const EdgeInsets.all(15),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40,),
                            // ignore: deprecated_member_use
                            FlatButton(
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                shape: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                padding: const EdgeInsets.all(15),
                                textColor: Colors.white,
                                onPressed: () async {
                                  await addSubUserWeb(emailController.text);

                                  // Navigator.of(context).pop();


                                  // await floorVal;
                                  // goToNextPage();
                                }),


                            // FutureBuilder<List<PlaceType>>(
                            //     future: placeVal,
                            //     builder: (context,
                            //         AsyncSnapshot<List<PlaceType>> snapshot) {
                            //       if (snapshot.hasData) {
                            //         // print(snapshot.hasData);
                            //         // setState(() {
                            //         //   floorVal = getfloors(snapshot.data[0].p_id);
                            //         // });
                            //         if (snapshot.data.length == 0) {
                            //           return Center(
                            //               child: Text(
                            //                   "No Devices on this place"));
                            //         }
                            //         return Column(
                            //           children: [
                            //             Container(
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(41.0),
                            //                 child: SizedBox(
                            //                   width: double.infinity,
                            //                   height: 50.0,
                            //                   child: Container(
                            //                     width: MediaQuery
                            //                         .of(context)
                            //                         .size
                            //                         .width * 2,
                            //                     decoration: BoxDecoration(
                            //                         color: Colors.white,
                            //                         boxShadow: [BoxShadow(
                            //                             color: Colors.black,
                            //                             blurRadius: 30,
                            //                             offset: Offset(20, 20)
                            //                         )
                            //                         ],
                            //                         border: Border.all(
                            //                           color: Colors.black,
                            //                           width: 0.5,
                            //                         )
                            //                     ),
                            //                     child: DropdownButtonFormField<
                            //                         PlaceType>(
                            //                       decoration: InputDecoration(
                            //                         contentPadding: const EdgeInsets
                            //                             .all(15),
                            //                         focusedBorder: OutlineInputBorder(
                            //                           borderSide: BorderSide(
                            //                               color: Colors.white),
                            //                           borderRadius: BorderRadius
                            //                               .circular(10),
                            //                         ),
                            //                         enabledBorder: UnderlineInputBorder(
                            //                           borderSide: BorderSide(
                            //                               color: Colors.black),
                            //                           borderRadius: BorderRadius
                            //                               .circular(50),
                            //                         ),
                            //                       ),
                            //                       dropdownColor: Colors.white70,
                            //                       icon: Icon(
                            //                           Icons.arrow_drop_down),
                            //                       iconSize: 28,
                            //                       hint: Text('Select Place'),
                            //                       isExpanded: true,
                            //                       value: pt,
                            //                       style: TextStyle(
                            //                         color: Colors.black,
                            //                         fontWeight: FontWeight.bold,
                            //                       ),
                            //                       items: snapshot.data.map((
                            //                           selectedPlace) {
                            //                         return DropdownMenuItem<
                            //                             PlaceType>(
                            //                           value: selectedPlace,
                            //                           child: Text(
                            //                               selectedPlace.pType),
                            //                         );
                            //                       }).toList(),
                            //                       onChanged: (selectedPlace) {
                            //                         assignSubUserPlaceId =
                            //                             selectedPlace.pId;
                            //                         print(
                            //                             'selectedPlace ${assignSubUserPlaceId}');
                            //                         setState(() {
                            //                           // fl = null;
                            //                           // pt = selectedPlace;
                            //                           // floorVal =
                            //                           //     getfloors(selectedPlace.pId);
                            //                         });
                            //                       },
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //               margin: new EdgeInsets.symmetric(
                            //                   vertical: 10, horizontal: 10),
                            //             ),
                            //             SizedBox(
                            //               height: 10,
                            //             ),
                            //             Container(
                            //               margin: EdgeInsets.all(8),
                            //               // ignore: deprecated_member_use
                            //               child: FlatButton(
                            //                 child: Text(
                            //                   'Next',
                            //                   style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontSize: 20,
                            //                     fontWeight: FontWeight.bold,
                            //                   ),
                            //                 ),
                            //                 padding: EdgeInsets.all(12),
                            //                 shape: OutlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white,
                            //                         width: 1),
                            //                     borderRadius:
                            //                     BorderRadius.circular(50)),
                            //                 onPressed: () async {
                            //                   _assignPlace();
                            //                 },
                            //               ),
                            //             ),
                            //           ],
                            //         );
                            //       } else {
                            //         SizedBox(height: 45,);
                            //         return null;
                            //       }
                            //     }
                            // ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Add SubUser',style: TextStyle(fontFamily: fonttest ?? 'RobotoMono',),),
              ),
              body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.lightBlueAccent])),
                child: Form(
                  key: formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    // color: Theme.of(context).primaryColor,
                    // width: double.infinity,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 140,),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54,fontFamily: fonttest ?? 'RobotoMono',),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Email for SubUser',
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40,),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54,fontFamily: fonttest ?? 'RobotoMono',),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Name for SubUser',
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40,),
                          // ignore: deprecated_member_use
                          FlatButton(
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              shape: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              padding: const EdgeInsets.all(15),
                              textColor: Colors.white,
                              onPressed: () async {
                                await addSubUser(emailController.text);


                                // Navigator.of(context).pop();


                                // await floorVal;
                                // goToNextPage();
                              }),

                          const SizedBox(height: 40,),
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
                                            "No Devices on this place",style: TextStyle( fontFamily: fonttest ?? 'RobotoMono',),));
                                  }
                                  return Column(
                                      children: [
                                   Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 2,
                                decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
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
                                borderSide: const BorderSide(
                                color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                                ),
                                ),
                                dropdownColor: Colors.white70,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 28,
                                hint: const Text('Select Place'),
                                isExpanded: true,
                                style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                ),

                                items: placeRows.map((selectedPlace) {
                                return DropdownMenuItem(
                                value: selectedPlace.toString(),
                                child: Text("${selectedPlace['p_type']}",style: TextStyle(fontFamily: fonttest ?? 'RobotoMono',),),
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
                                const SizedBox(
                                height: 10,
                                ),
                                Container(
                                margin: const EdgeInsets.all(8),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                child: Text(
                                'Next',
                                style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: fonttest ?? 'RobotoMono',
                                fontWeight: FontWeight.bold,
                                ),
                                ),
                                padding: const EdgeInsets.all(12),
                                shape: OutlineInputBorder(
                                borderSide: const BorderSide(
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
                                const SizedBox(height: 45,);
                                return null;
                                }
                              }
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget dropDown(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.lightBlueAccent])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 140,),
          FutureBuilder<List<PlaceType>>(
              future: placeValWeb,
              builder: (context,
                  AsyncSnapshot <List<PlaceType>> snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.hasData);
                  // setState(() {
                  //   floorVal = getfloors(snapshot.data[0].p_id);
                  // });
                  if (snapshot.data.isEmpty) {
                    return Center(
                        child: Text(
                          "No Devices on this place",style: TextStyle(fontFamily: fonttest ?? 'RobotoMono',),));
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
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 30,
                                  offset: Offset(20, 20))
                            ],
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            )),
                        child: DropdownButtonFormField<PlaceType>(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          dropdownColor: Colors.white70,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 28,
                          hint: Text('Select Place',style: TextStyle(fontFamily: fonttest ?? 'RobotoMono',),),
                          isExpanded: true,
                          value: pt,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          items: snapshot.data.map((selectedPlace) {
                            return DropdownMenuItem<PlaceType>(
                              value: selectedPlace,
                              child: Text(selectedPlace.pType),
                            );
                          }).toList(),
                          onChanged: (selectedPlace) async {

                            assignSubUserPlaceId = selectedPlace.pId;
                            // pt=as.map((data) => PlaceType.fromJson(data)).toList();
                            print("SElectedPlace ${selectedPlace}");


                            // qwe= ;
                          },
                          // items:snapshot.data
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: fonttest ?? 'RobotoMono',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          shape: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius:
                              BorderRadius.circular(50)),
                          onPressed: () async {
                            _assignPlaceWeb();

                          },
                        ),
                      ),
                    ],
                  );

                } else {
                  const SizedBox(height: 45,);
                  return const Center(child: Text('Add User'));
                }
              }
          ),
        ],
      ),
    );
  }




}
