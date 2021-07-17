import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/TemporaryUser/showTempUser.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';

import '../main.dart';



class AddTempUser extends StatefulWidget {
  const AddTempUser({Key key}) : super(key: key);

  @override
  _AddTempUserState createState() => _AddTempUserState();
}

class _AddTempUserState extends State<AddTempUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  var assignTempUserPlaceId;
  TempUSerRequirementDetails tempUSerRequirementDetails= new TempUSerRequirementDetails();
  FloorType fl;
  Future placeVal;

  var floorval;

  var assignFloorId;


  @override
  void initState() {
    super.initState();
    placeVal=fetchPlace();
  }


  goToNextPage() {
    // setState(() {
    //   isVisible=true;
    // });
    formKey.currentState.save();
    print('clear');
    addTempUser(tempUSerRequirementDetails).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowTempUser()),
      );
    }).catchError((e) {
      print(e);
    });
  }


  Future addTempUser(TempUSerRequirementDetails data)async{
    String token= await getToken();
    final url='http://genorionofficial.herokuapp.com/giveaccesstotempuser/';
    var postData={
      "name": data.name,
      "user": getUidVariable,
      "p_id":assignTempUserPlaceId,
      "email":data.email,
      "mobile":data.pno
    };
    final response= await http.post(url,
        body: jsonEncode(postData)
        ,headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });

    if(response.statusCode>0){
      print('TempResponse ${response.statusCode}');
      if(response.statusCode==201){
        final snackBar = SnackBar(
          content: Text('Temp User Added'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // floorVal= getplaces();
      }else{
        // _showDialog(context);
      }
      print('AddTempUserCode  ${response.statusCode}');
    }
  }



  List placeData;
  List<PlaceType> places;
  Future<List<PlaceType>> fetchPlace() async {
    // await openPlaceBox();
    String token = await getToken();
    // final url = 'http://genorionofficial.herokuapp.com/addyourplace/?p_id=' + placeResponse;
    final url = 'http://genorionofficial.herokuapp.com/getallplaces/';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });


    try{
      if (response.statusCode >0) {
        placeData = jsonDecode(response.body);
        // await putPlaceData(placeData);
        print("Place-->  ${placeData}");
        places = placeData.map((data) => PlaceType.fromJson(data)).toList();

        // places = placeData.map((data) {
        //   PlaceType.fromJson(data).toJson();
        //   DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(data));
        // }).toList();

        print('List ${places.toList()}');
      }
    }catch(e){

    }

    // var myMap=placeBox.toMap().values.toList();
    // if(myMap.isEmpty){
    //   placeData.add('empty');
    //   print('adding from 0 ${placeData.toString()}');
    //
    // }else{
    //   placeData=myMap;
    //   print('adding  ${placeData.toString()}');
    //
    //
    //   setState(() {
    //     print('adding147  ${placeData.toString()}');
    //     // pt.pId=placeData[0]['p_id'];
    //     print('adding1478  ${placeData.toString()}');
    //     // pt.pId=placeData[0]['p_id'];
    //   });
    //
    //
    // }


    return places;

  }

  Future<List<FloorType>> fetchFloors(String pId) async {
    var query = {'p_id': pId};
    String token = await getToken();
    final url = Uri.https('genorionofficial.herokuapp.com', '/getallfloors/', query);

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode>0) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<FloorType> floors =
      data.map((data) => FloorType.fromJson(data)).toList();

      // floorVal = getfloors(places[0].p_id);

      return floors;
    }
  }


  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Temp User'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent])),
        child: Form(
          key: formKey,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                dragStartBehavior: DragStartBehavior.down,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.text,
                            onSaved: (String value){
                              this.tempUSerRequirementDetails.name=value;
                            },
                            // controller: nameController,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Name of TempUser',
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
                          SizedBox(height: 40,),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.emailAddress,
                            // controller: emailController,
                            onSaved: (String value){
                              this.tempUSerRequirementDetails.email=value;
                            },
                            style: TextStyle(fontSize: 18, color: Colors.black54),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Email of TempUser',
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
                          SizedBox(height: 40,),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.phone,
                            onSaved: (String value){
                              this.tempUSerRequirementDetails.pno=value;
                            },
                            // controller: phoneController,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Phone Number of TempUser',
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
                          // SizedBox(height: 10,),
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
                                        child: Text("Please Select"));
                                  }
                                  return Container(
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
                                              setState(() {
                                                fl = null;
                                                pt = selectedPlace;
                                                assignTempUserPlaceId=selectedPlace.pId;
                                                print('place Selected');
                                                print('After Place Selected ${pt.pId}');
                                                // pt=  DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(pt.pId));
                                                floorval =
                                                    fetchFloors(selectedPlace.pId);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    margin: new EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                  );
                                } else {
                                  return CircularProgressIndicator(semanticsLabel: "Loading",);
                                }
                              }
                          ),
                          // SizedBox(height: 10,),
                          FutureBuilder<List<FloorType>>(
                              future: floorval,
                              builder:
                                  (context, AsyncSnapshot<List<FloorType>> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.length == 0) {
                                    return Center(
                                        child: Text("Please Select"));
                                  }
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(45.0),
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
                                                  // offset for Upward Effect
                                                  offset: Offset(20,20)
                                              )],
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 0.5,
                                              )
                                          ),
                                          child: DropdownButtonFormField<FloorType>(
                                            decoration:InputDecoration(
                                              contentPadding: const EdgeInsets.all(15),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                                borderRadius: BorderRadius.circular(10),
                                              ),enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            ),
                                            dropdownColor: Colors.white70,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 28,
                                            hint: Text('Select Floor'),
                                            isExpanded: true,
                                            value: fl,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            items: snapshot.data
                                                .map((selectedFloor) {
                                              return DropdownMenuItem<FloorType>(
                                                value: selectedFloor,
                                                child: Text(selectedFloor.fName),
                                              );
                                            }).toList(),
                                            onChanged: ( selectedFloor) {
                                              setState(() {
                                                fl = selectedFloor;
                                                print(fl.fId);
                                                assignFloorId=selectedFloor.fId;
                                                // roomVal=getrooms(selectedFloor.fId);
                                                // rm2=getDevices(rm2.rId);
                                                // dv=rm2.rId as List<Device>;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    // margin: new EdgeInsets.symmetric(
                                    //     vertical: 10, horizontal: 10),
                                  );
                                } else {
                                  return Center(
                                      child: Text(
                                          "Loading..."));
                                }
                              }),
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
                                print("assignTempUserPlaceId->  ${assignTempUserPlaceId}");
                                await goToNextPage();
                                // await addSubUser(emailController.text);

                                // Navigator.of(context).pop();


                                // await floorVal;
                                // goToNextPage();
                              }),





                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


class TempUSerRequirementDetails {
  String email = '';
  String pno = '';
  String name = '';



}