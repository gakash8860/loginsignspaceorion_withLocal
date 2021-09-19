import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Setting_Page.dart';

void main() {
  runApp(MyApp());
}

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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Container();
      }else{
          return Scaffold(
            appBar: AppBar(

              title: Text("Genorion"  ,
                  style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest)),
            ),
            body: Container(
              color: Colors.yellow,
              child: SingleChildScrollView(
                child: Flexible(
                  child: Column(
                    children: [
                      Card(
                       margin: EdgeInsets.only(
                           top: MediaQuery.of(context).size.height/40,
                           left: MediaQuery.of(context).size.height/25,
                           right: MediaQuery.of(context).size.width/25,
                           bottom: MediaQuery.of(context).size.height/2.8),
                       clipBehavior: Clip.antiAlias,
                       color: change_toDark ? Colors.black : Colors.white,
                       // elevation: 4.0,
                       child: Column(
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(18.0),
                             child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '),
                           ),
                           ElevatedButton(
                               onPressed: (){

                               },
                               child: Text('Button'))
                         ],
                       ),
                        ),
                      Card(
                       margin: EdgeInsets.only(
                           top: MediaQuery.of(context).size.height/40,
                           left: MediaQuery.of(context).size.height/25,
                           right: MediaQuery.of(context).size.width/25,
                           bottom: MediaQuery.of(context).size.height/2.8),
                       clipBehavior: Clip.antiAlias,
                       color: change_toDark ? Colors.black : Colors.white,
                       // elevation: 4.0,
                       child: Column(
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '),
                           ),
                           ElevatedButton(
                               onPressed: (){

                               },
                               child: Text('Button'))
                         ],
                       ),
                        ),
                      Card(
                       margin: EdgeInsets.only(
                           top: MediaQuery.of(context).size.height/40,
                           left: MediaQuery.of(context).size.height/25,
                           right: MediaQuery.of(context).size.width/25,
                           bottom: MediaQuery.of(context).size.height/2.8),
                       clipBehavior: Clip.antiAlias,
                       color: change_toDark ? Colors.black : Colors.white,
                       // elevation: 4.0,
                       child: Column(
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '),
                           ),
                           ElevatedButton(
                               onPressed: (){

                               },
                               child: Text('Button'))
                         ],
                       ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          );
      }
        }

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _fontfunction,
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
