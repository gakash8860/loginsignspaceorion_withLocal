import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart ' as http;

import '../changeFont.dart';
import '../dropdown2.dart';
import '../main.dart';
import 'EmergencyNmber.dart';


void main()=>runApp(
  MaterialApp(
    home:ShowEmergencyNumber()
  )
);

class ShowEmergencyNumber extends StatefulWidget {

  final deviceId;

  const ShowEmergencyNumber({Key key, this.deviceId}) : super(key: key);
  @override
  _ShowEmergencyNumberState createState() => _ShowEmergencyNumberState();
}

class _ShowEmergencyNumberState extends State<ShowEmergencyNumber> {

  var statusDecode;
  var ipDecode;
  Box emergencyNumberBox;
  final storage= new FlutterSecureStorage();
  Timer timer;
  @override
  void initState(){
    super.initState();

timer=Timer.periodic(Duration(seconds: 1), (timer) {getEmergencyNumber2();  getEmergencyNumber(); });
  }


  Future openEmergencyNumberBox()async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    emergencyNumberBox=await Hive.openBox('status');

    return;
  }
  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }
  List statusData=[];


  Future putPinStatus(data)async{
    await emergencyNumberBox.clear();
    for(var d in data){

      emergencyNumberBox.add(d);
    }

  }




  Future<bool> getEmergencyNumber()async{
    await openEmergencyNumberBox();
    String token = await getToken();
    final url = API+'getpostemergencynumber/?d_id='+widget.deviceId.toString();
    try{
     final response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if(response.statusCode>0){
        print('number1Emergency ${response.statusCode}');
      }
      statusDecode=jsonDecode(response.body);
      statusData=[
        statusDecode['number1'],
        statusDecode['number2'],
        statusDecode['number3'],
        statusDecode['number4'],
        statusDecode['number5'],

      ];
      print('Number1123->  ${statusData[0]}');


      await putPinStatus(statusData);


    }catch(e){
      // print('Status Exception $e');

    }

    var myMap=emergencyNumberBox.toMap().values.toList();
    if(myMap.isEmpty){
      emergencyNumberBox.add('empty');

    }else{
      statusData=myMap ;

    }
    return Future.value(true);
  }



  var number1;
  var number2;
  var number3;
  var number4;
  var number5;
  getEmergencyNumber2()async{
    String token = await getToken();
    final url = API+'getpostemergencynumber/?d_id='+widget.deviceId.toString();
    final response= await http.get(Uri.parse(url),headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if(response.statusCode>0){
      print('code  ${response.statusCode}');
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Number',style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
      ),
      body:  Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent])),
        child:Container(
          // color: Colors.green,
          height: 789,
          width:MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: getEmergencyNumber(),
              builder: ( context,  snapshot){
                if(snapshot.hasData){
                  if(statusData.contains('empty')){
                    return Text('No data');
                  }else{
                    return Column(
                      children: [
                        SizedBox(height: 25,),
                        Expanded(child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context,index){
                              return Column(
                                children: <Widget>[
                                  SizedBox(height: 100,),
                                  Text('Emergency Number',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: fonttest==null?changeFont:fonttest,),),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      SizedBox(width: 55,),
                                      Text('Number 1',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                      SizedBox(width: 15,),
                                      Container(
                                        height: 45,
                                        width: 195,
                                        child:Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(statusData[0].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black38 ,
                                            width: 5.0 ,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      SizedBox(width: 55,),
                                      Text('Number 2',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                      SizedBox(width: 15,),
                                      Container(
                                        height: 45,
                                        width: 195,
                                        child:Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(statusData[1].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black38 ,
                                            width: 5.0 ,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      SizedBox(width: 55,),
                                      Text('Number 3',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                      SizedBox(width: 15,),
                                      Container(
                                        height: 45,
                                        width: 195,
                                        child:Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(statusData[2].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black38 ,
                                            width: 5.0 ,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      SizedBox(width: 55,),
                                      Text('Number 4',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                      SizedBox(width: 15,),
                                      Container(
                                        height: 45,
                                        width: 195,
                                        child:Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(statusData[3].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black38 ,
                                            width: 5.0 ,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      SizedBox(width: 55,),
                                      Text('Number 5',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                      SizedBox(width: 15,),
                                      Container(
                                        height: 45,
                                        width: 195,
                                        child:Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(statusData[4].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black38 ,
                                            width: 5.0 ,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      SizedBox(width: 175,),

                                      SizedBox(width: 15,),
                                      ElevatedButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyNumber(deviceId: dv[index].dId,)));
                                      }, child: Text('Edit')),
                                    ],
                                  ),

                                ],

                                // trailing: Text("Place Id->  ${statusData[index]['d_id']}"),
                                // subtitle: Text("${statusData[index]['id']}"),

                              );
                            }
                        ))

                      ],
                    );
                  }
                }else{
                  return CircularProgressIndicator();
                }

              }

          ),
        ),
      ),
    );
  }
}
