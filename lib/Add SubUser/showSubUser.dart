import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:loginsignspaceorion/Add%20SubUser/AlreadySubUserAssignPlace.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../changeFont.dart';
import '../main.dart';
import 'AddSubUser.dart';
import 'SubUserDetailPage.dart';

Future snackBarMessage(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('User Deleted'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}



class ShowSubUser extends StatefulWidget {
  @override
  _ShowSubUserState createState() => _ShowSubUserState();
}

class _ShowSubUserState extends State<ShowSubUser> {
  Box subUserBox;
  final storage = new FlutterSecureStorage();
  List subUserDecodeList = [];
  List subUserDecodeListWeb = [];
  Timer timer;

  @override
  void initState() {
    super.initState();
    openSubUserBox();
    getSinglePlaceName();
    getSubUsers();
    getSubUsersWeb();
    // timer=Timer.periodic(Duration(seconds: 1), (timer) {     getSubUsers();});
  }

  Future openSubUserBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    subUserBox = await Hive.openBox('subUser');
    print('subUserBox  ${subUserBox.values.toString()}');
    return;
  }
  var tokenWeb;
  Future getTokenWeb()async{
    final pref= await SharedPreferences.getInstance();
    tokenWeb=pref.getString('tokenWeb');
    return tokenWeb;
  }
  // List subUserList=[];
  Future<bool> getSubUsers() async {
    await openSubUserBox();
    String token = await getToken();
    final url = API+'subuserfindall/';
    var response;
    try {
      response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      var subUserDecode = jsonDecode(response.body);
      setState(() {
        subUserDecodeList = subUserDecode;
      });
      print('subUserDecode ${subUserDecodeList}');
      print('Number1123->  ${subUserDecodeList[0]['p_id']}');

      await putSubUser(subUserDecodeList);
    } catch (e) {
      // print('Status Exception $e');

    }

    var myMap = subUserBox.toMap().values.toList();
    if (myMap.isEmpty) {
      subUserBox.add('empty');
    } else {
      subUserDecodeList = myMap;
    }
    return Future.value(true);
  }
  Future<bool> getSubUsersWeb() async {

    String token = await getTokenWeb();
    final url = API+'subuserfindall/';
    var response;
    try {
      response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      var subUserDecode = jsonDecode(response.body);
      setState(() {
        subUserDecodeListWeb = subUserDecode;
      });
      print('subUserDecode ${subUserDecodeListWeb}');
      print('Number1123->  ${subUserDecodeListWeb[0]['p_id']}');

    } catch (e) {
      // print('Status Exception $e');

    }
    return Future.value(true);
  }

  Future deleteLocal() {
    Hive.box('subUser').deleteFromDisk();
  }

  Future getSinglePlaceName() async {
    String token = await getToken();
    final url = API+'getyouplacename/?p_id=7120663';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('getSinglePlaceName${response.statusCode}');
      print('getSinglePlaceName${response.body}');
    }
  }

  Future putSubUser(data) async {
    await subUserBox.clear();
    for (var d in data) {
      subUserBox.add(d);
    }
  }

  // List<AllSubUserData> allSubUser;
  // Future<List<AllSubUserData>> fetchSubUser() async {
  //   await openSubUserBox();
  //   String token = await getToken();
  //   // final url = 'http://genorionofficial.herokuapp.com/addyourplace/?p_id=' + placeResponse;
  //   final url = 'http://genorionofficial.herokuapp.com/subuserfindall/';
  //   final response = await http.get(url, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Token $token',
  //   });
  //
  //
  //   try{
  //     if (response.statusCode >0) {
  //       subUserDecodeList = jsonDecode(response.body);
  //       await putSubUser(subUserDecodeList);
  //       print("Place-->  ${subUserDecodeList}");
  //       allSubUser = subUserDecodeList.map((data) => AllSubUserData.fromJson(data)).toList();
  //
  //       print('ListOfSubUser ${allSubUser.toList()}');
  //     }
  //   }catch(e){
  //
  //   }
  //
  //   var myMap=subUserBox.toMap().values.toList();
  //   if(myMap.isEmpty){
  //     subUserDecodeList.add('empty');
  //     print('addingSubUser ${subUserDecodeList.toString()}');
  //
  //   }else{
  //     subUserDecodeList=myMap;
  //     print('adding  ${subUserDecodeList.toString()}');
  //
  //
  //     setState(() {
  //       print('adding147  ${subUserDecodeList.toString()}');
  //       // pt.pId=placeData[0]['p_id'];
  //       print('adding1478  ${subUserDecodeList.toString()}');
  //       // pt.pId=placeData[0]['p_id'];
  //     });
  //
  //
  //   }
  //
  //
  //   return allSubUser;
  //
  // }

  Future deleteSubUser(String email, String pId) async {
    String token = await getToken();
    final url =
        API+'subuseraccess/?email=$email&p_id=' +
            pId;
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('deleteSubUser ${response.statusCode}');
      print('deleteSubUser ${response.body}');
      if (response.statusCode == 200) {
        snackBarMessage(context);
      }
    }
  }
  Future deleteSubUserWeb(String email, String pId) async {
    String token = await getTokenWeb();
    final url =
        API+'subuseraccess/?email=$email&p_id=' +
            pId;
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('deleteSubUser ${response.statusCode}');
      print('deleteSubUser ${response.body}');
      if (response.statusCode == 200) {
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
          FlatButton(
              child: Text("Yes"),
              onPressed: () async {
                await deleteSubUser(subUserDecodeList[index]['email'],
                    subUserDecodeList[index]['p_id']);
                subUserBox.delete('subUser');
                Hive.box('subUser').deleteFromDisk();
                Navigator.of(context).pop();

                // await  _logout().then((value) => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => GettingStartedScreen())));
              }),
          // ignore: deprecated_member_use

          FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
  _showDialogForDeleteSubUserWeb(int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete"),
        content: Text("Are you sure to delete this user"),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
              child: Text("Yes"),
              onPressed: () async {
                await deleteSubUserWeb(subUserDecodeListWeb[index]['email'],
                    subUserDecodeListWeb[index]['p_id']);

                Navigator.of(context).pop();

                // await  _logout().then((value) => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => GettingStartedScreen())));
              }),
          // ignore: deprecated_member_use

          FlatButton(
              child: Text("No"),
              onPressed: () {
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
        automaticallyImplyLeading: false,
        title: Text('SubUser',style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
        actions: [
          MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddSubUser()));
              },
              child: Text(
                'Add SubUser',
                style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlreadySubUser(

                        )));
              },
              child: Text(
                'Assign Place',
                style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),
              )),
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        if (viewportConstraints.maxWidth > 600) {
          return Scaffold(

            body: RefreshIndicator(
              onRefresh: getSubUsersWeb,
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
                        future: getSubUsersWeb(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (subUserDecodeListWeb.contains('empty')|| subUserDecodeListWeb.length==null||subUserDecodeListWeb.isEmpty) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 250,
                                  ),
                                  Center(
                                      child: Text(
                                        'Sorry we cannot find any sub User, please add',
                                        style: TextStyle(fontSize: 14,fontFamily: fonttest==null?changeFont:fonttest,),
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
                                          itemCount: subUserDecodeListWeb.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Card(
                                                semanticContainer: true,
                                                shadowColor: Colors.grey,
                                                child: ListTile(
                                                  title: Text(
                                                    subUserDecodeListWeb[index]
                                                    ['name'],style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                  trailing: Text(
                                                    subUserDecodeListWeb[index]
                                                    ['email'],style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                  leading: IconButton(
                                                    icon: Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.black,
                                                      semanticLabel: 'Delete',
                                                    ),
                                                    onPressed: () {
                                                      print('delete');
                                                      _showDialogForDeleteSubUserWeb(index);
                                                    },
                                                  ),
                                                  // onTap: () {
                                                  //   print(
                                                  //       'printSubUser ${subUserDecodeList[index]['name']}');
                                                  //   // placeName=
                                                  //   Navigator.push(
                                                  //       context,
                                                  //       MaterialPageRoute(
                                                  //           builder: (context) =>
                                                  //               SubUserDetails(
                                                  //                 subUserPlaceId:
                                                  //                 subUserDecodeList[
                                                  //                 index]
                                                  //                 [
                                                  //                 'p_id'],
                                                  //                 subUserEmail:
                                                  //                 subUserDecodeList[
                                                  //                 index]
                                                  //                 [
                                                  //                 'email'],
                                                  //                 subUserName:
                                                  //                 subUserDecodeList[
                                                  //                 index]
                                                  //                 [
                                                  //                 'name'],
                                                  //               )));
                                                  // },
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
                                child:   SpinKitFadingCircle(
                                  itemBuilder: (BuildContext context, int index) {
                                    return DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: index.isEven ? Colors.red : Colors.green,
                                      ),
                                    );
                                  },
                                )

                              // child: Image.network('https://i.gifer.com/78ff.gif'),
                              // child: CircularProgressIndicator(
                              //   color: Colors.red,
                              //   semanticsLabel: 'Loading...',
                              // ),
                            );
                          }
                        }),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(

            body: RefreshIndicator(
              onRefresh: getSubUsers,
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
                        future: getSubUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (subUserDecodeList.contains('empty')) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 250,
                                  ),
                                  Center(
                                      child: Text(
                                    'Sorry we cannot find any sub User, please add',
                                    style: TextStyle(fontSize: 14,fontFamily: fonttest==null?changeFont:fonttest,),
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
                                          itemCount: subUserDecodeList.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                semanticContainer: true,
                                                shadowColor: Colors.grey,
                                                child: ListTile(
                                                  title: Text(
                                                      subUserDecodeList[index]
                                                          ['name'],style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                  trailing: Text(
                                                      subUserDecodeList[index]
                                                          ['email'],style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                  leading: IconButton(
                                                    icon: Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.black,
                                                      semanticLabel: 'Delete',
                                                    ),
                                                    onPressed: () {
                                                      print('delete');
                                                      _showDialogForDeleteSubUser(
                                                          index);
                                                    },
                                                  ),
                                                  onTap: () {
                                                    print(
                                                        'printSubUser ${subUserDecodeList[index]['name']}');
                                                    // placeName=
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SubUserDetails(
                                                                  subUserPlaceId:
                                                                      subUserDecodeList[
                                                                              index]
                                                                          [
                                                                          'p_id'],
                                                                  subUserEmail:
                                                                      subUserDecodeList[
                                                                              index]
                                                                          [
                                                                          'email'],
                                                                  subUserName:
                                                                      subUserDecodeList[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                )));
                                                  },
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
                              child:   SpinKitFadingCircle(
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: index.isEven ? Colors.red : Colors.green,
                                    ),
                                  );
                                },
                              )

                              // child: Image.network('https://i.gifer.com/78ff.gif'),
                              // child: CircularProgressIndicator(
                              //   color: Colors.red,
                              //   semanticsLabel: 'Loading...',
                              // ),
                            );
                          }
                        }),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
