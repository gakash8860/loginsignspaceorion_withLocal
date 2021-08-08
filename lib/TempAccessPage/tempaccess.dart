import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';




void main()=>runApp(MaterialApp(
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
@override
void initState(){
  super.initState();
  getTempUsers();
}
TempUser tempUser;

List tempUserDecodeList;

Future openTempUserBox()async{

  var dir= await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  tempUserBox=await Hive.openBox('tempUser');
  print('tempUserBox  ${tempUserBox.values.toString()}');
  return;
}




Future<void> getTempUsers()async{
  String token ='fc8a8de66981014125077cadbf12bb12cbfe95fb';
  await openTempUserBox();

  final url ='http://genorion1.herokuapp.com/giveaccesstotempuser/?mobile=7042717549';
  try{
    final response= await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',

    });

    await tempUserBox.clear();

    var  tempUserDecode=jsonDecode(response.body);


    print('tempResponse ${tempUserDecode}');
    setState(() {
      tempUserDecodeList=tempUserDecode;
      putTempUser(tempUserDecodeList);
    });
    print('tempUserDecode ${tempUserDecodeList}');
    print('Number1123->  ${tempUserDecodeList}');


  }catch(e){
    // print('Status Exception $e');

  }

  var myMap=tempUserBox.toMap().values.toList();
  if(myMap.isEmpty){
    tempUserBox.add('empty');

  }else{
    tempUserDecodeList=myMap ;

  }
  return Future.value(true);
}

Future putTempUser(data)async{
  await tempUserBox.clear();
  for(var d in data){

    tempUserBox.add(d);
  }

}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ownerName.toString()),
      ),
      body:  RefreshIndicator(
        onRefresh: getTempUsers,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.lightBlueAccent])),
            child:Container(
              // color: Colors.green,
              // height: 789,
              width:MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              child: FutureBuilder(
                  future: getTempUsers(),
                  builder: ( context,  snapshot){
                    if(snapshot.hasData){
                      if(tempUserDecodeList.isEmpty){
                        return Column(
                          children: [
                            SizedBox(height: 250,),
                            Center(child: Text('Sorry we cannot find any Temp User please add',style: TextStyle(fontSize: 18),)),
                          ],
                        );
                      }else{
                        return Column(
                          children: [
                            SizedBox(height: 25,),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: tempUserDecodeList.length,
                                    itemBuilder: (context,index){
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          semanticContainer:true,
                                          shadowColor: Colors.grey,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(tempUserDecodeList[index]['name']),
                                                trailing: Text(tempUserDecodeList[index]['email']),

                                                subtitle: Text(tempUserDecodeList[index]['timing'].toString()),

                                                onTap: (){
                                                  print('printSubUser ${tempUserDecodeList[index]['name']}');
                                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>TempUserDetails(tempUserPlaceName: tempUserDecodeList[index]['p_id'],
                                                  //   tempUserFloorName: tempUserDecodeList[index]['f_id'] ,)));

                                                },
                                              ),
                                              Row(
                                                children: [
                                                  Text(tempUserDecodeList[index]['date'].toString(),textAlign: TextAlign.end,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(tempUserDecodeList[index]['mobile'].toString(),textAlign: TextAlign.end,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(tempUserDecodeList[index]['f_id'].toString(),textAlign: TextAlign.end,),
                                                  SizedBox(width: 10,),
                                                  Text(tempUserDecodeList[index]['p_id'].toString(),textAlign: TextAlign.end,),
                                                  SizedBox(width: 10,),
                                                  Text(tempUserDecodeList[index]['r_id'].toString(),textAlign: TextAlign.end,),
                                                  SizedBox(width: 10,),
                                                  Text(tempUserDecodeList[index]['flt_id'].toString(),textAlign: TextAlign.end,),
                                                  SizedBox(width: 10,),
                                                  Text(tempUserDecodeList[index]['d_id'].toString(),textAlign: TextAlign.end,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(tempUserDecodeList[index]['owner_name'].toString(),textAlign: TextAlign.end,),
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
                                    }
                                )),


                          ],
                        );
                      }
                    }else{
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          semanticsLabel: 'Loading...',
                        ),
                      );
                    }

                  }

              ),
            ),
          ),
        ),
      ),
    );
  }
}
