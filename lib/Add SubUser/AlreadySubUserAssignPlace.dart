import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/Add%20SubUser/showSubUser.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/main.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';


void main()=>runApp(MaterialApp(
  home: AlreadySubUser(),
));

class AlreadySubUser extends StatefulWidget {
  const AlreadySubUser({Key key}) : super(key: key);

  @override
  _AlreadySubUserState createState() => _AlreadySubUserState();
}

class _AlreadySubUserState extends State<AlreadySubUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  var assignSubUserPlaceId;

  Future placeVal;


  Future assignAlreadySubUserPlace()async{
    String token = await getToken();
    final url='http://genorionofficial.herokuapp.com/subuserpalceaccess/';
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
    String token = await getToken();
    print('token123 $token');
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = 'http://genorionofficial.herokuapp.com/getallplaces/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode>0) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
      data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // placeVal=getplaces();
  }



  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      body:  LayoutBuilder(
        builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          if(viewportConstraints.maxWidth>600){
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Colors.lightBlueAccent])),
              child: SingleChildScrollView(
                dragStartBehavior:  DragStartBehavior.down,
                physics: BouncingScrollPhysics(),
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
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              // validator: nameValid,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              style:
                              TextStyle(fontSize: 18, color: Colors.black54),
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
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: 300,
                            child: TextFormField(
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              // validator: nameValid,
                              keyboardType: TextInputType.text,
                              controller: nameController,
                              style:
                              TextStyle(fontSize: 18, color: Colors.black54),
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
                          ),
                          SizedBox(height: 10,),
                          // ignore: deprecated_member_use

                          FutureBuilder<List<PlaceType>>(
                              future: placeVal,
                              builder: (context,
                                  AsyncSnapshot<List<PlaceType>> snapshot) {
                                if (!snapshot.hasData) {
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

                                      ),

                                    ],
                                  );

                                } else {
                                  SizedBox(height: 45,);
                                  return Center(child: Text('Add User'));
                                }
                              }
                          ),

                          FlatButton(
                              child: Text(
                                'Submit',
                                style: TextStyle(
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
          }else{
            return Scaffold(
              appBar: AppBar(
                title: Text('Already SubUser'),
              ),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.lightBlueAccent])),
                child: SingleChildScrollView(
                  dragStartBehavior:  DragStartBehavior.down,
                  physics: BouncingScrollPhysics(),
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
                                TextStyle(fontSize: 18, color: Colors.black54),
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
                                TextStyle(fontSize: 18, color: Colors.black54),
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

                              FutureBuilder<List<PlaceType>>(
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

                                          ),

                                        ],
                                      );

                                    } else {
                                      SizedBox(height: 45,);
                                      return Center(child: Text('Add User'));
                                    }
                                  }
                              ),

                              FlatButton(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
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
                ),
              ),
            );
          }

        },
      ),
    );
  }
}
