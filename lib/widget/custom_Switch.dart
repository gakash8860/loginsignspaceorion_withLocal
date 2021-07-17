import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // to add the material theme


import 'package:url_launcher/url_launcher.dart'; // to send SMS, call, email, URL
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:custom_switch/custom_switch.dart';
import 'package:connectivity/connectivity.dart'


    show Connectivity, Platform; // to check the platform on which system is running

void main() {
  runApp(
    new MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: new CheckInternetHome(),
    );
  }

}

class CheckInternetHome extends StatefulWidget {
  CheckInternetHome({Key key}) : super(key: key);

  @override
  _CheckInternetHomeState createState() => _CheckInternetHomeState();
}

class _CheckInternetHomeState extends State<CheckInternetHome> {
  bool _switchValue=true;





  _showDialog(tittle ,text) {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(tittle),
        content: Text(text),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
          },
              child: Text('Ok')
          )
        ],
      );
    },);
  }

  _checkInternetConnectivity()async{
    var result= await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.none){
      messageSms(context);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) => new Scaffold(

    appBar: new AppBar(
      title: new Text("Launchers"),
    ),
    body: SingleChildScrollView(
      child: new Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: TextButton.icon(
                          icon: Icon(Icons.add_to_home_screen),
                          label: Text(
                            "Open Website",
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () => launch("https://www.genorion.com"),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextButton.icon(
                        icon: Icon(Icons.call),
                        label: Text(
                          "Make a Call",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () => launch("tel://9911757588"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextButton.icon(
                          icon: Icon(Icons.email),
                          label: Text("Send a Email",
                              style: TextStyle(fontSize: 25)),
                          onPressed: () {
                            emailMessage(context);
                          }
                        // => launch(
                        //       "mailto:contact@genorion.com?subject=Hi&body=How are_you%20plugin"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextButton.icon(
                          icon: Icon(Icons.sms),
                          label: Text("Write a SMS",
                              style: TextStyle(fontSize: 25)),
                          onPressed: () {
                            // if (Platform.isAndroid) {
                            //   launch("sms:" + recipents + "?body=" + message);
                            // } else if (Platform.isIOS) {
                            //   launch("sms:" + recipents + "&body=" + message);
                            // }
                            messageSms(context);
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              CustomSwitch(
                value: _switchValue,
                onChanged: (newValue){
                  setState(() {
                    _switchValue=newValue;
                    switch_Value();
                  });
                },
                activeColor: Color(0xff457be4),
                // onChanged:_switchChanged,
              ),
              ElevatedButton(
                  child: Text('OK'),
                  onPressed: (){
                switch_Value();
              }),

            ],
          ),
        ),
      ),
    ),
  );
}



// ignore: non_constant_identifier_names
switch_Value() async {
  // String query1='1';
  // var query = {'d_id': query1};
  var url1='https://genorion1234.herokuapp.com/devicePinStatus/?d_id=2';
  // final url = Uri.https('genorion1234.herokuapp.com', '/devicePinStatus/?d_id=1',query);
  String token='ecc609cd9b5a54b72b972ac42ba56a38cab39732';
  int plaVariable=1;
  final response = await http.post(
    url1,
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'put': 'no',
      'd_id': '2',
      'pin1status':'1',
      'pin2status':'2',
      'pin3status':'6',
      'pin4status':'9',
      'pin5status':'5',
      'pin6status':'5',
      'pin7status':'7',
      'pin8status':'2',
      'pin9status':'7',
      'pin10status':'6',
      'pin11status':'5',
      'pin12status':'9',
      'pin13status':'9',
      'pin14status':'9',
      'pin15status':'5',
      'pin16status':'2',
      'pin17status':'1',
      'pin18status':'0',
      'pin19status':'7',
      'pin20status':'9',


      //'user': '1',
    }),
  );

  if (response.statusCode == 201) {
    final String res=response.body;
    print(response.body);
    print(response.statusCode);
    return '1';

  } else {
    print(response.statusCode);
    print(response.body);
    return 'null';

  }

}
var recipents = "9911757588";
var message = "This_is_time";
var messageIOS = "This_is%20time";

void messageSms(BuildContext context) {
  if (Platform.isAndroid) {
    launch("sms:" + recipents + "?body=" + message);
  } else if (Platform.isIOS) {
    launch("sms:" + recipents + "&body=" + messageIOS);
  }
}

var recipentEmail = "contact@genorion.com";
var emailSubject = "heyy";
var emailBody = "hello how are you%20plugin";
var emailBodyIOS = "hello_how_are_you%20plugin";

void emailMessage(BuildContext context) {
  if (Platform.isAndroid) {
    launch("mailto:" +
        recipentEmail +
        "?subject=" +
        emailSubject +
        "&body=" +
        emailBody);
  } else if (Platform.isIOS) {
    launch("mailto:" +
        recipentEmail +
        "?subject=" +
        emailSubject +
        "&body=" +
        emailBodyIOS);
  }
}
