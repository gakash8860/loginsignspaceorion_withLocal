
import 'dart:convert';
import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/utility.dart';
import 'Setting_Page.dart';
import 'main.dart';
import 'models/modeldefine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
void main()=>runApp(MaterialApp(
  home: ProfilePage(
    fl: null,
    // pt: null,
    // rm: null,
    // dv: null,
  ),
  debugShowCheckedModeBanner: false,
));

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  String value;


  // place_type pt;
  FloorType fl;
  // List<Room> rm;
  // List<Device> dv;


  @override
  _ProfilePageState createState() => _ProfilePageState();
  ProfilePage(
      {Key key,
        // @required this.pt,
        @required this.fl,
        // @required this.rm,
        // @required this.dv
      })
      : super(key: key);
}

class _ProfilePageState extends State<ProfilePage> {
  Image setImage;
  Box userDataBox;
  SharedPreferences preferences;
  List<Map<String, dynamic>> userRows;



  _showChoiceDialog(BuildContext context)async {
    return showDialog(context:context,builder: (BuildContext context){
      return AlertDialog(
        title: Text('Make a choice'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),

                onTap: () async{
                  await pickImage(ImageSource.gallery);
                  startUpload();
                  print('Gallery');
                  Navigator.pop(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Take a photo'),
                onTap: ()async{
                  await pickImage(ImageSource.camera);
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
  pickImage(ImageSource source)async{
    // ignore: deprecated_member_use
     _image = await ImagePicker.pickImage(source: source);
    if(_image!=null){
      print('Pick');
      setState(() {
        setImage=Image.file(_image);
      });
      Utility.saveImage(
        Utility.base64String(_image.readAsBytesSync()),
      );

      print("ssssssssssssssssssssssssssssssss  ${_image.readAsBytesSync()} ");
    }else{
      print('Error');
    }
  }

  loadImageFromPreferences() async{
    preferences = await SharedPreferences.getInstance();
    final _imageKeyValue =preferences.getString(IMAGE_KEY);
    if(_imageKeyValue!=null){
      final imageString= await Utility.getImagefrompreference();
      setState(() {
        setImage=Utility.imageFrom64BaseString(imageString);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImageFromPreferences();
    getAllUserDataInHive();
    getUserDataOffline();
    getUserDetailsSql();

    openUserBox();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     // NewDbProvider.instance.close();
  }
  var userDataVariable;
  // ignore: deprecated_member_use
  List userDataList= List(3);






  Future openUserBox()async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    userDataBox=await Hive.openBox('place');

    // print('openPlaceBox ${placeBox.values.last}');
    return;

  }
  Future putData(data)async{
    await userDataBox.clear();
    for(var d in data){
      // print('D-->  $d');
      userDataBox.add(d);
    }

  }

   String base64Image;
  startUpload() {

    if (null == _image) {
print('null');
      return;
    }
    String fileName = _image.path.split('/').last;
    upload(fileName);
  }
  static final String uploadEndPoint = 'https://genorionofficial.herokuapp.com/addprofileimage/?user=3';
  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": setImage,
      "name": fileName,
    }).then((result) {
print(result);
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> getUserDetailsSql()async{
    String token = await getToken();
    print(getUidVariable);
    String url="http://genorionofficial.herokuapp.com/getthedataofuser/?id=2";
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });


      if (response.statusCode >0) {
        print('responseStatus ${response.statusCode}');
        userDataVariable=jsonDecode(response.body);
        print('response $userDataVariable');

        var userQuery=User(
          email: userDataVariable['email'],
          firstName: userDataVariable['first_name'],
          lastName: userDataVariable['last_name'],
        );
        await NewDbProvider.instance.insertUserDetailsModelData(userQuery);
        print('userQuery  ${userQuery.firstName}' );
        // await NewDbProvider.instance.close();



      }


  }
  List data;
var userQuery;
var email;
var firstName;
var lastName;
getUserDataOffline()async{
  data= await NewDbProvider.instance.userQuery();
  var userQuery=User(
    lastName: data.first['last_name'].toString(),
    firstName: data.first['first_name'].toString(),
    email: data.first['email'].toString()
  );
    setState(() {
      email=userQuery.email;
      firstName=userQuery.firstName;
      lastName=userQuery.lastName;
    });
    print('asasa ${lastName}');
}

  Future<bool> getAllUserDataInHive()async{
    await openUserBox();
    // String url="http://10.0.2.2:8000/api/data";
    String token=await getToken();
    String url="http://genorionofficial.herokuapp.com/getthedataofuser/?id=2";
    var response;
    try{
      response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });

      userDataVariable=jsonDecode(response.body);
      print('gtggg${userDataVariable}');
      userDataList=[
        userDataVariable['first_name'],
        userDataVariable['last_name'],
        userDataVariable['email'],

      ];
      var userQuery=User(
        email: userDataList[0]['email'],
        firstName: userDataList[0]['first_name'],
        lastName: userDataList[0]['last_name'],
      );
      // await NewDbProvider.instance.insertUserDetailsModelData(userQuery);

      // print('userQuery $userQuery');
      await putData(userDataList);


    }catch(e){
      // print('Status Exception $e');

    }

    var myMap=userDataBox.toMap().values.toList();
    if(myMap.isEmpty){
      userDataBox.add('empty');

    }else{
      userDataList=myMap ;

    }
    return Future.value(true);
  }


  Widget  textFormField({String text}){
    return Material(
      elevation: 8,
      shadowColor: Colors.grey,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width-65,
        child: TextField(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              hintText: text,

              hintStyle: TextStyle(
                  letterSpacing: 2,
                  color: Colors.black54
              ),
              border: OutlineInputBorder(
                borderSide:BorderSide.none,
                borderRadius: BorderRadius.circular(15.0),

              )
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: _switchValue?Colors.white12:Colors.white,
      appBar: AppBar(
        title: Text('GenOrion'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
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
                colors: [Colors.blueGrey,Colors.blueAccent,Colors.blueGrey]
            )
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/18,),
              // Container(
              //   decoration: BoxDecoration(
              //   image:   setimage==null? AssetImage('assets/images/blank.png'):setimage
              //   ),
              // ),
              CircularProfileAvatar(
                '',child:setImage==null? Image.asset('assets/images/blank.png'):setImage,
                radius: 90,
                elevation: 5,
                onTap: (){
                  print('Full Screen');
                },
                cacheImage: true,

              ),

              CircleAvatar(
                maxRadius: MediaQuery.of(context).size.width*0.05,
                child: IconButton(icon: Icon(Icons.edit),color: Colors.black54,
                  onPressed: (){
                    _showChoiceDialog(context);
                  },),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 1.1,),

                      Container(
                        height: MediaQuery.of(context).size.height/18,
                          width: MediaQuery.of(context).size.width/1.8,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(email==null?"Loading":email.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 14),),
                            ),)),
                      Container(
                          height: MediaQuery.of(context).size.height/18,
                          width: MediaQuery.of(context).size.width/1.8,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(firstName==null?"Loading":firstName.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 14),),
                            ),)),
                      Container(
                          height: MediaQuery.of(context).size.height/18,
                          width: MediaQuery.of(context).size.width/1.8,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(lastName==null?"Loading":lastName.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 14),),
                            ),)),
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








//
// FutureBuilder(
// future: getAllUserDataInHive(),
// builder: ( context,  snapshot){
// if(snapshot.hasData){
// if(userDataList.contains('empty')){
// return Text('No data');
// }else{
// return Column(
// children: [
// SizedBox(height: 25,),
// Expanded(child: ListView.builder(
// itemCount: 1,
// itemBuilder: (context,index){
// return
// Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: <Widget>[
// SizedBox(height: 1.1,),
// // Container(
// //   height: 65,
// //   width: 235,
// //   child:Padding(
// //     padding: const EdgeInsets.all(18.0),
// //     child: Text(userDataList[0].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
// //   ),
// //   decoration: BoxDecoration(
// //     color: Colors.white,
// //     border: Border.all(
// //       color: Colors.black38 ,
// //       width: 5.0 ,
// //     ),
// //     borderRadius: BorderRadius.circular(20),
// //   ),
// // ),
// // SizedBox(height: 15,),
// //
// // Container(
// //   height: 65,
// //   width: 235,
// //   child:Padding(
// //     padding: const EdgeInsets.all(18.0),
// //     child: Text(userDataList[1].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
// //   ),
// //   decoration: BoxDecoration(
// //     color: Colors.white,
// //     border: Border.all(
// //       color: Colors.black38 ,
// //       width: 5.0 ,
// //     ),
// //     borderRadius: BorderRadius.circular(20),
// //   ),
// // ),
// // SizedBox(height: 15,),
// // Container(
// //   height: 65,
// //   width: 235,
// //   child:Padding(
// //     padding: const EdgeInsets.all(18.0),
// //     child: Text(userDataList[2].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
// //   ),
// //   decoration: BoxDecoration(
// //     color: Colors.white,
// //     border: Border.all(
// //       color: Colors.black38 ,
// //       width: 5.0 ,
// //     ),
// //     borderRadius: BorderRadius.circular(20),
// //   ),
// // ),
// textFormField(text: userDataList[0].toString(),),
// SizedBox(height: MediaQuery.of(context).size.height/68,),
// textFormField(text: userDataList[1].toString()),
// SizedBox(height: MediaQuery.of(context).size.height/68,),
// textFormField(text: userDataList[2].toString()),
//
//
// ],
// );
//
// }
// ))
//
// ],
// );
// }
// }else{
// return Text('Loading...',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),);
// }
//
// }
//
// ),