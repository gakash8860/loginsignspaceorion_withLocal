// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:http/http.dart'as http;
// // void main()=>runApp(MaterialApp(
// //   home:GetApi() ,
// // ));
// // class GetApi extends StatefulWidget {
// //   const GetApi({Key key}) : super(key: key);
// //
// //   @override
// //   _GetApiState createState() => _GetApiState();
// // }
// //
// // class _GetApiState extends State<GetApi> {
// //
// //   Future<dynamic> getApi()async{
// //     final token='991e2c065477866a5c981802812aaee561398afc';
// //     // final url= 'http://localhost:5000';
// //     final url= 'http://127.0.0.1:8000/?p_id=8537388';
// //     print('statusCode ' );
// //     final response= await http.get(url,headers: {
// //       'Content-Type': 'application/json',
// //       'Accept': 'application/json',
// //     "Access-Control_Allow_Origin": "*",
// //       'Authorization': 'Token $token',
// //     });
// //     print('statusCode14 ${response.statusCode}' );
// //     if (response.statusCode > 0) {
// //       print('statusCode ${response.statusCode}' );
// //     }
// //   }
// // var icon1=FontAwesomeIcons.fan;
// // var icon2=Icons.update;
// // var icon3=Icons.forward;
// // var changeIcon=null;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('AA'),
// //       ),
// //       body: Center(
// //         child: Container(
// //           child: ListofIcons(),
// //           // child: Column(
// //           //   children: [
// //           //     SizedBox(height: 147,),
// //           //     Icon(changeIcon),
// //           //     ElevatedButton(
// //           //       onPressed: (){
// //           //         if(changeIcon==null ||changeIcon!=null ){
// //           //           changeIcon =icon1;
// //           //           runApp(MaterialApp(
// //           //             home:GetApi() ,
// //           //           ));
// //           //         }
// //           //         },
// //           //       child: Text('Hit'),
// //           //     ),
// //           //     SizedBox(height: 14,),
// //           //
// //           //     ElevatedButton(
// //           //       onPressed: (){
// //           //         if(changeIcon==null ||changeIcon!=null ){
// //           //           changeIcon =icon2;
// //           //           runApp(MaterialApp(
// //           //             home:GetApi() ,
// //           //           ));
// //           //         }
// //           //       },
// //           //       child: Text('icon2'),
// //           //     ),
// //           //   ],
// //           // ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   Widget ListofIcons(){
// //     return ListView.builder(
// //         itemCount: 9,
// //         itemBuilder: (context,index){
// //           return Card(
// //             child: GestureDetector(
// //                 onTap: (){
// //             if(changeIcon==null ||changeIcon!=null ){
// //                         changeIcon =icon2;
// //                         runApp(MaterialApp(
// //                           home:GetApi() ,
// //                         ));
// //                       }
// //                 },
// //                 child: Icon(changeIcon)
// //
// //             ),
// //           );
// //         }
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// void main()=>runApp(MaterialApp(
//   home: DropDownDemo(),
// ));
//
// class DropDownDemo extends StatefulWidget {
//   @override
//   _DropDownDemoState createState() => _DropDownDemoState();
// }
//
// class _DropDownDemoState extends State<DropDownDemo> {
//   String _chosenValue;
//
//   var icon1=FontAwesomeIcons.ring;
//   var icon2=FontAwesomeIcons.bullhorn;
//   var icon3=FontAwesomeIcons.mobile;
//   var changeIcon=null;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DropDown'),
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(0.0),
//           child: Column(
//             children: [
//               DropdownButton<String>(
//                 value: _chosenValue,
//                 //elevation: 5,
//                 style: TextStyle(color: Colors.black),
//
//                 items: <String>[
//                   'Fan',
//                   'Bulb',
//                   'Mobile',
//                   // 'Node',
//                   // 'Java',
//                   // 'Python',
//                   // 'PHP',
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 hint: Text(
//                   "Please choose a language",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 onChanged: (String value) {
//                   setState(() {
//                     _chosenValue = value;
//                     if(_chosenValue=='Fan'){
//                       changeIcon=icon1;
//                       print('true');
//                     }else if(_chosenValue=='Bulb'){
//                       changeIcon=icon2;
//                       print('true');
//                     }else if(_chosenValue=='Mobile'){
//                       changeIcon=icon3;
//                       print('true');
//                     }
//                     // changeIcon=value;
//                   });
//                 },
//               ),
//               Icon(changeIcon==null?Icons.forward:changeIcon)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

Future createAlbum() async {
  String token='d47d6e9a942dc30250308706527ba29343ad975f';
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      }
  );

  print('response.body');
  if (response.statusCode >0) {

    print(response.statusCode);
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  Album({ this.id,  this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            createAlbum();
            setState(() {

            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}