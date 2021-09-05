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
  var mobileNumber;
  TempAccessPage({Key key,
    this.mobileNumber,
  });
  @override
  _TempAccessPageState createState() => _TempAccessPageState();
}

class _TempAccessPageState extends State<TempAccessPage> {
  var ownerName;
  var listOfFloorId;
  List data;
  Box tempUserBox;
  Box tempUserPlaceNameBox;
  Future tem;
  Future getTempFuture;

  List placeNameList;
  List<dynamic> floorNameList=[];
  List<dynamic> flatNameList=[];
  List<dynamic> roomNameList=[];
  @override
  void initState() {
    super.initState();
    print('initState123 ${widget.mobileNumber}');
    getTempUsers().then((value) => getPlaceName().then((value) =>  getFloorName().then((value) => getFlatName()).then((value) => getRoomName())));

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
  List tempUserPlaceNameDecode;

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

    final url = API+'giveaccesstotempuser/?mobile='+widget.mobileNumber;
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
  List tempUserDecodeListNames;
  List <PlaceNameModelsForTempUSer> placeName;




  Future getPlaceName() async {
    String token = "a039b535792f99ee21d34dc544caad703cb7f78e";
    for(int i=0;i<tempUserDecodeList.length;i++){
      pId=tempUserDecodeList[i]['p_id'];
      print('checkPlaceId $pId');
      if(pId!=null){
        final url = API+'getyouplacename/?p_id='+ pId;
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
        if (response.statusCode > 0) {
          print("GetPlaceName  ${response.statusCode}");
          print("GetPlaceNameResponseBody  ${response.body}");
          var data = jsonDecode(response.body);
          placeNameList=data;
          // setState(() {
          //   placeName=data.map((data) =>PlaceNameModelsForTempUSer.fromJson(data));
          // });
          print("GetPlaceNameResponseBodynames ${placeNameList}");

        }
      }else{
        return;
      }


    }
    

  }

  Future getFloorName() async {
    String token = "a039b535792f99ee21d34dc544caad703cb7f78e";
    for(int i=0;i<tempUserDecodeList.length;i++){
     var fId=tempUserDecodeList[i]['f_id'];
      print('checkFloorId $fId');
      if(fId!=null){
        final url = API+'getyoufloorname/?f_id='+ fId;
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
        if (response.statusCode > 0) {
          print("GetFloorName  ${response.statusCode}");
          print("GetFloorNameResponseBody  ${response.body}");
          var data = jsonDecode(response.body);
          floorNameList=data;
          // setState(() {
          //   placeName=data.map((data) =>PlaceNameModelsForTempUSer.fromJson(data));
          // });
          print("GetFloorNameResponseBodynames ${floorNameList[0]['f_name']}");

        }
      }else{

      }


    }

  }


  Future getFlatName() async {
    String token = "a039b535792f99ee21d34dc544caad703cb7f78e";
    for(int i=0;i<tempUserDecodeList.length;i++){
      var flatId=tempUserDecodeList[i]['flt_id'];
      print('checkFloorId $flatId');
      if(flatId!=null){
        final url = API+'getyouflatname/?flt_id='+ flatId;
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
        if (response.statusCode > 0) {
          print("getyouflatname  ${response.statusCode}");
          print("getyouflatname  ${response.body}");
          var data = jsonDecode(response.body);
          flatNameList=data;
          // setState(() {
          //   placeName=data.map((data) =>PlaceNameModelsForTempUSer.fromJson(data));
          // });
          print("getyouflatname ${flatNameList[0]['f_name']}");

        }
      }else{

      }


    }

  }
  
  Future getRoomName() async {
    String token = "a039b535792f99ee21d34dc544caad703cb7f78e";
    for(int i=0;i<tempUserDecodeList.length;i++){
      var rId=tempUserDecodeList[i]['r_id'];
      print('checkRoomId $rId');
      if(rId!=null){
        final url = API+'getyouroomname/?r_id='+ rId;
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });
        if (response.statusCode > 0) {
          print("getyouroomname  ${response.statusCode}");
          print("getyouroomname  ${response.body}");
          var data = jsonDecode(response.body);
          roomNameList=data;
          // setState(() {
          //   placeName=data.map((data) =>PlaceNameModelsForTempUSer.fromJson(data));
          // });
          print("GetFloorNameResponseBodynames ${roomNameList[0]['r_name']}");

        }
      }else{

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
                      // getPlaceName();
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
                                      // print('tempUserDecodeListNames14785 ${tempUserDecodeListNames.length}');
                                      // getPlaceName();
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
                                                title: Text(tempUserDecodeList[index]['owner_name'].toString()),

                                              ),


                                              // Column(
                                              //   children: [
                                              //     Container(
                                              //       color: Colors.red,
                                              //       height: 45,
                                              //       child: ListView.builder(
                                              //         itemCount: 1,
                                              //           itemBuilder: (context,index){
                                              //             if(tempUserDecodeList[index]['p_id']!=null){
                                              //               return Row(
                                              //                 children: [
                                              //                   Text(tempUserDecodeList[index]['p_id'].toString()),
                                              //                 ],
                                              //               );
                                              //             }else if(tempUserDecodeList[index]['f_id']!=null){
                                              //               return Row(
                                              //                 children: [
                                              //                   Text('aaaa')
                                              //                   // Text(tempUserDecodeList[index]['f_id'].toString()),
                                              //                 ],
                                              //               );
                                              //             }else{return null;}
                                              //       }
                                              //       ),
                                              //
                                              //     ),
                                              //   ],
                                              // ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text(
                                                      tempUserDecodeList[index]['p_id']==null?'':"PlaceName : ${placeNameList[index]['p_type']}",
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    tempUserDecodeList[index]
                                                    ['f_id']==null?"":"FloorName : ${floorNameList[0]['f_name'].toString()}",
                                                    textAlign: TextAlign.end,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    tempUserDecodeList[index]
                                                    ['flt_id']
                                                        ==null?"":"Flat Name :  ${flatNameList[0]['flt_name']}",
                                                    textAlign: TextAlign.end,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    tempUserDecodeList[index]
                                                    ['r_id']==null?"":  "RoomName : ${roomNameList[0]['r_name']}",
                                                    textAlign: TextAlign.end,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),

                                                  Text(
                                                    tempUserDecodeList[index]
                                                    ['d_id']==null?"":'Device : ${tempUserDecodeList[index]['d_id']}',
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      );

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
