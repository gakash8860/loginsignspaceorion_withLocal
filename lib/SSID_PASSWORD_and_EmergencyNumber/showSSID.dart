import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/SSID_PASSWORD_and_EmergencyNumber/SSID.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart ' as http;

import '../changeFont.dart';
import '../main.dart';
import 'EmergencyNmber.dart';


void main()=>runApp(
    MaterialApp(
        home:ShowSsid()
    )
);

class ShowSsid extends StatefulWidget {

  final deviceId;

  const ShowSsid({Key key, this.deviceId}) : super(key: key);
  @override
  _ShowSsidState createState() => _ShowSsidState();
}

class _ShowSsidState extends State<ShowSsid> {

  var statusDecode;
  var ipDecode;
  Box ssidNumberBox;
  final storage= new FlutterSecureStorage();
  Timer timer;
  @override
  void initState(){
    super.initState();
    getSSID();
    timer=Timer.periodic(Duration(seconds: 1), (timer) { });
  }


  Future openSsideBox()async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    ssidNumberBox=await Hive.openBox('status');

    return;
  }
  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }
  List statusData=[];


  Future putSSID(data)async{
    await ssidNumberBox.clear();
    for(var d in data){

      ssidNumberBox.add(d);
    }

  }




  Future<bool> getSSID()async{
    await openSsideBox();
    String token = await getToken();
    final url = API+'ssidpassword/?d_id='+widget.deviceId.toString();
    var response;
    try{
      response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });



      statusDecode=jsonDecode(response.body);
      statusData=[
        statusDecode['ssid1'],
        statusDecode['password1'],
        statusDecode['ssid2'],
        statusDecode['password2'],
        statusDecode['ssid3'],
        statusDecode['password3'],


      ];
      print('ssidpassword->  ${statusData[0]}');


      await putSSID(statusData);


    }catch(e){
      // print('Status Exception $e');

    }

    var myMap=ssidNumberBox.toMap().values.toList();
    if(myMap.isEmpty){
      ssidNumberBox.add('empty');

    }else{
      statusData=myMap ;

    }
    return Future.value(true);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SSID '),
      ),
      body:  Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent])),
        child:Container(
          color: Colors.green,
          height: 789,
          width:MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: getSSID(),
              builder: ( context,  snapshot){
                if(snapshot.hasData){
                  if(statusData.contains('empty')){
                    return Text('No data');
                  }else{
                    return Column(
                      children: [

                        Expanded(child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context,index){
                              return Column(
                                children: <Widget>[
                                  SizedBox(height: 70,),
                                  Text('SSID Number',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: fonttest==null?changeFont:fonttest,),),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      SizedBox(width: 55,),
                                       Text('SSID1',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
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
                                      SizedBox(width: 25,),
                                      Text('Password 1',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
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
                                      Text('SSID2',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
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
                                      SizedBox(width: 25,),
                                      Text('Password 2',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
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
                                      Text('SSID3',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
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
                                      SizedBox(width: 25,),
                                      Text('Password 3',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
                                      SizedBox(width: 15,),
                                      Container(
                                        height: 45,
                                        width: 195,
                                        child:Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(statusData[5].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
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

                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SSID(deviceId: dv[index].dId,)));
                                  }, child: Text('Edit')),

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
