import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../Setting_Page.dart';
import '../../changeFont.dart';
import '../../main.dart';
import '../../setting_icons.dart';
import '../testinghome2.dart';


var tabbarStateWeb;

class DesktopHome extends StatefulWidget {
  PlaceType pt;
Flat flt;
  FloorType fl;
  List<RoomType> rm;
  var tabbarState;
  List<Device> dv;
   DesktopHome({Key key,this.pt,this.fl,this.rm,this.dv,this.flt,this.tabbarState}) : super(key: key);
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
  var Slider_get3;
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
  // var API='https://genorion1.herokuapp.com/';
  Future deviceSensorVal;
  int index=0;
  int DeleteRoomIndex=0;
  TabController tabC;
  bool val1 = true;
  bool val2 = false;
  var postData;
  var rIdForName;
  List<int> listDynamic = [];
  List responseGetData;
  List responseGetData2;
  var catchReturn;
  var data;
  List <dynamic> deviceStatus=[];

  String _alarmTimeString;
  var getVariable;
  String _dateString = "";
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

  var namesDataList12;

  Future placeVal;

  Future floorVal;

  Future flatVal;

  Future floorValWeb;

  TextEditingController pinNameController =TextEditingController();






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
  TextEditingController roomNameEditing = TextEditingController();
  TextEditingController flatNameEditing = TextEditingController();
  TextEditingController flatEditing = TextEditingController();
  TextEditingController floorEditing = TextEditingController();
  TextEditingController deviceController = TextEditingController();
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
  DateTime pickedDate;
  pickTime(index) async {
    time23 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(data: ThemeData(), child: child);
        });
    // print(time23);
    String time12;
    if (time23 != null) {
      setState(() {
        time = time23;
        print('Time ${time}');

      });
      time12=time.toString();
      cutTime=time12.substring(10,15);
      print('cutTime ${cutTime}');
    }
  }

  @override
  void initState(){
    super.initState();
    pickedDate = DateTime.now();
    getUid();
    print('tabbbass147as4s4 ${widget.tabbarState}');
  }

  pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
    String date2 = pickedDate.toString();
    setState(() {
      cutDate = date2.substring(0, 10);
    });

    print('pickedDate ${date2}');
    print('pickedDate ${cutDate}');
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
      final url =API+'addipaddress/?d_id='+dId;
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
    await getTokenWeb();
    final response = await http.get(
        API+'tensensorsdata/?d_id=' + dId,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $tokenWeb',
        });

// Appropriate action depending upon the
// server response
    if (response.statusCode > 0) {
      print('Sensor ${response.body}');
      print('SensorStatsCode ${response.statusCode}');
      sensorData = jsonDecode(response.body);
      return sensorData;
      print('sensorData  ${sensorData['sensor1']}');

      // return SensorData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
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
    final String url = API+'getpostdevicePinStatus/?d_id='+dId;
   await getTokenWeb();
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {

      data = jsonDecode(response.body);
      var arr = jsonDecode(response.body);
      List listOfPinStatus = [
        arr,
      ];

      // for (int i = 0; i < listOfPinStatus.length; i++) {
      //
      //   String a = listOfPinStatus[i]['pin20Status'].toString();
      //   print('ForLoop123 ${a}');
      //   int aa = int.parse(a);
      //   int ms = ((DateTime.now().millisecondsSinceEpoch) / 1000).round() - 100; // -100 for checking a difference for 100 seconds in current time
      //   print('CheckMs ${ms}');
      //   print('Checkaa ${aa}');
      //   if (aa >= ms) {
      //     print('ifelse');
      //     statusOfDevice = 1;
      //   } else {
      //     print('ifelse2');
      //     statusOfDevice = 0;
      //   }
      // }
      print("DATAAdmin-->  $data");
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
    // await getPinsName(dId);
    return data;
  }
  List<String> namesDataList;
  Future getPinsName(String dId) async {
    await getTokenWeb();
    String url = API+"editpinnames/?d_id=" + dId;
    // String token = await getToken();
    // try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      namesDataList12 = json.decode(response.body);
      print('QWERTY  $namesDataList12');
      // namesDataList = [
      //   widget.switch1Name = namesDataList12['pin1Name'].toString(),
      //   widget.switch2Name = namesDataList12['pin2Name'].toString(),
      //   widget.switch3Name = namesDataList12['pin3Name'].toString(),
      //   widget.switch4Name = namesDataList12['pin4Name'].toString(),
      //   widget.switch5Name = namesDataList12['pin5Name'].toString(),
      //   widget.switch6Name = namesDataList12['pin6Name'].toString(),
      //   widget.switch7Name = namesDataList12['pin7Name'].toString(),
      //   widget.switch8Name = namesDataList12['pin8Name'].toString(),
      //   widget.switch9Name = namesDataList12['pin9Name'].toString(),
      //   widget.switch10Name = namesDataList12['pin10Name'].toString(),
      //   widget.switch11Name = namesDataList12['pin11Name'].toString(),
      //   widget.switch12Name = namesDataList12['pin12Name'].toString(),
      // ];
      print('namesDataList  $namesDataList');
    return namesDataList12;
    }
  }


  String _chosenValue;
  var icon1=Icons.ac_unit;
  var icon2=FontAwesomeIcons.lightbulb;
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
                        iconCode[index]='001';
                        print('true AirCon  ${changeIcon[index]}' );
                      }else if(_chosenValue=='Refrigerator'){
                        changeIcon[index]=icon2;
                        iconCode[index]='002';
                        print('true');
                      }else if(_chosenValue=='Bulb'){
                        changeIcon[index]=icon3;
                        iconCode[index]='003';
                        print('true');
                      }else if(_chosenValue=='Fan'){
                        changeIcon[index]=icon4;
                        iconCode[index]='004';
                        print('true');
                      }else if(_chosenValue=='Washing Machine'){
                        changeIcon[index]=icon5;
                        iconCode[index]='005';
                        print('true');
                      }else if(_chosenValue=='Washing Machine'){
                        changeIcon[index]=icon6;
                        iconCode[index]='006';
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
              controller: pinNameController,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async{
                   String piname=pinNameController.text;
                    print('checkConditioncheck ${iconCode[index]}');
                    String aa=piname+","+iconCode[index];
                    await addPinsName(aa, index);
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
  var postDataPinName;
  Future addPinsName(String data, int index) async {
    print('editpinnames ${index}');
    String token = await getTokenWeb();
    final url = API+'editpinnames/';


    if (index == 0) {
      postDataPinName = {
        "d_id": deviceId,
        "pin1Name": data
      };
    } else if (index == 1) {
      postDataPinName = {
        "d_id": deviceId,
        "pin2Name": data,
      };
    } else if (index == 2) {
      postDataPinName = {
        "d_id": deviceId,
        "pin3Name": data,
      };
    } else if (index == 3) {
      postDataPinName = {
        "d_id": deviceId,
        "pin4Name": data,
      };
    } else if (index == 4) {
      postDataPinName = {
        "d_id": deviceId,
        "pin5Name": data,
      };
    } else if (index == 5) {
      postDataPinName = {
        "d_id": deviceId,
        "pin6Name": data,
      };
    } else if (index == 6) {
      postDataPinName = {
        "d_id": deviceId,
        "pin7Name": data,
      };
    } else if (index == 7) {
      postDataPinName = {
        "d_id": deviceId,
        "pin8Name": data,
      };
    } else if (index == 8) {
      postDataPinName = {
        "d_id": deviceId,
        "pin9Name": data,
      };
    } else if (index == 9) {
      postDataPinName = {
        "d_id": deviceId,
        "pin10Name": data,
      };
    } else if (index == 10) {
      postDataPinName = {
        "d_id": deviceId,
        "pin11Name": data,
      };
    } else if (index == 11) {
      postDataPinName = {
        "d_id": deviceId,
        "pin12Name": data,
      };
    }

    //
    //  postDataPinName = {
    //
    //   "d_id": deviceIdForSensor,
    //   "pin1Name": data.toString(),
    //   "pin2Name": data,
    //   "pin3Name": data,
    //   "pin4Name": data,
    //   "pin5Name": data,
    //
    // };
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postDataPinName),
    );

    if (response.statusCode > 0) {
      print('DevicePinResponseCode ${response.statusCode}');
      print(response.body);

      var devicePinResponse = jsonDecode(response.body);
      print(' DevicePinResponse--> $devicePinResponse');
      print(' PinName--> ${postDataPinName['pin2Name']}');
      namesDataList[index] = postDataPinName[index];
      print('namesDataList $namesDataList');
      return DevicePin.fromJson(postDataPinName);
    } else {
      throw Exception('Failed to Update Pin Name.');
    }
  }
var tokenWeb;
  Future getTokenWeb()async{
    final pref= await SharedPreferences.getInstance();
    tokenWeb=pref.getString('tokenWeb');
    return tokenWeb;
  }

  Future<List<RoomType>> getrooms( flt_Id) async {
    await getTokenWeb();
    print('senddsas $tokenWeb');
    final url =API+'addroom/?flt_id='+flt_Id;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      print('responseif ${response.statusCode}');
      print('responseif ${response.body}');
      List<dynamic> data = jsonDecode(response.body);
       List<RoomType> rm= data.map((data) => RoomType.fromJson(data)).toList();
      print('rooms147 ${widget.rm[0].rId}');
      return rm;
    }else{
      print('response ${response.statusCode}');
      print('response ${response.body}');
    }
  }

  Future<List<Device>> getDeviceForDropDown( r_Id) async {
    await getTokenWeb();
    print('senddsas $tokenWeb');
    final url =API+'addyourdevice/?rid='+r_Id;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      print('responseif ${response.statusCode}');
      print('responseif ${response.body}');
      List<dynamic> data = jsonDecode(response.body);
      List<Device> dv = data.map((data) => Device.fromJson(data)).toList();
      print('rooms147 ${widget.rm[0].rId}');
      return dv;
    }else{
      print('response ${response.statusCode}');
      print('response ${response.body}');
    }
  }

  Future<Device> send_DeviceId(String data) async {
    await getTokenWeb();
    print('senddsas $tokenWeb');
    print('getUidVariable $getUidVariable');
    final url = API+'addyourdevice/';
    postData = {"user": getUidVariable, "r_id": tabbarStateWeb, "d_id": data};
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode > 0) {
      // print(roomResponse);
      print("CHECKDEVICE123CODE   ${response.statusCode}");
      print(response.body);
     var deviceResponse = jsonDecode(response.body);
     await getDevices(tabbarStateWeb);
      // await getDeviceOffline();
      print(postData);
    } else {
      throw Exception('Failed to create Device.');
    }
  }
  Future<List<PlaceType>> getplaces() async {
   await getTokenWeb();
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = API+'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode>0) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      print('place ${data}');
      List<PlaceType> places =
      data.map((data) => PlaceType.fromJson(data)).toList();
      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }
  }
  Future<List<FloorType>> getfloors(String pId) async {
    await getTokenWeb();
    final url = API+'addyourfloor/?p_id='+pId;
    // String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print('floorrror ${data}');
      List<FloorType> floors = data.map((data) => FloorType.fromJson(data)).toList();
      print(floors);
      return floors;
    }
  }
  Future<List<Flat>> getflat(String fId) async {
    final url = API+'addyourflat/?f_id='+fId;
    // String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Flat> flatData = data.map((data) => Flat.fromJson(data)).toList();
      print(flatData);
      return flatData;
    }
  }

PlaceType selectedPt;
FloorType selectedfl;
Flat selectedflat;
  List <RoomType> selectedRoom;
  List <Device> selectedDevice;


  _createAlertDialogDropDown(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Place'),
            content: Container(
              height: 390,
              child: Column(
                children: [
                  FutureBuilder<List<PlaceType>>(
                      future: placeVal,
                      builder: (context,
                          AsyncSnapshot<List<PlaceType>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Center(
                                child: Text("No Devices on this place"));
                          }
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(41.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width*2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          offset: Offset(20,20)
                                      )],
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      )
                                  ),
                                  child: DropdownButtonFormField<PlaceType>(
                                    decoration:InputDecoration(
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    ),
                                    dropdownColor: Colors.white70,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 28,
                                    hint: Text('Select Place'),
                                    isExpanded: true,
                                    value: pt,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    items: snapshot.data.map((selectedPlace) {
                                      return DropdownMenuItem<PlaceType>(
                                        value: selectedPlace,
                                        child: Text(selectedPlace.pType),
                                      );
                                    }).toList(),
                                    onChanged: (PlaceType selectedPlace) {
                                      setState(() {
                                        fl = null;
                                        selectedPt = selectedPlace;
                                        floorVal =
                                            getfloors(selectedPlace.pId);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            margin: new EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child:FutureBuilder<List<FloorType>>(
                        future: floorVal,
                        builder:
                            (context, AsyncSnapshot<List<FloorType>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length == 0) {
                              return Center(
                                  child: Text("No Devices on this place"));
                            }
                            return Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(41.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50.0,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 30,
                                                // offset for Upward Effect
                                                offset: Offset(20,20)
                                            )],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.5,
                                            )
                                        ),
                                        child: DropdownButtonFormField<FloorType>(
                                          decoration:InputDecoration(
                                            contentPadding: const EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(10),
                                            ),enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          ),
                                          dropdownColor: Colors.white70,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 28,
                                          hint: Text('Select Floor'),
                                          isExpanded: true,
                                          value: fl,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          items: snapshot.data
                                              .map((selectedFloor) {
                                            return DropdownMenuItem<FloorType>(
                                              value: selectedFloor,
                                              child: Text(selectedFloor.fName),
                                            );
                                          }).toList(),
                                          onChanged: (FloorType selectedFloor) {
                                            setState(() {
                                              selectedfl = selectedFloor;
                                              flatVal=getflat(selectedFloor.fId);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  margin: new EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                              ],
                            );
                          } else {
                            return Center(
                                child: Text(
                                    "Please select a place to proceed further"));
                          }
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child:FutureBuilder<List<Flat>>(
                        future: flatVal,
                        builder:
                            (context, AsyncSnapshot<List<Flat>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length == 0) {
                              return Center(
                                  child: Text("No Devices on this place"));
                            }
                            return Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(41.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50.0,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 30,
                                                // offset for Upward Effect
                                                offset: Offset(20,20)
                                            )],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.5,
                                            )
                                        ),
                                        child: DropdownButtonFormField<Flat>(
                                          decoration:InputDecoration(
                                            contentPadding: const EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(10),
                                            ),enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          ),
                                          dropdownColor: Colors.white70,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 28,
                                          hint: Text('Select Flat'),
                                          isExpanded: true,
                                          value: flt,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          items: snapshot.data
                                              .map((selectedFlat) {
                                            return DropdownMenuItem<Flat>(
                                              value: selectedFlat,
                                              child: Text(selectedFlat.fltName),
                                            );
                                          }).toList(),
                                          onChanged: (Flat selectedFlat) {
                                            setState(() {
                                              selectedflat=selectedFlat;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  margin: new EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //   margin: EdgeInsets.all(8),
                                //   // ignore: deprecated_member_use
                                //   child: FlatButton(
                                //     child: Text(
                                //       'Next',
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //     padding: EdgeInsets.all(12),
                                //     shape: OutlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color: Colors.white, width: 1),
                                //         borderRadius:
                                //         BorderRadius.circular(50)),
                                //     onPressed: () async {
                                //       // selectedRoom = await getrooms(widget.flt.fltId);
                                //       //
                                //       //
                                //       // //print(pt.p_type);
                                //       // // print(rm[1]);
                                //       // //  print(rm[0].r_name);
                                //       // Navigator.push(
                                //       //   context,
                                //       //   MaterialPageRoute(
                                //       //       builder: (
                                //       //           context,
                                //       //           ) =>
                                //       //           Container(
                                //       //             child: HomeTest(
                                //       //                 pt: selectedPt,
                                //       //                 fl: selectedfl,
                                //       //                 flat: selectedflat,
                                //       //                 rm: selectedRoom,
                                //       //                 dv: dv),
                                //       //           )),
                                //       // );
                                //     },
                                //   ),
                                // ),
                              ],
                            );
                          } else {
                            return Center(
                                child: Text(
                                    "Please select a place to proceed further"));
                          }
                        }),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  // elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    print('selectedPt ${selectedflat.fltId}');
                    selectedRoom = await getrooms(selectedflat.fltId);
                    // selectedDevice= await getDeviceForDropDown(selectedRoom.)


                    // print(rm[1]);
                    //  print(rm[0].r_name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (
                              context,
                              ) =>
                              Container(
                                child: HomeTest(
                                    pt: selectedPt,
                                    fl: selectedfl,
                                    flat: selectedflat,
                                    rm: selectedRoom,
                                    // dv: dv
                                ),
                              )),
                    );
                    //
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>TempAccessPlacePage(
                    //   tempPlace: place[0],
                    //   tempFloor: floor[0],
                    //   tempFlat: flat[0],
                    //   room: room,
                    // )
                    // ));
                    // dv= a
                  },
                ),
              )
            ],
          );
        });
  }






  _createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Device Id'),
            content: TextField(
              controller: deviceController,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: ()async {
                    // readId();
                    // addDynamic();
                    //
                    print('Add Device-->  $tabbarStateWeb');
                   await send_DeviceId(deviceController.text);
                    // .then((value) => getDevices(tabbarState));
                    Navigator.of(context).pop();

                    // .then((value) =>   readId());
                    // .then((value) => addListItem(index));

                    //
                  },
                ),
              )
            ],
          );
        });
  }

bool switchOn;
  dataUpdateWeb(String dId) async {
    await getTokenWeb();
    final String url =
        API+'getpostdevicePinStatus/?d_id=' + dId;
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
    };
    http.Response response =
    await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 201) {
      print("Data Updated  ${response.body}");
      // print(switch_1);
      // print(switch_2);


      await getData(dId);
      //jsonDecode only for get method
      //return place_type.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update data');
    }
  }
  var deviceId;
  int checkSwitch;
  int sliderValue;

  Future schedulingDevicePin(String dId, index) async {
    final url = API+'schedulingpinsalltheway/';
    String token = await getTokenWeb();
    var postData;
    if (index == 0) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate.toString(),
        "timing1": cutTime.toString(),
        "pin1Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 1) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate.toString(),
        "timing1": _alarmTimeString.toString(),
        "pin2Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 2) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate.toString(),
        "timing1": _alarmTimeString,
        "pin2Status": checkSwitch,
        "d_id": dId.toString(),
      };
    } else if (index == 3) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin4Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 4) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin5Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 5) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin6Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 6) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin7Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 7) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin8Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 8) {
      postData = {
        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin9Status": checkSwitch,
        "d_id": dId,
      };
    } else if (index == 9) {
      postData = {

        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin10Status": sliderValue,
        "d_id": dId,
      };
    } else if (index == 10) {
      postData = {

        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin11Status": sliderValue,
        "d_id": dId,
      };
    }else if (index == 11) {
      postData = {

        "user": getUidVariable2,
        "date1": cutDate,
        "timing1": _alarmTimeString,
        "pin12Status": sliderValue,
        "d_id": dId,
      };
    }
    final response = await http.post(url, body: jsonEncode(postData), headers: {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print("SchedulingStatus ${response.statusCode}");
      print("SchedulingStatus ${response.body}");
      if(response.statusCode==201){
        final snackBar = SnackBar(
          content: Text('Device Scheduled '),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  var cutDate;
  TimeOfDay pickedTime;
  var cutTime;

  var icon10=FontAwesomeIcons.lightbulb;
  var icon11=FontAwesomeIcons.lightbulb;
  var icon12=FontAwesomeIcons.lightbulb;

  List<String> iconCode=['','002','003','','','','','','','','',''];

  deviceContainer(String dId,int index) async {
    getData(dId);
    getPinsName(dId);
    deviceId=dId;
    catchReturn = await getData(dId);

    print('insidedevicecontainercatchreturn $catchReturn');
    var namesDataList12= await getPinsName(dId);
    // deviceSensorVal = getSensorData(dId);
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

      namesDataList = [
        widget.switch1Name = namesDataList12['pin1Name'].toString(),
        widget.switch2Name = namesDataList12['pin2Name'].toString(),
        widget.switch3Name = namesDataList12['pin3Name'].toString(),
        widget.switch4Name = namesDataList12['pin4Name'].toString(),
        widget.switch5Name = namesDataList12['pin5Name'].toString(),
        widget.switch6Name = namesDataList12['pin6Name'].toString(),
        widget.switch7Name = namesDataList12['pin7Name'].toString(),
        widget.switch8Name = namesDataList12['pin8Name'].toString(),
        widget.switch9Name = namesDataList12['pin9Name'].toString(),
        widget.switch10Name = namesDataList12['pin10Name'].toString(),
        widget.switch11Name = namesDataList12['pin11Name'].toString(),
        widget.switch12Name = namesDataList12['pin12Name'].toString(),
      ];



      String pin1=namesDataList12['pin1Name'];
      var indexOfPin1Name=pin1.indexOf(',');
      var pin1FinalName=pin1.substring(0,indexOfPin1Name);

      print('indexofpppp ${namesDataList12}');


      String pin2=namesDataList12['pin2Name'];
      var indexOfPin2Name=pin2.indexOf(',');
      var pin2FinalName=pin2.substring(0,indexOfPin2Name);
      print('indexofpppppin2 $pin2');

      String pin3=namesDataList12['pin3Name'];
      var indexOfPin3Name=pin3.indexOf(',');
      var pin3FinalName=pin3.substring(0,indexOfPin3Name);
      print('indexofpppppin2 $pin3');

      String pin4=namesDataList12['pin4Name'];
      var indexOfPin4Name=pin4.indexOf(',');
      var pin4FinalName=pin4.substring(0,indexOfPin4Name);
      print('indexofpppppin2 $pin3');

      String pin5=namesDataList12['pin5Name'];
      var indexOfPin5Name=pin5.indexOf(',');
      var pin5FinalName=pin5.substring(0,indexOfPin5Name);
      print('indexofpppppin2 $pin3');

      String pin6=namesDataList12['pin6Name'];
      var indexOfPin6Name=pin6.indexOf(',');
      var pin6FinalName=pin6.substring(0,indexOfPin6Name);
      print('indexofpppppin2 $pin3');

      String pin7=namesDataList12['pin7Name'];
      var indexOfPin7Name=pin7.indexOf(',');
      var pin7FinalName=pin7.substring(0,indexOfPin7Name);
      print('indexofpppppin2 $pin3');

      String pin8=namesDataList12['pin8Name'];
      var indexOfPin8Name=pin8.indexOf(',');
      var pin8FinalName=pin8.substring(0,indexOfPin8Name);
      print('indexofpppppin2 $pin3');

      String pin9=namesDataList12['pin9Name'];
      var indexOfPin9Name=pin9.indexOf(',');
      var pin9FinalName=pin9.substring(0,indexOfPin9Name);
      print('indexofpppppin2 $pin3');

      String pin10=namesDataList12['pin10Name'];
      var indexOfPin10Name=pin10.indexOf(',');
      var pin10FinalName=pin9.substring(0,indexOfPin10Name);
      print('indexofpppppin2 $pin3');

      String pin11=namesDataList12['pin11Name'];
      var indexOfPin11Name=pin11.indexOf(',');
      var pin11FinalName=pin11.substring(0,indexOfPin11Name);
      print('indexofpppppin2 $pin3');


      String pin12=namesDataList12['pin12Name'];
      var indexOfPin12Name=pin12.indexOf(',');
      var pin12FinalName=pin12.substring(0,indexOfPin12Name);
      print('indexofpppppin2 $pin3');



      for(int i=0;i<namesDataList.length;i++){
        if(pin1.contains('001') || pin1.contains('002')||pin1.contains('003') ||pin1.contains('004' )||pin1.contains('005') ||pin1.contains('006')||pin1.contains('007')||pin1.contains('008')||pin1.contains('009')|| pin1.contains('0010')||pin1.contains('0011')){
          print('qwertyhgf $index');
          // icon1=Icons.ac_unit;
          if(pin1.contains('001')){
            print('indexofpppp2 $pin1');
            setState(() {
              changeIcon[index]=icon1;
            });
          }
          if(pin1.contains('002')){
            changeIcon[index]=icon2;
          }
          if(pin1.contains('003')){
            // changeIcon[index]=icon3;
            setState(() {
              changeIcon[index]=icon3;
            });
            print('imcomming ${changeIcon[index]}');
          }
          if(pin1.contains('004')){
            changeIcon[index]=icon5;
            print('imcomming4 ${changeIcon[index]}');
          }
          if(pin1.contains('005')){
            changeIcon[index]=icon6;
          }
          if(pin1.contains('007')){
            changeIcon[index]=icon6;
          }
          if(pin1.contains('008')){
            changeIcon[index]=icon7;
          }
          if(pin1.contains('009')){
            changeIcon[index]=icon8;
          }
          if(pin1.contains('0010')){
            changeIcon[index]=icon9;
          }
          if(pin1.contains('0011')){
            changeIcon[index]=icon10;
          }
          if(pin1.contains('0012')){
            changeIcon[index]=icon12;
          }
        }

        if(pin2.contains('001') || pin2.contains('002')||pin2.contains('003') ||pin2.contains('004' )||pin2.contains('005') ||pin2.contains('006')||pin2.contains('007')||pin2.contains('008')||pin2.contains('009')|| pin2.contains('0010')||pin2.contains('0011')){
          print('qwertyhgfnamesDataList $index');
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if(pin2.contains('001')){
            changeIcon[index+1]=icon1;
          }
          if(pin2.contains('002')){
            changeIcon[index+1]=icon2;
          }
          if(pin2.contains('003')){

            changeIcon[index+1]=icon3;
            print('commnng inde  3');
          }
          if(pin2.contains('004')){
            changeIcon[index+1]=icon5;
          }
          if(pin2.contains('005')){
            changeIcon[index+1]=icon6;
          }
          if(pin2.contains('007')){
            changeIcon[index+1]=icon6;
          }
          if(pin2.contains('008')){
            changeIcon[index+1]=icon7;
          }
          if(pin2.contains('009')){
            changeIcon[index]=icon8;
          }
          if(pin2.contains('0010')){
            changeIcon[index+1]=icon9;
          }
          if(pin2.contains('0011')){
            changeIcon[index+1]=icon10;
          }
          if(pin2.contains('0012')){
            changeIcon[index+1]=icon12;
          }
        }

        if(pin3.contains('001') || pin3.contains('002')||pin3.contains('003') ||pin3.contains('004' )||pin3.contains('005') ||pin3.contains('006')||pin3.contains('007')||pin3.contains('008')||pin3.contains('009')|| pin3.contains('0010')||pin3.contains('0011')){
          print('qwertyhgfnamesDataList $index');
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if(pin3.contains('001')){
            changeIcon[index+2]=icon1;
          }
          if(pin3.contains('002')){
            changeIcon[index+2]=icon2;
          }
          if(pin3.contains('003')){
            changeIcon[index+2]=icon3;
          }
          if(pin3.contains('004')){
            changeIcon[index+2]=icon5;
          }
          if(pin3.contains('005')){
            changeIcon[index+2]=icon6;
          }
          if(pin3.contains('007')){
            changeIcon[index+2]=icon6;
          }
          if(pin3.contains('008')){
            changeIcon[index+2]=icon7;
          }
          if(pin3.contains('009')){
            changeIcon[index+2]=icon8;
          }
          if(pin3.contains('0010')){
            changeIcon[index+2]=icon9;
          }
          if(pin3.contains('0011')){
            changeIcon[index+2]=icon10;
          }
          if(pin3.contains('0012')){
            changeIcon[index+2]=icon12;
          }
        }

        if(pin4.contains('001') || pin4.contains('002')||pin4.contains('003') ||pin4.contains('004' )||pin4.contains('005') ||pin4.contains('006')||pin4.contains('007')||pin4.contains('008')||pin4.contains('009')|| pin4.contains('0010')||pin4.contains('0011')){
          print('qwertyhgfnamesDataList $index');
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if(pin4.contains('001')){
            changeIcon[index+3]=icon1;
          }
          if(pin4.contains('002')){
            changeIcon[index+3]=icon2;
          }
          if(pin4.contains('003')){
            changeIcon[index+3]=icon3;
          }
          if(pin4.contains('004')){
            changeIcon[index+3]=icon5;
          }
          if(pin4.contains('005')){
            changeIcon[index+3]=icon6;
          }
          if(pin4.contains('007')){
            changeIcon[index+3]=icon6;
          }
          if(pin4.contains('008')){
            changeIcon[index+3]=icon7;
          }
          if(pin4.contains('009')){
            changeIcon[index+3]=icon8;
          }
          if(pin4.contains('0010')){
            changeIcon[index+3]=icon9;
          }
          if(pin4.contains('0011')){
            changeIcon[index+3]=icon10;
          }
          if(pin4.contains('0012')){
            changeIcon[index+3]=icon12;
          }
        }
        if(pin5.contains('001') || pin5.contains('002')||pin5.contains('003') ||pin5.contains('004' )||pin5.contains('005') ||pin5.contains('006')||pin5.contains('007')||pin5.contains('008')||pin5.contains('009')|| pin5.contains('0010')||pin5.contains('0011')){
          print('qwertyhgfnamesDataList $index');
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if(pin5.contains('001')){
            changeIcon[index+4]=icon1;
          }
          if(pin5.contains('002')){
            changeIcon[index+4]=icon2;
          }
          if(pin5.contains('003')){
            changeIcon[index+4]=icon3;
          }
          if(pin5.contains('004')){
            changeIcon[index+4]=icon5;
          }
          if(pin5.contains('005')){
            changeIcon[index+4]=icon6;
          }
          if(pin5.contains('007')){
            changeIcon[index+4]=icon6;
          }
          if(pin5.contains('008')){
            changeIcon[index+4]=icon7;
          }
          if(pin5.contains('009')){
            changeIcon[index+4]=icon8;
          }
          if(pin5.contains('0010')){
            changeIcon[index+4]=icon9;
          }
          if(pin5.contains('0011')){
            changeIcon[index+4]=icon10;
          }
          if(pin5.contains('0012')){
            changeIcon[index+4]=icon12;
          }
        }
        if(pin6.contains('001') || pin6.contains('002')||pin6.contains('003') ||pin6.contains('004' )||pin6.contains('005') ||pin6.contains('006')||pin6.contains('007')||pin6.contains('008')||pin6.contains('009')|| pin6.contains('0010')||pin6.contains('0011')){
          print('qwertyhgfnamesDataList $index');
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if(pin6.contains('001')){
            changeIcon[index+5]=icon1;
          }
          if(pin6.contains('002')){
            changeIcon[index+5]=icon2;
          }
          if(pin6.contains('003')){
            changeIcon[index+5]=icon3;
          }
          if(pin6.contains('004')){
            changeIcon[index+5]=icon5;
          }
          if(pin6.contains('005')){
            changeIcon[index+5]=icon6;
          }
          if(pin6.contains('007')){
            changeIcon[index+5]=icon6;
          }
          if(pin6.contains('008')){
            changeIcon[index+5]=icon7;
          }
          if(pin6.contains('009')){
            changeIcon[index+5]=icon8;
          }
          if(pin6.contains('0010')){
            changeIcon[index+5]=icon9;
          }
          if(pin6.contains('0011')){
            changeIcon[index+5]=icon10;
          }
          if(pin6.contains('0012')){
            changeIcon[index+5]=icon12;
          }
        }
        if(pin7.contains('001') || pin7.contains('002')||pin7.contains('003') ||pin7.contains('004' )||pin7.contains('005') ||pin7.contains('006')||pin7.contains('007')||pin7.contains('008')||pin7.contains('009')|| pin7.contains('0010')||pin7.contains('0011')){
          print('qwertyhgfnamesDataList $index');
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if(pin7.contains('001')){
            changeIcon[index+6]=icon1;
          }
          if(pin7.contains('002')){
            changeIcon[index+6]=icon2;
          }
          if(pin7.contains('003')){
            changeIcon[index+6]=icon3;
          }
          if(pin7.contains('004')){
            changeIcon[index+6]=icon5;
          }
          if(pin7.contains('005')){
            changeIcon[index+6]=icon6;
          }
          if(pin7.contains('007')){
            changeIcon[index+6]=icon6;
          }
          if(pin7.contains('008')){
            changeIcon[index+6]=icon7;
          }
          if(pin7.contains('009')){
            changeIcon[index+6]=icon8;
          }
          if(pin7.contains('0010')){
            changeIcon[index+6]=icon9;
          }
          if(pin7.contains('0011')){
            changeIcon[index+6]=icon10;
          }
          if(pin7.contains('0012')){
            changeIcon[index+6]=icon12;
          }
        }
        if(pin8.contains('001') || pin8.contains('002')||pin8.contains('003') ||pin8.contains('004' )||pin8.contains('005') ||pin8.contains('006')||pin8.contains('007')||pin8.contains('008')||pin8.contains('009')|| pin8.contains('0010')||pin8.contains('0011')){
          print('qwertyhgfnamesDataList $index');
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if(pin8.contains('001')){
            changeIcon[index+7]=icon1;
          }
          if(pin8.contains('002')){
            changeIcon[index+7]=icon2;
          }
          if(pin8.contains('003')){
            changeIcon[index+7]=icon3;
          }
          if(pin8.contains('004')){
            changeIcon[index+7]=icon5;
          }
          if(pin8.contains('005')){
            changeIcon[index+7]=icon6;
          }
          if(pin8.contains('007')){
            changeIcon[index+7]=icon6;
          }
          if(pin8.contains('008')){
            changeIcon[index+7]=icon7;
          }
          if(pin8.contains('009')){
            changeIcon[index+7]=icon8;
          }
          if(pin8.contains('0010')){
            changeIcon[index+7]=icon9;
          }
          if(pin8.contains('0011')){
            changeIcon[index+7]=icon10;
          }
          if(pin8.contains('0012')){
            changeIcon[index+7]=icon12;
          }
        }
        if(pin9.contains('001') || pin9.contains('002')||pin9.contains('003') ||pin9.contains('004' )||pin9.contains('005') ||pin9.contains('006')||pin9.contains('007')||pin9.contains('008')||pin9.contains('009')|| pin9.contains('0010')||pin9.contains('0011')){
          print('qwertyhgfnamesDataList $index');
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if(pin9.contains('001')){
            changeIcon[index+8]=icon1;
          }
          if(pin9.contains('002')){
            changeIcon[index+8]=icon2;
          }
          if(pin9.contains('003')){
            changeIcon[index+8]=icon3;
          }
          if(pin9.contains('004')){
            changeIcon[index+8]=icon5;
          }
          if(pin9.contains('005')){
            changeIcon[index+8]=icon6;
          }
          if(pin9.contains('007')){
            changeIcon[index+8]=icon6;
          }
          if(pin9.contains('008')){
            changeIcon[index+8]=icon7;
          }
          if(pin9.contains('009')){
            changeIcon[index+8]=icon8;
          }
          if(pin9.contains('0010')){
            changeIcon[index+8]=icon9;
          }
          if(pin9.contains('0011')){
            changeIcon[index+8]=icon10;
          }
          if(pin9.contains('0012')){
            changeIcon[index+8]=icon12;
          }
        }

        // if(namesDataList[index+2].contains('003')){
        //   // icon2=Icons.ac_unit;
        //   changeIcon[index+2]=icon3;
        // }
        // if(namesDataList[index+3].contains('004')){
        //   print('qwertyhgf $index');
        //   // icon2=Icons.ac_unit;
        //   changeIcon[index+3]=icon4;
        // }
      }
      namesDataList = [
        widget.switch1Name = pin1FinalName,
        widget.switch2Name = pin2FinalName,
        widget.switch3Name = pin3FinalName,
        widget.switch4Name = pin4FinalName,
        widget.switch5Name = pin5FinalName,
        widget.switch6Name = pin6FinalName,
        widget.switch7Name = pin7FinalName,
        widget.switch8Name = pin8FinalName,
        widget.switch9Name = pin9FinalName,
        widget.switch10Name = pin10FinalName,
        widget.switch11Name = pin11FinalName,
        widget.switch12Name = pin12FinalName,
      ];


    });
    if(responseGetData.contains(1)){
      setState(() {
        switchOn=true;
      });
      print('else ${switchOn}');
      print('else ${responseGetData}');
    }else{
      setState(() {
        switchOn=false;
      });
      print('else ${switchOn}');
      print('else ${responseGetData}');
    }
    // responseGetData=  await getData(d_id)   ;
    print('getResponse--> $responseGetData');
    print('getResponse Length --> ${responseGetData.length}');
    print('Device id-> $dId');
  }
var textSelected;
  deviceContainer2(String dId,int index) {
    var deviceSize= MediaQuery.of(context).size.height;
    var deviceWidth= MediaQuery.of(context).size.width;
    print('Mediadsaass $deviceSize');
    print('deviceWidth $deviceWidth');
    deviceContainer(dId,index);
    // fetchIp(dId);
    return Container(
      height: MediaQuery.of(context).size.height * 1.55,
      width: MediaQuery.of(context).size.width,
      color: Colors.redAccent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 5,
              ),
              Text(
                'Turn Off All Appliances',
                style: TextStyle(
                  color: change_toDark ? Colors.white : Colors.black,
                  // fontFamily: fonttest==null?'RobotoMono':fonttest,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,

                ),
              ),
              SizedBox(
                width: 14,
              ),
              GestureDetector(
                child:  Container(
                  // color:textSelected==dId.toString()?Colors.green:Colors.red,
                  child: Icon(textSelected==dId.toString()?Icons.update:Icons.sensors,color: change_toDark ? Colors.white : Colors.black,),
                ),

                onTap: () {
                  print('check123${textSelected}');
                  deviceSensorVal = getSensorData(dId);
                  setState(() {
                    textSelected=dId.toString();
                    deviceSensorVal = getSensorData(dId);
                  });
                  print('check123${textSelected==dId}');
                  print('_hasBeenPressed ${textSelected}');
                },
              ),
              GestureDetector(
                child: Icon(Icons.schedule,color: change_toDark ? Colors.white : Colors.black,),
                onTap: () {

                  // _createAlertDialogForPinSchedule(context,dId);
                  // _createAlertDialogForPin17(context, dId);
                },
              ),
              Container(
                width: 14,
                height: 14,

                decoration: BoxDecoration(
                    color: statusOfDevice == 1 ? Colors.green : Colors.grey,
                    shape: BoxShape.circle),
                // child: ...
              ),
              Switch(
                value: switchOn,
                //boolean value
                onChanged: (val) async {
                  // await _showDialog(dId);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  child: Icon(Icons.settings_remote , color: change_toDark ? Colors.white : Colors.black,),
                  onTap: () {
                    // _createAlertDialogForPin19(context, dId);
                  },
                ),
              ),

            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.98,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: GridView.count(
                crossAxisSpacing: 8,
                childAspectRatio: 2 / 1.8,
                mainAxisSpacing: 4,
                physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                crossAxisCount: 4,
                children: List.generate(
                    responseGetData.length - 3,
                        (index) {
                  print('Something');
                  print('catch return --> $index');

                  return Container(
                    // color: Colors.green,
                    height: 203,
                    child: GestureDetector(
                      // onTap:Text(),
                      onLongPress: () async {
                        print('finalDate ${cutDate}');
                        _alarmTimeString =
                            DateFormat('HH:mm').format(DateTime.now());
                        cutDate = DateFormat('dd-MM-yyyy').format(
                            DateTime.now());
                        print('finalDate ${cutDate}');
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
                                      Container(
                                        width: 145,
                                        child: GestureDetector(
                                            child: Text(cutDate
                                                .toString() == null
                                                ? _dateString
                                                : cutDate.toString()
                                                .toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                            onTap: () {
                                              pickDate();
                                            }

                                        ),
                                      ),
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
                                            checkSwitch = index;
                                            setState(() {
                                              changeIndex(index);
                                            });
                                          },
                                        ),
                                        // trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                      FloatingActionButton.extended(
                                        onPressed: () async{
                                          await schedulingDevicePin(dId, index);
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
                        padding:  EdgeInsets.all(12.5),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0,
                            alignment: new FractionalOffset(1.0, 0.0),
                            // alignment: Alignment.bottomRight,
                            height: MediaQuery.of(context).size.height*0.85,

                            padding: EdgeInsets.all(12.0),
                            // margin: index / 2 == 0
                            //     ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                            //     : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                            // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height/80,
                                right: MediaQuery.of(context).size.height/70,
                              bottom: MediaQuery.of(context).size.height/40
                            ),

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
                                      child: InkWell(
                                        child: Text(
                                          namesDataList[index],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 10,color: Colors.blue),
                                        ),
                                        onTap: () async{
                                          print('index->  ${names[index]}');
                                          setState(() {
                                            if (names[index] != null) {
                                              names[index] =
                                                  deviceNameEditing.text;
                                            }
                                          });
                                          _createAlertDialogForNameDeviceBox(context,index);


                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Switch(
                                        value: responseGetData[index] == 0
                                            ? val2
                                            : val1,
                                        // value: val1,
                                        onChanged: (val) async {
                                          if (responseGetData[index] == 0) {
                                            setState(() {


                                              responseGetData[index] = 1;                                              // print('index of $index --> ${listDynamic[index]}');
                                            });
                                            responseGetData[index] = 1;
                                          } else {
                                            setState(() {


                                              responseGetData[index] = 0;                                              // print('index of $index --> ${listDynamic[index]}');
                                            });
                                            responseGetData[index] = 0;
                                          }
                                          setState(() {


                                            print('index of update $index --> ${responseGetData[index]}');
                                          });
                                         await dataUpdateWeb(dId);

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
                                        child: Icon(changeIcon[index]==null?null:changeIcon[index],size: 25,)),
                                  ],
                                ),

                              ],
                            )),
                      ),
                    ),
                  );
                })),
          ),
          // SizedBox(height: 10,),
          Container(
            height: MediaQuery.of(context).size.height *0.35,
            color: Colors.black,
            // color: Colors.amber,
            child: GridView.count(
                crossAxisSpacing: 8,
                childAspectRatio: 2 / 1.8,
                mainAxisSpacing: 4,
                physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(
                  // 3,
                    responseGetData.length - 9,
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
                              margin: EdgeInsets.only(top: 11,
                                  right: deviceWidth/70,
                                  left: 55
                                  ),
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
                                            namesDataList[index+9],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          onPressed: ()async {
                                            // print(
                                            //     'index->  ${names[index]}');
                                            // setState(() {
                                            //   if (names[index] != null) {
                                            //     names[index] =
                                            //         deviceNameEditing.text;
                                            //   }
                                            // });
                                           await  _createAlertDialogForNameDeviceBox(context,index+9);


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

                                              print("Round-->  ${newValue.round()}");
                                              var roundVar = newValue.round();
                                              print("Round 2-->  $roundVar");
                                              responseGetData[newIndex - 1] = roundVar;
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
                      ],
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
  Future<List<Device>> getDevices(String rId) async {
    await getTokenWeb();
    print('tabbas ${tabbarStateWeb}');
    await getTokenWeb();
    final url = API+'addyourdevice/?r_id='+tabbarStateWeb;

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      print(response.statusCode);
      deviceData = jsonDecode(response.body);
     widget. dv = deviceData.map((data) => Device.fromJson(data)).toList();
      print('------Devicessssssssssssssssssssssssssssss Data $deviceData');
      print('------Devicessssssssssssssssssssssssssssss Data ${widget.dv.length}');


      return widget.dv;
    }
  }

  getUid() async{
    final url= API+'getuid/';
    await getTokenWeb();
    final response =
    await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $tokenWeb',
        });
    if(response.statusCode==200){
      getUidVariable=response.body;
      getUidVariable2=int.parse(getUidVariable);

      print('GetUi Variable Integer-->   ${getUidVariable2}');
    }else{
      print(response.statusCode);
    }
  }

var flatResponse;
  Future<List<Flat>> getflatWeb(String fId) async {
    final url = API + 'addyourflat/?f_id=' + fId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Flat> flatData = data.map((data) => Flat.fromJson(data)).toList();
      print(flatData);
      return flatData;
    }
  }

  Future<RoomType> addRoom(String data) async {

    print('floorwidgetid ${widget.flt.fltId}');
    print('floorwidgetid ${getUidVariable2}');
    final url = API+'addroom/';
    String tokenWeb =  await getTokenWeb();
    var postData = {
      "user": getUidVariable2,
      "r_name": data,
      "flt_id": widget.flt.fltId,

    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode > 0) {
      print("body");
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        tabbarState = jsonDecode(response.body);

        final snackBar = SnackBar(
          content: Text('Room Added'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      widget.rm =  await getrooms(widget.flt.fltId);
      }
      print(' RoomTabs--> $tabbarState');

      // return RoomType.fromJson(postData);
    } else {
      throw Exception('Failed to create Room.');
    }
  }
  Future<Flat> addFlat(String data) async {
    print('floorwidgetid ${widget.fl.fId}');
    final url = API+'addyourflat/';
     await getTokenWeb();
    var postData = {
      "user": getUidVariable2,
      "flt_name": data,
      "f_id": widget.fl.fId,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode > 0) {
      print("body");
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        flatResponse = jsonDecode(response.body);

        final snackBar = SnackBar(
          content: Text('Flat Added'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // getAllRoom();
      }

      // setState(() {
      //   roomResponse2=roomResponse;
      //   // roomResponsePreference.setInt('r_id', roomResponse2);
      // });
      print(' RoomTabs--> $tabbarState');

      // return RoomType.fromJson(postData);
    } else {
      throw Exception('Failed to create Room.');
    }
  }
  Future<RoomType> addRoom2(String data) async {

    print('floorwidgetid ${widget.flt.fltId}');
    print('floorwidgetid ${getUidVariable2}');
    final url = API+'addroom/';
    await getTokenWeb();
    var postData = {
      "user": getUidVariable2,
      "r_name": data,
      "flt_id": flatResponse,

    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode > 0) {
      print("body");
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        tabbarState = jsonDecode(response.body);

        final snackBar = SnackBar(
          content: Text('Room Added'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await getrooms(widget.flt.fltId);
      }
      print(' RoomTabs--> $tabbarState');

      // return RoomType.fromJson(postData);
    } else {
      throw Exception('Failed to create Room.');
    }
  }
  _createAlertDialogForAddRoom(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Name of Room'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  controller: roomEditing,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Room Name',
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

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    elevation: 5.0,
                    child: Text('Submit'),
                    onPressed: () async {
                      print('addddd');
                      await addRoom(roomEditing.text);
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
            actions: <Widget>[],
          );
        });
  }

  List listOfAllFloor;
  List listOfAllFlat;
  Future<List<Flat>> getflatWebForDropDown(String fId) async {
    print('asasdasdsa ${widget.fl.fId}');
    final url = API + 'addyourflat/?f_id=' + fId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
       listOfAllFlat=data;
       print('checklendehe ${listOfAllFlat}');
      List<Flat> flatData = data.map((data) => Flat.fromJson(data)).toList();
      print(flatData.length);
      return flatData;
    }
  }
  Future<List<FloorType>> getfloorsWeb(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getTokenWeb();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      listOfAllFloor=data;
      List<FloorType> floors = data.map((data) => FloorType.fromJson(data))
          .toList();
      print(floors);
      return floors;
    }
  }
Future flatValWeb;
  _createAlertDialogDropDownFlat(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Flat'),
            content: FutureBuilder<List<Flat>>(
                 future: flatValWeb,
                 builder:
                     (context, AsyncSnapshot<List<Flat>> snapshot) {
                   if (snapshot.hasData) {
                     if (snapshot.data.length == 0) {
                       return Center(
                           child: Text("No Devices on this place"));
                     }
                     return Container(
                       child: Padding(
                         padding: const EdgeInsets.all(41.0),
                         child: SizedBox(
                           width: double.infinity,
                           height: 50.0,
                           child: Container(
                             width: MediaQuery.of(context).size.width/4,
                             decoration: BoxDecoration(
                                 color: Colors.white,
                                 boxShadow: [BoxShadow(
                                     color: Colors.black,
                                     blurRadius: 30,
                                     // offset for Upward Effect
                                     offset: Offset(20,20)
                                 )],
                                 border: Border.all(
                                   color: Colors.black,
                                   width: 0.5,
                                 )
                             ),
                             child: DropdownButtonFormField<Flat>(
                               decoration:InputDecoration(
                                 contentPadding: const EdgeInsets.all(15),
                                 focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.white),
                                   borderRadius: BorderRadius.circular(10),
                                 ),enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.white),
                                 borderRadius: BorderRadius.circular(50),
                               ),
                               ),
                               dropdownColor: Colors.white70,
                               icon: Icon(Icons.arrow_drop_down),
                               iconSize: 28,
                               hint: Text('Select Floor'),
                               isExpanded: true,
                               value: flt,
                               style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold,
                               ),
                               items: snapshot.data
                                   .map((selectedFlat) {
                                 return DropdownMenuItem<Flat>(
                                   value: selectedFlat,
                                   child: Text(selectedFlat.fltName),
                                 );
                               }).toList(),
                               onChanged: (Flat selectedFlat) {
                                 setState(() {
                                   selectedflat=selectedFlat;
                                 });
                               },
                             ),
                           ),
                         ),
                       ),
                       margin: new EdgeInsets.symmetric(
                           vertical: 10, horizontal: 10),
                     );
                   } else {
                     return Center(
                         child: Text(
                             "Please select a place to proceed further"));
                   }
                 }),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                // ignore: deprecated_member_use
                child: FlatButton(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black54, width: 1),
                      borderRadius:
                      BorderRadius.circular(50)),
                  onPressed: () async {

                    selectedRoom = await getrooms(selectedflat.fltId);


                    //print(pt.p_type);
                    // print(rm[1]);
                    //  print(rm[0].r_name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (
                              context,
                              ) =>
                              Container(
                                child: HomeTest(
                                    pt: widget.pt,
                                    fl: widget.fl,
                                    flat: selectedflat,
                                    rm: selectedRoom,
                                    dv: dv),
                              )),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  _createAlertDialogForDeleteFlatAndAddFlat(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Choose One',
              style: TextStyle(fontSize: 20),
            ),
            content: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 120,
              child: Column(
                children: [
                  TextButton(
                    child: Text(
                      'Add Flat',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _createAlertDialogForFlat(context);

                    },
                  ),
                  TextButton(
                    child: Text(
                      'Delete Flat',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async{
                      await getflatWebForDropDown(widget.fl.fId);
                      deleteFlatOption(context);

                    },
                  ),
                  TextButton(
                    child: Text(
                      'Edit Flat Name',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _editFlatNameAlertDialog(context);

                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }
  _createAlertDialogForFlat(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Name of Flat'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  controller: flatEditing,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Flat Name',
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
                  controller: roomEditing,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Room Name',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    elevation: 5.0,
                    child: Text('Submit'),
                    onPressed: () async {
                      await addFlat(flatEditing.text);
                      await addRoom2(roomEditing.text);
                      //   Navigator.of(context).push(
                      //       MaterialPageRoute(builder: (context) => DropDown2()));
                      Navigator.of(context).pop();
                      final snackBar = SnackBar(
                        content: Text('Floor Added'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
  _editFlatNameAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Flat Name"),
            content: TextField(
              controller: flatNameEditing,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  // elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    await addFlatName(flatNameEditing.text);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }
  Future<FloorType> addFlatName(String data) async {
    await getTokenWeb();
    final url = API+'addyourflat/';
    var postDataFlatName = {
      "flt_id": widget.flt.fltId,
      "flt_name": data,
      "user": getUidVariable2,
    };
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postDataFlatName),
    );

    if (response.statusCode > 0) {
      print('FlatResposne ${response.statusCode}');
      print(response.body);

      var flatResponse = jsonDecode(response.body);
      setState(() {
        widget.flt.fltName = postDataFlatName['flt_name'];
      });
      print(' Flat Response--> $flatResponse');
// pt.pType=;
      print(' FlatName--> ${postDataFlatName['flt_name']}');

      // DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(postData));
      // placeResponsePreference.setInt('p_id', placeResponse);

      return FloorType.fromJson(postDataFlatName);
    } else {
      throw Exception('Failed to create Floor.');
    }
  }
  Future<void> deleteFlat(String flt_Id) async {
    await getTokenWeb();
    final url = API+'addyourflat/?flt_id=' + flt_Id;
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      print('deleteFlat ${response.body}');
      final snackBar = SnackBar(
        content: Text('Flat Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  alertDialogExistingFloor(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Oops',),
            content: Container(
              color: Colors.blueGrey,
              child: MaterialButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          );
        }
    );
  }

    deleteFlatOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select Flat'),
            content: Container(
              color: Colors.amber,
              width: 78,
              child: ListView.builder(
                  itemCount: listOfAllFlat.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          semanticContainer: true,
                          shadowColor: Colors.grey,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(listOfAllFlat[index]['flt_name']),
                              ),
                              RaisedButton(
                                child: Text('Delete Floor'),
                                onPressed: () {
                                  print(listOfAllFlat[index]['flt_id']);
                                  var selectedFlat = listOfAllFlat[index]['flt_id']
                                      .toString();
                                  var flatId = widget.flt.fltId.toString();
                                  if (flatId.contains(selectedFlat)) {
                                    alertDialogExistingFloor(context);
                                  }
                                  deleteFlat(listOfAllFlat[index]['flt_id']);
                                  Navigator.pop(context);
                                  // deleteFloor(listOfAllFloor[index]['f_id']);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
    );
  }
  _editRoomNameAlertDialog(BuildContext context,index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Room Name"),
            content: TextField(
              controller: roomNameEditing,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  // elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    await addRoomName(roomNameEditing.text,index);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }

  _createAlertDialogDropDownFloor(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Place'),
            content: Container(
              height: 390,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(
                      height: 30,
                    ),
                    FutureBuilder<List<FloorType>>(
                        future: floorValWeb,
                        builder:
                            (context, AsyncSnapshot<List<FloorType>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length == 0) {
                              return Center(
                                  child: Text("No Devices on this place"));
                            }
                            return Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(41.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50.0,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 30,
                                                // offset for Upward Effect
                                                offset: Offset(20,20)
                                            )],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.5,
                                            )
                                        ),
                                        child: DropdownButtonFormField<FloorType>(
                                          decoration:InputDecoration(
                                            contentPadding: const EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(10),
                                            ),enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          ),
                                          dropdownColor: Colors.white70,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 28,
                                          hint: Text('Select Floor'),
                                          isExpanded: true,
                                          value: fl,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          items: snapshot.data
                                              .map((selectedFloor) {
                                            return DropdownMenuItem<FloorType>(
                                              value: selectedFloor,
                                              child: Text(selectedFloor.fName),
                                            );
                                          }).toList(),
                                          onChanged: (FloorType selectedFloor) {
                                            setState(() {
                                              selectedfl = selectedFloor;
                                              flatValWeb=getflatWeb(selectedFloor.fId);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  margin: new EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                              ],
                            );
                          } else {
                            return Center(
                                child: Text(
                                    "Please select a place to proceed further"));
                          }
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    FutureBuilder<List<Flat>>(
                        future: flatValWeb,
                        builder:
                            (context, AsyncSnapshot<List<Flat>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length == 0) {
                              return Center(
                                  child: Text("No Devices on this place"));
                            }
                            return Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(41.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50.0,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 30,
                                                // offset for Upward Effect
                                                offset: Offset(20,20)
                                            )],
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.5,
                                            )
                                        ),
                                        child: DropdownButtonFormField<Flat>(
                                          decoration:InputDecoration(
                                            contentPadding: const EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(10),
                                            ),enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          ),
                                          dropdownColor: Colors.white70,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 28,
                                          hint: Text('Select Floor'),
                                          isExpanded: true,
                                          value: flt,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          items: snapshot.data
                                              .map((selectedFlat) {
                                            return DropdownMenuItem<Flat>(
                                              value: selectedFlat,
                                              child: Text(selectedFlat.fltName),
                                            );
                                          }).toList(),
                                          onChanged: (Flat selectedFlat) {
                                            setState(() {
                                              selectedflat=selectedFlat;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  margin: new EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          } else {
                            return Center(
                                child: Text(
                                    "Please select a place to proceed further"));
                          }
                        }),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                // ignore: deprecated_member_use
                child: FlatButton(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, width: 1),
                      borderRadius:
                      BorderRadius.circular(50)),
                  onPressed: () async {
                    selectedRoom = await getrooms(widget.flt.fltId);


                    //print(pt.p_type);
                    // print(rm[1]);
                    //  print(rm[0].r_name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (
                              context,
                              ) =>
                              Container(
                                child: HomeTest(
                                    pt: widget.pt,
                                    fl: selectedfl,
                                    flat: selectedflat,
                                    rm: selectedRoom,
                                    dv: dv),
                              )),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
  _createAlertDialogForDeleteFloorAndAddFloor(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Choose One For Floor',
              style: TextStyle(fontSize: 20),
            ),
            content: Container(
              // height: MediaQuery
              //     .of(context)
              //     .size
              //     .height - 120,
              child: Column(
                children: [
                  TextButton(
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 54,),
                        Text(
                          'Add Floor',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _createAlertDialogForFloor(context);

                    },
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 54,),
                        Text(
                          'Delete Floor',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: ()async  {
                      await getfloorsWeb(widget.pt.pId);
                      deleteFloorOption(context);
                    },
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 54,),
                        Text(
                          'Edit Floor Name',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      // _editFloorNameAlertDialog(context);
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  _createAlertDialogForFloor(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Name of Floor'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  controller: floorEditing,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Floor Name',
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
                  controller: flatEditing,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Flat Name',
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
                  controller: roomEditing,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Room Name',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    elevation: 5.0,
                    child: Text('Submit'),
                    onPressed: () async {
                      await addFloor(floorEditing.text);
                      await addFlat2(flatEditing.text);
                      await addRoom2(roomEditing.text);

                      Navigator.of(context).pop();
                      final snackBar = SnackBar(
                        content: Text('Floor Added'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
  deleteFloorOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select Floor'),
            content: Container(
              color: Colors.amber,
              width: 78,
              child: ListView.builder(
                  itemCount: listOfAllFloor.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          semanticContainer: true,
                          shadowColor: Colors.grey,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(listOfAllFloor[index]['f_name']),
                              ),
                              RaisedButton(
                                child: Text('Delete Floor'),
                                onPressed: () async {

                                  var floorId = widget.fl.fId.toString();
                                  var selectDelete = listOfAllFloor[index]['f_id']
                                      .toString();
                                  if (floorId.contains(selectDelete)) {
                                    print('true');
                                    alertDialogExistingFloor(context);
                                  }
                                  deleteFloor(listOfAllFloor[index]['f_id'].toString());
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
    );
  }
  Future<void> deleteFloor(String fId) async {
     await getTokenWeb();
    final url = API+'addyourfloor/?f_id=' + fId;
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      print('deleteFloor ${response.body}');
      final snackBar = SnackBar(
        content: Text('Floor Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  var floorResponse;
  Future<void> addFloor(String data) async {
    await getTokenWeb();
    final url = API+'addyourfloor/';
    var postData = {
      "user": getUidVariable,
      "p_id": widget.pt.pId,
      "f_name": data
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode > 0) {
      print(response.statusCode);
      floorResponse = jsonDecode(response.body);
      print(' Floor--> $floorResponse');
    } else {
      throw Exception('Failed to create Floor.');
    }
  }
  Future<void> addFlat2(String data) async {
    print('floorwidgetid ${widget.fl.fId}');
    final url = API+'addyourflat/';
    await getTokenWeb();
    var postData = {
      "user": getUidVariable2,
      "flt_name": data,
      "f_id": floorResponse,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode > 0) {
      print("body");
      print(response.statusCode);
      print('  Flat Created ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        flatResponse = jsonDecode(response.body);

        final snackBar = SnackBar(
          content: Text('Flat Added'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      print(' RoomTabs--> $tabbarState');

      // return RoomType.fromJson(postData);
    } else {
      throw Exception('Failed to create Room.');
    }
  }

  _createAlertDialogForAddRoomDeleteDevices(BuildContext context, String rId,int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Choose One',
              style: TextStyle(fontSize: 20),
            ),
            content: Container(
              height: 90,
              child: Column(
                children: [
                  TextButton(
                    child: Text(
                      'Edit Room Name',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _editRoomNameAlertDialog(context,index);
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Delete Room',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _showDialogForDeleteRoomWithAllDevices(rId);
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  _showDialogForDeleteRoomWithAllDevices(String rId) {
    // dialog implementation
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Alert"),
            content: Text("Are your sure to delete room with all devices"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    print('rid ${rId}');

                    await deleteRoomWithAllDevice(rId);
                    Navigator.pop(context);
                  }
              ),
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
    );
  }

  Future<void> deleteRoomWithAllDevice(String rId) async {
    await getTokenWeb();
    print('deleteRoomId $rId');
    final url = API+'addroom/?r_id=' + rId;
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $tokenWeb',
    });
    if (response.statusCode == 200) {
      print('delete ${response.body}');
      final snackBar = SnackBar(
        content: Text('Device Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
     widget.rm = await getrooms(widget.flt.fltId);
    } else {
      final snackBar = SnackBar(
        content: Text('Something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<RoomType> addRoomName(String data,int index) async {
    await getTokenWeb();
    final url = API+'addroom/';
    print(rIdForName);
    var postDataRoomName = {
      "r_id": rIdForName,
      "f_id": widget.fl.fId,
      "r_name": data,
      "user": getUidVariable2,
    };
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Token $tokenWeb',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postDataRoomName),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      // print(response.body);

      var roomResponse = jsonDecode(response.body);
      setState(() {
        widget.rm[index].rName = postDataRoomName['r_name'];
      });
      print(' Room Response--> $roomResponse');
      print(' RoomName--> ${postDataRoomName['r_name'].toString()}');

      // DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(postData));
      // placeResponsePreference.setInt('p_id', placeResponse);

      return RoomType.fromJson(postDataRoomName);
    } else {
      throw Exception('Failed to create Room.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(widget.pt.pType ==null?" ":widget.pt.pType)),
                SizedBox(width: 12,),
                Icon(Icons.arrow_drop_down_circle_outlined)
              ],
            ),
            onTap: ()async{
              placeVal=  getplaces();
          _createAlertDialogDropDown(context);
      },
        ),

      ),
      body: Container(
        // width: double.maxFinite,
        //
        // // color: change_toDark ? Colors.black : Colors.white,
        child: DefaultTabController(
          // length: rm.length,
          length: widget.rm.length,
          // length: widget.rm.length,
          child: CustomScrollView(
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
                                                    widget.fl.fName.toString(),
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
                                                  InkWell(
                                                      onTap: ()async{
                                                        floorValWeb= getfloorsWeb(widget.pt.pId);
                                                        _createAlertDialogDropDownFloor(context);
                                                      },
                                                      child: Icon(Icons.arrow_drop_down)),
                                                  SizedBox(width: 10,),
                                                  InkWell(
                                                    child: Icon(SettingIcon.params,size: 18,),
                                                    onTap: () async {
                                                      _createAlertDialogForDeleteFloorAndAddFloor(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            // _createAlertDialogDropDown(
                                            //     context);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                    height: 45,
                                      // height: MediaQuery.of(context).size.height/70.2,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 358),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Text('Flat - ',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontFamily: fonttest==null?changeFont:fonttest,
                                                        fontSize: 22,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        // fontStyle: FontStyle.italic
                                                    ),),
                                                ),
                                                Text(
                                                  widget.flt.fltName.toString(),
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
                                                InkWell(
                                                    onTap: ()async{
                                                      flatValWeb=getflatWebForDropDown(widget.fl.fId);
                                                      _createAlertDialogDropDownFlat(context);
                                                    },
                                                    child: Icon(Icons.arrow_drop_down)),
                                                SizedBox(width: 10,),
                                                InkWell(
                                                  child: Icon(SettingIcon.params,size: 18,),
                                                  onTap: () async {
                                                    _createAlertDialogForDeleteFlatAndAddFlat(
                                                        context);
                                                  },
                                                ),
                                                // Row(
                                                //   children: [
                                                //     SizedBox(width: 28,),
                                                //     Container(
                                                //       // color:Colors.red,
                                                //       child: CircularProfileAvatar(
                                                //         '',
                                                //         child: setImage == null
                                                //             ? Image.asset('assets/images/genLogo.png')
                                                //             : setImage,
                                                //         radius: 47.5,
                                                //         // elevation: 5,
                                                //         onTap: () {
                                                //           Navigator.push(
                                                //               context,
                                                //               MaterialPageRoute(
                                                //                   builder: (context) =>
                                                //                       ProfilePage()));
                                                //           //     .then((value) =>
                                                //           // loadImageFromPreferences()
                                                //           //     ? _deleteImage()
                                                //           //     : loadImageFromPreferences());
                                                //         },
                                                //         cacheImage: true,
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                         thickness: 45.3,
                                        ),
                                        // Row(
                                        //   children: [
                                        //     SizedBox(width: 28,),
                                        //     Center(
                                        //       // color:Colors.red,
                                        //       child: CircularProfileAvatar(
                                        //         '',
                                        //         child: setImage == null
                                        //             ? Image.asset('assets/images/genLogo.png')
                                        //             : setImage,
                                        //         radius: 47.5,
                                        //         // elevation: 5,
                                        //         onTap: () {
                                        //           Navigator.push(
                                        //               context,
                                        //               MaterialPageRoute(
                                        //                   builder: (context) =>
                                        //                       ProfilePage()));
                                        //           //     .then((value) =>
                                        //           // loadImageFromPreferences()
                                        //           //     ? _deleteImage()
                                        //           //     : loadImageFromPreferences());
                                        //         },
                                        //         cacheImage: true,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),

                                    // Row(
                                    //   children: <Widget>[
                                    //     Row(
                                    //       children: [
                                    //
                                    //         Text('Flat - ', style: TextStyle(
                                    //               color: Colors
                                    //                   .white,
                                    //               fontWeight: FontWeight
                                    //                   .bold,
                                    //
                                    //               fontFamily: fonttest==null?changeFont:fonttest,
                                    //               fontSize: 22),),
                                    //
                                    //         Text(
                                    //           widget.flt.fltName.toString(),
                                    //           style: TextStyle(
                                    //               color: Colors
                                    //                   .white,
                                    //               fontFamily: fonttest==null?changeFont:fonttest,
                                    //               // fontWeight: FontWeight.bold,
                                    //               // fontStyle: FontStyle
                                    //               //     .italic,
                                    //               fontSize: 22),
                                    //         ),
                                    //         InkWell(
                                    //           onTap: (){
                                    //             flatValWeb=getflatWebForDropDown(widget.fl.fId);
                                    //             _createAlertDialogDropDownFlat(context);
                                    //             },
                                    //           child: Icon(Icons
                                    //               .arrow_drop_down),
                                    //         ),
                                    //         SizedBox(width: 10,),
                                    //         InkWell(
                                    //           onTap: () async {
                                    //             _createAlertDialogForDeleteFlatAndAddFlat(
                                    //                 context);
                                    //           },
                                    //           child: Icon(SettingIcon.params,size: 18,),
                                    //         ),
                                    //         Row(
                                    //           children: [
                                    //             SizedBox(width: 28,),
                                    //             Container(
                                    //               // color:Colors.red,
                                    //               child: CircularProfileAvatar(
                                    //                 '',
                                    //                 child: setImage == null
                                    //                     ? Image.asset('assets/images/genLogo.png')
                                    //                     : setImage,
                                    //                 radius: 47.5,
                                    //                 // elevation: 5,
                                    //                 onTap: () {
                                    //                   Navigator.push(
                                    //                       context,
                                    //                       MaterialPageRoute(
                                    //                           builder: (context) =>
                                    //                               ProfilePage()));
                                    //                   //     .then((value) =>
                                    //                   // loadImageFromPreferences()
                                    //                   //     ? _deleteImage()
                                    //                   //     : loadImageFromPreferences());
                                    //                 },
                                    //                 cacheImage: true,
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     SizedBox(width: 35),
                                    //     // GestureDetector(
                                    //     //     onTap: () async {
                                    //     //
                                    //     //     },
                                    //     //     child: Icon(Icons.add)),
                                    //   ],
                                    // ),

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            FutureBuilder(
                              future: deviceSensorVal,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
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
                                                  child: Text(
                                                      // '2.65',
                                                      sensorData['sensor1'].toString(),
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
                                                  child: Text(
                                                      // '45.36',
                                                      sensorData[
                                                      'sensor2']
                                                          .toString(),
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
                                                  child: Text(
                                                      // '41.25',
                                                      sensorData['sensor3'].toString(),
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
                                                  child: Text(
                                                      // '45.2',
                                                      sensorData['sensor4'].toString(),
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
                                                  child: Text(
                                                      // 'Device Id',
                                                      sensorData['d_id'].toString(),
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
                                  onTap: () async{
                                    await    getUid();
                                    _createAlertDialogForAddRoom(context);
                                  },
                                ),
                              ),
                              InkWell(
                                onLongPress: () {
                                  print('longPress');
                                  print(widget.rm[index].rId);
                                  print(widget.rm[index].rName);
                                  _createAlertDialogForAddRoomDeleteDevices(context,widget.rm[DeleteRoomIndex].rId,index);
                                },
                                child: TabBar(
                                  indicatorColor: Colors.blueAccent,
                                  controller: tabC,
                                  labelColor: Colors.blueAccent,
                                  indicatorWeight: 2.0,
                                  isScrollable: true,
                                  tabs: widget.rm.map<Widget>((RoomType rm) {
                                    rIdForName = rm.rId;
                                    print('RoomId  $rIdForName');
                                    print('RoomId  ${rm.rName}');
                                    return Tab(
                                      text: rm.rName,
                                    );
                                  }).toList(),
                                  onTap: (index) async {
                                      setState(() {
                                        DeleteRoomIndex=index;
                                      });
                                    if(widget.rm[index].rId==null) {
                                      setState(() {
                                        tabbarStateWeb = widget.tabbarState;
                                      });
                                      widget.rm = await getrooms(widget.flt.fltId);
                                      widget.dv= await getDevices(tabbarStateWeb);
                                    }else{


                                      setState(() {
                                        tabbarStateWeb=widget.rm[index].rId;
                                      });
                                      print('qwedsaxcfr ${widget.rm[index].rName}');
                                      print('qwedsaxcfr ${widget.rm[index].rName}');
                                      print('qwedsaxcfr ${widget.rm[index].rId}');
                                      print('qwedsaxcfr ${widget.rm[index].fltId}');
                                      print('qwedsaxcfr ${widget.rm[index].user}');
                                      print('flat ${widget.flt.fltId}');
                                     widget.rm = await getrooms(widget.flt.fltId);
                                     widget.dv= await getDevices(tabbarStateWeb);
                                    }

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
                    print('checkindex123 $index');
                    print('checkdevice123 ${widget.dv.length}');
                    if (index < widget.dv.length) {
                      print('checkindex123underif $index');
                      print('checkdevice123 ${widget.dv.length}');
                      print('checkdevice123 ${widget.dv[index].dId}');

                      return Container(
                        child: Column(
                          children: [
                            deviceContainer2(widget.dv[index].dId,index),
                            Container(
                                //
                                // color: Colors.green,
                                height: 35,
                                child: GestureDetector(
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: widget.dv[index].dId,
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.black)),
                                      TextSpan(text: "   "),
                                      WidgetSpan(
                                          child: Icon(
                                        Icons.settings,
                                        size: 18,
                                      ))
                                    ]),
                                  ),
                                  onTap: () {
                                    // _createAlertDialogForSSIDAndEmergencyNumber(
                                    //     context);
                                    print('on tap');
                                  },
                                )),
                          ],
                        ),
                        // child: Text(dv[index].dId),
                      );
                    } else {
                      return null;
                    }
                  }),
                )
              ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          print('Add Device-->  $tabbarStateWeb');
          _createAlertDialog(context);
          setState(() {
            // i++;
          });
        },
      ),
    );
  }
}

