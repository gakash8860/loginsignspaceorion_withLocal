import 'dart:convert';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/scheduling/alarmHelper.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../ProfilePage.dart';
import '../../changeFont.dart';
import '../../main.dart';
import '../testinghome2.dart';
class DesktopHome extends StatefulWidget {
  PlaceType pt;
Flat flt;
  FloorType fl;
  List<RoomType> rm;
  List<Device> dv;
   DesktopHome({Key key,this.pt,this.fl,this.rm,this.dv,this.flt}) : super(key: key);
  var switch1_get;
  var switch1Name;
  var switch2Name;
  var switch3Name;
  var switch4Name;
  var switch5Name;
  var switch6Name;
  var switch7Name;
  var switch8Name;
  var switch9Name;
  var switch10Name;
  var switch11Name;
  var switch12Name;


  // ignore: non_constant_identifier_names
  var Slider_get = 1;

  // ignore: non_constant_identifier_names
  var Slider_get2 = 1;

  // ignore: non_constant_identifier_names
  var Slider_get3 = 1;
  var Slider_get4;

  var Slider_get5;

  var Slider_get6;

  var Slider_get7;

  var Slider_get8;

  var Slider_get9;

  var Slider_get10;
  var Slider_get11;
  var Slider_get12;

  // ignore: non_constant_identifier_names
  var switch2_get,
  // ignore: non_constant_identifier_names
      switch3_get,
  // ignore: non_constant_identifier_names
      switch4_get,
  // ignore: non_constant_identifier_names
      switch5_get,
  // ignore: non_constant_identifier_names
      switch6_get,
  // ignore: non_constant_identifier_names
      switch7_get,
  // ignore: non_constant_identifier_names
      switch8_get,
  // ignore: non_constant_identifier_names
      switch9_get;

  @override
  _DesktopHomeState createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  var Api='https://genorion1.herokuapp.com/';
  Future deviceSensorVal;
  int index=0;
  TabController tabC;
  bool val1 = true;
  bool val2 = false;
  var rIdForName;
  List<int> listDynamic = [];
  List responseGetData;
  List responseGetData2;
  var catchReturn;
  var data;
  List <dynamic> deviceStatus=[];
  String tabbarState = "";
  String _alarmTimeString;
  var getVariable;
  int counter=0;
  TimeOfDay time;
  TimeOfDay time23;
  TimeOfDay picked;
  List names = [
    'Enter Name',
    'Enter Name',
    'Enter Name',
    'Enter Name',
    'Enter Name',
    'Enter Name',
    'Enter Name',
    'Enter Name',
    'Enter Name',
  ];

  addDeviceName(index) {
    names.add("");
    names.add("");
    names.add("");
    names.add("");
    names.add("");
    names.add("");
    names.add("");
    names.add("");
    names.add("");
  }
  List roomData;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController deviceNameEditing = TextEditingController();
  TextEditingController roomEditing = TextEditingController();
  TextEditingController floorEditing = TextEditingController();
  TextEditingController controller = TextEditingController();
  AlarmHelper _alarmHelper = AlarmHelper();
  int switch_1 = 0,
      switch_2 = 0,
      switch_3 = 0,
      switch_4 = 0,
      switch_5 = 0,
      switch_6 = 0,
      switch_7 = 0,
      switch_8 = 0,
      switch_9 = 0;
  int slider1,
      slider2 = 0;
  int slider3 = 1;
  var dvlenght;
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

  getIp() async {
    print('no');
    while(counter<=dv.length-1){
      print('yes');
      final url ='http://genorion1.herokuapp.com/addipaddress/?d_id='+dv[counter].dId.toString();
      String token = await getToken();
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode > 0) {
        print('Status test--> ${response.statusCode}');
        getVariable = jsonDecode(response.body);

//      to update the list of Ip Address of each Device

        print("getIpVariable-->  $getVariable");
        // print("getIpVariable-->  ${getIpVariable}");
      }
      counter++;
    }

    counter=0;

  }
  IpAddress ip12;
  var ip;
  var sensorData;
  // ignore: missing_return
  Future<IpAddress> fetchIp(String dId) async {
    while(counter<=dv.length){
      String token = await getToken();
      final url =Api+'addipaddress/?d_id='+dId;
      final response = await http.get(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $token',
          }
      );

      if (response.statusCode == 200) {
        ip= IpAddress.fromJson(jsonDecode(response.body)).ipaddress;
        print('IPCheck  ${ip.toString()}');

      }
      counter++;
    }
    counter=0;


  }
  Future getSensorData(String dId) async {
    String token = await getToken();
    final response = await http.get(
        Api+'tensensorsdata/?d_id=' + dId,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        });

// Appropriate action depending upon the
// server response
    if (response.statusCode > 0) {
      print('Sensor ${response.body}');
      print('SensorStatsCode ${response.statusCode}');
      sensorData = jsonDecode(response.body);

      print('sensorData  ${sensorData}');

      return SensorData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
  dataUpdate(String dId) async {
    final String url = Api+'getpostdevicePinStatus/?d_id=' + dId;
    String token = await getToken();
    Map data = {
      'put': 'yes',
      "d_id": dId,
      'pin1Status': responseGetData[0],
      'pin2Status': responseGetData[1],
      'pin3Status': responseGetData[2],
      'pin4Status': responseGetData[3],
      'pin5Status': responseGetData[4],
      'pin6Status': responseGetData[5],
      'pin7Status': responseGetData[6],
      'pin8Status': responseGetData[7],
      'pin9Status': responseGetData[8],
      'pin10Status': responseGetData[9],
      'pin11Status': responseGetData[10],
      'pin12Status': responseGetData[11],
      // 'pin13Status': m,
      // 'pin14Status': n,
      // 'pin15Status': o,
      // 'pin16Status': p,
      // 'pin17Status': q,
      // 'pin18Status': r,
      // 'pin19Status': s,
      // 'pin20Status': t
    };
    http.Response response =
    await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 201) {
      print("Data Updated  ${response.body}");
      // print(switch_1);
      // print(switch_2);

      print('Switch 1 --> $switch_1');
      print('Switch 2 --> $switch_2');
      print('Switch 3 --> $switch_3');
      print('Switch 4 --> $switch_4');

      //jsonDecode only for get method
      //return place_type.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update data');
    }
  }


  void onOffSchedule() {
    print(time23);
    // _alarms = _alarmHelper.getAlarms();
    if (time == TimeOfDay.now()) {
      // dataUpdate(index);
      print(switch_1);
    }
  }

  changeIndex(int index) {
    this.index = index;
    if (time == TimeOfDay.now()) {
      if (index == 0) {
        // ignore: unnecessary_statements
        listDynamic[index];
        print("index -> ${listDynamic[index]}");
        // dataUpdate(index);
        return;
      } else if (index == 1) {
        // ignore: unnecessary_statements
        listDynamic[index];
        // dataUpdate(index);
        return;
      }
      // dataUpdate(index);
    }
  }




  getData(String dId) async {
    print("Vice Id $dId");
    final String url =  Api+'getpostdevicePinStatus/?d_id=' + dId;
    String token = await getToken();
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print(data);
      data = jsonDecode(response.body);
      print("DATA-->  $data");
      print('\n');
      deviceStatus = [
        widget.switch1_get = data["pin1Status"],
        widget.switch2_get = data["pin2Status"],
        widget.switch3_get = data["pin3Status"],
        widget.switch4_get = data["pin4Status"],
        widget.switch5_get = data["pin5Status"],
        widget.switch6_get = data["pin6Status"],
        widget.switch7_get = data["pin7Status"],
        widget.switch8_get = data["pin8Status"],
        widget.switch9_get = data["pin9Status"],
        widget.Slider_get = data["pin10Status"],
        widget.Slider_get2 = data["pin11Status"],
        widget.Slider_get3 = data["pin12Status"],
      ];
      print('Switch 1 --> ${widget.switch1_get}');
      print('Switch 2 --> ${widget.switch2_get}');
      print('Switch 3 --> ${widget.switch3_get}');
      print('Switch 4 --> ${widget.switch4_get}');
      print('Switch 5 --> ${widget.switch5_get}');
      print('Switch 6 --> ${widget.switch6_get}');
      print('Switch 7 --> ${widget.switch7_get}');
      print('Switch 8 --> ${widget.switch8_get}');
      print('Switch 9 --> ${widget.switch9_get}');
      print('Switch 10 --> ${widget.Slider_get}');
      print('Switch 11 --> ${widget.Slider_get2}');
      print('Switch 12 --> ${widget.Slider_get3}');
    } else {
      print(response.statusCode);
      throw Exception('Failed to getData.');
    }
    return data;
  }





  String _chosenValue;
  var icon1=Icons.ac_unit;
  var icon2=IconData(0xe800);
  var icon3=FontAwesomeIcons.lightbulb;
  var icon4=FontAwesomeIcons.fan;
  var icon5=FontAwesomeIcons.handsWash;
  var icon6=FontAwesomeIcons.lightbulb;
  var icon7=FontAwesomeIcons.lightbulb;
  var icon8=FontAwesomeIcons.lightbulb;
  var icon9=FontAwesomeIcons.lightbulb;
  List changeIcon=[null,null,null,null,null,null,null,null,null];


  _createAlertDialogForNameDeviceBox(BuildContext context, int index) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                DropdownButton<String>(
                  value: _chosenValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),

                  items: <String>[
                    'Air Conditioner',
                    'Refrigerator',
                    'Bulb',
                    'Fan',
                    'Washing Machine',
                    'Heater',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(
                    "Please choose a Icon",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                      if(_chosenValue=='Air Conditioner'){
                        changeIcon[index]=icon1;
                        print('true');
                      }else if(_chosenValue=='Refrigerator'){
                        changeIcon[index]=icon2;
                        print('true');
                      }else if(_chosenValue=='Bulb'){
                        changeIcon[index]=icon3;
                        print('true');
                      }else if(_chosenValue=='Fan'){
                        changeIcon[index]=icon4;
                        print('true');
                      }else if(_chosenValue=='Washing Machine'){
                        changeIcon[index]=icon5;
                        print('true');
                      }else if(_chosenValue=='Washing Machine'){
                        changeIcon[index]=icon6;
                        print('true');
                      }
                      // changeIcon=value;
                    });
                  },
                ),
                Text('Enter the Name of Device'),
              ],
            ),
            content: TextField(
              // controller: pinNameController,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () {
                    // addPinsName(pinNameController.text, index);
                    Navigator.of(context).pop();
                    //


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






  deviceContainer(String dId) async {
    catchReturn = await getData(dId);
    setState(() {
      responseGetData = [
        widget.switch1_get = catchReturn["pin1Status"],
        widget.switch2_get = catchReturn["pin2Status"],
        widget.switch3_get = catchReturn["pin3Status"],
        widget.switch4_get = catchReturn["pin4Status"],
        widget.switch5_get = catchReturn["pin5Status"],
        widget.switch6_get = catchReturn["pin6Status"],
        widget.switch7_get = catchReturn["pin7Status"],
        widget.switch8_get = catchReturn["pin8Status"],
        widget.switch9_get = catchReturn["pin9Status"],
        widget.Slider_get = catchReturn["pin10Status"],
        widget.Slider_get2 = catchReturn["pin11Status"],
        widget.Slider_get3 = catchReturn["pin12Status"],
      ];
    });

    // responseGetData=  await getData(d_id)   ;
    print('getResponse--> $responseGetData');
    print('getResponse Length --> ${responseGetData.length}');
    print('Device id-> $dId');
  }

  deviceContainer2() {
    // deviceContainer(dId);
    // fetchIp(dId);
    return Container(
      height: MediaQuery.of(context).size.height * 4.8,
      // color: Colors.redAccent,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1.2,
            // color: Colors.amber,
            child: GridView.count(
                crossAxisSpacing: 8,
                childAspectRatio: 2 / 1.8,
                mainAxisSpacing: 4,
                physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(
                  9,
                    // responseGetData.length - 3,
                        (index) {
                  print('Something');
                  print('catch return --> $index');

                  return Container(
                    // color: Colors.green,
                    height: 203,
                    child: GestureDetector(
                      // onTap:Text(),
                      onLongPress: () async {
                        _alarmTimeString =
                            DateFormat('HH:mm').format(DateTime.now());
                        showModalBottomSheet(
                            useRootNavigator: true,
                            context: context,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setModalState) {
                                return Container(
                                    padding: const EdgeInsets.all(32),
                                    child: Column(children: [
                                      // ignore: deprecated_member_use
                                      FlatButton(
                                        onPressed: () async {
                                          pickTime(index);
                                          // s
                                          print("index --> $index");
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
                                        child: Text(
                                          _alarmTimeString,
                                          style: TextStyle(fontSize: 32),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text('What Do You Want ??'),
                                        trailing: Icon(Icons.timer),
                                      ),
                                      ListTile(
                                        title: ToggleSwitch(
                                          initialLabelIndex: 0,
                                          labels: ['On', 'Off'],
                                          onToggle: (index) {
                                            print('switched to: $index');

                                            setState(() {
                                              changeIndex(index);
                                            });
                                          },
                                        ),
                                        // trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                      FloatingActionButton.extended(
                                        onPressed: () {
                                          pickTime(index);
                                          Navigator.pop(context);

                                          print('Sceduled');
                                        },
                                        icon: Icon(Icons.alarm),
                                        label: Text('Save'),
                                      ),
                                    ]));
                              });
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                            // alignment: new FractionalOffset(1.0, 0.0),
                            // alignment: Alignment.bottomRight,
                            height: 20,
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: 74, vertical: 10),
                            // margin: index / 2 == 0
                            //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                            //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                            // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                            margin: EdgeInsets.only(top: 41,right: 41,bottom: 30),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(8, 10),
                                      color: Colors.black)
                                ],
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Color(0xffa3a3a3)),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              // crossAxisAlignment:
                              // CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [

                                    Expanded(
                                      child: TextButton(
                                        child: Text(
                                          '$index ',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        onPressed: () {
                                          print('index->  ${names[index]}');
                                          setState(() {
                                            if (names[index] != null) {
                                              names[index] =
                                                  deviceNameEditing.text;
                                            }
                                          });
                                          _createAlertDialogForNameDeviceBox(context,index);

                                           addDeviceName(index);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14.5,
                                        vertical: 10
                                      ),
                                      child: Switch(
                                        // value: responseGetData[index] == 0
                                        //     ? val2
                                        //     : val1,
                                        value: val1,
                                        onChanged: (val) async {
                                          setState(() {
                                            if (responseGetData[index] ==
                                                0) {
                                              responseGetData[index] = 1;
                                            } else {
                                              responseGetData[index] = 0;
                                            }

                                            // print('index of $index --> ${listDynamic[index]}');
                                          });

                                          // if Internet is not available then _checkInternetConnectivity = true
                                          // var result = await Connectivity()
                                          //     .checkConnectivity();
                                          // if (result ==
                                          //     ConnectivityResult.wifi) {
                                          //   print("True2-->   $result");
                                          //   // await localUpdate(dId);
                                          //   await dataUpdate(dId);
                                          // } else if (result ==
                                          //     ConnectivityResult.mobile) {
                                          //   print("mobile-->   $result");
                                          //   // await localUpdate(d_id);
                                          //   await dataUpdate(dId);
                                          // } else {
                                          //   // messageSms(context, dId);
                                          // }
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 45,),
                                    GestureDetector(
                                        onTap:(){
                                          // _createAlertDialogForlocalUpdateAndMessage(context,dId);
                                        },
                                        child: Icon(changeIcon[index]==null?null:changeIcon[index])),
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  );
                })),
          ),
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height - 45,
              // color: Colors.black,
              // color: Colors.amber,
              child: GridView.count(
                  crossAxisSpacing: 8,
                  childAspectRatio: 2 / 1.8,
                  mainAxisSpacing: 4,
                  physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                    3,
                      // responseGetData.length - 9,
                          (index) {
                    print('Slider Start');
                    print('catch return --> $catchReturn');
                    var newIndex = index + 10;
                    return Container(
                      // color: Colors.deepOrange,
                      // height: 2030,
                      child: Column(
                        children: [
                          GestureDetector(
                            // onTap:Text(),
                            onLongPress: () async {
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(DateTime.now());
                              showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setModalState) {
                                      return Container(
                                          padding: const EdgeInsets.all(32),
                                          child: Column(children: [
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                              onPressed: () async {
                                                pickTime(index);
                                                // s
                                                print("index --> $index");
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
                                              child: Text(
                                                _alarmTimeString,
                                                style: TextStyle(fontSize: 32),
                                              ),
                                            ),
                                            ListTile(
                                              title:
                                                  Text('What Do You Want ??'),
                                              trailing: Icon(Icons.timer),
                                            ),
                                            ListTile(
                                              title: ToggleSwitch(
                                                initialLabelIndex: 0,
                                                labels: ['On', 'Off'],
                                                onToggle: (index) {
                                                  print('switched to: $index');

                                                  setState(() {
                                                    changeIndex(index);
                                                  });
                                                },
                                              ),
                                              // trailing: Icon(Icons.arrow_forward_ios),
                                            ),
                                            FloatingActionButton.extended(
                                              onPressed: () {
                                                pickTime(index);
                                                Navigator.pop(context);

                                                print('Sceduled');
                                              },
                                              icon: Icon(Icons.alarm),
                                              label: Text('Save'),
                                            ),
                                          ]));
                                    });
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Container(
                                  // alignment: new FractionalOffset(1.0, 0.0),
                                  alignment: Alignment.bottomRight,
                                  height: 120,
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 1, vertical: 10),
                                  // margin: index % 2 == 0
                                  //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                                  //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                                  // margin: EdgeInsets.fromLTRB(95, 77.5, 7.5, 75),
                                  margin: EdgeInsets.only(top: 41,right: 81,bottom: 70),
                                  decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(8, 10),
                                            color: Colors.black)
                                      ],
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Color(0xffa3a3a3)),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              child: Text(
                                                '$index ',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              onPressed: () {
                                                print(
                                                    'index->  ${names[index]}');
                                                setState(() {
                                                  if (names[index] != null) {
                                                    names[index] =
                                                        deviceNameEditing.text;
                                                  }
                                                });
                                                _createAlertDialogForNameDeviceBox(context,index);

                                                return addDeviceName(index);
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 109,
                                            child: Slider(
                                              value: 5.0,
                                              // value: double.parse(
                                              //     responseGetData[newIndex - 1]
                                              //         .toString()),
                                              min: 0,
                                              max: 10,
                                              divisions: 500,
                                              activeColor: Colors.blue,
                                              inactiveColor: Colors.black,
                                              label:
                                                  '${widget.Slider_get.round()}',
                                              onChanged:
                                                  (double newValue) async {
                                                print(
                                                    'index of data $index --> ${responseGetData[newIndex - 1]}');
                                                print(
                                                    'index of $index --> ${newIndex - 1}');

                                                setState(() {
                                                  // if (responseGetData[newIndex-1] != null) {
                                                  //   responseGetData[newIndex-1] = widget.Slider_get.round();
                                                  // }

                                                  print(
                                                      "Round-->  ${newValue.round()}");
                                                  var roundVar =
                                                      newValue.round();
                                                  print(
                                                      "Round 2-->  $roundVar");
                                                  responseGetData[
                                                      newIndex - 1] = roundVar;
                                                  print(
                                                      "Response Round-->  ${responseGetData[newIndex - 1]}");
                                                });

                                                // if Internet is not available then _checkInternetConnectivity = true
                                                var result =
                                                    await Connectivity()
                                                        .checkConnectivity();
                                                if (result ==
                                                    ConnectivityResult.wifi) {
                                                  print("True2-->   $result");
                                                  // await localUpdate(dId);
                                                  // await dataUpdate(dId);
                                                } else if (result ==
                                                    ConnectivityResult.mobile) {
                                                  print("mobile-->   $result");
                                                  // await localUpdate(d_id);
                                                  // await dataUpdate(dId);
                                                } else {
                                                  // messageSms(context, dId);
                                                }
                                              },
                                              // semanticFormatterCallback: (double newValue) {
                                              //   return '${newValue.round()}';
                                              // }
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
  Future<List<Device>> getDevices(String rId) async {
    print('tabbas ${tabbarState}');
    var query = {'r_id': tabbarState};
    final url = API+'addyourdevice/?r_id='+tabbarState;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print(response.statusCode);
      deviceData = jsonDecode(response.body);
      dv = deviceData.map((data) => Device.fromJson(data)).toList();
      print('Room Id query ================================   $query');
      print('------Devicessssssssssssssssssssssssssssss Data $deviceData');


      return dv;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
            child: Center(child: Text('Place'))

        ),

      ),
      body: Container(
        width: double.maxFinite,

        // color: change_toDark ? Colors.black : Colors.white,
        child: DefaultTabController(
          // length: rm.length,
          length: 3,
          // length: widget.rm.length,
          child: CustomScrollView(
              // key: key,

              // controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.41,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff669df4),
                                Color(0xff4e80f3)
                              ]),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        ),
                        padding: EdgeInsets.only(
                          top: 40,
                          bottom: 10,
                          left: 28,
                          right: 30,
                        ),
                        // alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            // _editFloorNameAlertDialog(context);
                                          },
                                          child: GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 361.0),
                                              child: Row(
                                                children: [
                                                  Text('Floor - ',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontFamily: fonttest==null?changeFont:fonttest,
                                                        fontSize: 22,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        // fontStyle: FontStyle.italic
                                                    ),),
                                                  Text(
                                                    // fl.fName.toString(),
                                                    // getFloorData[0]['f_name'].toString(),
                                                    'Floor 1 ',
                                                    // + widget.fl.user.first_name,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize: 22,
                                                        fontFamily: fonttest==null?changeFont:fonttest,
                                                        // fontWeight: FontWeight.bold,
                                                        // fontStyle: FontStyle
                                                        //     .italic
                                                    ),
                                                  ),
                                                  Icon(Icons.arrow_drop_down),
                                                  SizedBox(width: 10,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            // _createAlertDialogDropDown(
                                            //     context);
                                          },
                                        ),
                                        // SizedBox(width: 10,),
                                        // // GestureDetector(
                                        // //   child: Icon(Icons.add),
                                        // //   onTap: () async {
                                        // //
                                        // //     // _createAlertDialogForFloor(context);
                                        // //   },
                                        // // )
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 12,
                                    // ),

                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onLongPress: () {

                                          },
                                          child: Row(
                                            children: [

                                              Text('Flat - ', style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontWeight: FontWeight
                                                        .bold,

                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                    fontSize: 22),),

                                              Text(
                                                // flat.fltName.toString(),
                                                // getFlatData[0]['flt_name'].toString(),
                                                'Flat 1 ',
                                                // + widget.fl.user.first_name,
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                    // fontWeight: FontWeight.bold,
                                                    // fontStyle: FontStyle
                                                    //     .italic,
                                                    fontSize: 22),
                                              ),
                                              Icon(Icons
                                                  .arrow_drop_down),
                                              SizedBox(width: 250,),
                                              Row(
                                                children: [
                                                  SizedBox(width: 28,),
                                                  Container(
                                                    // color:Colors.red,
                                                    child: CircularProfileAvatar(
                                                      '',
                                                      child: setImage == null
                                                          ? Image.asset('assets/images/genLogo.png')
                                                          : setImage,
                                                      radius: 47.5,
                                                      // elevation: 5,
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ProfilePage()));
                                                        //     .then((value) =>
                                                        // loadImageFromPreferences()
                                                        //     ? _deleteImage()
                                                        //     : loadImageFromPreferences());
                                                      },
                                                      cacheImage: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            // _createAlertDialogDropDown(
                                            //     context);
                                          },
                                        ),
                                        SizedBox(width: 35),
                                        // GestureDetector(
                                        //     onTap: () async {
                                        //
                                        //     },
                                        //     child: Icon(Icons.add)),
                                      ],
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FutureBuilder(
                              future: deviceSensorVal,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Column(children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.fire,
                                              color: Colors.yellow,
                                            ),
                                            SizedBox(
                                              height: 32,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text('2.65',
                                                      // sensorData[index]['sensor1'].toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .white70)),
                                                ),
                                              ],
                                            ),
                                          ]),
                                          SizedBox(
                                            width: 35,
                                          ),
                                          Column(children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.temperatureLow,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text('45.36',
                                                      // sensorData[index][
                                                      // 'sensor2']
                                                      //     .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .white70)),
                                                ),
                                              ],
                                            ),
                                          ]),
                                          SizedBox(
                                            width: 45,
                                          ),
                                          Column(children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.wind,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text('41.25',
                                                      // sensorData[index]['sensor3'].toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .white70)),
                                                ),
                                              ],
                                            ),
                                          ]),
                                          SizedBox(
                                            width: 42,
                                          ),
                                          Column(children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.cloud,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text('45.2',
                                                      // sensorData[index]['sensor4'].toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .white70)),
                                                ),
                                              ],
                                            ),
                                          ]),
                                          SizedBox(
                                            width: 42,
                                          ),
                                          Column(children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.idBadge,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text('Device Id',
                                                      // sensorData[index]['sensor4'].toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .white70)),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 22,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: Text('Loading...'),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //Room Tabs
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  // centerTitle: true,
                  floating: true,
                  pinned: true,
                  backgroundColor: Colors.white,

                  title: Container(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, bottom: 2),
                                child: GestureDetector(
                                  // color: Colors.black,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onTap: () {
                                    // _createAlertDialogForAddRoom(context);
                                  },
                                ),
                              ),
                              GestureDetector(
                                onLongPress: () {
                                  print('longPress');
                                  // _editRoomNameAlertDialog(context);
                                },
                                child: TabBar(
                                  indicatorColor: Colors.blueAccent,
                                  controller: tabC,
                                  labelColor: Colors.blueAccent,
                                  indicatorWeight: 2.0,
                                  isScrollable: true,
                                  tabs: [
                                    Text('Room 1',),
                                    Text('Room 2',),
                                    Text('Room 3',),
                                  ],
                                  // tabs: rm.map<Widget>((RoomType rm) {
                                  //   rIdForName = rm.rId;
                                  //   print('RoomId  $rIdForName');
                                  //   print('RoomId  ${rm.rName}');
                                  //   return Tab(
                                  //     text: rm.rName,
                                  //   );
                                  // }).toList(),
                                  onTap: (index) async {

                                    getDevices(tabbarState);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // SizedBox(height: 45,),
                      ],
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                   return deviceContainer2();
                    // if (index < dv.length) {
                    //   Text(
                    //     "Loading",
                    //     style: TextStyle(fontSize: 44),
                    //   );
                    //
                    //   return Container(
                    //     child: Column(
                    //       children: [
                    //         deviceContainer2(),
                    //         // Container(
                    //         //     //
                    //         //     // color: Colors.green,
                    //         //     height: 35,
                    //         //     child: GestureDetector(
                    //         //       child: RichText(
                    //         //         text: TextSpan(children: [
                    //         //           TextSpan(
                    //         //               text: dv[index].dId,
                    //         //               style: TextStyle(
                    //         //                   fontSize: 15, color: Colors.black)),
                    //         //           TextSpan(text: "   "),
                    //         //           WidgetSpan(
                    //         //               child: Icon(
                    //         //             Icons.settings,
                    //         //             size: 18,
                    //         //           ))
                    //         //         ]),
                    //         //       ),
                    //         //       onTap: () {
                    //         //         // _createAlertDialogForSSIDAndEmergencyNumber(
                    //         //         //     context);
                    //         //         print('on tap');
                    //         //       },
                    //         //     )),
                    //       ],
                    //     ),
                    //     // child: Text(dv[index].dId),
                    //   );
                    // } else {
                    //   return null;
                    // }
                  }),
                )
              ]),
        ),
      ),
    );
  }
}
// CustomScrollView(
// // key: key,
//
// // controller: _scrollController,
// slivers: <Widget>[
// //Upper Widget
// SliverToBoxAdapter(
// child: Column(
// children: <Widget>[
// Container(
// height: MediaQuery.of(context).size.height * 0.35,
// width: MediaQuery.of(context).size.width,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.topCenter,
// end: Alignment.bottomCenter,
// colors: [
// Color(0xff669df4),
// Color(0xff4e80f3)
// ]),
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(30),
// bottomRight: Radius.circular(30)),
// ),
// padding: EdgeInsets.only(
// top: 40,
// bottom: 10,
// left: 30,
// right: 30,
// ),
// alignment: Alignment.topLeft,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Column(
// children: <Widget>[
// GestureDetector(
// onLongPress: () {
// // _editFloorNameAlertDialog(context);
// },
// child: Text(
// // widget.fl.fName,
// 'Hello ',
// // + widget.fl.user.first_name,
// style: TextStyle(
// color: Colors.white,
// fontSize: 22,
// fontWeight: FontWeight.bold,
// fontStyle: FontStyle.italic),
// ),
// onTap: () {
// // _createAlertDialogDropDown(context);
// },
// ),
// SizedBox(
// height: 12,
// ),
// GestureDetector(
// onLongPress: () {
// // _editFloorNameAlertDialog(context);
// },
// child: Text(
// // widget.flat.fltName,
// 'Hello ',
// // + widget.fl.user.first_name,
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 22),
// ),
// onTap: () {
// // _createAlertDialogDropDown(context);
// },
// ),
// ],
// ),
// ],
// ),
// SizedBox(
// height: 45,
// ),
// Row(
// // mainAxisAlignment: MainAxisAlignment.start,
// children: <Widget>[
// FutureBuilder(
// future: deviceSensorVal,
// builder: (context, snapshot) {
// if (!snapshot.hasData) {
// return Column(
// children: <Widget>[
// Row(
// children: <Widget>[
// SizedBox(
// width: 8,
// ),
// Column(children: <Widget>[
// Icon(FontAwesomeIcons.fire,
// color: Colors.yellow,
// ),
// SizedBox(
// height: 32,
// ),
// Row(
// children: <Widget>[
// Container(
// child: Text(
// 'a',
// style: TextStyle(
// fontSize: 14,
// color: Colors
//     .white70)),
// ),
// ],
// ),
// ]),
// SizedBox(
// width: 35,
// ),
// Column(children: <Widget>[
// Icon(
// FontAwesomeIcons
//     .temperatureLow,
// color: Colors.orange,
// ),
// SizedBox(
// height: 30,
// ),
// Row(
// children: <Widget>[
// Container(
// child: Text(
// 'a',
// style: TextStyle(
// fontSize: 14,
// color: Colors
//     .white70)),
// ),
// ],
// ),
// ]),
// SizedBox(
// width: 45,
// ),
// Column(children: <Widget>[
// Icon(
// FontAwesomeIcons.wind,
// color: Colors.white,
// ),
// SizedBox(
// height: 30,
// ),
// Row(
// children: <Widget>[
// Container(
// child: Text(
// 'a',
// style: TextStyle(
// fontSize: 14,
// color: Colors
//     .white70)),
// ),
// ],
// ),
// ]),
// SizedBox(
// width: 42,
// ),
// Column(children: <Widget>[
// Icon(
// FontAwesomeIcons.cloud,
// color: Colors.orange,
// ),
// SizedBox(
// height: 30,
// ),
// Row(
// children: <Widget>[
// Container(
// child: Text(
// 'a',
// style: TextStyle(
// fontSize: 14,
// color: Colors
//     .white70)),
// ),
// ],
// ),
// ]),
// ],
// ),
// SizedBox(
// height: 22,
// ),
// ],
// );
// } else {
// return Center(
// child: Text('Loading...'),
// );
// }
// },
// ),
// ],
// )
// ],
// ),
// )
// ],
// ),
// ),
//
// //Room Tabs
// SliverAppBar(
// automaticallyImplyLeading: false,
// // centerTitle: true,
// floating: true,
// pinned: true,
// backgroundColor: Colors.white,
//
// title: Container(
// alignment: Alignment.bottomLeft,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SingleChildScrollView(
// scrollDirection: Axis.horizontal,
// child: Row(
// children: [
//
// Padding(
// padding: const EdgeInsets.only(
// right: 10, bottom: 2),
// child: GestureDetector(
// // color: Colors.black,
// child: Icon(
// Icons.add,
// color: Colors.black,
// ),
// onTap: () {
// // _createAlertDialogForAddRoom(context);
// },
// ),
// )
// ],
// ),
// ),
//
// // SizedBox(height: 45,),
// ],
// ),
// ),
// ),
//
//
// ]),
