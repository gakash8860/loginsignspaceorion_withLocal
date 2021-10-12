import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../login_Screen.dart';

void main()=>runApp(MaterialApp(
  home:LoginSmallScreen() ,
));

class LoginSmallScreen extends StatefulWidget {


  @override
  _LoginSmallScreenState createState() => _LoginSmallScreenState();
}

class _LoginSmallScreenState extends State<LoginSmallScreen> {
  int _currentIndex = 0;
  FocusNode myFocusNode;
  final storage = new FlutterSecureStorage();
  List<Device> dv;
  bool isHiddenPassword = true;
  LoginData data = new LoginData();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String error;
  bool isVisible=false;
  bool _isInAsyncCall = false;


  @override
  void initState() {
    super.initState();
    // _currentIndex = widget.currentIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GenOrion"),
      ),
        body:isVisible?Container(color: Colors.blueAccent,child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),),): ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          progressIndicator:CircularProgressIndicator() ,
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Colors.black])),
              child: Form(
                key: formKey,
                child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints viewportConstraints) {

                    if(viewportConstraints.maxWidth>600){
                      return Column(
                        children: [
                          Container(
                              width: 250,
                              child: Center(child: Image.asset('assets/images/genLogo.png'))),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            // color: Theme.of(context).primaryColor,

                            child: ClipPath(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  // Image.asset(
                                  //   'assets/images/signin.png',
                                  //   height: 130,
                                  // ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Container(
                                    width: 275,
                                    child: TextFormField(
                                      autofocus: true,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,

                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      // validator: validateEmail,
                                      onSaved: (String value) {
                                        this.data.username = value;
                                      },
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter your Email',
                                        errorText: this.error,
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
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 275,
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      // onEditingComplete: () => node.nextFocus(),
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      // validator: validatePass,
                                      onSaved: (String value) {
                                        this.data.password = value;
                                      },
                                      obscureText: isHiddenPassword,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.security),
                                        errorText: this.error,
                                        errorStyle: TextStyle(),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter your password',
                                        suffixIcon: InkWell(
                                            // onTap: _tooglePassword,
                                            child: Icon(isHiddenPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off)),
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
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  // ignore: deprecated_member_use
                                  Container(
                                    width: 275,
                                    child: FlatButton(
                                        child: Text(
                                          'Login',
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

                                          if (formKey.currentState.validate()) {

                                            // goToNextPage();

                                          } else {
                                            print("not validated");
                                          }
                                        }),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    verticalDirection: VerticalDirection.down,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Text(
                                              'Create new Account ?? ',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             SignUpScreen1()
                                              //     ));
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return SingleChildScrollView(
                      // dragStartBehavior: DragStartBehavior.down,
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        // color: Theme.of(context).primaryColor,

                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: ClipPath(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                // Image.asset(
                                //   'assets/images/signin.png',
                                //   height: 130,
                                // ),
                                SizedBox(
                                  height: 15,
                                ),

                                TextFormField(
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  // onEditingComplete: () => node.nextFocus(),
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  // validator: validateEmail,
                                  onSaved: (String value) {
                                    this.data.username = value;
                                  },
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter your Email',
                                    errorText: this.error,
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
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  // onEditingComplete: () => node.nextFocus(),
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  // validator: validatePass,
                                  onSaved: (String value) {
                                    this.data.password = value;
                                  },
                                  obscureText: isHiddenPassword,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.security),
                                    errorText: this.error,
                                    errorStyle: TextStyle(),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter your password',
                                    suffixIcon: InkWell(
                                        // onTap: _tooglePassword,
                                        child: Icon(isHiddenPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
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

                                SizedBox(
                                  height: 15,
                                ),
                                // ignore: deprecated_member_use
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: FlatButton(
                                      child: Text(
                                        'Login',
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

                                        if (formKey.currentState.validate()) {

                                          // goToNextPage();

                                        } else {
                                          print("not validated");
                                        }
                                      }),
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Text(
                                            'Create new Account ?? ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onTap: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                                        // SignUpScreen1()));
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
          ),
        )
    );
  }
}
