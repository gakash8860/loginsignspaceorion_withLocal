import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Setting_Page.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //  fontFamily: 'Satisfy',
        fontFamily: fonttest,
        primarySwatch: Colors.blue,
      ),
      home: ChangeFont(),
    );
  }
}

var font1 = 'Setting';
var font2 = 'RobotoMono';
var font3='Satisfy';
var fonttest = font2;

class ChangeFont extends StatefulWidget {
  ChangeFont({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChangeFontState createState() => _ChangeFontState();
}

class _ChangeFontState extends State<ChangeFont> {
  int _counter = 0;

  // void _fontfunction() {
  //   setState(() {
  //     if (fonttest == font1) {
  //       fonttest = font2;
  //       print(fonttest);
  //       runApp(MaterialApp(home: HomeTest(),));
  //     } else if (fonttest == font2) {
  //       fonttest = font3;
  //       print(fonttest);
  //       runApp(MaterialApp(home: HomeTest(),));
  //     }else if(fonttest == font3){
  //       fonttest = font1;
  //       print(fonttest);
  //       runApp(MaterialApp(home: HomeTest(),));
  //
  //     }
  //   });
  // }


  Future _setFont( font)async{
    final pref= await SharedPreferences.getInstance();
    pref.setString('font', font);

  }
  var font;
  _getFont()async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    font= pref.getString('font');
    print('number147859 ${font}');
  }
  _removeFont()async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    // number= pref.getString('mobileNumber');
    pref.remove('mobileNumber');
    print('number147859 ${font}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        title: Text("Genorion"  ,
            style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest)),
      ),
      body: Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(118.0),
            child: ElevatedButton(
                onPressed: ()async{
                  await _getFont();
                  if(font==null ||font!=null ){
                    await _removeFont();
                    if (fonttest == font1 ||fonttest == null||fonttest != font1) {
                      fonttest = font1;
                     await _setFont(fonttest);
                      print('fonttest');
                      runApp(MaterialApp(home: ChangeFont(),));
                    }
                  }else{
                    print('eleseFont');
                    fonttest=font;
                  }

                },
                child: Text('Font 1',style: TextStyle(fontFamily: fonttest==null?'Setting':'Setting'))),
          ),
          SizedBox(height: 147,),
          ElevatedButton(
              onPressed: ()async{
                // await _getFont();
                // if(font==null ||font!=null ){
                //   await _removeFont();
                //   if (fonttest == font1 ||fonttest == null||fonttest != font1) {
                //     fonttest = font2;
                //     await _setFont(fonttest);
                //     print(fonttest);
                //
                //   }
                // }else{
                //   print('eleseFont');
                //   fonttest=font;
                // }

                        // if (fonttest == font1 ||fonttest == null||fonttest != font1) {
                        //   fonttest = font2;
                        //   print(fonttest);
                        //   runApp(MaterialApp(home: SettingPage(),));
                        // }
              },
              child: Text('Font 2 ',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':'RobotoMono'))),
          ElevatedButton(
              onPressed: ()async{
                await _getFont();
                if(font==null ||font!=null ){
                  await _removeFont();
                  if (fonttest == font1 ||fonttest == null||fonttest != font1) {
                    fonttest = font3;
                    await _setFont(fonttest);
                    print(fonttest);
                    runApp(MaterialApp(home: ChangeFont(),));

                  }
                }else{
                  print('eleseFont');
                  fonttest=font;
                }
              },
              child: Text('Font 3',style: TextStyle(fontFamily: fonttest==null?'Satisfy':'Satisfy'))),
        ],
      ),

      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _fontfunction,
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
