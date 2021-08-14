import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/TemporaryUser/showTempUser.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import '../main.dart';

void main()=>runApp(MaterialApp(home: AddTempUser(),));
class AddTempUser extends StatefulWidget {
  const AddTempUser({Key key}) : super(key: key);

  @override
  _AddTempUserState createState() => _AddTempUserState();
}

class _AddTempUserState extends State<AddTempUser> {
  DateTime selectedDate = DateTime.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  var assignTempUserPlaceId;
  TempUSerRequirementDetails tempUSerRequirementDetails = new TempUSerRequirementDetails();
  FloorType fl;
  Future placeVal;
  var cutTime;
  var cutDate;
  Future flatVal;
  List<Map<String, dynamic>> flatQueryRows2;
  List<Map<String, dynamic>> floorQueryRows2;
  List<Map<String, dynamic>> floorQueryRows;
  List<Map<String, dynamic>> queryRows;
  var floorval;
  List<Map<String, dynamic>> roomQueryRows2;
  var assignFloorId;
  var assignFlatId;
  var assignRoomId;
  http.Response response;
  DateTime pickedDate;
  TimeOfDay pickedTime;

  Future roomVal;


  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
    placeVal = returnPlaceQuery();
    placeQueryFunc();
    // placeVal=fetchPlace();
  }


  goToNextPage() {
    // setState(() {
    //   isVisible=true;
    // });
    formKey.currentState.save();
    print('clear');
    addTempUser(tempUSerRequirementDetails).then((value) {
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowTempUser()),
        );
      } else {
        return Center(child: Text('Error'),);
      }
    }).catchError((e) {
      print(e);
    });
  }


  Future addTempUser(TempUSerRequirementDetails data) async {
    String token = await getToken();
    final url = 'https://genorion1.herokuapp.com/giveaccesstotempuser/';
    int pNo;
    var postData;
    pNo = int.parse(data.pno);
    if (assignTempUserPlaceId != null) {
      postData = {
        "name": data.name,
        "owner_name": data.ownerName,
        "user": getUidVariable2,
        "p_id": assignTempUserPlaceId.toString(),
        "email": data.email,
        "mobile": pNo,
        "timing": cutTime.toString(),
        "date": cutDate.toString(),
      };
    } else if (assignFloorId != null) {
      postData = {
        "name": data.name,
        "user": getUidVariable2,
        "owner_name": data.ownerName,
        // "p_id":assignTempUserPlaceId.toString(),
        "email": data.email,
        "mobile": pNo,
        "timing": cutTime.toString(),
        "date": cutDate.toString(),
        "f_id": assignFloorId.toString(),


        // "d_id":""
      };
    } else if (assignFlatId != null) {
      postData = {
        "name": data.name,
        "user": getUidVariable2,
        "owner_name": data.ownerName,
        "email": data.email,
        "mobile": pNo,
        "timing": cutTime.toString(),
        "date": cutDate.toString(),
        "flt_id": assignFlatId.toString(),
      };
    } else if (assignRoomId != null) {
      postData = {
        "name": data.name,
        "user": getUidVariable2,
        "owner_name": data.ownerName,
        "email": data.email,
        "mobile": pNo,
        "timing": cutTime.toString(),
        "date": cutDate.toString(),
        "r_id": assignRoomId.toString(),
        // "d_id":""
      };
    }


    response = await http.post(Uri.parse(url),
        body: jsonEncode(postData), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode > 0) {
      print('TempResponse ${response.statusCode}');
      print('TempResponse ${response.body}');
      print('aaaaaa ${postData}');
      if (response.statusCode == 201) {
        final snackBar = SnackBar(
          content: Text('Temp User Added'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {

      }
      print('AddTempUserCode  ${response.statusCode}');
    }
  }


  Future returnPlaceQuery() async {
    return NewDbProvider.instance.queryPlace();
  }

  Future placeQueryFunc() async {
    queryRows =
    await NewDbProvider.instance.queryPlace();
    print('qwe123 $queryRows');
  }


  pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
    String date2 = pickedDate.toString();
    cutDate = date2.substring(0, 10);
    print('pickedDate ${pickedDate}');
    print('pickedDate ${cutDate}');
  }


  pickTime() async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: pickedTime
    );
    if (time != null) {
      setState(() {
        pickedTime = time;
      });
    }
    String se = pickedTime.toString();
    cutTime = se.substring(10, 16);
    print('pickedTime ${pickedTime.toString()}');
    print('pickedTime ${cutTime}');
  }


  Future returnFlatQuery(String fId) {
    return NewDbProvider.instance.queryFlat();
  }

  Future returnFloorQuery(String pId) {
    return NewDbProvider.instance.queryFloor();
  }

  Future returnRoomQuery(String fId) {
    return NewDbProvider.instance.queryRoom();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: LayoutBuilder(
          builder: (BuildContext context,
              BoxConstraints viewportConstraints) {
            if (viewportConstraints.maxWidth > 600) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.lightBlueAccent])),
                child: SingleChildScrollView(

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
                        // minHeight: viewportConstraints.maxHeight,
                      ),
                      child: ClipPath(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 45,),
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
                                onSaved: (String value) {
                                  this.tempUSerRequirementDetails.name = value;
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
                            ),
                            SizedBox(height: 10,),
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
                                // controller: emailController,
                                onSaved: (String value) {
                                  this.tempUSerRequirementDetails.email = value;
                                },
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
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
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: 300,
                              child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                // validator: nameValid,
                                keyboardType: TextInputType.name,
                                // controller: emailController,
                                onSaved: (String value) {
                                  this.tempUSerRequirementDetails.ownerName =
                                      value;
                                },
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(

                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter your Name',
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
                            Container(
                              width: 300,
                              child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                // validator: nameValid,
                                keyboardType: TextInputType.phone,
                                onSaved: (String value) {
                                  this.tempUSerRequirementDetails.pno = value;
                                },
                                // controller: phoneController,
                                style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(

                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter Phone Number of Temp. User',
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
                            Container(
                                height: MediaQuery.of(context).size.height / 18,
                                width: 290,
                                child: Card(
                                  child: GestureDetector(
                                    onTap: pickDate,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Date:${pickedDate.day}/${pickedDate
                                              .month}/${pickedDate.year}",
                                          textAlign: TextAlign.start,)
                                    ),
                                  ),)),
                            Container(
                                height: MediaQuery.of(context).size.height / 18,
                                width: 290,
                                child: Card(
                                  child: GestureDetector(
                                    onTap: pickTime,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Time :${pickedTime.hour}:${pickedTime
                                              .minute}",
                                          textAlign: TextAlign.start,)
                                    ),
                                  ),)),

                            FutureBuilder(
                                future: placeVal,
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
                                      child: DropdownButtonFormField<String>(
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
                                        hint: Text('Select Place'),
                                        isExpanded: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),

                                        items: queryRows.map((selectedPlace) {
                                          return DropdownMenuItem<String>(
                                            value: selectedPlace.toString(),
                                            child: Text(
                                                "${selectedPlace['p_type']}"),
                                          );
                                        }).toList(),
                                        onChanged: (selectedPlace) async {
                                          floorval = null;
                                          // floorQueryRows2=null;
                                          // print('Floorqwe  ${floorQueryRows2}');
                                          var placeId = selectedPlace.substring(
                                              7, 14);
                                          assignTempUserPlaceId = placeId;
                                          print(
                                              'PlaceId->  ${assignTempUserPlaceId}');
                                          var aa = await NewDbProvider.instance
                                              .getFloorById(placeId.toString());
                                          print('AA  ${aa}');
                                          floorval = null;
                                          setState(() {
                                            floorQueryRows2 = aa;
                                            floorval =
                                                returnFloorQuery(placeId);
                                            returnFloorQuery(placeId);
                                          });
                                          print('Floorqwe  ${floorQueryRows2}');


                                          // qwe= ;

                                        },
                                        // items:snapshot.data
                                      ),
                                    );
                                  } else {
                                    return Center(child: Text('Please Wait'));
                                  }
                                }),
                            SizedBox(height: 20),
                            FutureBuilder(
                                future: floorval,
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
                                        hint: Text('Select Floor'),
                                        isExpanded: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: floorQueryRows2.map((
                                            selectedFloor) {
                                          return DropdownMenuItem(
                                            value: selectedFloor.toString(),
                                            child: Text(
                                                "${selectedFloor['f_name']}"),
                                          );
                                        }).toList(),
                                        onChanged: (selectedFloor) async {
                                          print(
                                              'Floor selected $selectedFloor');
                                          var floorId = selectedFloor.substring(
                                              7, 14);
                                          assignTempUserPlaceId = null;
                                          assignFloorId = floorId;
                                          var getFlat = await NewDbProvider
                                              .instance.getFlatByFId(
                                              floorId.toString());
                                          print(getFlat);
                                          setState(() {
                                            flatVal = returnFlatQuery(floorId);
                                            flatQueryRows2 = getFlat;
                                          });
                                          print('forRoom  ${roomQueryRows2}');


                                          returnFloorQuery(floorId);
                                        },
                                        // items:snapshot.data
                                      ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                            SizedBox(height: 20),
                            FutureBuilder(
                                future: flatVal,
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
                                        hint: Text('Select Flat'),
                                        isExpanded: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        items: flatQueryRows2.map((
                                            selectedFlat) {
                                          return DropdownMenuItem(
                                            value: selectedFlat.toString(),
                                            child: Text(
                                                "${selectedFlat['flt_name']}"),
                                          );
                                        }).toList(),
                                        onChanged: (selectedFlat) async {
                                          print('Flat selected $selectedFlat');
                                          var flatId = selectedFlat.substring(
                                              9, 16);
                                          assignFloorId = null;
                                          assignFlatId = flatId;
                                          print(flatId);
                                          var aa = await NewDbProvider.instance
                                              .getRoomById(flatId.toString());
                                          print('AA  ${aa}');
                                          setState(() {
                                            roomQueryRows2 = aa;
                                            roomVal = returnRoomQuery(flatId);
                                          });
                                          print('forRoom  ${roomQueryRows2}');


                                          // returnFloorQuery(floorId);

                                        },
                                        // items:snapshot.data
                                      ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),

                            SizedBox(height: 20),
                            FutureBuilder(
                                future: roomVal,
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
                                      child: DropdownButtonFormField<String>(
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
                                        hint: Text('Select Room'),
                                        isExpanded: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),

                                        items: roomQueryRows2.map((
                                            selectedRoom) {
                                          return DropdownMenuItem<String>(
                                            value: selectedRoom.toString(),
                                            child: Text(
                                                "${selectedRoom['r_name']}"),
                                          );
                                        }).toList(),
                                        onChanged: (selectedRoom) async {
                                          assignFlatId = null;
                                          var roomId = selectedRoom.substring(
                                              7, 14);
                                          assignRoomId = roomId;
                                          print('roomId ${roomId}');
                                          var aa = await NewDbProvider.instance
                                              .getDeviceByRId(
                                              roomId.toString());
                                          print('deviceQueryRows ${aa}');
                                          setState(() {
                                            // deviceQueryRows2=aa;
                                            // deviceVal=returnDeviceQuery(roomId);
                                          });
                                          print('DeviceCheck  ${aa}');
                                        },
                                        // items:snapshot.data
                                      ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
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
                                onPressed: () async {
                                  print(
                                      "assignTempUserPlaceId->  ${assignTempUserPlaceId}");
                                  print(
                                      "assignTempUserFloorId->  ${assignFloorId}");
                                  print(
                                      "assignTempUserRooId->  ${assignRoomId}");
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
                ),
              );
            } else {
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
                  child: SingleChildScrollView(

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
                          // minHeight: viewportConstraints.maxHeight,
                        ),
                        child: ClipPath(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 45,),
                              TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                // validator: nameValid,
                                keyboardType: TextInputType.text,
                                onSaved: (String value) {
                                  this.tempUSerRequirementDetails.name = value;
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
                              SizedBox(height: 10,),
                              TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                // validator: nameValid,
                                keyboardType: TextInputType.emailAddress,
                                // controller: emailController,
                                onSaved: (String value) {
                                  this.tempUSerRequirementDetails.email = value;
                                },
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
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
                              SizedBox(height: 10,),
                              TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                // validator: nameValid,
                                keyboardType: TextInputType.name,
                                // controller: emailController,
                                onSaved: (String value) {
                                  this.tempUSerRequirementDetails.ownerName =
                                      value;
                                },
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(

                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter your Name',
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
                              TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                // validator: nameValid,
                                keyboardType: TextInputType.phone,
                                onSaved: (String value) {
                                  this.tempUSerRequirementDetails.pno = value;
                                },
                                // controller: phoneController,
                                style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(

                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter Phone Number of Temp. User',
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
                              Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 18,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.8,
                                  child: Card(
                                    child: GestureDetector(
                                      onTap: pickDate,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Date:${pickedDate.day}/${pickedDate
                                                .month}/${pickedDate.year}",
                                            textAlign: TextAlign.start,)
                                      ),
                                    ),)),
                              Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 18,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.8,
                                  child: Card(
                                    child: GestureDetector(
                                      onTap: pickTime,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Time :${pickedTime.hour}:${pickedTime
                                                .minute}",
                                            textAlign: TextAlign.start,)
                                      ),
                                    ),)),

                              FutureBuilder(
                                  future: placeVal,
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
                                        child: DropdownButtonFormField<String>(
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
                                          hint: Text('Select Place'),
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),

                                          items: queryRows.map((selectedPlace) {
                                            return DropdownMenuItem<String>(
                                              value: selectedPlace.toString(),
                                              child: Text(
                                                  "${selectedPlace['p_type']}"),
                                            );
                                          }).toList(),
                                          onChanged: (selectedPlace) async {
                                            floorval = null;
                                            // floorQueryRows2=null;
                                            // print('Floorqwe  ${floorQueryRows2}');
                                            var placeId = selectedPlace.substring(
                                                7, 14);
                                            assignTempUserPlaceId = placeId;
                                            print(
                                                'PlaceId->  ${assignTempUserPlaceId}');
                                            var aa = await NewDbProvider.instance
                                                .getFloorById(placeId.toString());
                                            print('AA  ${aa}');
                                            floorval = null;
                                            setState(() {
                                              floorQueryRows2 = aa;
                                              floorval =
                                                  returnFloorQuery(placeId);
                                              returnFloorQuery(placeId);
                                            });
                                            print('Floorqwe  ${floorQueryRows2}');


                                            // qwe= ;

                                          },
                                          // items:snapshot.data
                                        ),
                                      );
                                    } else {
                                      return Center(child: Text('Please Wait'));
                                    }
                                  }),
                              SizedBox(height: 20),
                              FutureBuilder(
                                  future: floorval,
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
                                          hint: Text('Select Floor'),
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          items: floorQueryRows2.map((
                                              selectedFloor) {
                                            return DropdownMenuItem(
                                              value: selectedFloor.toString(),
                                              child: Text(
                                                  "${selectedFloor['f_name']}"),
                                            );
                                          }).toList(),
                                          onChanged: (selectedFloor) async {
                                            print(
                                                'Floor selected $selectedFloor');
                                            var floorId = selectedFloor.substring(
                                                7, 14);
                                            assignTempUserPlaceId = null;
                                            assignFloorId = floorId;
                                            var getFlat = await NewDbProvider
                                                .instance.getFlatByFId(
                                                floorId.toString());
                                            print(getFlat);
                                            setState(() {
                                              flatVal = returnFlatQuery(floorId);
                                              flatQueryRows2 = getFlat;
                                            });
                                            print('forRoom  ${roomQueryRows2}');


                                            returnFloorQuery(floorId);
                                          },
                                          // items:snapshot.data
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                              SizedBox(height: 20),
                              FutureBuilder(
                                  future: flatVal,
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
                                          hint: Text('Select Flat'),
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          items: flatQueryRows2.map((
                                              selectedFlat) {
                                            return DropdownMenuItem(
                                              value: selectedFlat.toString(),
                                              child: Text(
                                                  "${selectedFlat['flt_name']}"),
                                            );
                                          }).toList(),
                                          onChanged: (selectedFlat) async {
                                            print('Flat selected $selectedFlat');
                                            var flatId = selectedFlat.substring(
                                                9, 16);
                                            assignFloorId = null;
                                            assignFlatId = flatId;
                                            print(flatId);
                                            var aa = await NewDbProvider.instance
                                                .getRoomById(flatId.toString());
                                            print('AA  ${aa}');
                                            setState(() {
                                              roomQueryRows2 = aa;
                                              roomVal = returnRoomQuery(flatId);
                                            });
                                            print('forRoom  ${roomQueryRows2}');


                                            // returnFloorQuery(floorId);

                                          },
                                          // items:snapshot.data
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),

                              SizedBox(height: 20),
                              FutureBuilder(
                                  future: roomVal,
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
                                        child: DropdownButtonFormField<String>(
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
                                          hint: Text('Select Room'),
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),

                                          items: roomQueryRows2.map((
                                              selectedRoom) {
                                            return DropdownMenuItem<String>(
                                              value: selectedRoom.toString(),
                                              child: Text(
                                                  "${selectedRoom['r_name']}"),
                                            );
                                          }).toList(),
                                          onChanged: (selectedRoom) async {
                                            assignFlatId = null;
                                            var roomId = selectedRoom.substring(
                                                7, 14);
                                            assignRoomId = roomId;
                                            print('roomId ${roomId}');
                                            var aa = await NewDbProvider.instance
                                                .getDeviceByRId(
                                                roomId.toString());
                                            print('deviceQueryRows ${aa}');
                                            setState(() {
                                              // deviceQueryRows2=aa;
                                              // deviceVal=returnDeviceQuery(roomId);
                                            });
                                            print('DeviceCheck  ${aa}');
                                          },
                                          // items:snapshot.data
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
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
                                  onPressed: () async {
                                    print(
                                        "assignTempUserPlaceId->  ${assignTempUserPlaceId}");
                                    print(
                                        "assignTempUserFloorId->  ${assignFloorId}");
                                    print(
                                        "assignTempUserRooId->  ${assignRoomId}");
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
                  ),
                ),
              );
          }
          },

        ),
        // child: LayoutBuilder(
        //   builder:
        //       (BuildContext context, BoxConstraints viewportConstraints) {
        //     return SingleChildScrollView(
        //       dragStartBehavior: DragStartBehavior.down,
        //       physics: BouncingScrollPhysics(),
        //       child: Container(
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 30,
        //         ),
        //         // color: Theme.of(context).primaryColor,
        //         width: double.infinity,
        //         child: ConstrainedBox(
        //           constraints: BoxConstraints(
        //             minHeight: viewportConstraints.maxHeight,
        //           ),
        //           child: ClipPath(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.stretch,
        //               children: <Widget>[
        //
        //                 TextFormField(
        //                   autofocus: true,
        //                   textInputAction: TextInputAction.next,
        //                   onEditingComplete: () => node.nextFocus(),
        //                   autovalidateMode: AutovalidateMode.onUserInteraction,
        //                   // validator: nameValid,
        //                   keyboardType: TextInputType.text,
        //                   onSaved: (String value){
        //                     this.tempUSerRequirementDetails.name=value;
        //                   },
        //                   // controller: nameController,
        //                   style:
        //                   TextStyle(fontSize: 18, color: Colors.black54),
        //                   decoration: InputDecoration(
        //
        //                     filled: true,
        //                     fillColor: Colors.white,
        //                     hintText: 'Enter Name of TempUser',
        //                     contentPadding: const EdgeInsets.all(15),
        //                     focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(color: Colors.white),
        //                       borderRadius: BorderRadius.circular(50),
        //                     ),
        //                     enabledBorder: UnderlineInputBorder(
        //                       borderSide: BorderSide(color: Colors.white),
        //                       borderRadius: BorderRadius.circular(50),
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(height: 10,),
        //                 TextFormField(
        //                   autofocus: true,
        //                   textInputAction: TextInputAction.next,
        //                   onEditingComplete: () => node.nextFocus(),
        //                   autovalidateMode: AutovalidateMode.onUserInteraction,
        //                   // validator: nameValid,
        //                   keyboardType: TextInputType.emailAddress,
        //                   // controller: emailController,
        //                   onSaved: (String value){
        //                     this.tempUSerRequirementDetails.email=value;
        //                   },
        //                   style: TextStyle(fontSize: 18, color: Colors.black54),
        //                   decoration: InputDecoration(
        //
        //                     filled: true,
        //                     fillColor: Colors.white,
        //                     hintText: 'Enter Email of TempUser',
        //                     contentPadding: const EdgeInsets.all(15),
        //                     focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(color: Colors.white),
        //                       borderRadius: BorderRadius.circular(50),
        //                     ),
        //                     enabledBorder: UnderlineInputBorder(
        //                       borderSide: BorderSide(color: Colors.white),
        //                       borderRadius: BorderRadius.circular(50),
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(height: 10,),
        //                 TextFormField(
        //                   autofocus: true,
        //                   textInputAction: TextInputAction.next,
        //                   onEditingComplete: () => node.nextFocus(),
        //                   autovalidateMode: AutovalidateMode.onUserInteraction,
        //                   // validator: nameValid,
        //                   keyboardType: TextInputType.phone,
        //                   onSaved: (String value){
        //                     this.tempUSerRequirementDetails.pno=value;
        //                   },
        //                   // controller: phoneController,
        //                   style:
        //                   TextStyle(fontSize: 18, color: Colors.black54),
        //                   decoration: InputDecoration(
        //
        //                     filled: true,
        //                     fillColor: Colors.white,
        //                     hintText: 'Enter Phone Number of Temp. User',
        //                     contentPadding: const EdgeInsets.all(15),
        //                     focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(color: Colors.white),
        //                       borderRadius: BorderRadius.circular(50),
        //                     ),
        //                     enabledBorder: UnderlineInputBorder(
        //                       borderSide: BorderSide(color: Colors.white),
        //                       borderRadius: BorderRadius.circular(50),
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(height: 10,),
        //                 Container(
        //                     height: MediaQuery.of(context).size.height/18,
        //                     width: MediaQuery.of(context).size.width/1.8,
        //                     child: Card(
        //                       child: GestureDetector(
        //                         onTap: pickDate,
        //                         child: Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                             child: Text("Date:${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",textAlign: TextAlign.start,)
        //                         ),
        //                       ),)),
        //                 Container(
        //                     height: MediaQuery.of(context).size.height/18,
        //                     width: MediaQuery.of(context).size.width/1.8,
        //                     child: Card(
        //                       child: GestureDetector(
        //                         onTap: pickTime,
        //                         child: Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child: Text("Time :${pickedTime.hour}:${pickedTime.minute}",textAlign: TextAlign.start,)
        //                         ),
        //                       ),)),
        //
        //                 FutureBuilder(
        //                     future: placeVal,
        //                     builder: (context, AsyncSnapshot snapshot) {
        //                       if (snapshot.hasData) {
        //                         return Container(
        //                           width: MediaQuery.of(context).size.width * 2,
        //                           decoration: BoxDecoration(
        //                               color: Colors.white,
        //                               boxShadow: [
        //                                 BoxShadow(
        //                                     color: Colors.black,
        //                                     blurRadius: 30,
        //                                     offset: Offset(20, 20))
        //                               ],
        //                               border: Border.all(
        //                                 color: Colors.black,
        //                                 width: 0.5,
        //                               )),
        //                           child: DropdownButtonFormField<String>(
        //                             decoration: InputDecoration(
        //                               contentPadding: const EdgeInsets.all(15),
        //                               focusedBorder: OutlineInputBorder(
        //                                 borderSide:
        //                                 BorderSide(color: Colors.white),
        //                                 borderRadius: BorderRadius.circular(10),
        //                               ),
        //                               enabledBorder: UnderlineInputBorder(
        //                                 borderSide:
        //                                 BorderSide(color: Colors.black),
        //                                 borderRadius: BorderRadius.circular(50),
        //                               ),
        //                             ),
        //                             dropdownColor: Colors.white70,
        //                             icon: Icon(Icons.arrow_drop_down),
        //                             iconSize: 28,
        //                             hint: Text('Select Place'),
        //                             isExpanded: true,
        //                             style: TextStyle(
        //                               color: Colors.black,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //
        //                             items: queryRows.map((selectedPlace) {
        //
        //                               return DropdownMenuItem<String>(
        //                                 value: selectedPlace.toString(),
        //                                 child: Text("${selectedPlace['p_type']}"),
        //                               );
        //                             }).toList(),
        //                             onChanged: (selectedPlace)async {
        //                               floorval=null;
        //                               // floorQueryRows2=null;
        //                               // print('Floorqwe  ${floorQueryRows2}');
        //                               var placeId=selectedPlace.substring(7,14);
        //                               assignTempUserPlaceId=placeId;
        //                               print('PlaceId->  ${assignTempUserPlaceId}');
        //                              var aa= await NewDbProvider.instance.getFloorById(placeId.toString());
        //                               print('AA  ${aa}');
        //                               floorval=null;
        //                               setState(() {
        //                                 floorQueryRows2=aa;
        //                                 floorval=returnFloorQuery(placeId);
        //                                 returnFloorQuery(placeId);
        //                               });
        //                               print('Floorqwe  ${floorQueryRows2}');
        //
        //
        //                               // qwe= ;
        //
        //                             },
        //                             // items:snapshot.data
        //                           ),
        //                         );
        //                       } else {
        //                         return Center(child:Text('Please Wait'));
        //                       }
        //                     }),
        //                 SizedBox(height:20),
        //                 FutureBuilder(
        //                     future: floorval,
        //                     builder: (context, AsyncSnapshot snapshot) {
        //                       if (snapshot.hasData) {
        //                         return Container(
        //                           width: MediaQuery.of(context).size.width * 2,
        //                           decoration: BoxDecoration(
        //                               color: Colors.white,
        //                               boxShadow: [
        //                                 BoxShadow(
        //                                     color: Colors.black,
        //                                     blurRadius: 30,
        //                                     offset: Offset(20, 20))
        //                               ],
        //                               border: Border.all(
        //                                 color: Colors.black,
        //                                 width: 0.5,
        //                               )),
        //                           child: DropdownButtonFormField(
        //                             decoration: InputDecoration(
        //                               contentPadding: const EdgeInsets.all(15),
        //                               focusedBorder: OutlineInputBorder(
        //                                 borderSide:
        //                                 BorderSide(color: Colors.white),
        //                                 borderRadius: BorderRadius.circular(10),
        //                               ),
        //                               enabledBorder: UnderlineInputBorder(
        //                                 borderSide:
        //                                 BorderSide(color: Colors.black),
        //                                 borderRadius: BorderRadius.circular(50),
        //                               ),
        //                             ),
        //
        //                             dropdownColor: Colors.white70,
        //                             icon: Icon(Icons.arrow_drop_down),
        //                             iconSize: 28,
        //                             hint: Text('Select Floor'),
        //                             isExpanded: true,
        //                             style: TextStyle(
        //                               color: Colors.black,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                             items: floorQueryRows2.map((selectedFloor) {
        //                               return DropdownMenuItem(
        //                                 value: selectedFloor.toString(),
        //                                 child: Text("${selectedFloor['f_name']}"),
        //                               );
        //                             }).toList(),
        //                             onChanged: (selectedFloor)async {
        //                               print('Floor selected $selectedFloor');
        //                               var floorId=selectedFloor.substring(7,14);
        //                               assignTempUserPlaceId=null;
        //                               assignFloorId=floorId;
        //                               var getFlat= await NewDbProvider.instance.getFlatByFId(floorId.toString());
        //                               print(getFlat);
        //                               setState(() {
        //                                 flatVal=returnFlatQuery(floorId);
        //                                 flatQueryRows2=getFlat;
        //
        //                               });
        //                               print('forRoom  ${roomQueryRows2}');
        //
        //
        //
        //                               returnFloorQuery(floorId);
        //
        //                             },
        //                             // items:snapshot.data
        //                           ),
        //                         );
        //                       } else {
        //                         return CircularProgressIndicator();
        //                       }
        //                     }),
        //                 SizedBox(height:20),
        //                 FutureBuilder(
        //                     future: flatVal,
        //                     builder: (context, AsyncSnapshot snapshot) {
        //                       if (snapshot.hasData) {
        //                         return Container(
        //                           width: MediaQuery.of(context).size.width * 2,
        //                           decoration: BoxDecoration(
        //                               color: Colors.white,
        //                               boxShadow: [
        //                                 BoxShadow(
        //                                     color: Colors.black,
        //                                     blurRadius: 30,
        //                                     offset: Offset(20, 20))
        //                               ],
        //                               border: Border.all(
        //                                 color: Colors.black,
        //                                 width: 0.5,
        //                               )),
        //                           child: DropdownButtonFormField(
        //                             decoration: InputDecoration(
        //                               contentPadding: const EdgeInsets.all(15),
        //                               focusedBorder: OutlineInputBorder(
        //                                 borderSide:
        //                                 BorderSide(color: Colors.white),
        //                                 borderRadius: BorderRadius.circular(10),
        //                               ),
        //                               enabledBorder: UnderlineInputBorder(
        //                                 borderSide:
        //                                 BorderSide(color: Colors.black),
        //                                 borderRadius: BorderRadius.circular(50),
        //                               ),
        //                             ),
        //
        //                             dropdownColor: Colors.white70,
        //                             icon: Icon(Icons.arrow_drop_down),
        //                             iconSize: 28,
        //                             hint: Text('Select Flat'),
        //                             isExpanded: true,
        //                             style: TextStyle(
        //                               color: Colors.black,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                             items: flatQueryRows2.map((selectedFlat) {
        //                               return DropdownMenuItem(
        //                                 value: selectedFlat.toString(),
        //                                 child: Text("${selectedFlat['flt_name']}"),
        //                               );
        //                             }).toList(),
        //                             onChanged: (selectedFlat)async {
        //                               print('Flat selected $selectedFlat');
        //                               var flatId=selectedFlat.substring(9,16);
        //                               assignFloorId=null;
        //                               assignFlatId=flatId;
        //                               print(flatId);
        //                               var  aa= await NewDbProvider.instance.getRoomById(flatId.toString());
        //                               print('AA  ${aa}');
        //                               setState(() {
        //                                 roomQueryRows2=aa;
        //                                 roomVal=returnRoomQuery(flatId);
        //                               });
        //                               print('forRoom  ${roomQueryRows2}');
        //
        //
        //
        //                               // returnFloorQuery(floorId);
        //
        //                             },
        //                             // items:snapshot.data
        //                           ),
        //                         );
        //                       } else {
        //                         return CircularProgressIndicator();
        //                       }
        //                     }),
        //
        //                 SizedBox(height:20),
        //                 FutureBuilder(
        //                     future: roomVal,
        //                     builder: (context, AsyncSnapshot snapshot) {
        //                       if (snapshot.hasData) {
        //                         return Container(
        //                           width: MediaQuery.of(context).size.width * 2,
        //                           decoration: BoxDecoration(
        //                               color: Colors.white,
        //                               boxShadow: [
        //                                 BoxShadow(
        //                                     color: Colors.black,
        //                                     blurRadius: 30,
        //                                     offset: Offset(20, 20))
        //                               ],
        //                               border: Border.all(
        //                                 color: Colors.black,
        //                                 width: 0.5,
        //                               )),
        //                           child: DropdownButtonFormField<String>(
        //                             decoration: InputDecoration(
        //                               contentPadding: const EdgeInsets.all(15),
        //                               focusedBorder: OutlineInputBorder(
        //                                 borderSide:
        //                                 BorderSide(color: Colors.white),
        //                                 borderRadius: BorderRadius.circular(10),
        //                               ),
        //                               enabledBorder: UnderlineInputBorder(
        //                                 borderSide:
        //                                 BorderSide(color: Colors.black),
        //                                 borderRadius: BorderRadius.circular(50),
        //                               ),
        //                             ),
        //                             dropdownColor: Colors.white70,
        //                             icon: Icon(Icons.arrow_drop_down),
        //                             iconSize: 28,
        //                             hint: Text('Select Room'),
        //                             isExpanded: true,
        //                             style: TextStyle(
        //                               color: Colors.black,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //
        //                             items:  roomQueryRows2.map((selectedRoom) {
        //
        //                               return DropdownMenuItem<String>(
        //                                 value: selectedRoom.toString(),
        //                                 child: Text("${selectedRoom['r_name']}"),
        //                               );
        //                             }).toList(),
        //                             onChanged: (selectedRoom)async {
        //                               assignFlatId=null;
        //                               var roomId=selectedRoom.substring(7,14);
        //                               assignRoomId=roomId;
        //                               print('roomId ${roomId}');
        //                               var  aa= await NewDbProvider.instance.getDeviceByRId(roomId.toString());
        //                               print('deviceQueryRows ${aa}');
        //                               setState(() {
        //                                 // deviceQueryRows2=aa;
        //                                 // deviceVal=returnDeviceQuery(roomId);
        //                               });
        //                               print('DeviceCheck  ${aa}');
        //                             },
        //                             // items:snapshot.data
        //                           ),
        //                         );
        //                       } else {
        //                         return CircularProgressIndicator();
        //                       }
        //                     }),
        //                 FlatButton(
        //                     child: Text(
        //                       'Submit',
        //                       style: TextStyle(
        //                         color: Colors.white,
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                     shape: OutlineInputBorder(
        //                       borderSide:
        //                       BorderSide(color: Colors.white, width: 2),
        //                       borderRadius: BorderRadius.circular(90),
        //                     ),
        //                     padding: const EdgeInsets.all(15),
        //                     textColor: Colors.white,
        //                     onPressed: ()async {
        //                       print("assignTempUserPlaceId->  ${assignTempUserPlaceId}");
        //                       print("assignTempUserFloorId->  ${assignFloorId}");
        //                       print("assignTempUserRooId->  ${assignRoomId}");
        //                       await goToNextPage();
        //                       // await addSubUser(emailController.text);
        //
        //                       // Navigator.of(context).pop();
        //
        //
        //                       // await floorVal;
        //                       // goToNextPage();
        //                     }),
        //
        //
        //
        //
        //
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}


class TempUSerRequirementDetails {
  var email;
  var pno;

  var name;

  var ownerName;

  DateTime date;
  TimeOfDay time;


}