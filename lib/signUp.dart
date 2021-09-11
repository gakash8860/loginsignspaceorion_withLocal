import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/login_Screen.dart';
import 'package:loginsignspaceorion/main.dart';
import 'package:loginsignspaceorion/wrongpassword.dart';
import 'package:string_validator/string_validator.dart';


void main()=>runApp(MaterialApp(home: SignUpScreen1(),));

class SignupData {
  String email = '';
  String password = '';
  String password2 = '';
  String fname = '';
  String lname = '';
  String pno = '';
  String valuedata;
  String username='';

  checkPassword(){
    if(password.length!=password2.length){
      throw ("Password Doesn't match");
    }else{
        return null;
    }
  }

}
class SignUpScreen1 extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  FocusNode myFocusNode;
  File imageFile;
  bool isHiddenPassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isVisible=false;
  http.Response response;
  SignupData data = new SignupData();
  goToNextPage() {
      setState(() {
        isVisible=true;
      });
    formKey.currentState.save();
    print('clear');
    checkDetails(data).then((value) {
      if(response.statusCode==200){
        final snackBar = SnackBar(
          content: Text('Please Login'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Navigator.of(context)
        //     .pushNamed(LoginScreen.routeName);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
     
    }).catchError((e) {
      print(e);
    });
  }
  checkDetails(SignupData data) async {
    final url = API+'regflu';
    var map = new Map<String, dynamic>();
    map['username'] = data.email;
    map['password1'] = data.password;
    map['password2'] = data.password;
    map['first_name'] = data.fname;
    map['last_name'] = data.lname;
    map['email'] = data.email;
    map['phone_no'] = data.pno;
    response = await http.post(url, body: map,encoding: Encoding.getByName("utf-8"),headers: {HttpHeaders.contentTypeHeader:"application/json"});
    print('response.body');
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      print(data.email);
      return true;
    } else {
      if (response.statusCode == 400) {
        print(response.body);
        print(response.statusCode);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>WrongPassword()));
        throw ("Details Error");
      }
      if (response.statusCode == 500) {
        print(response.statusCode);
        print(response.body);
        print(response.headers);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>WrongPassword()));
        throw ("Internal Server Error");
      }
    }
  }

  // checkDetailsUser(User dataUser) async {
  //   final url = 'https://genorionofficial.herokuapp.com/regflu';
  //   var map = new Map<String, dynamic>();
  //  var postData={
  //    "username":dataUser.email,
  //    "password1":dataUser.password1,
  //    "password2":dataUser.password2,
  //    "first_name":dataUser.firstName,
  //    "last_name":dataUser.lastName,
  //    "email":dataUser.email,
  //    "phone_no":dataUser.phoneNo
  //
  //  };
  //   http.Response response = await http.post(url, body: postData,headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   });
  //   if (response.statusCode >0) {
  //     print(response.statusCode);
  //
  //     return User.fromJson(postData);
  //   } else {
  //
  //     throw Exception('Failed to create User.');
  //   }
  // }

  String nameValid(String value) {
    if (value.isEmpty) {
      return 'Required';
    } else if (!isAlpha(value)) {
      return 'Please Enter Valid Name';
    } else {
      return null;
    }
  }

  // Future checkEmail(evalue) async {
  //   final url = "http://gemorion1.herokuapp.com/ckemail";
  //   var map = new Map<String, dynamic>();
  //   map['email'] = evalue;
  //   http.Response response = await http.post(url, body: map);
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     Map<String, dynamic> map = jsonDecode(response.body);
  //     if (map['Exists']) {
  //       rejectemail = evalue;
  //     } else {
  //       acceptemail = evalue;
  //     }
  //     formKey.currentState.validate();
  //     return;
  //   } else {
  //     print(response.statusCode);
  //     return Future<bool>.value(false);
  //   }
  // }
  //
  // String validateEmail(String value) {
  //   Pattern pattern =
  //       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?)*$";
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value) || value == null)
  //     return 'Enter a valid email address';
  //
  //   if (acceptemail == value) {
  //     goToNextPage();
  //     return null;
  //   } else if (rejectemail == value) {
  //     return "Already Registered";
  //   } else {
  //
  //     return "Checking Email";
  //   }
  // }

  void tooglePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  // ignore: missing_return
  String passwordStrength(value) {
    Pattern pattern = r"^[A-Z a-z]";
    Pattern pattern1 = r"^[0-9]";
    Pattern pattern2 =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})";
    RegExp regExp = new RegExp(pattern);
    RegExp regExp1 = new RegExp(pattern1);
    RegExp regExp2 = new RegExp(pattern2);
    if (regExp2.hasMatch(value) && regExp2 != null) {
      return "Strong Password";
    } else if (regExp.hasMatch(value) && regExp != null) {
      return 'Password is weak only alphabets';
    } else if (regExp1.hasMatch(value) && regExp1 != null) {
      return 'Password is weak only numericals';
    }
  }

  String validatePass(value) {
    if (value.isEmpty) {
      return "Required";
    } else if (value.length < 8) {
      return "should be atleast 8 Character";
    } else if (value.length > 15) {
      return "should not be more than 15 character";
    } else {
      var strength = passwordStrength(value);
      if (strength == "Strong Password") {
        return null;
      } else {
        return strength;
      }
    }
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    } else if (value.length != 10) {
      return "Please Enter the 10 Digit Mobile Number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(

      body: isVisible?Container(color: Colors.blueAccent,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),),):
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
              if(viewportConstraints.maxWidth>600){
                return SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    // color: Theme.of(context).primaryColor,
                    width: double.maxFinite,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: ClipPath(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // CircleAvatar(
                                //   radius: 105,
                                //   backgroundImage: imageFile==null? AssetImage('assets/images/blank.png'):FileImage(File(imageFile.path)),
                                // )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 300,
                                child: TextFormField(
                                  autofocus: true,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  validator: nameValid,
                                  onSaved: (String value) {
                                    this.data.fname = value;
                                  },
                                  style:
                                  TextStyle(fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'First name',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 300,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: nameValid,
                                onSaved: (String value) {
                                  this.data.lname = value;
                                },
                                style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Last name',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Container(
                              width: 300,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                // autovalidateMode: AutovalidateMode.values[2],
                                // validator: validateEmail,
                                onSaved: (String value) {
                                  // ignore: unnecessary_statements
                                  this.data.email = value;
                                },
                                style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter your Email',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 300,
                              child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: validatePass,
                                onSaved: (String value) {
                                  this.data.password = value;
                                },
                                obscureText: isHiddenPassword,
                                style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter your password',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 300,
                              child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: validatePass,
                                onSaved: (String value) {
                                  if(data.password.length==data.password2.length){
                                    this.data.password2=value;
                                  }else{
                                    return Text("Password doesn't match");
                                  }
                                  // this.data.password2 = value;
                                },
                                obscureText: isHiddenPassword,
                                style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Re-enter your password',
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
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 300,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.phone,
                                validator: validateMobile,
                                onSaved: (String value) {
                                  this.data.pno = value;
                                },
                                style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_iphone),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter your Phone Number',
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // ignore: deprecated_member_use
                            Container(
                              width: 300,
                              child: FlatButton(
                                  child: Text(
                                    'Signup',
                                    style: TextStyle(
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
                                    if (formKey.currentState.validate()) {
                                      //data.checkPassword();
                                      goToNextPage();
                                    } else {
                                      print("not validated");
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text('GenOrion'),
                  // backgroundColor: Colors.blueAccent,
                  elevation: 0,
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue, Colors.lightBlueAccent])),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  // color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // CircleAvatar(
                          //   radius: 105,
                          //   backgroundImage: imageFile==null? AssetImage('assets/images/blank.png'):FileImage(File(imageFile.path)),
                          // )
                        ],
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
                        validator: nameValid,
                        onSaved: (String value) {
                          this.data.fname = value;
                        },
                        style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'First name',
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
                        validator: nameValid,
                        onSaved: (String value) {
                          this.data.lname = value;
                        },
                        style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Last name',
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
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        // autovalidateMode: AutovalidateMode.values[2],
                        // validator: validateEmail,
                        onSaved: (String value) {
                          // ignore: unnecessary_statements
                          this.data.email = value;
                        },
                        style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your Email',
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
                        validator: validatePass,
                        onSaved: (String value) {
                          this.data.password = value;
                        },
                        obscureText: isHiddenPassword,
                        style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.security),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your password',
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
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: validatePass,
                        onSaved: (String value) {
                          if(data.password.length==data.password2.length){
                            this.data.password2=value;
                          }else{
                            return Text("Password doesn't match");
                          }
                         // this.data.password2 = value;
                        },
                        obscureText: isHiddenPassword,
                        style:
                        TextStyle(fontSize: 18, color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.security),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Re-enter your password',
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
                        keyboardType: TextInputType.phone,
                        validator: validateMobile,
                        onSaved: (String value) {
                          this.data.pno = value;
                        },
                        style:
                            TextStyle(fontSize: 18, color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone_iphone),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your Phone Number',
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
                      // ignore: deprecated_member_use
                      FlatButton(
                          child: Text(
                            'Signup',
                            style: TextStyle(
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
                            if (formKey.currentState.validate()) {
                                //data.checkPassword();
                               goToNextPage();
                            } else {
                              print("not validated");
                            }
                          }),
                    ],
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
