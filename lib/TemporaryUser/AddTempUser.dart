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
  TempUSerRequirementDetails tempUSerRequirementDetails= new TempUSerRequirementDetails();
  FloorType fl;
  Future placeVal;
  var cutTime;
  var cutDate;
  List<Map<String, dynamic>> floorQueryRows2;
  List<Map<String, dynamic>> floorQueryRows;
  List<Map<String, dynamic>> queryRows;
  var floorval;

  var assignFloorId;

  DateTime pickedDate;
  TimeOfDay pickedTime;


  @override
  void initState() {
    super.initState();
    pickedDate=DateTime.now();
    pickedTime=TimeOfDay.now();
    placeVal=returnPlaceQuery();
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowTempUser()),
      );
    }).catchError((e) {
      print(e);
    });
  }


  Future addTempUser(TempUSerRequirementDetails data)async{
    String token = 'aea5b178d26513ea6c5f0edc5f09377a3a958c22';
    final url='http://genorion1.herokuapp.com/giveaccesstotempuser/';
    var postData={
      "name": data.name.toString(),
      "user": 1,
      // "p_id":assignTempUserPlaceId.toString(),
      "email":data.email.toString(),
      "mobile":data.pno.toString(),
      "timing":cutTime.toString(),
      "date":cutDate.toString(),
      "f_id":"",
      "r_id":"",
      "d_id":""
    };
    print('aaaaaa ${postData}');
    final response= await http.post(Uri.parse(url),
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
      }else{

      }
      print('AddTempUserCode  ${response.statusCode}');
    }
  }




  Future returnPlaceQuery()async{
     return NewDbProvider.instance.queryPlace();

    }
  Future placeQueryFunc()async{
    queryRows =
    await NewDbProvider.instance.queryPlace();
    print('qwe123 $queryRows');

  }



  pickDate()async{
    DateTime date=  await showDatePicker(
        context: context,
        initialDate: pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if(date!=null){
      setState(() {
        pickedDate = date;
      });
    }
    String date2=pickedDate.toString();
    cutDate=date2.substring(0,10);
    print('pickedDate ${pickedDate}');
    print('pickedDate ${cutDate}');
  }


  pickTime()async{
    TimeOfDay time=  await showTimePicker(
        context: context,
        initialTime: pickedTime
    );
    if(time!=null){
      setState(() {
        pickedTime = time;
      });

    }
String se= pickedTime.toString();
    cutTime=se.substring(10,15);
    print('pickedTime ${pickedTime.toString()}');
    print('pickedTime ${cutTime}');
  }







  Future returnFloorQuery(String pId){

    return NewDbProvider.instance.queryFloor();
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
                          SizedBox(height: 10,),
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
                          SizedBox(height: 10,),
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
                              height: MediaQuery.of(context).size.height/18,
                              width: MediaQuery.of(context).size.width/1.8,
                              child: Card(
                                child: GestureDetector(
                                  onTap: pickDate,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                      child: Text("Date:${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",textAlign: TextAlign.start,)
                                  ),
                                ),)),
                          Container(
                              height: MediaQuery.of(context).size.height/18,
                              width: MediaQuery.of(context).size.width/1.8,
                              child: Card(
                                child: GestureDetector(
                                  onTap: pickTime,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Time :${pickedTime.hour}:${pickedTime.minute}",textAlign: TextAlign.start,)
                                  ),
                                ),)),

                          FutureBuilder(
                              future: placeVal,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width * 2,
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
                                        contentPadding: const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black),
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

                                      items: queryRows.map((selectedPlace) {

                                        return DropdownMenuItem<String>(
                                          value: selectedPlace.toString(),
                                          child: Text("${selectedPlace['p_type']}"),
                                        );
                                      }).toList(),
                                      onChanged: (selectedPlace)async {
                                        floorval=null;
                                        // floorQueryRows2=null;
                                        // print('Floorqwe  ${floorQueryRows2}');
                                        var placeId=selectedPlace.substring(7,14);
                                        assignTempUserPlaceId=placeId;
                                       var aa= await NewDbProvider.instance.getFloorById(placeId.toString());
                                        print('AA  ${aa}');
                                        floorval=null;
                                        setState(() {
                                          floorQueryRows2=aa;
                                          floorval=returnFloorQuery(placeId);
                                          returnFloorQuery(placeId);
                                        });
                                        print('Floorqwe  ${floorQueryRows2}');


                                        // qwe= ;

                                      },
                                      // items:snapshot.data
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                          SizedBox(height: 10,),
                          FutureBuilder(
                              future: floorval,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width * 2,
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
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.circular(50),
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
                                      items: floorQueryRows2.map((selectedFloor) {
                                        return DropdownMenuItem(
                                          value: selectedFloor.toString(),
                                          child: Text("${selectedFloor['f_name']}"),
                                        );
                                      }).toList(),
                                      onChanged: (selectedFloor)async {
                                        print('Floor selected $selectedFloor');
                                        var floorId=selectedFloor.substring(7,14);

                                        var  aa= await NewDbProvider.instance.getRoomById(floorId.toString());
                                        print('AA  ${aa}');
                                        setState(() {
                                          // roomQueryRows2=aa;
                                          // roomVal=returnRoomQuery(floorId);
                                        });
                                        // print('forRoom  ${roomQueryRows2}');



                                        returnFloorQuery(floorId);

                                      },
                                      // items:snapshot.data
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                          SizedBox(height: 20,),
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
  DateTime date;
  TimeOfDay time;


}