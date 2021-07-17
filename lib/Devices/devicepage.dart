import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:loginsignspaceorion/scheduling/alarmHelper.dart';
import 'package:loginsignspaceorion/scheduling/alarmInfo.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;



void main()=>runApp(MaterialApp(
  home:DeviceAddPage() ,
));

class DeviceAddPage extends StatefulWidget {
  // const DeviceAddPage({Key key}) : super(key: key);

  @override
  _DeviceAddPageState createState() => _DeviceAddPageState();


  // ignore: non_constant_identifier_names
  var switch1_get;
  var Slider_get = 1;
  var Slider_get2 = 1;
  var Slider_get3 = 1;
  var switch2_get,
      switch3_get,
      switch4_get,
      switch5_get,
      switch6_get,
      switch7_get,
      switch8_get,
      switch9_get;

}

class _DeviceAddPageState extends State<DeviceAddPage> {

  List<int> listDynamic = [];
  TextEditingController textEditingController = TextEditingController();
  TextEditingController deviceNameEditing = TextEditingController();
  var temp = "DIDM12932021AAAAAA";
  TimeOfDay time;
  TimeOfDay time23;
  TimeOfDay picked;
  String _alarmTimeString;
  DateTime _alarmTime;
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;
  AlarmHelper _alarmHelper = AlarmHelper();
  bool val1 = true;
  bool val2 = false;
  Timer timer;
  int switch_1 = 0,
      switch_2 = 0,
      switch_3 = 0,
      switch_4 = 0,
      switch_5 = 0,
      switch_6 = 0,
      switch_7 = 0,
      switch_8 = 0,
      switch_9 = 0;
  int j, k = 0;
  int index;
  int l = 1;
  int m = 0, n = 0, o = 0, p = 0, q = 0, r = 0, s = 0, t = 0;
  int c = 0;
  final storage = FlutterSecureStorage();
  List names = ['Enter Name','Enter Name','Enter Name','Enter Name','Enter Name','Enter Name','Enter Name','Enter Name','Enter Name'];
  List<int> sliderContainer = [];

  addDeviceName(index){

    names.add(0);
    names.add(0);
    names.add(0);
    names.add(0);
    names.add(0);
    names.add(0);
    names.add(0);
    names.add(0);
    names.add(0);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add([deviceNameEditing.text]);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);
    // names.add(deviceNameEditing.text);

  }
  _createAlertDialogForNameDeviceBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Name of Device'),
            content: TextField(
              controller: deviceNameEditing,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () {
                    addDeviceName(index);
                    // listDynamic.map((e) => deviceNameEditing.text);
                    //   addDynamic();
                    //   names.map((index) => deviceNameEditing.text);
                    //   if(names[index]==0){
                    //     setState(() {
                    //       names[index]=deviceNameEditing.text;
                    //     });
                    //   }

                    Navigator.of(context).pop();
                    //

                    print('Device Name ----->>>> ${names.map((e) => addDeviceName(index))}');
                    final snackBar = SnackBar(
                      content: Text('Name Added'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              )
            ],
          );
        });
  }
  addDynamic() {
    if (textEditingController.text.contains(temp)) {
      listDynamic.add(switch_1 = 0);
      listDynamic.add(switch_2 = 0);
      listDynamic.add(switch_3 = 0);
      listDynamic.add(switch_4 = 0);
      listDynamic.add(switch_5 = 0);
      listDynamic.add(switch_6 = 0);
      listDynamic.add(switch_7 = 0);
      listDynamic.add(switch_8 = 0);
      listDynamic.add(switch_9 = 0);
      // addListItem(index);
    } else {
      print('Enter Valid Id');
    }
    // listDynamic.add(DynamicWidget());
    print('added');
  }
  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }

  dataUpdate(index) async {
    final String url =
        'http://genorionofficial.herokuapp.com/getpostdevicePinStatus/?d_id=DIDM12932021AAAAAB';
    String token = await getToken();
    Map data = {
      'put': 'yes',
      "d_id": "DIDM12932021AAAAAB",
      'pin1Status': listDynamic[0],
      'pin2Status': listDynamic[1],
      'pin3Status': listDynamic[2],
      'pin4Status': listDynamic[3],
      'pin5Status': listDynamic[4],
      'pin6Status': listDynamic[5],
      'pin7Status': listDynamic[6],
      'pin8Status': listDynamic[7],
      'pin9Status': listDynamic[8],
      'pin10Status': sliderContainer[0],
      'pin11Status': sliderContainer[1],
      'pin12Status': sliderContainer[2],
      'pin13Status': m,
      'pin14Status': n,
      'pin15Status': o,
      'pin16Status': p,
      'pin17Status': q,
      'pin18Status': r,
      'pin19Status': s,
      'pin20Status': t
    };
    //var map = new Map<String,dynamic>();
    // map['put']="yes";
    // map['user']="1";
    // // map['id']="1";
    // map['p_id']="1";
    // map['p_type']="Home";

    http.Response response =
    await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 201) {
      print(response.body);
      // print(switch_1);
      // print(switch_2);

      print('Switch 1 --> ${switch_1}');
      print('Switch 2 --> ${switch_2}');
      print('Switch 3 --> ${switch_3}');
      print('Switch 4 --> ${switch_4}');

      //jsonDecode only for get method
      //return place_type.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update data');
    }
  }
  addSlider() {
    sliderContainer.add(j = 0);
    sliderContainer.add(k = 0);
    sliderContainer.add(l = 0);
  }


  pickTime(index) async {
    time23 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(data: ThemeData(), child: child);
        });
    // print(time23);
    if (time23 != null) {
      setState(() {
        time = time23;
        print(time);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: deviceGrid(),
    );
  }

  Widget deviceGrid(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          // controller: scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(
                          horizontal: 1, vertical: 10),
                      // height: 630,

                      child:GridView.builder(
                          shrinkWrap: true,
                          // primary: true,
                          physics: ScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                          itemCount: listDynamic.length,
                          itemBuilder: (BuildContext context,
                              int index) {
                            return Container(
                              child: Column(
                                children: [
                                  // Align(
                                  //   alignment: Alignment.topLeft,
                                  //   child:  new TextFormField(
                                  //     decoration: InputDecoration(hintText: "Enter the Name"),
                                  //     style: TextStyle(fontSize: 20.0),),
                                  // ),
                                  GestureDetector(
                                    // onTap:Text(),
                                    onLongPress: () async {
                                      _alarmTimeString =
                                          DateFormat('HH:mm')
                                              .format(DateTime
                                              .now());
                                      showModalBottomSheet(
                                          useRootNavigator:
                                          true,
                                          context: context,
                                          clipBehavior:
                                          Clip.antiAlias,
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius
                                                .vertical(
                                              top: Radius
                                                  .circular(24),
                                            ),
                                          ),
                                          builder: (context) {
                                            return StatefulBuilder(
                                                builder: (context,
                                                    setModalState) {
                                                  return Container(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(
                                                          32),
                                                      child: Column(
                                                          children: [
                                                            FlatButton(
                                                              onPressed:
                                                                  () async {
                                                                pickTime(index);
                                                                // s
                                                                print("index --> ${index}");
                                                                // var selectedTime = await showTimePicker(
                                                                //   context: context,
                                                                //   initialTime: TimeOfDay.now(),
                                                                // );
                                                                // if (selectedTime != null) {
                                                                //   final now = DateTime.now();
                                                                //   var selectedDateTime = DateTime(
                                                                //       now.year,
                                                                //       now.month,
                                                                //       now.day,
                                                                //       selectedTime.hour,
                                                                //       selectedTime.minute);
                                                                //   _alarmTime = selectedDateTime;
                                                                //   setModalState(() {
                                                                //     _alarmTimeString =
                                                                //         DateFormat('HH:mm')
                                                                //             .format(selectedDateTime);
                                                                //   });
                                                                // }
                                                              },
                                                              child:
                                                              Text(
                                                                _alarmTimeString,
                                                                style:
                                                                TextStyle(fontSize: 32),
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title:
                                                              Text('What Do You Want ??'),
                                                              trailing:
                                                              Icon(Icons.timer),
                                                            ),
                                                            ListTile(
                                                              title:
                                                              ToggleSwitch(
                                                                initialLabelIndex:
                                                                0,
                                                                labels: [
                                                                  'On',
                                                                  'Off'
                                                                ],
                                                                onToggle:
                                                                    (index) {
                                                                  print('switched to: $index');
                                                                  // _checkInternetConnectivity();
                                                                  setState(() {
                                                                    // changeIndex(index);
                                                                  });
                                                                },
                                                              ),
                                                              // trailing: Icon(Icons.arrow_forward_ios),
                                                            ),
                                                            // ListTile(
                                                            //   title: Text('Title'),
                                                            //   trailing: Icon(Icons.arrow_forward_ios),
                                                            // ),
                                                            FloatingActionButton
                                                                .extended(
                                                              onPressed:
                                                                  () {
                                                                pickTime(index);
                                                                Navigator.pop(context);

                                                                print('Sceduled');
                                                              },
                                                              icon:
                                                              Icon(Icons.alarm),
                                                              label:
                                                              Text('Save'),
                                                            ),
                                                          ]));
                                                });
                                          });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                          alignment: new FractionalOffset(1.0, 0.0),
                                          // alignment: Alignment.bottomRight,
                                          height: 120,
                                          padding:
                                          EdgeInsets.symmetric(
                                              horizontal: 1,
                                              vertical: 10),
                                          margin: index % 2 == 0
                                              ? EdgeInsets.fromLTRB(
                                              15, 7.5, 7.5, 7.5)
                                              : EdgeInsets.fromLTRB(
                                              7.5,
                                              7.5,
                                              15,
                                              7.5),
                                          // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                                          decoration: BoxDecoration(
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    blurRadius: 10,
                                                    offset: Offset(
                                                        8, 10),
                                                    color: Colors
                                                        .black)
                                              ],
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 1,
                                                  style: BorderStyle
                                                      .solid,
                                                  color: Color(
                                                      0xffa3a3a3)),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  20)),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextButton(
                                                    child: Text('${names[index]} ',
                                                      style: TextStyle(fontSize: 10),

                                                    ),

                                                    onPressed: (){
                                                      setState(() {
                                                        if(names[index]!=null){
                                                          names[index]=deviceNameEditing.text;
                                                        }
                                                      });
                                                      _createAlertDialogForNameDeviceBox(context);
                                                      print('index->  ${index.toString()}');
                                                    },),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 0.5,
                                                      // vertical: 10
                                                    ),
                                                    child: Switch(
                                                      value:
                                                      listDynamic[index] ==
                                                          1
                                                          ? val1
                                                          : val2,
                                                      //boolean value
                                                      onChanged:
                                                          (val) {
                                                        setState(
                                                                () {
                                                              if (listDynamic[
                                                              index] ==
                                                                  0) {
                                                                listDynamic[
                                                                index] = 1;
                                                              } else if (listDynamic[
                                                              index] ==
                                                                  1) {
                                                                listDynamic[
                                                                index] = 0;
                                                              }
                                                              dataUpdate(
                                                                  listDynamic[
                                                                  index]);
                                                              // print('index of $index --> ${listDynamic[index]}');
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),


                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        // => listDynamic[index],

                      )
                  ),
                ],
              ),
              GestureDetector(
                onLongPress: () async {
                  _alarmTimeString =
                      DateFormat('HH:mm')
                          .format(DateTime
                          .now());
                  showModalBottomSheet(
                      useRootNavigator:
                      true,
                      context: context,
                      clipBehavior:
                      Clip.antiAlias,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius
                            .vertical(
                          top: Radius
                              .circular(24),
                        ),
                      ),
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (context,
                                setModalState) {
                              return Container(
                                  padding:
                                  const EdgeInsets
                                      .all(
                                      32),
                                  child: Column(
                                      children: [
                                        FlatButton(
                                          onPressed:
                                              () async {
                                            pickTime(index);
                                            // s
                                            print("index --> ${index}");
                                            // var selectedTime = await showTimePicker(
                                            //   context: context,
                                            //   initialTime: TimeOfDay.now(),
                                            // );
                                            // if (selectedTime != null) {
                                            //   final now = DateTime.now();
                                            //   var selectedDateTime = DateTime(
                                            //       now.year,
                                            //       now.month,
                                            //       now.day,
                                            //       selectedTime.hour,
                                            //       selectedTime.minute);
                                            //   _alarmTime = selectedDateTime;
                                            //   setModalState(() {
                                            //     _alarmTimeString =
                                            //         DateFormat('HH:mm')
                                            //             .format(selectedDateTime);
                                            //   });
                                            // }
                                          },
                                          child:
                                          Text(
                                            _alarmTimeString,
                                            style:
                                            TextStyle(fontSize: 32),
                                          ),
                                        ),
                                        ListTile(
                                          title:
                                          Text('What Do You Want ??'),
                                          trailing:
                                          Icon(Icons.timer),
                                        ),
                                        ListTile(
                                          title:
                                          ToggleSwitch(
                                            initialLabelIndex:
                                            0,
                                            labels: [
                                              'On',
                                              'Off'
                                            ],
                                            onToggle:
                                                (index) {
                                              print('switched to: $index');
                                              // _checkInternetConnectivity();
                                              setState(() {
                                                // changeIndex(index);
                                              });
                                            },
                                          ),
                                          // trailing: Icon(Icons.arrow_forward_ios),
                                        ),
                                        // ListTile(
                                        //   title: Text('Title'),
                                        //   trailing: Icon(Icons.arrow_forward_ios),
                                        // ),
                                        FloatingActionButton
                                            .extended(
                                          onPressed:
                                              () {
                                            pickTime(index);
                                            Navigator.pop(context);

                                            print('Sceduled');
                                          },
                                          icon:
                                          Icon(Icons.alarm),
                                          label:
                                          Text('Save'),
                                        ),
                                      ]));
                            });
                      });
                },
                child: Container(
                  // alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(
                      horizontal: 1, vertical: 10),
                  height: 630,
                  child: GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5),
                      itemCount: sliderContainer.length,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return Container(
                          child: Container(
                            alignment: new FractionalOffset(1.0, 1.0),
                            // height: 120,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 50),
                            margin: index % 2 == 0
                                ? EdgeInsets.fromLTRB(
                                15, 7.5, 7.5, 7.5)
                                : EdgeInsets.fromLTRB(
                                7.5, 7.5, 15, 7.5),
                            // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(0, 10),
                                      color: Colors.black)
                                ],
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Color(0xffa3a3a3)),
                                borderRadius:
                                BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                      child: Text('${names[index]} ',
                                        style: TextStyle(fontSize: 12),

                                      ),

                                      onPressed: (){
                                        setState(() {
                                          if(names[index]!=null){
                                            names[index]=deviceNameEditing.text;
                                          }
                                        });
                                        _createAlertDialogForNameDeviceBox(context);
                                        print('index->  ${index.toString()}');
                                      },),
                                  ],
                                ),
                                Slider(
                                  value: sliderContainer[index]
                                      .toDouble(),
                                  // value: widget.Slider_get.toDouble(),
                                  min: 0,
                                  max: 10,
                                  divisions: 500,
                                  activeColor: Colors.blue,
                                  inactiveColor: Colors.black,
                                  label:
                                  '${widget.Slider_get.round()}',
                                  onChanged: (double newValue) {
                                    print(
                                        'index of $index --> ${sliderContainer[index]}');
                                    setState(() {
                                      if (j != null) {
                                        j = widget.Slider_get
                                            .round();
                                      }

                                      if (sliderContainer[index] !=
                                          null) {
                                        widget.Slider_get =
                                        sliderContainer[index];
                                      }
                                      dataUpdate(index);
                                      // _Slider_Changed(index);
                                      sliderContainer[index] =
                                          newValue.round();
                                    });
                                  },
                                  // semanticFormatterCallback: (double newValue) {
                                  //   return '${newValue.round()}';
                                  // }
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

}
