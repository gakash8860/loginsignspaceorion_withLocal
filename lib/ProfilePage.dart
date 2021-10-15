import 'dart:convert';
import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/utility.dart';
import 'SQLITE_database/testinghome2.dart';
import 'Setting_Page.dart';
import 'changeFont.dart';
import 'main.dart';
import 'models/modeldefine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
Image setImage;
var firstName;
var userQuery;
var email;

var lastName;
void main() => runApp(MaterialApp(
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    ));

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  String value;

  @override
  _ProfilePageState createState() => _ProfilePageState();

  ProfilePage({
    Key key,
  }) : super(key: key);
}

class _ProfilePageState extends State<ProfilePage> {

  Box userDataBox;
  SharedPreferences preferences;
  List<Map<String, dynamic>> userRows;

  _showChoiceDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make a choice'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () async {
                      await pickImage(ImageSource.gallery);
                      await startUpload();
                      print('Gallery');
                      Navigator.pop(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text('Take a photo'),
                    onTap: () async {
                      await pickImage(ImageSource.camera);
                      await startUpload();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  File _image;
  var base64String;
  var bytes;
  String baseConvertPath;

  pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(source: source);
    if (_image != null) {
      print('Pick');
      print('Pick ${_image.path}');
      setState(() {
        setImage = Image.file(_image);
        baseConvertPath = _image.path;
      });
      base64String = base64Encode(_image.readAsBytesSync());
      Utility.saveImage(base64String
          // Utility.base64String(_image.readAsBytesSync()),
          );
      // bytes = Io.File(base64String).readAsBytesSync();
      print("ssssssssssssssssssssssssssssssss $base64String  ");
    } else {
      print('Error');
    }
  }

  loadImageFromPreferences() async {
    preferences = await SharedPreferences.getInstance();
    final _imageKeyValue = preferences.getString(IMAGE_KEY);
    if (_imageKeyValue != null) {
      final imageString = await Utility.getImagefrompreference();
      setState(() {
        setImage = Utility.imageFrom64BaseString(imageString);
      });
    }
  }
  deleteImageFromLocal()async{
    final _imageKeyValue = preferences.getString(IMAGE_KEY);
    preferences.remove(_imageKeyValue);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
    loadImageFromPreferences();
    getUserDataOfflineSql();
    getUserDetailsSql();

    // openUserBox();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // NewDbProvider.instance.close();
  }

  var userDataVariable;

  // ignore: deprecated_member_use
  List userDataList = List(3);

  Future openUserBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    userDataBox = await Hive.openBox('place');

    // print('openPlaceBox ${placeBox.values.last}');
    return;
  }

  Future putData(data) async {
    await userDataBox.clear();
    for (var d in data) {
      // print('D-->  $d');
      userDataBox.add(d);
    }
  }

  String base64Image;

  startUpload() async {
    if (null == _image) {
      return;
    }
    imageUpload();
  }

  imageUpload() async {
    // String token = "b8bd2e8bc8f9541d031f03217cf9ac0153048a97";
    String token = await getToken();
    final url = API+'testimages123/';
    // final url = 'http://192.168.0.105:8000/testimages123/?user=1';

    var postData = {
      "file": base64String,
      "user": getUidVariable,
    };
    var flag = 0;
    var response;
//       if(flag==0){
//         flag=1;
//          response = await http.post(url, body: jsonEncode(postData), headers: {
//           'Content-Type': 'application/json',
//           // 'Accept': 'application/json',
//           'Authorization': 'Token $token',
//         });
// print('response123 ${response.statusCode}');
//          print('flag $flag');
//       }else if(flag==1){
//         response = await http.put(url, body: jsonEncode(postData), headers: {
//           'Content-Type': 'application/json',
//           // 'Accept': 'application/json',
//           'Authorization': 'Token $token',
//         });
//         print('response123 ${response.statusCode}');
//         print('ElseIfFlag $flag');
//       }
    response = await http.put(url, body: jsonEncode(postData), headers: {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('response123 ${response.statusCode}');
    print('ElseIfFlag $flag');

    if (response.statusCode > 0) {
      print('ImageResponseStatusCode  ${response.statusCode}');
      print('ImageResponseStatusCode  ${response.body}');
    }
  }

  var convertImage;

  getImage() async {
    String token = await getToken();
    final url = API+'testimages123/?user=' + getUidVariable;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('statusCode ${response.statusCode}');
    if (response.statusCode == 200) {
      print('statusCode ${response.statusCode}');
      print('statusCode ${response.body}');
      var imageData = json.decode(response.body);
      print('statusCode ${response.body}');
      await deleteImageFromLocal();
      Utility.saveImage(imageData['file']).then((value) => loadImageFromPreferences());
      setState(() {

      });


      print('ConvertImagesetImage ${setImage}');
      print('ConvertImage ${imageData['file']}');
    }
  }

  Future<void> getUserDetailsSql() async {
    String token = await getToken();
    print(getUidVariable);
    String url =
        API+"getthedataofuser/?id=" + getUidVariable;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    if (response.statusCode > 0) {
      print('responseStatus ${response.statusCode}');
      userDataVariable = jsonDecode(response.body);
      print('response $userDataVariable');

      var userQuery = User(
        email: userDataVariable['email'],
        firstName: userDataVariable['first_name'],
        lastName: userDataVariable['last_name'],
      );
      await NewDbProvider.instance.insertUserDetailsModelData(userQuery);
      print('userQuery  ${userQuery.firstName}');
      // await NewDbProvider.instance.close();

    }
  }

  List data;


  getUserDataOfflineSql() async {
    data = await NewDbProvider.instance.userQuery();
    print('qqqqqq $data');
    var userQuery = User(
        lastName: data.first['last_name'].toString(),
        firstName: data.first['first_name'].toString(),
        email: data.first['email'].toString());
    setState(() {
      email = userQuery.email;
      firstName = userQuery.firstName;
      lastName = userQuery.lastName;
    });
    print('asasa ${lastName}');
  }

  Future<bool> getAllUserDataInHive() async {
    await openUserBox();
    // String url="http://10.0.2.2:8000/api/data";
    String token = await getToken();
    String url = API+"getthedataofuser/?id=2";
    var response;
    try {
      response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      userDataVariable = jsonDecode(response.body);
      print('gtggg  $userDataVariable');
      userDataList = [
        userDataVariable['first_name'],
        userDataVariable['last_name'],
        userDataVariable['email'],
      ];
      await putData(userDataList);
    } catch (e) {
      // print('Status Exception $e');

    }

    var myMap = userDataBox.toMap().values.toList();
    if (myMap.isEmpty) {
      userDataBox.add('empty');
    } else {
      userDataList = myMap;
    }
    return Future.value(true);
  }

  Widget textFormField({String text}) {
    return Material(
      elevation: 8,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 65,
        child: TextField(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.0),
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: _switchValue?Colors.white12:Colors.white,

      body: Container(
        color: change_toDark ? Colors.black : Colors.white,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.centerLeft,
        //         end: Alignment.centerRight,
        //         colors: [Colors.blueGrey, Colors.blueAccent, Colors.blueGrey])),
        child: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
          if (viewportConstraints.maxWidth > 600) {
            return Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //   image:   setimage==null? AssetImage('assets/images/blank.png'):setimage
                  //   ),
                  // ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(width: 140,),
                          CircularProfileAvatar(
                            '',
                            child: setImage == null
                                ? Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')
                                : setImage,
                            // '',child: Image.network(imageData['images']),
                            radius: 90,
                            elevation: 5,
                            onTap: () {
                              print('Full Screen');
                            },
                            cacheImage: true,
                          ),
                          Container(
                            height: 50,
                            width: 40,
                            child:CircleAvatar(
                              maxRadius: MediaQuery.of(context).size.width * 0.05,
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.black54,
                                onPressed: () {
                                  _showChoiceDialog(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),


                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 1.1,
                          ),

                          Container(
                            width: 300,
                              child: Card(
                                child: Text(
                                  email == null
                                      ? "Loading"
                                      : email.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                ),
                              )),
                          Container(
                              width: 300,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    firstName == null
                                        ? "Loading"
                                        : firstName.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              )),
                          Container(
                              width: 300,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    lastName == null
                                        ? "Loading"
                                        : lastName.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,),
                                  ),
                                ),
                              )),
                          //
                          // SizedBox(height: MediaQuery.of(context).size.height/68,),
                          // textformfield(text: userData['last_name'].toString()),
                          // SizedBox(height: MediaQuery.of(context).size.height/68,),
                          // textformfield(text: userData['email'].toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('GenOrion',style: TextStyle( fontFamily: fonttest==null?'RobotoMono':fonttest),),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Container(
                // color: change_toDark ? Colors.black : Colors.white,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blueGrey, Colors.blueAccent, Colors.blueGrey])),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //   image:   setimage==null? AssetImage('assets/images/blank.png'):setimage
                      //   ),
                      // ),
                      CircularProfileAvatar(
                        '',
                        child: setImage == null
                            ? Image.asset('assets/images/blank.png')
                            : setImage,
                        // '',child: Image.network(imageData['images']),
                        radius: 90,
                        elevation: 5,
                        onTap: () {
                          print('Full Screen');
                        },
                        cacheImage: true,
                      ),

                      CircleAvatar(
                        maxRadius: MediaQuery.of(context).size.width * 0.05,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.black54,
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                height: 1.1,
                              ),

                              Container(
                                  height: MediaQuery.of(context).size.height / 18,
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        email == null
                                            ? "Loading"
                                            : email.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(

                                            fontSize: 14,fontFamily: fonttest==null?'RobotoMono':fonttest),
                                      ),
                                    ),
                                  )),
                              Container(
                                  height: MediaQuery.of(context).size.height / 18,
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        firstName == null
                                            ? "Loading"
                                            : firstName.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14,fontFamily: fonttest==null?'RobotoMono':fonttest),
                                      ),
                                    ),
                                  )),
                              Container(
                                  height: MediaQuery.of(context).size.height / 18,
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        lastName == null
                                            ? "Loading"
                                            : lastName.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14,fontFamily:  fonttest==null?changeFont:fonttest,),
                                      ),
                                    ),
                                  )),
                              //
                              // SizedBox(height: MediaQuery.of(context).size.height/68,),
                              // textformfield(text: userData['last_name'].toString()),
                              // SizedBox(height: MediaQuery.of(context).size.height/68,),
                              // textformfield(text: userData['email'].toString()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
            // child:
            ),
      ),
    );
  }
}


