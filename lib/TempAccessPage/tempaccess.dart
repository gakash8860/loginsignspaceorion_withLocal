import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/TempAccessPage/tempacccessroomPage.dart';
import 'package:loginsignspaceorion/TempAccessPage/tempaccessdevicepage.dart';
import 'package:loginsignspaceorion/TempAccessPage/tempaccessflatpage.dart';
import 'package:loginsignspaceorion/TempAccessPage/tempaccessfloor.dart';
import 'package:loginsignspaceorion/TempAccessPage/tempaccessmodels.dart';
import 'package:loginsignspaceorion/TempAccessPage/tempacessplace.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';

import '../main.dart';

void main() => runApp(MaterialApp(
      home: TempAccessPage(),
    ));

class TempAccessPage extends StatefulWidget {
  @override
  _TempAccessPageState createState() => _TempAccessPageState();
}

class _TempAccessPageState extends State<TempAccessPage> {
  var ownerName;
  var listOfFloorId;
  List data;
  Box tempUserBox;
  Future tem;
  Future getTempFuture;
  @override
  void initState() {
    super.initState();
    print('initState123');
    getTempUsers();
    getPlaceName();
  }

  @override
  void dispose(){
    super.dispose();
    // print('dispose');
    getTempUsers();
  }


  TempUser tempUser;

  List tempUserDecodeList;
  List tempUserDecode;

  Future openTempUserBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    tempUserBox = await Hive.openBox('tempUser');
    print('tempUserBoxLength  ${tempUserBox.length}');
    return;
  }

  Future<void> getTempUsers() async {
    String token = await getToken();
    await openTempUserBox();

    final url = API+'giveaccesstotempuser/?mobile=7042717549';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      await tempUserBox.clear();

       tempUserDecode = jsonDecode(response.body);

      print('tempResponse ${tempUserDecode}');
      setState(() {
        tempUserDecodeList = tempUserDecode;
        putTempUser(tempUserDecodeList);
      });
      print('tempUserDecode ${tempUserDecodeList.length}');
      print('Number1123->  ${tempUserDecodeList}');
    } catch (e) {
      // print('Status Exception $e');

    }

    var myMap = tempUserBox.toMap().values.toList();
    if (myMap.isEmpty) {
      tempUserBox.add('empty');
    } else {
      tempUserDecodeList = myMap;
    }
    return Future.value(true);
  }

  Future putTempUser(data) async {
    await tempUserBox.clear();
    for (var d in data) {
      tempUserBox.add(d);
    }
  }


var pId;
  List<String> placeName;
  Future getPlaceName() async {
    String token = await getToken();
    print('tempUserDecodeList ${tempUserDecode.length}');
    for(int i=0;i<tempUserDecodeList.length;i++){
      pId=tempUserDecodeList[i]['p_id'].toString();
      final url = API+'getyouplacename/?p_id='+ pId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print("GetPlaceName  ${response.statusCode}");
        print("GetPlaceNameResponseBody  ${response.body}");
        List<dynamic> data = jsonDecode(response.body);

      }
    }

  }














var NoPlace='NoPlace';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temp Access Page'),
      ),
      body: RefreshIndicator(
        onRefresh: getTempUsers,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.lightBlueAccent])),
            child: Container(
              // color: Colors.green,
              // height: 789,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                  future: getTempUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (tempUserDecodeList.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 250,
                            ),
                            Center(
                                child: Text(
                              'Sorry we cannot find any Temp User please add',
                              style: TextStyle(fontSize: 18),
                            )),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: tempUserDecodeList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          semanticContainer: true,
                                          shadowColor: Colors.grey,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                onTap: (){
                                                  if(tempUserDecodeList[index]['p_id']!=null){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TempAccessPlacePage(
                                                      placeId: tempUserDecodeList[index]['p_id'].toString(),
                                                      ownerName: tempUserDecodeList[index]['owner_name'].toString(),
                                                    )));
                                                  }else if(tempUserDecodeList[index]['f_id']!=null){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TempAccessFloorPage(
                                                      floorId: tempUserDecodeList[index]['f_id'].toString(),
                                                      ownerName: tempUserDecodeList[index]['owner_name'].toString(),
                                                    )));
                                                  }else if(tempUserDecodeList[index]['flt_id']!=null){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TempAccessFlatPage(
                                                      flatId: tempUserDecodeList[index]['flt_id'].toString(),
                                                      ownerName: tempUserDecodeList[index]['owner_name'].toString(),
                                                    )));
                                                  }else if(tempUserDecodeList[index]['r_id']!=null){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TempAccessRoomPage(
                                                   ownerName: tempUserDecodeList[index]['owner_name'].toString(),
                                                      roomId: tempUserDecodeList[index]['r_id'],
                                                    )));
                                                  }else if(tempUserDecodeList[index]['d_id']!=null){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TempAccessDevicePage(
                                                      ownerName: tempUserDecodeList[index]['owner_name'].toString(),
                                                      deviceId: tempUserDecodeList[index]['d_id'],
                                                    )));
                                                  }


                                                },
                                                title: Text(
                                                    tempUserDecodeList[index]
                                                        ['name']),
                                                trailing: Text(
                                                    tempUserDecodeList[index]
                                                        ['email']),
                                                subtitle: Text(
                                                    tempUserDecodeList[index]
                                                            ['timing']
                                                        .toString()),

                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    tempUserDecodeList[index]
                                                            ['date']
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    tempUserDecodeList[index]
                                                            ['mobile']
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                              // Container(
                                              //   color: Colors.red,
                                              //   height: 45,
                                              //   child: ListView.builder(
                                              //     itemCount: 1,
                                              //       itemBuilder: (context,index){
                                              //         if(tempUserDecodeList[index]['p_id']!=null){
                                              //           return Row(
                                              //             children: [
                                              //               Text(tempUserDecodeList[index]['p_id'].toString()),
                                              //             ],
                                              //           );
                                              //         }else if(tempUserDecodeList[index]['f_id']!=null){
                                              //           return Row(
                                              //             children: [
                                              //               Text(tempUserDecodeList[index]['_id'].toString()),
                                              //             ],
                                              //           );
                                              //         }else{return null;}
                                              //   }
                                              //   ),
                                              //
                                              // ),
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   tempUserDecodeList[index]
                                                  //           ['f_id']
                                                  //       .toString(),
                                                  //   textAlign: TextAlign.end,
                                                  // ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),

                                                  Text(
                                                    tempUserDecodeList[index]['p_id'].toString()==null?NoPlace:tempUserDecodeList[index]['p_id'].toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    tempUserDecodeList[index]
                                                    ['f_id']
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    tempUserDecodeList[index]
                                                    ['flt_id']
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    tempUserDecodeList[index]
                                                    ['r_id']
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),

                                                  Text(
                                                    tempUserDecodeList[index]
                                                    ['d_id']
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    tempUserDecodeList[index]
                                                            ['owner_name']
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );

                                      //   Column(
                                      //   children: <Widget>[
                                      //     SizedBox(height: 100,),
                                      //     Text('Sub User List',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      //     SizedBox(height: 15,),
                                      //     Row(
                                      //       children: [
                                      //         SizedBox(width: 55,),
                                      //         Text('Number 1',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                      //         SizedBox(width: 15,),
                                      //         Container(
                                      //           height: 45,
                                      //           width: 195,
                                      //           child:Padding(
                                      //             padding: const EdgeInsets.all(8.0),
                                      //             child: Text(subUserDecode[0]['email'].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                      //           ),
                                      //           decoration: BoxDecoration(
                                      //             color: Colors.white,
                                      //             border: Border.all(
                                      //               color: Colors.black38 ,
                                      //               width: 5.0 ,
                                      //             ),
                                      //             borderRadius: BorderRadius.circular(20),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //
                                      //
                                      //   ],
                                      //
                                      //   // trailing: Text("Place Id->  ${statusData[index]['d_id']}"),
                                      //   // subtitle: Text("${statusData[index]['id']}"),
                                      //
                                      // );
                                    })),
                          ],
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          semanticsLabel: 'Loading...',
                        ),
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
