
import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/dropDown.dart';
import 'package:loginsignspaceorion/dropdown1.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/main.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';

import 'package:loginsignspaceorion/signUp.dart';
import 'package:loginsignspaceorion/wrongpassword.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SQLITE_database/testinghome2.dart';

void main()=>runApp(
    MaterialApp(
      home: LoginScreen(),));

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class LoginData {
  String username = '';
  String password = '';
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode myFocusNode;
  final storage = new FlutterSecureStorage();
  List<Device> dv;
  bool isHiddenPassword = true;
  LoginData data = new LoginData();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String error;
  bool isVisible=false;
  bool _isInAsyncCall = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  goToNextPage() {

    formKey.currentState.save();
    print('clear');
    print(data);
    checkDetails(data).then((value) {
      print(data);

      // Navigator.push(context, MaterialPageRoute(builder: (context)=>DropDown1()));
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => DropDown1()));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => NewDropDown(
      //   )),
      // );
    }).catchError((e) {

      print(e);
      setState(() {
        this.error = "Wrong Credentials";
      });
    });
  }
  goToNextPageWeb() {
// '192.168.0.107':800

    formKey.currentState.save();
    print('clear');
    print(data.username);
    checkDetailsWeb().then((value) {
      print(data.password);

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => DropDown1()));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => NewDropDown(
      //   )),
      // );
    }).catchError((e) {

      print(e);
      setState(() {
        this.error = "Wrong Credentials";
      });
    });
  }
  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }







  checkDetails(LoginData data) async {
    setState(() {
      isVisible=true;
    });
    // final url = 'https://genorion.herokuapp.com/api-token-auth/';
    final url = API+'api-token-auth/';
    print(getToken());
    var map = new Map<String, dynamic>();
    map['username'] = data.username;
    map['password'] = data.password;

    http.Response response = await  http.post(url, body: map);

    print(response);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final storage = new FlutterSecureStorage();
      await storage.write(key: "token", value: map["token"]);
      final all = await storage.readAll();

      print(all);
      await checkUserPlace();

    }

    if (response.statusCode == 400) {
      //  final snackBar=SnackBar(content: Text('Login Successful')
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WrongPassword()));

      throw ("Wrong Credentials");
    }
    if (response.statusCode == 500) {
      throw ("Internal Server Error");
    }

  }

  setToken(token)async{
    final pref= await SharedPreferences.getInstance();
    pref.setString('tokenWeb', token);
  }
  var token12;
  checkDetailsWeb() async {
    print('email ${emailController.text}');
    print('email ${passwordController.text}');
    setState(() {
      isVisible=true;
    });
    // final url = 'http://192.168.0.107:8000/api-token-auth/';
    final url = API+'api-token-auth/';
    var map = new Map<String, dynamic>();
    map['username'] = emailController.text;
    map['password'] = passwordController.text;

    http.Response response = await  http.post(url, body: map);

    print('response.statusCode ${response.statusCode}');
    print('response.statusCode ${response.body}');
    if (response.statusCode == 200) {
     var tokenAuth=jsonDecode(response.body);
      String token= tokenAuth.toString();
      var index= token.indexOf(':');
      token12= token.substring(index+1,token.length-1);
      print('token $index');
      print('token $token12');
      print('token $tokenAuth');
      print('token $tokenAuth');
      setToken(token12);
      await checkUserPlaceWeb(token12);
      // Navigator.of(context).pushNamed('/dropDown1');
      // Navigator.of(context).pushNamed(DropDown1.routeName);

    }else{
      Navigator.of(context).pushNamed(WrongPassword.routeName);
    }
  }
List userPlace;
  PlaceType pt;
  FloorType fl;
  Flat flat;
  List<RoomType> rm=[];

  Future checkUserPlaceWeb(String token)async{
    final url = API+'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if(response.statusCode==200){
      userPlace=jsonDecode(response.body);
        print('userplace $userPlace');
        if(userPlace.isEmpty || userPlace.length==null){
          Navigator.of(context).pushNamed(DropDown1.routeName);
        }else{
          List<dynamic> data = jsonDecode(response.body);
          var places = PlaceType(
              pId: data[0]['p_id'],
              pType: data[0]['p_type'],
              user: data[0]['user']
          );
          setState(() {
            pt = places;

          });
          await getFloorsWeb(pt.pId);
          // Navigator.of(context).pushNamed(DropDown.routeName);
        }

    }
  }

  Future checkUserPlace()async{
    String token = await getToken();
    final url = API+'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if(response.statusCode==200){
      userPlace=jsonDecode(response.body);
      print('userplace $userPlace');
      if(userPlace.isEmpty || userPlace.length==null){
        Navigator.of(context).pushNamed(DropDown1.routeName);
      }else{
        List<dynamic> data = jsonDecode(response.body);
          var places = PlaceType(
              pId: data[0]['p_id'],
              pType: data[0]['p_type'],
              user: data[0]['user']
          );
          setState(() {
            pt = places;

          });
          await getFloors(pt.pId);

        // Navigator.of(context).pushNamed(DropDown.routeName);
      }

    }
  }
  var tokenWeb;
  Future getTokenWeb() async {
    final pref = await SharedPreferences.getInstance();
    tokenWeb = pref.getString('tokenWeb');
    return tokenWeb;
  }
  Future getFloors(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      var floor = FloorType(
        fName: data[0]['f_name'],
        fId: data[0]['f_id'],
        pId: data[0]['f_id'],
        user: data[0]['user']
      );
      setState(() {
        fl = floor;
      });
      await  getFlat(fl.fId);

    }
  }

  Future getFloorsWeb(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      var floor = FloorType(
        fName: data[0]['f_name'],
        fId: data[0]['f_id'],
        pId: data[0]['f_id'],
        user: data[0]['user']
      );
      setState(() {
        fl = floor;
      });
      await  getFlatWeb(fl.fId);

    }
  }

  Future getFlat(String fId) async {
    final url = API + 'addyourflat/?f_id=' + fId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
        var flatData = Flat(
          fId: data[0]['f_id'],
          fltName: data[0]['flt_name'],
          fltId: data[0]['flt_id'],
          user: data[0]['user']
        );

      setState(() {
        flat=flatData;

      });
      await getRooms(flat.fltId) ;
    }
  }
  Future getFlatWeb(String fId) async {
    final url = API + 'addyourflat/?f_id=' + fId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
        var flatData = Flat(
          fId: data[0]['f_id'],
          fltName: data[0]['flt_name'],
          fltId: data[0]['flt_id'],
          user: data[0]['user']
        );

      setState(() {
        flat=flatData;

      });
      await getRoomsWeb(flat.fltId) ;
    }
  }

  Future getRooms(String flt_id) async {
    final url = API + 'addroom/?flt_id=' + flt_id;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        rm = List.generate(data.length, (index) => RoomType(
          rId: data[index]['r_id'].toString(),
          fltId: data[index]['flt_id'].toString(),
          rName:data[index]['r_name'].toString(),
          user: data[index]['user'],
        ));
      });
     await getDevices(rm[0].rId);
    }
  }
  Future getRoomsWeb(String flt_id) async {
    final url = API + 'addroom/?flt_id=' + flt_id;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        rm = List.generate(data.length, (index) => RoomType(
          rId: data[index]['r_id'].toString(),
          fltId: data[index]['flt_id'].toString(),
          rName:data[index]['r_name'].toString(),
          user: data[index]['user'],
        ));
      });
     await getDevicesWeb(rm[0].rId);
    }
  }

  Future getDevices(String rId) async {
    final url = API+'addyourdevice/?r_id='+rId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        dv = List.generate(data.length, (index) => Device(
          rId: data[index]['r_id'],
          dId: data[index]['d_id'],
          user: data[index]['user'],
        ));
      });
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeTest(pt: pt,fl: fl,flat: flat,rm: rm,dv: dv,)));
    }
  }
  Future getDevicesWeb(String rId) async {
    final url = API+'addyourdevice/?r_id='+rId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        dv = List.generate(data.length, (index) => Device(
          rId: data[index]['r_id'],
          dId: data[index]['d_id'],
          user: data[index]['user'],
        ));
      });
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeTest(pt: pt,fl: fl,flat: flat,rm: rm,dv: dv,)));
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';

    return null;
  }

  void _tooglePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  // ignore: missing_return
  String validatePass(value) {
    if (value.isEmpty) {
      return "Required";
    } else if (value.length < 8) {
      return "should be atleast 8 Character";
    } else if (value.length > 15) {
      return "should not be more than 15 character";
    }
  }

  _showDialoge(tittle, text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tittle),
            content: Text(text),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: Navigator.of(context).pop, child: Text('Ok'))
            ],
          );
        });
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectionState.none) {
      return _showDialoge('No Internet', ' check your internet connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(

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
                        colors: [Colors.blue, Colors.lightBlueAccent])),
                child: Form(
                  key: formKey,
                  child: LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {

                          if(viewportConstraints.maxWidth>600){
                            return Container(
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
                                      // Text('Login',style: TextStyle(fontSize: 78),),
                                      SizedBox(
                                        height: 15,
                                      ),

                                      Container(
                                        width: 275,
                                        child: TextFormField(
                                          autofocus: true,
                                          keyboardType: TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () => node.nextFocus(),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: validateEmail,
                                          controller: emailController,
                                          // onSaved: (String value) {
                                          //   this.data.email = value;
                                          // },
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
                                          onEditingComplete: () => node.nextFocus(),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: validatePass,
                                          controller: passwordController,
                                          // onSaved: (String value) {
                                          //   this.data.password = value;
                                          // },
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
                                                onTap: _tooglePassword,
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
                                              print('aaaaaaaaaaaaaa');
                                              checkDetailsWeb();
                                              // Navigator.of(context).pushNamed(DropDown1.routeName);
                                              // if (formKey.currentState.validate()) {
                                              //
                                              //   checkDetailsWeb();
                                              //
                                              // } else {
                                              //   print("not validated");
                                              // }
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
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SignUpScreen1()));
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
                            );
                          }
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('GenOrion'),
                          // automaticallyImplyLeading: false,
                          // elevation: 0,
                        ),
                        body: Container(
                          height: MediaQuery.of(context).size.height,

                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.blue, Colors.lightBlueAccent])),
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
                                    onEditingComplete: () => node.nextFocus(),
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
                                    onEditingComplete: () => node.nextFocus(),
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: validatePass,
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
                                          onTap: _tooglePassword,
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

                                            goToNextPage();

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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpScreen1()));
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
      ),
    );
  }
}
