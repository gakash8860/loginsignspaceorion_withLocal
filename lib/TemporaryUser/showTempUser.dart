import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:loginsignspaceorion/Add%20SubUser/showSubUser.dart';
import 'package:loginsignspaceorion/TemporaryUser/AddTempUser.dart';
import 'package:loginsignspaceorion/TemporaryUser/tempUserdetails.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;



class ShowTempUser extends StatefulWidget {


  @override
  _ShowTempUserState createState() => _ShowTempUserState();
}

class _ShowTempUserState extends State<ShowTempUser> {
  Box tempUserBox;
  final storage= new FlutterSecureStorage();
var deleteData;
var deleteMobile;
var deletePid;
var deleteFid;
var deleteFlatId;
var deleteRid;
Timer timer;

  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }
  List subUserList=[];
  List tempUserDecodeList;

@override
void initState(){
  super.initState();
  openTempUserBox();
  timer=Timer.periodic(Duration(seconds: 10), (timer) { getTempUsers(); tempAutoDelete();});


}

  Future openTempUserBox()async{

    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    tempUserBox=await Hive.openBox('tempUser');
    print('tempUserBox  ${tempUserBox.values.toString()}');
    return;
  }
  Future<bool> tempAutoDelete() async {
    // await openPlaceBox();

    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/tempuserautodelete/';
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    try {
      if (response.statusCode > 0) {
        var placeData = jsonDecode(response.body);
        // for (int i = 0; i < placeData.length; i++) {
        //
        //     //  var placeQuery = PlaceType(
        //     //     pId: placeData[i]['p_id'],
        //     //     pType: placeData[i]['p_type'],
        //     //     user: placeData[i]['user']
        //     // );
        //     //  NewDbProvider.instance.insertPlaceModelData(placeQuery);
        //
        //
        // }


        // places = placeData.map((data) => PlaceType.fromJson(data)).toList();
        print(placeData);
      }
    } catch (e) {}


  }
  Future<void> getTempUsers()async{
    await openTempUserBox();
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/getalldatayouaddedtempuser/';
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

  var postData={

  };
  Future deleteTempUser()async{

    String token = await getToken();
    String url;
    if(deletePid!=null){
      url= 'http://genorion1.herokuapp.com/giveaccesstotempuser/?mobile=$deleteMobile&p_id=$deletePid';
    }else if(deleteFid!=null){
      url= 'http://genorion1.herokuapp.com/giveaccesstotempuser/?mobile=$deleteMobile&f_id=$deleteFid';
    }else if(deleteFlatId!=null){
      url= 'http://genorion1.herokuapp.com/giveaccesstotempuser/?mobile=$deleteMobile&flt_id=$deleteFlatId';
    }else if(deleteRid!=null){
      url= 'http://genorion1.herokuapp.com/giveaccesstotempuser/?mobile=$deleteMobile&r_id=$deleteRid';
    }
    // final url= 'http://genorion1.herokuapp.com/giveaccesstotempuser/?mobile=$deleteMobile&p_id=$deletePid';
    final response= await http.delete(url,
      headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    },

    );
    if(response.statusCode>0){
      print('deleteTempUser ${response.statusCode}');
      print('deleteTempUser ${response.body}');
      if(response.statusCode==200){
        snackBarMessage(context);
      }
    }

  }


  _showDialogForDeleteSubUser(int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete"),
        content: Text("Are you sure to delete this user"),
        actions: <Widget>[

          // ignore: deprecated_member_use
          FlatButton(child: Text("Yes"),
              onPressed: () async{
                print('delete');

                print('tempUserBoxDelete ${tempUserDecodeList[index]}   ');
                deletePid=tempUserDecodeList[index]['p_id'];
                deleteFid=tempUserDecodeList[index]['f_id'];
                deleteFlatId=tempUserDecodeList[index]['flt_id'];
                deleteRid=tempUserDecodeList[index]['r_id'];
                deleteMobile=tempUserDecodeList[index]['mobile'];
               await Hive.box('tempUser').deleteFromDisk();
                print('deletePid ${deletePid}');
                print('deleteFid ${deleteFid}');
                print('deleteFlatid ${deleteFlatId}');
                print('deleteRid ${deleteRid}');
               await deleteTempUser();


                Navigator.of(context).pop();

                // await  _logout().then((value) => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => GettingStartedScreen())));
              }),
          // ignore: deprecated_member_use

          MaterialButton(child: Text("No"), onPressed: () {
            Navigator.of(context).pop();
          }),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temporary Users'),
        actions: [

          MaterialButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTempUser()));
          }, child: Text('Add TempUser',style: TextStyle(
              fontSize: 15
          ),)),
        ],
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
                                                leading: IconButton(
                                                  icon: Icon(Icons.delete_forever,color: Colors.black,semanticLabel: 'Delete',),
                                                  onPressed: (){

                                                    _showDialogForDeleteSubUser(index);
                                                  },
                                                ),
                                                subtitle: Text(tempUserDecodeList[index]['timing'].toString()),

                                                onTap: (){
                                                  print('printSubUser ${tempUserDecodeList[index]['name']}');
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TempUserDetails(tempUserPlaceName: tempUserDecodeList[index]['p_id'],
                                                    tempUserFloorName: tempUserDecodeList[index]['f_id'] ,)));

                                                },
                                              ),
                                              Row(
                                                children: [
                                                  Text(tempUserDecodeList[index]['date'].toString(),textAlign: TextAlign.end,),
                                                ],
                                              )
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
