import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'otp.dart';




class EnterPhoneNumber extends StatefulWidget {
  const EnterPhoneNumber({Key key}) : super(key: key);

  @override
  _EnterPhoneNumberState createState() => _EnterPhoneNumberState();
}

class _EnterPhoneNumberState extends State<EnterPhoneNumber> {
  TextEditingController phoneController= new TextEditingController();

Future submitMobile()async{
  String token= '2cc4533c72d33d794e3c7b7277ae03191b91d406';
  final url='http://genorionofficial.herokuapp.com/loginotpsend/';
  var map = new Map<String, dynamic>();
  map['mobile'] = phoneController.text;

  http.Response response = await http.post(url, body: map,encoding: Encoding.getByName("utf-8"),headers: {
      'Authorization': 'Token $token',
  });
  // final response= await http.post(url,body: jsonEncode(postData),headers: {
  //   'Content-Type': 'application/json',
  //   'Accept': 'application/json',
  //   'Authorization': 'Token $token',
  // });
  if(response.statusCode>0){
    print('otpResponse ${response.statusCode}');
    print('otpResponse ${response.body}');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GenOrion'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent])),
          child: LayoutBuilder(
            builder: (BuildContext context,
                BoxConstraints viewportConstraints) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                // color: Theme.of(context).primaryColor,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Image.asset(
                    //   'assets/images/signin.png',
                    //   height: 130,
                    // ),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      controller: phoneController,
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                          fontSize: 18, color: Colors.black54),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),

                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your Phone Number',
                        errorStyle: TextStyle(),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // ignore: deprecated_member_use
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FlatButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,),),
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(color:
                            Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(90),),
                          padding: const EdgeInsets.all(15),
                          textColor: Colors.white,
                          onPressed: () async {
                            await submitMobile();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPageForTempUser(mobileNumber: phoneController.text,)));
                          }),
                    ),

                  ],
                ),
              );
            },
          )
      ),
    );
  }
}
