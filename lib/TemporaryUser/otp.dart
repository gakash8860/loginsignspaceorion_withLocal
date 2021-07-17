import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class OtpPageForTempUser extends StatefulWidget {
  final mobileNumber;
  const OtpPageForTempUser({Key key, this.mobileNumber}) : super(key: key);

  @override
  _OtpPageForTempUserState createState() => _OtpPageForTempUserState();
}

class _OtpPageForTempUserState extends State<OtpPageForTempUser> {
  TextEditingController otpController= new TextEditingController();



  Future submitOtp()async{
    String token= '2cc4533c72d33d794e3c7b7277ae03191b91d406';
    final url='http://genorionofficial.herokuapp.com/tempuserloginwithotp/';
    var postData={
      "mobile":widget.mobileNumber,
      "otp":otpController.text
    };

    final response= await http.post(url,body: jsonEncode(postData),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if(response.statusCode>0){
      print('otpResponse ${response.statusCode}');
      print('otpResponse ${response.body}');
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temp Login'),
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
                      controller: otpController,
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                          fontSize: 18, color: Colors.black54),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),

                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter OTP',
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
                            await submitOtp();
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
