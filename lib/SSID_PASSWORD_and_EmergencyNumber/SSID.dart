import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';

import '../changeFont.dart';
import '../main.dart';
import 'nextPage.dart';
class SSID extends StatefulWidget {
  final deviceId;

  const SSID({Key key, this.deviceId}) : super(key: key);

  @override
  _SSIDState createState() => _SSIDState();
}


class _SSIDState extends State<SSID> {
  bool isVisible=false;
  bool isHiddenPassword = true;
  TextEditingController controller = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SsidRequirementField ssidRequirementField = new SsidRequirementField();
  final storage = new FlutterSecureStorage();

  void tooglePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  void initState(){
    super.initState();
    print('Device Id init-->  ${widget.deviceId}');
  }
  goToNextPage() {
    setState(() {
      isVisible=true;
    });
    formKey.currentState.save();
    print('clear');
    updateSSID_Password(ssidRequirementField).then((value) {
      final snackBar = SnackBar(
        content: Text('Data Sent'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextPageSSID()),
      );
    }).catchError((e) {
      print(e);
    });
  }

  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }
  updateSSID_Password(SsidRequirementField data) async {
    String token =await getToken();
print('SsidRequirementField ${widget.deviceId}');
    final url = API+'ssidpassword/?d_id='+widget.deviceId.toString();
  var postData={
    "d_id":widget.deviceId,
    "ssid1":data.sSSID1,
    "password1":data.sSSIDPassword_1,
    "ssid2":data.sSSID2,
    "password2":data.sSSIDPassword_2,
    "ssid3":data.sSSID3,
    "password3":data.sSSIDPassword_3,
  };
    final response = await http.put(url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if(response.statusCode>0){
      print("Kuch Bi -->${response.body}");
    }
  }
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('GenOrion',style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
      ),
      body: isVisible?Container(color: Colors.blueAccent,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),),):
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent])),
        child: Form(
          key: formKey,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                dragStartBehavior: DragStartBehavior.down,
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  // color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: ClipPath(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            // validator: nameValid,
                            onSaved: (String value) {
                              this.ssidRequirementField.sSSID1 = value;
                            },
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54,fontFamily: fonttest==null?changeFont:fonttest,),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'SSID 1',
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            controller:controller ,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (String value) {
                              this.ssidRequirementField.sSSIDPassword_1 = value;
                            },
                            obscureText: isHiddenPassword,
                            style:
                            TextStyle(fontSize: 18, color: Colors.black54,fontFamily: fonttest==null?changeFont:fonttest,),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.security),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your SSID1 password',
                              suffixIcon: InkWell(
                                  onTap: tooglePassword,
                                  child: Icon(isHiddenPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (String value) {
                              this.ssidRequirementField.sSSID2 = value;
                            },
                            style:
                            TextStyle(fontSize: 18, fontFamily: fonttest==null?changeFont:fonttest,color: Colors.black54),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'SSID 2',
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            autofocus: true,
                            controller: controller2,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (String value) {
                              this.ssidRequirementField.sSSIDPassword_2 = value;
                            },
                            obscureText: isHiddenPassword,
                            style:
                            TextStyle(fontSize: 18, fontFamily: fonttest==null?changeFont:fonttest,color: Colors.black54),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.security),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter SSID2 password',
                              suffixIcon: InkWell(
                                  onTap: tooglePassword,
                                  child: Icon(isHiddenPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          // TextFormField(
                          //   autofocus: true,
                          //   textInputAction: TextInputAction.next,
                          //   onEditingComplete: () => node.nextFocus(),
                          //   autovalidateMode:
                          //   AutovalidateMode.onUserInteraction,
                          //   //validator: nameValid,
                          //   onSaved: (String value) {
                          //     this.data.username = value;
                          //   },
                          //   style:
                          //   TextStyle(fontSize: 18, color: Colors.black54),
                          //   decoration: InputDecoration(
                          //     prefixIcon: Icon(Icons.person),
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     hintText: 'username',
                          //     contentPadding: const EdgeInsets.all(15),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //       borderRadius: BorderRadius.circular(50),
                          //     ),
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //       borderRadius: BorderRadius.circular(50),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 15,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            // autovalidateMode: AutovalidateMode.values[2],
                            // validator: validateEmail,
                            onSaved: (String value) {
                              // ignore: unnecessary_statements
                              this.ssidRequirementField.sSSID3 = value;
                            },
                            style:
                            TextStyle(fontSize: 18,fontFamily: fonttest==null?changeFont:fonttest, color: Colors.black54),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'SSID3',
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (String value) {
                              this.ssidRequirementField.sSSIDPassword_3 = value;
                            },
                            obscureText: isHiddenPassword,
                            style:
                            TextStyle(fontSize: 18, fontFamily: fonttest==null?changeFont:fonttest,color: Colors.black54),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.security),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter SSID3 password',
                              suffixIcon: InkWell(
                                  onTap: tooglePassword,
                                  child: Icon(isHiddenPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          // ignore: deprecated_member_use
                          FlatButton(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: fonttest==null?changeFont:fonttest,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              shape: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              padding: const EdgeInsets.all(15),
                              textColor: Colors.white,
                              onPressed: () {
                                goToNextPage();
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
class SsidRequirementField {
  String sSSID1 = '';
  String sSSID2 = '';
  String sSSID3 = '';
  String sSSIDPassword_1 = '';
  String sSSIDPassword_2 = '';
  String sSSIDPassword_3 = '';



}