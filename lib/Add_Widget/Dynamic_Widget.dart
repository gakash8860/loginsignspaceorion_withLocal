// // import 'package:custom_switch/custom_switch.dart';
// // import 'package:flutter/material.dart';
// // import 'package:syncfusion_flutter_sliders/sliders.dart';
// // // import 'package:syncfusion_flutter_sliders/sliders.dart';
// // // class DynamicWidget extends StatelessWidget {
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //
// // //     bool _switchValue=true;
// // //     return  SingleChildScrollView(
// // //       scrollDirection: Axis.vertical,
// // //       child: Container(
// // //
// // //           alignment: Alignment.topCenter,
// // //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
// // //           height: 630,
// // //           child: GridView.count(
// // //               mainAxisSpacing: 10,
// // //               crossAxisSpacing: 10,
// // //               crossAxisCount: 2,
// // //               padding: EdgeInsets.all(0),
// // //               children:<Widget>[
// // //                 Column(
// // //                   children: [
// // //                     Row(
// // //                       children: [
// // //                         Container(
// // //                           height: 120,
// // //                           padding: EdgeInsets.symmetric(horizontal:60, vertical: 50),
// // //                           // margin: index % 2 == 0
// // //                           //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
// // //                           //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
// // //                           margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
// // //                           decoration: BoxDecoration(
// // //                               boxShadow: <BoxShadow>[
// // //                                 BoxShadow(
// // //                                     blurRadius: 10,
// // //                                     offset: Offset(0, 10),
// // //                                     color: Colors.black)
// // //                               ],
// // //                               color: Colors.white,
// // //                               border: Border.all(
// // //                                   width: 1,
// // //                                   style: BorderStyle.solid,
// // //                                   color: Color(0xffa3a3a3)),
// // //                               borderRadius: BorderRadius.circular(20)),
// // //                           // child:CustomSwitch(
// // //                           //   value: _switchValue,
// // //                           //   activeColor: Color(0xff457be4),
// // //                           // ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 )
// // //
// // //               ]
// // //           )),
// // //     );
// // //     Container(
// // //       child: GridView(
// // //
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // class DynamicWidget extends StatelessWidget {
// //   bool  _switchValue=false;
// //   // ignore: non_constant_identifier_names
// //   int value_Holder=3;
// //   @override
// //   Widget build(BuildContext context) {
// //     return  Container(
// //
// //         alignment: Alignment.topCenter,
// //         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
// //         // height: 430,
// //         child: GridView.count(
// //             mainAxisSpacing: 1,
// //             crossAxisSpacing: 1,
// //             crossAxisCount: 1,
// //             padding: EdgeInsets.all(0),
// //             children:<Widget>[
// //               Column(
// //
// //                 children: [
// //                   Container(
// //                     // height: 120,
// //                     padding: EdgeInsets.symmetric(horizontal:30, vertical: 50),
// //                     // margin: index % 2 == 0
// //                     //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
// //                     //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
// //                     margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
// //                     decoration: BoxDecoration(
// //                         boxShadow: <BoxShadow>[
// //                           BoxShadow(
// //                               blurRadius: 10,
// //                               offset: Offset(0, 10),
// //                               color: Colors.black)
// //                         ],
// //                         color: Colors.white,
// //                         border: Border.all(
// //                             width: 1,
// //                             style: BorderStyle.solid,
// //                             color: Color(0xffa3a3a3)),
// //                         borderRadius: BorderRadius.circular(20)),
// //                     child:CustomSwitch(
// //                       value:_switchValue,
// //                       activeColor: Color(0xff457be4),
// //                       onChanged: (bool newValue){
// //                         _switchValue=newValue;
// //
// //                         //  setState(() {    _switch = _switch1;});
// //                         //print(_switchValue);
// //                         // createAlbum();
// //                       },
// //                     ),
// //                     //  child:CustomSwitch(
// //                     //   value: _switchValue,
// //                     //   activeColor: Color(0xff457be4),
// //                     // ),
// //                   ),
// //
// //                 ],
// //               )
// //
// //             ]
// //         ));
// //
// //   }
// //
// // }
// // // ignore: must_be_immutable
// // class Add_Slider extends StatelessWidget {
// //   int value_Holder=3;
// //   @override
// //   Widget build(BuildContext context) {
// //     return  SingleChildScrollView(
// //       child: Container(
// //
// //           alignment: Alignment.topCenter,
// //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
// //           height: 430,
// //           child: GridView.count(
// //               mainAxisSpacing: 1,
// //               crossAxisSpacing: 1,
// //               crossAxisCount: 1,
// //               padding: EdgeInsets.all(10),
// //               children:<Widget>[
// //                 Column(
// //
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.all(88.0),
// //                       child: Container(
// //                         height: 120,
// //                         padding: EdgeInsets.symmetric(horizontal:30, vertical: 50),
// //                         // margin: index % 2 == 0
// //                         //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
// //                         //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
// //                         margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
// //                         decoration: BoxDecoration(
// //                             boxShadow: <BoxShadow>[
// //                               BoxShadow(
// //                                   blurRadius: 10,
// //                                   offset: Offset(0, 10),
// //                                   color: Colors.black)
// //                             ],
// //                             color: Colors.white,
// //                             border: Border.all(
// //                                 width: 1,
// //                                 style: BorderStyle.solid,
// //                                 color: Color(0xffa3a3a3)),
// //                             borderRadius: BorderRadius.circular(20)),
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.end,
// //                           children: [
// //                             SfSlider.vertical(
// //                               min: 1.0,
// //                               max: 10.0,
// //                               value: value_Holder.toDouble(),
// // // interval: 5,
// //                               showTicks: true,
// //                               showLabels: true,
// //                               enableTooltip: true,
// // // minorTicksPerInterval: 1,
// //                               onChanged: (dynamic value){
// //                                 value_Holder = value;
// //                               },
// //                             ),
// //                           ],
// //                         ),
// //                         //  child:CustomSwitch(
// //                         //   value: _switchValue,
// //                         //   activeColor: Color(0xff457be4),
// //                         // ),
// //                       ),
// //                     ),
// //
// //                   ],
// //                 )
// //
// //               ]
// //           )),
// //     );
// //   }
// // }
// import 'dart:convert';
//
// import 'package:connectivity/connectivity.dart';
// import 'package:custom_switch/custom_switch.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:loginsignspaceorion/widget/custom_Switch.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:http/http.dart' as http;
// void main()=>runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: DynamicWidget(null),
// ));
//
// class DynamicWidget extends StatefulWidget {
//   int switch_1=0 ,switch_2=0 ,switch_3=0 ,switch_4=0 ,switch_5=0 ,switch_6=0,switch_7=0 ,switch_8=0,switch_9=0 ;
//
//   DynamicWidget(int i);
//
//   @override
//   _DynamicWidgetState createState() => _DynamicWidgetState();
// }
//
// class _DynamicWidgetState extends State<DynamicWidget> {
//   var switch_1_get;
//
//   var  switch_2_get, switch_3_get,switch_4_get,switch_5_get,switch_6_get,switch_7_get,switch_8_get,switch_9_get;
//
//   var data;
//
//   String icon;
//
//   String name;
//
//
//   int j=0,k=0 ;
//
//   int l=0;
//   int m=0,n=0,o=0,p=0,q=0,r=0,s=0,t=0;
//   int c=0;
//
//   bool  _switchValue=false;
//
//   bool  _switchValue1=true;
//   final storage = new FlutterSecureStorage();
//   int value_Holder=3;
//
//
//
//   changedSwitchMethod(){
//     Map<String,int> qwert=Map();
//     qwert["switch 1"]=0;
//     qwert["switch 2"]=0;
//     qwert["switch 3"]=0;
//     qwert["switch 4"]=0;
//     qwert["switch 5"]=0;
//     qwert["switch 6"]=0;
//     qwert["switch 7"]=0;
//     qwert["switch 8"]=0;
//     qwert["switch 9"]=0;
//
//
//     for(int i=0;i<qwert.length;i++){
//
//     }
//   }
//
//   dataUpdate() async {
//     final String url='https://genorion1234.herokuapp.com/devicePinStatus/';
//     String token='1589f3e0683c170daaf849438c56f5188d068b11';
//     Map data = {'put': 'yes',
//       'd_id': '1',
//       'pin1Status': widget.switch_1 ,
//       'pin2Status': widget.switch_2,
//       'pin3Status':widget.switch_3,
//       'pin4Status':widget.switch_4,
//       'pin5Status':widget.switch_5,
//       'pin6Status':widget.switch_6,
//       'pin7Status':widget.switch_7,
//       'pin8Status':widget.switch_8,
//       'pin9Status':widget.switch_9,
//       'pin10Status':j,
//       'pin11Status':k,
//       'pin12Status':l,
//       'pin13Status':m,
//       'pin14Status':n,
//       'pin15Status':o,
//       'pin16Status':p,
//       'pin17Status':q,
//       'pin18Status':r,
//       'pin19Status':s,
//       'pin20Status':t
//     };
//     //var map = new Map<String,dynamic>();
//     // map['put']="yes";
//     // map['user']="1";
//     // // map['id']="1";
//     // map['p_id']="1";
//     // map['p_type']="Home";
//
//     http.Response response = await http.post(url,
//         body:jsonEncode(data),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization':'Token $token',
//         }
//     );
//     if (response.statusCode == 201) {
//       print(response.body);
//       print(widget.switch_1);
//       print("Ffffffffffffffffffffff");
//       //jsonDecode only for get method
//       //return place_type.fromJson(jsonDecode(response.body));
//     } else {
//       print(response.statusCode);
//       throw Exception('Failed to Update data');
//     }
//   }
//
//   getData() async{
//     final String url='https://genorion1234.herokuapp.com/devicePinStatus/?d_id=1';
//     String token='ecc609cd9b5a54b72b972ac42ba56a38cab39732';
//
//     http.Response response = await http.get(url,
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization':'Token $token',
//         });
//     // deserialize the pins values
//     // then update the variables accordingly
//     // a, b , c
//     // then update the switch status too
//     if (response.statusCode == 200) {
//       //print(response.body);
//       data = jsonDecode(response.body);
//       // print(data);
//       print('\n');
//       switch_1_get = data["pin1Status"];
//
//       switch_2_get = data["pin2Status"];
//       switch_3_get = data["pin3Status"];
//       switch_4_get = data["pin4Status"];
//       switch_5_get = data["pin5Status"];
//       switch_6_get = data["pin6Status"];
//       switch_7_get = data["pin7Status"];
//       switch_8_get = data["pin8Status"];
//       switch_9_get = data["pin9Status"];
//
//
//       print(switch_1_get);
//       print(switch_2_get);
//       print(switch_2_get);
//
//       // print("Ffffffffffffffffffffff");
//       //jsonDecode only for get method
//       //return place_type.fromJson(jsonDecode(response.body));
//     } else {
//       print(response.statusCode);
//       throw Exception('Failed to create album.');
//     }
//     // if (widget.x_get == 1) {return true;}
//     // else {return false;}
//
//   }
//
//
//   Future<String> getToken() async {
//     final token = await storage.read(key: "token");
//     return token;
//   }
//
//   // getIp()async{
//   //   String token = await getToken();
//   //   final response = await http.get(url, headers: {
//   //     'Content-Type': 'application/json',
//   //     'Accept': 'application/json',
//   //     'Authorization': 'Token $token',
//   //   }
//   //   );
//   //
//   //   if (response.statusCode >0) {
//   //     print(response.statusCode);
//   //    print(response.body);
//   //    var ipResponse= jsonDecode(response.body);
//   //    return ipResponse;
//   //   }else{
//   //     print(response.statusCode);
//   //   }
//   // }
//
//
//
//
//   _checkInternetConnectivity() async {
//     // print('AAAA');
//     var result = await Connectivity().checkConnectivity();
//     if (result == ConnectivityResult.none) {
//       messageSms(context);
//       // return _showDialoge('No Internet', ' check your internet connection');
//     }else if(result == ConnectivityResult.wifi){
//
//     }
//
//
//     getIp(){
//       final url = 'http://genorionofficial.herokuapp.com/addipaddress/';
//       String token='b6625e2b625e920c1828a8244bdea9b84a6a5ae3';
//       var postData={
//         "user":3,
//         "p_type":data
//       };
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//
//         alignment: Alignment.topCenter,
//         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
//         height: 430,
//         child: GridView.count(
//             mainAxisSpacing: 1,
//             crossAxisSpacing: 1,
//             crossAxisCount: 1,
//             padding: EdgeInsets.all(0),
//             children:<Widget>[
//               Column(
//
//                 children: [
//                   Container(
//                     // height: 120,
//                     padding: EdgeInsets.symmetric(horizontal:30, vertical: 50),
//                     // margin: index % 2 == 0
//                     //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
//                     //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
//                     margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
//                     decoration: BoxDecoration(
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                               blurRadius: 10,
//                               offset: Offset(0, 10),
//                               color: Colors.black)
//                         ],
//                         color: Colors.white,
//                         border: Border.all(
//                             width: 1,
//                             style: BorderStyle.solid,
//                             color: Color(0xffa3a3a3)),
//                         borderRadius: BorderRadius.circular(20)),
//                     child: ((switch_1_get==1)?CustomSwitch(
//                       value:_switchValue1,
//                       activeColor: Color(0xff457be4),
//                       onChanged: (bool newValue){
//
//                         _checkInternetConnectivity();
//
//                         // if(a==0){
//                         //   a=1;
//                         // }else if(a==1){a=1;}
//                         // if(a==0){a=1;}else if(b==0){b=1;}else if(c==0){c=1;}else if(d==0){d=1;}else if(g==0){g=1;} else if(h==0){h=1;}else if(i==0){i=1;}
//                         // else{ if(a==1){a=0;}else if(b==1){b=0;}else if(c==1){c=0;}else if(d==1){d=0;}else if(e==1){e=0;}else if(f==1){f=0;}else if(g==1){g=0;}else if(h==1){h=0;}else if(i==1){i=0;}}
//                         // for (int arr = 0; arr<9; arr++) {
//                         //   if (switch_changed_value[i])
//                         //     if (switch_value[i]==1 ) { switch_ =0} else {switch_1 = 1}
//                         // }
//                         //
//                         // if(switch_1)
//
//                         // for(int i=0;i<=switch_changed_value.length;i++){
//                         //   if(switch_changed_value[i]==0){
//                         //     switch_changed_value[i]=1;
//                         //   }else if(switch_changed_value[i]==0){
//                         //     switch_changed_value[i]=1;
//                         //   }
//                         // }
//                         // read_device_id.createState().listDynamic[0]==0
//                         //
//                         // switch(read_device_id.createState().listDynamic.length){
//                         //   case 1:{if(read_device_id.createState().switch_1==0){read_device_id.createState().switch_1=1;}
//                         //   else if(read_device_id.createState().switch_1==1){read_device_id.createState().switch_1=1;}}
//                         //   dataUpdate();
//                         //   break;
//                         //   case 2:{if(widget.switch_2==0){widget.switch_2=1;}
//                         //   else if(widget.switch_2==1){widget.switch_2=1;}}
//                         //   break;
//                         //   case 3:{if(widget.switch_3==0){widget.switch_3=1;}
//                         //   else if(widget.switch_3==1){widget.switch_3=1;}}
//                         //   break;
//                         //   case 4:{if(widget.switch_4==0){widget.switch_4=1;}
//                         //   else if(widget.switch_4==1){widget.switch_4=1;}}
//                         //   break;
//                         //   case 5:{if(widget.switch_5==0){widget.switch_5=1;}
//                         //   else if(widget.switch_5==1){widget.switch_5=1;}}
//                         //   break;
//                         //   case 6:{if(widget.switch_6==0){widget.switch_6=1;}
//                         //   else if(widget.switch_6==1){widget.switch_6=1;}}
//                         //   break;
//                         //   case 7:{if(widget.switch_7==0){widget.switch_7=1;}
//                         //   else if(widget.switch_7==1){widget.switch_7=1;}}
//                         //   break;
//                         //   case 8:{if(widget.switch_8==0){widget.switch_8=1;}
//                         //   else if(widget.switch_8==1){widget.switch_8=1;}}
//                         //   break;
//                         //   case 9:{if(widget.switch_9==0){widget.switch_9=1;}
//                         //   else if(widget.switch_9==1){widget.switch_9=1;}}
//                         //   break;
//                         //
//                         // }
//
//
//                         //
//                         //
//                         // switch(read_device_id.createState().listDynamic.length){
//                         //   case 1:{if( read_device_id.createState().listDynamic[1]==0){read_device_id.createState().listDynamic[1]=1 as DynamicWidget;}
//                         //   else if(widget.switch_1==1){widget.switch_1=1;}}
//                         //   break;
//                         //   case 2:{if( read_device_id.createState().listDynamic[1]==0){widget.switch_2=1;}
//                         //   else if(widget.switch_2==1){widget.switch_2=1;}}
//                         //   break;
//                         //   case 3:{if( read_device_id.createState().listDynamic[2]==0){widget.switch_3=1;}
//                         //   else if(widget.switch_3==1){widget.switch_3=1;}}
//                         //   break;
//                         //   case 4:{if( read_device_id.createState().listDynamic[3]==0){widget.switch_4=1;}
//                         //   else if(widget.switch_4==1){widget.switch_4=1;}}
//                         //   break;
//                         //   case 5:{if( read_device_id.createState().listDynamic[4]==0){widget.switch_5=1;}
//                         //   else if(widget.switch_5==1){widget.switch_5=1;}}
//                         //   break;
//                         //   case 6:{if( read_device_id.createState().listDynamic[5]==0){widget.switch_6=1;}
//                         //   else if(widget.switch_6==1){widget.switch_6=1;}}
//                         //   break;
//                         //   case 7:{if( read_device_id.createState().listDynamic[6]==0){widget.switch_7=1;}
//                         //   else if(widget.switch_7==1){widget.switch_7=1;}}
//                         //   break;
//                         //   case 8:{if( read_device_id.createState().listDynamic[7]==0){widget.switch_8=1;}
//                         //   else if(widget.switch_8==1){widget.switch_8=1;}}
//                         //   break;
//                         //   case 9:{if( read_device_id.createState().listDynamic[8]==0){widget.switch_9=1;}
//                         //   else if(widget.switch_9==1){widget.switch_9=1;}}
//                         //   break;
//                         //
//                         // }
//                         //
//                         // read_device_id.createState().listDynamic.map((index){
//                         //
//                         //   // if(read_device_id.createState().listDynamic[0]!=1){
//                         //   //   read_device_id.createState().listDynamic[0]=1;
//                         //   // }
//                         //
//                         //
//                         //
//                         //
//                         //
//                         //
//                         //
//                         //   switch(read_device_id.createState().listDynamic.length){
//                         //     case 1:{if( read_device_id.createState().listDynamic[0]==0){widget.switch_1=1;}
//                         //     else if(widget.switch_1==1){widget.switch_1=1;}}
//                         //     break;
//                         //     case 2:{if( read_device_id.createState().listDynamic[1]==0){widget.switch_2=1;}
//                         //     else if(widget.switch_2==1){widget.switch_2=1;}}
//                         //     break;
//                         //     case 3:{if( read_device_id.createState().listDynamic[2]==0){widget.switch_3=1;}
//                         //     else if(widget.switch_3==1){widget.switch_3=1;}}
//                         //     break;
//                         //     case 4:{if( read_device_id.createState().listDynamic[3]==0){widget.switch_4=1;}
//                         //     else if(widget.switch_4==1){widget.switch_4=1;}}
//                         //     break;
//                         //     case 5:{if( read_device_id.createState().listDynamic[4]==0){widget.switch_5=1;}
//                         //     else if(widget.switch_5==1){widget.switch_5=1;}}
//                         //     break;
//                         //     case 6:{if( read_device_id.createState().listDynamic[5]==0){widget.switch_6=1;}
//                         //     else if(widget.switch_6==1){widget.switch_6=1;}}
//                         //     break;
//                         //     case 7:{if( read_device_id.createState().listDynamic[6]==0){widget.switch_7=1;}
//                         //     else if(widget.switch_7==1){widget.switch_7=1;}}
//                         //     break;
//                         //     case 8:{if( read_device_id.createState().listDynamic[7]==0){widget.switch_8=1;}
//                         //     else if(widget.switch_8==1){widget.switch_8=1;}}
//                         //     break;
//                         //     case 9:{if( read_device_id.createState().listDynamic[8]==0){widget.switch_9=1;}
//                         //     else if(widget.switch_9==1){widget.switch_9=1;}}
//                         //     break;
//                         //
//                         //   }
//                         //
//                         // }).toList();
//
//
//
//                         // if(read_device_id.createState().dynamicWidget.switch_1==0){
//                         //   read_device_id.createState().dynamicWidget.switch_1=1;
//                         // }else if(read_device_id.createState().dynamicWidget.switch_1==1){
//                         //   read_device_id.createState().dynamicWidget.switch_1=0;
//                         // }
//                         dataUpdate();
//
//                         // if((widget.switch_1==0) || (widget.switch_2==0) || (widget.switch_3==0) || (widget.switch_4==0) || (widget.switch_5==0) || (widget.switch_6==0) || (widget.switch_7==0) ||(widget. switch_8==0) || (widget.switch_9==0)){
//                         //   widget.switch_1=1 ; widget.switch_2=1 ; widget.switch_3=1 ; widget.switch_4=1 ; widget.switch_5=1 ; widget.switch_6=1 ;widget.switch_7=1 ; widget.switch_8=1;  widget.switch_9=1;
//                         // }else if( (widget.switch_1==1) || (widget.switch_2==1) || (widget.switch_3==1) || (widget.switch_4==1) || (widget.switch_5==1) || (widget.switch_6==1) || (widget.switch_7==1) || (widget.switch_8==1) || (widget.switch_9==1))
//                         // {widget.switch_1=0;  widget.switch_2=0 ; widget.switch_3=0;  widget.switch_4=0; widget.switch_5=0; widget.switch_6=0;  widget.switch_7=0; widget.switch_8=0; widget.switch_9=0;}
//                         // dataUpdate();
//                         _switchValue=newValue;
//
//
//
//                       },
//                     ):CustomSwitch(
//                       value:_switchValue,
//                       activeColor: Color(0xff457be4),
//                       onChanged: (bool newValue){
//
//                         _checkInternetConnectivity();
//
//                         // print(read_device_id.createState().dynamicWidget.switch_1);
//
//
//
//                         // if(a==0){a=1;}else if(b==0){b=1;}else if(c==0){c=1;}else if(d==0){d=1;}else if(g==0){g=1;} else if(h==0){h=1;}else if(i==0){i=1;}
//                         // else{ if(a==1){a=0;}else if(b==1){b=0;}else if(c==1){c=0;}else if(d==1){d=0;}else if(e==1){e=0;}else if(f==1){f=0;}else if(g==1){g=0;}else if(h==1){h=0;}else if(i==1){i=0;}}
//
//                         // read_device_id.createState().listDynamic.map((index){
//                         //
//                         //   // if(read_device_id.createState().listDynamic[0]!=1){
//                         //   //   read_device_id.createState().listDynamic[0]=1;
//                         //   // }
//                         //
//                         //
//                         //
//                         //
//                         //
//                         //
//                         //
//                         //   switch(read_device_id.createState().listDynamic.length){
//                         //     case 1:{if( read_device_id.createState().listDynamic[0]==0){widget.switch_1=1;}
//                         //     else if(widget.switch_1==1){widget.switch_1=0;}}
//                         //     break;
//                         //     case 2:{if( read_device_id.createState().listDynamic[1]==0){widget.switch_2=1;}
//                         //     else if(widget.switch_2==1){widget.switch_2=1;}}
//                         //     break;
//                         //     case 3:{if( read_device_id.createState().listDynamic[2]==0){widget.switch_3=1;}
//                         //     else if(widget.switch_3==1){widget.switch_3=1;}}
//                         //     break;
//                         //     case 4:{if( read_device_id.createState().listDynamic[3]==0){widget.switch_4=1;}
//                         //     else if(widget.switch_4==1){widget.switch_4=1;}}
//                         //     break;
//                         //     case 5:{if( read_device_id.createState().listDynamic[4]==0){widget.switch_5=1;}
//                         //     else if(widget.switch_5==1){widget.switch_5=1;}}
//                         //     break;
//                         //     case 6:{if( read_device_id.createState().listDynamic[5]==0){widget.switch_6=1;}
//                         //     else if(widget.switch_6==1){widget.switch_6=1;}}
//                         //     break;
//                         //     case 7:{if( read_device_id.createState().listDynamic[6]==0){widget.switch_7=1;}
//                         //     else if(widget.switch_7==1){widget.switch_7=1;}}
//                         //     break;
//                         //     case 8:{if( read_device_id.createState().listDynamic[7]==0){widget.switch_8=1;}
//                         //     else if(widget.switch_8==1){widget.switch_8=1;}}
//                         //     break;
//                         //     case 9:{if( read_device_id.createState().listDynamic[8]==0){widget.switch_9=1;}
//                         //     else if(widget.switch_9==1){widget.switch_9=1;}}
//                         //     break;
//                         //
//                         //   }
//                         //
//                         // }).toList();
//
//
//                         // if(read_device_id.createState().dynamicWidget.switch_1==0){
//                         //   read_device_id.createState().dynamicWidget.switch_1=1;
//                         // }else if(read_device_id.createState().dynamicWidget.switch_1==1){
//                         //   read_device_id.createState().dynamicWidget.switch_1=0;
//                         // }
//                         // dataUpdate();
//
//
//
//                         // if((widget.switch_1==0) || (widget.switch_2==0) || (widget.switch_3==0) || (widget.switch_4==0) || (widget.switch_5==0) || (widget.switch_6==0) || (widget.switch_7==0) ||(widget. switch_8==0) || (widget.switch_9==0)){
//                         //   widget.switch_1=1 ; widget.switch_2=1 ; widget.switch_3=1 ; widget.switch_4=1 ; widget.switch_5=1 ; widget.switch_6=1 ;widget.switch_7=1 ; widget.switch_8=1;  widget.switch_9=1;
//                         // }else if( (widget.switch_1==1) || (widget.switch_2==1) || (widget.switch_3==1) || (widget.switch_4==1) || (widget.switch_5==1) || (widget.switch_6==1) || (widget.switch_7==1) || (widget.switch_8==1) || (widget.switch_9==1))
//                         // {widget.switch_1=0;  widget.switch_2=0 ; widget.switch_3=0;  widget.switch_4=0; widget.switch_5=0; widget.switch_6=0;  widget.switch_7=0; widget.switch_8=0; widget.switch_9=0;}
//                         // dataUpdate();
//                         _switchValue=newValue;
//
//                       },
//                     )
//                         //  child:CustomSwitch(
//                         //   value: _switchValue,
//                         //   activeColor: Color(0xff457be4),
//                         // ),
//                     ),
//                   )
//                 ],
//               )
//
//             ]
//         ));
//     Container(
//       child: GridView(
//
//       ),
//     );
//   }
//
//   onChangedSwitch(){
//
//
//   }
// }
//
//
//
