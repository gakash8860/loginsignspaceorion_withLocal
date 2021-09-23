import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/Add%20SubUser/showSubUser.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/main.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../changeFont.dart';


void main()=>runApp(MaterialApp(
  home: AlreadySubUser(),
));

class AlreadySubUser extends StatefulWidget {

   AlreadySubUser({Key key}) : super(key: key);

  @override
  _AlreadySubUserState createState() => _AlreadySubUserState();
}

class _AlreadySubUserState extends State<AlreadySubUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  var assignSubUserPlaceId;
  List<Map<String, dynamic>> queryRows;
  Future placeVal;
  Future placeValWeb;
  var tokenWeb;
  Future getTokenWeb()async{
    final pref= await SharedPreferences.getInstance();
    tokenWeb=pref.getString('tokenWeb');
    return tokenWeb;
  }

  Future assignAlreadySubUserPlace()async{
    String token = await getToken();
    final url=API+'subuserpalceaccess/';
    var postData={
      "user":getUidVariable,
      "email":emailController.text,
      "p_id":assignSubUserPlaceId,
      "name":nameController.text
    };
    final response= await http.post(url,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    },body: jsonEncode(postData));
    if(response.statusCode>0){

      if(response.statusCode==201){
        final snackBar = SnackBar(
          content: Text('Place Assigned'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSubUser()));
      }

      print('response.body  ${response.statusCode}');
      print('response.body  ${response.body}');
    }
  }

  Future assignAlreadySubUserPlaceWeb()async{
    String token = await getTokenWeb();
    final url=API+'subuserpalceaccess/';
    var postData={
      "user":getUidVariable,
      "email":emailController.text,
      "p_id":assignSubUserPlaceId,
      "name":nameController.text
    };
    final response= await http.post(url,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    },body: jsonEncode(postData));
    if(response.statusCode>0){

      if(response.statusCode==201){
        final snackBar = SnackBar(
          content: Text('Place Assigned'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSubUser()));
      }

      print('response.body  ${response.statusCode}');
      print('response.body  ${response.body}');
    }
  }


  Future<List<PlaceType>> getplaces() async {
    String token = await getTokenWeb();
    print('token123 $token');
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = API+'getallplaces/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
      data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    placeValWeb=getplaces();
    placeQueryFunc();
  }


  Future returnPlaceQuery() async {
    return NewDbProvider.instance.queryPlace();
  }

  Future placeQueryFunc() async {
    queryRows =
    await NewDbProvider.instance.queryPlace();
    print('qwe123 $queryRows');
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      body:  LayoutBuilder(
        builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          if(viewportConstraints.maxWidth>600){
            return Scaffold(
              appBar: AppBar(
                title: Text('Already SubUser',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
              ),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.lightBlueAccent])),
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54,fontFamily: fonttest==null?'RobotoMono':fonttest,),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Email for SubUser',
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
                          SizedBox(height: 20,),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54,fontFamily: fonttest==null?'RobotoMono':fonttest,),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Name for SubUser',
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
                          SizedBox(height: 10,),
                          // ignore: deprecated_member_use

                          Padding(
                            padding: const EdgeInsets.all(22.0),
                            child:FutureBuilder<List<PlaceType>>(
                                future: placeValWeb,
                                builder: (context,
                                    AsyncSnapshot <List<PlaceType>> snapshot) {
                                  if (snapshot.hasData) {
                                    // print(snapshot.hasData);
                                    // setState(() {
                                    //   floorVal = getfloors(snapshot.data[0].p_id);
                                    // });
                                    if (snapshot.data.length == 0) {
                                      return Center(
                                          child: Text(
                                            "No Devices on this place",style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),));
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
                                          child: DropdownButtonFormField<PlaceType>(
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
                                            hint: Text('Select Place',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
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
                                            onChanged: (selectedPlace) async {

                                              assignSubUserPlaceId = selectedPlace.pId;
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
                                      ],
                                    );

                                  } else {
                                    SizedBox(height: 45,);
                                    return Center(child: Text('Add User'));
                                  }
                                }
                            ),
                          ),

                          FlatButton(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: fonttest==null?'RobotoMono':fonttest,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              shape: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              padding: const EdgeInsets.all(15),
                              textColor: Colors.white,
                              onPressed: ()async {
                                // await addSubUser(emailController.text);
                                await assignAlreadySubUserPlaceWeb();
                                // Navigator.of(context).pop();


                                // await floorVal;
                                // goToNextPage();
                              }),





                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }else{
            return Scaffold(
              appBar: AppBar(
                title: Text('Already SubUser',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
              ),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.lightBlueAccent])),
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54,fontFamily: fonttest==null?'RobotoMono':fonttest,),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Email for SubUser',
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
                          SizedBox(height: 20,),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54,fontFamily: fonttest==null?'RobotoMono':fonttest,),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Name for SubUser',
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
                          SizedBox(height: 10,),
                          // ignore: deprecated_member_use

                          Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: FutureBuilder(
                                future: returnPlaceQuery(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
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
                                          contentPadding: const EdgeInsets.all(
                                              15),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.circular(
                                                50),
                                          ),
                                        ),
                                        dropdownColor: Colors.white70,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 28,
                                        hint: Text('Select Place',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                        isExpanded: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),

                                        items: queryRows.map((selectedPlace) {
                                          return DropdownMenuItem<String>(
                                            value: selectedPlace.toString(),
                                            child: Text(
                                                "${selectedPlace['p_type']}",style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                          );
                                        }).toList(),
                                        onChanged: (selectedPlace) async {

                                        var placeid=selectedPlace.substring(7,14);
                                        assignSubUserPlaceId=placeid;
                                        print('assignSubUserPlaceId ${placeid}');
                                        // assignSubUserPlaceId

                                          // qwe= ;

                                        },
                                        // items:snapshot.data
                                      ),
                                    );
                                  } else {
                                    return Center(child: Text('Please Wait',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),));
                                  }
                                }),
                          ),

                          FlatButton(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: fonttest==null?'RobotoMono':fonttest,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              shape: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              padding: const EdgeInsets.all(15),
                              textColor: Colors.white,
                              onPressed: ()async {
                                // await addSubUser(emailController.text);
                                await assignAlreadySubUserPlace();
                                // Navigator.of(context).pop();


                                // await floorVal;
                                // goToNextPage();
                              }),





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
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.lightBlueAccent])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 140,),
          FutureBuilder<List<PlaceType>>(
              future: placeValWeb,
              builder: (context,
                  AsyncSnapshot <List<PlaceType>> snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.hasData);
                  // setState(() {
                  //   floorVal = getfloors(snapshot.data[0].p_id);
                  // });
                  if (snapshot.data.length == 0) {
                    return Center(
                        child: Text(
                          "No Devices on this place",style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),));
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
                        child: DropdownButtonFormField<PlaceType>(
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
                          hint: Text('Select Place',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
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
                          onChanged: (selectedPlace) async {

                            assignSubUserPlaceId = selectedPlace.pId;
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
                              fontFamily: fonttest==null?'RobotoMono':fonttest,
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
                            assignAlreadySubUserPlaceWeb();

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
    );
  }
}
