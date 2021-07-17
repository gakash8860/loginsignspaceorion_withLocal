import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:http/http.dart' as http;

import 'nextPage.dart';
  class EmergencyNumber extends StatefulWidget {
    final deviceId;

    const EmergencyNumber({Key key, this.deviceId}) : super(key: key);

  @override
  _EmergencyNumberState createState() => _EmergencyNumberState();
}

class _EmergencyNumberState extends State<EmergencyNumber> {
  TextEditingController phoneController= new TextEditingController();
  EmergencyRequirementField emergencyRequirementField = new EmergencyRequirementField();
final storage= new FlutterSecureStorage();
  bool isVisible=false;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;



  goToNextPage() {
    setState(() {
      isVisible=true;
    });
    formKey.currentState.save();
    print('clear');
    updateEmergencyNumber(emergencyRequirementField).then((value) {
      final snackBar = SnackBar(
        content: Text('Data Sent'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextPageSSID()),
      );
    }).catchError((e) {
      print(e);
    });
  }

  var number1;
  var number2;
  var number3;
  var number4;
  var number5;
  getEmergencyNumber()async{
    String token = "0bcb23b98322c01d95211af236b4a8d029bdd9f3";
    final url = 'http://genorionofficial.herokuapp.com/getpostemergencynumber/?d_id=DIDM12932021AAAAAD';
    final response= await http.get(Uri.parse(url),headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if(response.statusCode>0){
      var q=jsonDecode(response.body);
      number1=q['number1'];
      number2=q['number2'];
      number3=q['number3'];
      number4=q['number4'];
      number5=q['number5'];
      print('number1 ->${number1}');
      print('number2 ->${number2}');
      print('number3 ->${number3}');
      print('number4 ->${number4}');
      print('number5 ->${number5}');
    }

  }
  @override
  void initState(){
    super.initState();
    getEmergencyNumber();
  }
  updateEmergencyNumber(EmergencyRequirementField data) async {
    String token =await getToken();
    print('idd ${widget.deviceId.toString()}');
    final url = 'http://genorionofficial.herokuapp.com/getpostemergencynumber/?d_id='+widget.deviceId.toString();
    var postData={
      "user":getUidVariable,
      "d_id":widget.deviceId,
      "number1":data.number1,
      "number2":data.number2,
      "number3":data.number3,
      "number4":data.number4,
      "number5":data.number5,
    };
    final response = await http.put(url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if(response.statusCode>0){
      print("Kuch Bi -->${response.body}");
    }
  }

  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }
  // updateEmergencyNumber(EmergencyRequirementField data) async {
  //   String token =await getToken();
  //   final url = 'http://genorionofficial.herokuapp.com/getpostemergencynumber/?d_id='+widget.deviceId.toString();
  //   var postData={
  //     "d_id":widget.deviceId.toString(),
  //     "user":getUidVariable,
  //
  //
  //     "number1":data.number1,
  //     "number2":data.number2,
  //     "number3":data.number3,
  //     "number4":data.number4,
  //     "number5":data.number5,
  //   };
  //   final response = await http.put(url,
  //     headers: {
  //       'Authorization': 'Token $token',
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(postData),
  //   );
  //   if(response.statusCode>0){
  //     print("Kuch Bi -->${response.statusCode}");
  //     print("Kuch Bi -->${response.body}");
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Emergency Number'),
        ),
      body: isVisible?Container(color: Colors.blueAccent,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),),):
      Container(
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
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            keyboardType: TextInputType.phone,
                            onSaved: (String value) {
                              print('value $value');
                              this.emergencyRequirementField.number1 = value;
                              print('AfterThis ${this.emergencyRequirementField.number1}');
                              },
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Emergency Number 1',
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
                          SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.phone,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (String value) {
                              this.emergencyRequirementField.number2 = value;
                            },
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Emergency Number 2',
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
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (String value) {
                              this.emergencyRequirementField.number3 = value;
                            },
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Emergency Number 3',
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
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (String value) {
                              this.emergencyRequirementField.number4 = value;
                            },

                            style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Emergency Number 4',

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
                          // TextFormField(
                          //   autofocus: true,
                          //   textInputAction: TextInputAction.next,
                          //   onEditingComplete: () => node.nextFocus(),
                          //   autovalidateMode:
                          //   AutovalidateMode.onUserInteraction,
                          //   //validator: nameValid,
                          //   onSaved: (String value) {
                          //     this.data.username = value;
                          //   },
                          //   style:
                          //   TextStyle(fontSize: 18, color: Colors.black54),
                          //   decoration: InputDecoration(
                          //     prefixIcon: Icon(Icons.person),
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     hintText: 'username',
                          //     contentPadding: const EdgeInsets.all(15),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //       borderRadius: BorderRadius.circular(50),
                          //     ),
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //       borderRadius: BorderRadius.circular(50),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 15,),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            // autovalidateMode: AutovalidateMode.values[2],
                            // validator: validateEmail,
                            onSaved: (String value) {
                              // ignore: unnecessary_statements
                              this.emergencyRequirementField.number5= value;
                            },
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Emergency Number 5',
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

                          SizedBox(
                            height: 15,
                          ),

                          SizedBox(height: 15,),
                          // ignore: deprecated_member_use
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
                              onPressed: () {
                                goToNextPage();
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


class EmergencyRequirementField {
  String number1 = "";
  String number2 = "";
  String number3 = "";
  String number4 = "";
  String number5 = "";




}