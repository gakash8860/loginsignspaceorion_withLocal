import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/painting.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:loginsignspaceorion/Add%20SubUser/showSubUser.dart';
import 'package:loginsignspaceorion/BillPrediction.dart';
import 'package:loginsignspaceorion/SETTINGS.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/SQLITE_database/database_helper.dart';

import 'package:loginsignspaceorion/SSID_PASSWORD_and_EmergencyNumber/showEmergencyNumber.dart';
import 'package:loginsignspaceorion/SSID_PASSWORD_and_EmergencyNumber/showSSID.dart';
import 'package:loginsignspaceorion/SubAccessPage/subaccesslist.dart';
import 'package:loginsignspaceorion/TempAccessPage/tempaccess.dart';
import 'package:loginsignspaceorion/TemporaryUser/showTempUser.dart';
import 'package:loginsignspaceorion/about_Genorion.dart';
import 'package:loginsignspaceorion/components/constant.dart';
import 'package:loginsignspaceorion/googleAssistant/DeviceApps.dart';
import 'package:loginsignspaceorion/information.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:loginsignspaceorion/schedulePin/schedulPin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import 'package:loginsignspaceorion/dropdown1.dart';
import 'package:loginsignspaceorion/main.dart';
import 'package:loginsignspaceorion/scheduling/alarmHelper.dart';
import 'package:loginsignspaceorion/scheduling/alarmInfo.dart';
import 'package:loginsignspaceorion/scopedModel/connectedModel.dart';
import 'package:loginsignspaceorion/utility.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignspaceorion/whatNew.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:loginsignspaceorion/ProfilePage.dart';

import '../Setting_Page.dart';
import '../billprediction2.dart';
import 'DesktopUi/desktopMenu.dart';
import 'DesktopUi/destination.dart';
import 'DesktopUi/destinationview.dart';

var tabbarState = "";
var value = 1;
List placeData = [];
List<PlaceType> places;

List<FloorType> floors;
List<RoomType> rooms;

List floorData;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeTest(
        // rm: [rm[0]],
      ),
    );
  }
}

// ignore: must_be_immutable
class HomeTest extends StatefulWidget {
  // ignore: must_be_immutable
  static const routeName = '/homeTest';
  PlaceType pt;
  FloorType fl;
  Flat flat;
  List<RoomType> rm;
  List<Device> dv;
  SensorData sensorData;
  final int currentIndex;
  final Function(int selectedIndex) onTapped;

  HomeTest({Key key,
    this.pt,
    this.fl,
    this.currentIndex,
    this.flat,
    this.onTapped,
    @required this.rm,
    @required this.dv,
    this.sensorData})
      : super(key: key);

  // ignore: non_constant_identifier_names
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
  _HomeTestState createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest>
    with TickerProviderStateMixin<HomeTest> {
  List roomData;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController deviceNameEditing = TextEditingController();
  TextEditingController roomEditing = TextEditingController();
  TextEditingController pin19Controller = TextEditingController();
  TextEditingController pin17Controller = TextEditingController();
  TextEditingController floorEditing = TextEditingController();
  TextEditingController flatEditing = TextEditingController();
  TextEditingController controller = TextEditingController();
  GlobalKey key;
  DateTime pickedDate;

  // List<RoomType> rm;
  // AudioCache _player;
  var postData;
  bool isVisible = false;

  // = GlobalKey<FormState>();
  var temp = "DIDM12932021AAAAAA";
  List<bool> isSelected = [true, false, false];
  var getDataStatus;
  Future placeVal;
  Future floorVal;
  final item = List.from(ConnectedModel.applianceList);
  Image setImage;
  SharedPreferences preferences;
  DateTime now = new DateTime.now();
  int _currentIndex = 0;
  var imageString;
  int index = 0;

  // PlaceType pt;
  // Flat flat;
  // FloorType fl;
  TimeOfDay time;
  TimeOfDay time23;
  TimeOfDay picked;
  String tabbarState = "";
  String _alarmTimeString;
  String _dateString = "";
  DateTime _alarmTime;
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> placeRows;
  List placeQueryData;
  List floorQueryData;
  List floorQueryData2;
  List<Map<String, dynamic>> floorQueryRows;
  List<Map<String, dynamic>> roomQueryRows;
  List<Map<String, dynamic>> deviceQueryRows;
  List<Map<String, dynamic>> pinStatusQueryRows;
  List<Map<String, dynamic>> sensorQueryRows;
  List<Map<String, dynamic>> sensor2QueryRows;
  List<Map<String, dynamic>> deviceQueryRows2;
  List<Map<String, dynamic>> devicePinNamesQueryRows;
  List<Map<String, dynamic>> devicePinNamesQueryRows2;
  List<Map<String, dynamic>> floorQueryRows2;
  List<Map<String, dynamic>> flatQueryRows2;
  List<Map<String, dynamic>> roomQueryRows2;
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

  int m = 0,
      n = 0,
      o = 0,
      p = 0,
      q = 0,
      r = 0,
      s = 0,
      t = 0;
  int c = 0;
  List<dynamic> deviceData;

  Device device;
  bool val1 = true;

  bool val2 = false;
  Timer timer;
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  final storage = FlutterSecureStorage();
  TextEditingController idText = new TextEditingController();
  DropDown1 down1 = new DropDown1();
  bool _switchValue = false;
  var data;
  List<int> listDynamic = [];
  var flatId;

  // TextEditingController sendDevice= TextEditingController();
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
  List<int> sliderContainer = [];
  TabController tabC;
  List<dynamic> deviceStatus = [];

  Future flatVal;

  // =new TabController(length: widget.rm.length, vsync: null);

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

  addDynamic() {
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

    // listDynamic.add(DynamicWidget());
    print('added');
  }

  addSlider() {
    sliderContainer.add(slider1 = 0);
    sliderContainer.add(slider2 = 0);
    sliderContainer.add(slider3 = 0);
  }

  checkDeviceResponse() {
    if (deviceResponse == 'data created') {
      readId();
    } else {
      final snackBar = SnackBar(
        content: Text('Enter The Valid Device Id'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future openPlaceBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    placeBox = await Hive.openBox('place');
    // places.first=placeBox.values.first;
    setState(() {
      // places[0]=placeBox.values.first;
    });

    return;
  }

  var deviceofI;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      print('10seconds');
      fetchPlace();
      // getAllFloor();
    });
    _index = widget.currentIndex;
  }


  TextEditingController placeEditing = new TextEditingController();
  TextEditingController floorNameEditing = new TextEditingController();
  TextEditingController flatNameEditing = new TextEditingController();
  TextEditingController roomNameEditing = new TextEditingController();

  Future<void> update() async {
    getPlaceName();
  }

  var postDataPlaceName;

// ignore: missing_return
  Future<PlaceType> getPlaceName() async {
    String token = await getToken();
    print('currentPlaceId ${widget.pt.pId}');
    final url =
        'http://genorion1.herokuapp.com/addyourplace/?p_id=' + widget.pt.pId;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      var p12t = jsonDecode(response.body);
      pt = PlaceType.fromJson(p12t);
      print("GetPlaceName  ${response.statusCode}");
      print("GetPlaceNameResponseBody  ${response.body}");
    }
  }

  // ignore: missing_return


  Future<PlaceType> addPlaceName(String data) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addyourplace/';
    var postDataPlaceName = {
      "p_id": widget.pt.pId,
      "p_type": data,
      "user": getUidVariable2,
    };
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postDataPlaceName),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      print("ResponseBody  ${response.body}");

      var placeResponse = jsonDecode(response.body);
      setState(() {
        widget.pt.pType = postDataPlaceName['p_type'];
      });
      return PlaceType.fromJson(postDataPlaceName);
    } else {
      throw Exception('Failed to create Place.');
    }
  }

  Future<FloorType> addFloorName(String data) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addyourfloor/';
    var postDataFloorName = {
      "f_id": widget.fl.fId,
      "f_name": data,
      "user": getUidVariable2,
    };
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postDataFloorName),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      print(response.body);

      var floorResponse = jsonDecode(response.body);
      setState(() {
        widget.fl.fName = postDataFloorName['f_name'];
      });
      getAllFloor();
      print(' Floor Response--> $floorResponse');
// pt.pType=;
      print(' FloorName--> ${postDataFloorName['f_name']}');

      // DatabaseHelper.databaseHelper.insertPlaceData(PlaceType.fromJson(postData));
      // placeResponsePreference.setInt('p_id', placeResponse);

      return FloorType.fromJson(postDataFloorName);
    } else {
      throw Exception('Failed to create Floor.');
    }
  }

  Future<FloorType> addFlatName(String data) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addyourflat/';
    var postDataFlatName = {
      "flt_id": widget.flat.fltId,
      "flt_name": data,
      "user": getUidVariable2,
    };
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postDataFlatName),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      print(response.body);

      var flatResponse = jsonDecode(response.body);
      setState(() {
        widget.flat.fltName = postDataFlatName['flt_name'];
      });
      getAllFlat();
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

  Future devicePinNamesQueryFunc() async {
    devicePinNamesQueryRows = await NewDbProvider.instance.queryPinNames();

    print('devicePinNamesQueryFunc  $devicePinNamesQueryRows');

    return devicePinNamesQueryRows;
  }

  Future devicePinStatusQueryFunc() async {
    pinStatusQueryRows = await NewDbProvider.instance.queryPinStatus();
    // List
    print('devicePinStatusLocalHome  $pinStatusQueryRows');
    // var deviceId=
    // var = await NewDbProvider.instance.getPinStatusByDeviceId(id)
    return pinStatusQueryRows;
  }

  var statusPinNames;
  List namesDataList = [];

  Future getPinsName(String dId) async {
    String url = "http://genorion1.herokuapp.com/editpinnames/?d_id=" + dId;
    String token = await getToken();
    // try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      var devicePinNamesData = json.decode(response.body);
      // DevicePin devicePin=DevicePin.fromJson(devicePinNamesData);

      List listOfPinNames = [
        devicePinNamesData,
      ];

      print('QWERTY  $listOfPinNames');
      for (int i = 0; i < listOfPinNames.length; i++) {
        print('devicePinData $listOfPinNames}');

        var devicePinNamesQuery = DevicePin(
          id: listOfPinNames[i]['id'],
          dId: listOfPinNames[i]['d_id'].toString(),
          pin1Name: listOfPinNames[i]['pin1Name'].toString(),
          pin2Name: listOfPinNames[i]['pin2Name'].toString(),
          pin3Name: listOfPinNames[i]['pin3Name'].toString(),
          pin4Name: listOfPinNames[i]['pin4Name'].toString(),
          pin5Name: listOfPinNames[i]['pin5Name'].toString(),
          pin6Name: listOfPinNames[i]['pin6Name'].toString(),
          pin7Name: listOfPinNames[i]['pin7Name'].toString(),
          pin8Name: listOfPinNames[i]['pin8Name'].toString(),
          pin9Name: listOfPinNames[i]['pin9Name'].toString(),
          pin10Name: listOfPinNames[i]['pin10Name'].toString(),
          pin11Name: listOfPinNames[i]['pin11Name'].toString(),
          pin12Name: listOfPinNames[i]['pin12Name'].toString(),
        );
        print('devicePinNamesInsertQuery    ${devicePinNamesQuery.toJson()}');
        print('devicePinQueryToJson    ${devicePinNamesQuery.toJson()}');
        await NewDbProvider.instance.updatePinName(devicePinNamesQuery);
      }
    }
  }


  List pinNames = [];

  Future<DevicePin> addPinsName(String data, int index) async {
    String token = await getToken();
    print('data[index] ${widget.dv[index].dId}');
    final url = 'http://genorion1.herokuapp.com/editpinnames/';
    var postDataPinName;
    if (index == 0) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin1Name": data.toString(),
      };
    } else if (index == 1) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin2Name": data.toString(),
      };
    } else if (index == 2) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin3Name": data,
      };
    } else if (index == 3) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin4Name": data,
      };
    } else if (index == 4) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin5Name": data,
      };
    } else if (index == 5) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin6Name": data,
      };
    } else if (index == 6) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin7Name": data,
      };
    } else if (index == 7) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin8Name": data,
      };
    } else if (index == 8) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin9Name": data,
      };
    } else if (index == 9) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin10Name": data,
      };
    } else if (index == 10) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
        "pin11Name": data,
      };
    } else if (index == 11) {
      postDataPinName = {
        "d_id": widget.dv[index].dId,
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

  Future<RoomType> addRoomName(String data) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addroom/';
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
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postDataRoomName),
    );

    if (response.statusCode > 0) {
      print(response.statusCode);
      // print(response.body);

      var roomResponse = jsonDecode(response.body);
      setState(() {
        rm.first.rName = postDataRoomName['r_name'];
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

  _editPlaceNameAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Place Name"),
            content: TextField(
              controller: placeEditing,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  // elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    addPlaceName(placeEditing.text);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }

  _editFloorNameAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Floor Name"),
            content: TextField(
              controller: floorNameEditing,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  // elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    addFloorName(floorNameEditing.text);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
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
                    addFlatName(flatNameEditing.text);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }


  _editRoomNameAlertDialog(BuildContext context) {
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
                    addRoomName(roomNameEditing.text);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }

  Future returnFlatQuery(String fId) {
    return NewDbProvider.instance.queryFlat();
  }

  _createAlertDialogDropDown(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Place'),
            content: Container(
              height: 390,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FutureBuilder(
                          future: returnPlaceQuery(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          offset: Offset(20, 20))
                                    ],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    )),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  dropdownColor: Colors.white70,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 28,
                                  hint: Text('Select Place'),
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  items: placeRows.map((selectedPlace) {
                                    return DropdownMenuItem<String>(
                                      value: selectedPlace.toString(),
                                      child: Text("${selectedPlace['p_type']}"),
                                    );
                                  }).toList(),
                                  onChanged: (selectedPlace) async {
                                    var check = selectedPlace;
                                    print('check ${check.toString()}');
                                    var placeid = selectedPlace.substring(
                                        7, 14);
                                    var placeName = selectedPlace.substring(
                                        24, 31);
                                    var user = selectedPlace.substring(38, 40);
                                    int user2 = int.parse(user);
                                    print('placeName $user');
                                    // pt=as.map((e) => PlaceType.fromJson(json));
                                    var pids = PlaceType(
                                        pId: placeid,
                                        pType: placeName,
                                        user: user2
                                    );
                                    pt = pids;
                                    // pt=as.map((data) => PlaceType.fromJson(data)).toList();
                                    print("SElectedPlace ${selectedPlace}");

                                    var aa = await NewDbProvider.instance
                                        .getFloorById(placeid.toString());
                                    print('AA  ${aa}');
                                    floorval = null;
                                    setState(() {
                                      floorQueryRows2 = aa;
                                      floorval = returnFloorQuery(placeid);
                                      returnFloorQuery(placeid);
                                    });
                                    print('Floorqwe  ${floorQueryRows2}');

                                    // qwe= ;
                                  },
                                  // items:snapshot.data
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FutureBuilder(
                          future: floorval,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          offset: Offset(20, 20))
                                    ],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    )),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),

                                  dropdownColor: Colors.white70,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 28,
                                  hint: Text('Select Floor'),
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  items: floorQueryRows2.map((selectedFloor) {
                                    return DropdownMenuItem(
                                      value: selectedFloor.toString(),
                                      child: Text("${selectedFloor['f_name']}"),
                                    );
                                  }).toList(),
                                  onChanged: (selectedFloor) async {
                                    print('Floor selected $selectedFloor');
                                    var check = selectedFloor;
                                    var floorId = selectedFloor.substring(
                                        7, 14);
                                    var floorName = selectedFloor.substring(
                                        24, 32);
                                    var placeId = selectedFloor.substring(
                                        39, 46);
                                    // var user =selectedFloor.substring(54,55);
                                    // int user2 =int.parse(user);
                                    // print('floorName $user');
                                    var floor = FloorType(
                                        fId: floorId,
                                        fName: floorName,
                                        pId: placeId,
                                        user: getUidVariable2
                                    );
                                    fl = floor;
                                    var getFlat = await NewDbProvider.instance
                                        .getFlatByFId(floorId.toString());
                                    print(getFlat);
                                    setState(() {
                                      flatVal = returnFlatQuery(floorId);
                                      flatQueryRows2 = getFlat;
                                    });
                                    print('forRoom  ${roomQueryRows2}');

                                    returnFloorQuery(floorId);
                                  },
                                  // items:snapshot.data
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FutureBuilder(
                          future: flatVal,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          offset: Offset(20, 20))
                                    ],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    )),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),

                                  dropdownColor: Colors.white70,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 28,
                                  hint: Text('Select Flat'),
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  items: flatQueryRows2.map((selectedFlat) {
                                    return DropdownMenuItem(
                                      value: selectedFlat.toString(),
                                      child: Text(
                                          "${selectedFlat['flt_name']}"),
                                    );
                                  }).toList(),
                                  onChanged: (selectedFlat) async {
                                    flatId = selectedFlat.substring(9, 16);
                                    // var flatId = selectedFlat.substring(7, 14);
                                    var flatName = selectedFlat.substring(
                                        28, 35);
                                    var floorId = selectedFlat.substring(
                                        39, 46);
                                    // var user =selectedFlat.substring(58,59);

                                    print('flatName $selectedFlat');
                                    // print('flatName $user');
                                    // int user2 =int.parse(user);
                                    // int user2=int.parse(user.toString());
                                    var flt = Flat(
                                        fId: floorId,
                                        fltId: flatId,
                                        fltName: flatName,
                                        user: getUidVariable2
                                    );
                                    flat = flt;
                                    print(flatId);

                                    // var  aa= await NewDbProvider.instance.getRoomById(flatId.toString());
                                    // print('AA  ${aa}');
                                    setState(() {
                                      // roomQueryRows2=aa;
                                      // roomVal=returnRoomQuery(flatId);
                                    });
                                    print('forRoom  ${roomQueryRows2}');

                                    // returnFloorQuery(floorId);
                                  },
                                  // items:snapshot.data
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  // elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    List result = await NewDbProvider.instance
                        .getRoomById(flatId.toString());
                    print("SubmitAllDetails  ${result}");
                    room = List.generate(
                        result.length,
                            (index) =>
                            RoomType(
                              rId: result[index]['r_id'].toString(),
                              fltId: result[index]['flt_id'].toString(),
                              rName: result[index]['r_name'].toString(),
                              user: result[index]['user'],
                            )
                    );
                    rm = room;
                    // rm = await getrooms(fl.fId);
                    // print('hello   ${rm[0].rId}') ;
                    setState(() {
                      // tabbarState = rm[0].rId;
                    });
                    // Navigator.of(context).pop();
                    // print('State   $tabbarState');
                    // print('FID-->   ${fl.fId}');
                    // // dv = await getDevices(tabbarState );
                    //
                    // print('On Pressed  ${pt.pId}');
                    // print('On Pressed place response ${pt.pId}');
                    // // print(rm[1]);
                    // //  print(rm[0].r_name);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context,) =>
                              Container(
                                child: HomeTest(
                                  pt: pt,
                                  fl: fl,
                                  flat: flat,
                                  rm: rm,
                                  // dv: dv
                                ),
                              )),
                    );
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
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Device Id'),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () {
                    // readId();
                    // addDynamic();
                    //
                    print('Add Device-->  $tabbarState');
                    send_DeviceId(controller.text)
                        .then((value) => checkDeviceResponse());
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

  Future<List<RoomType>> roomQueryFunc() async {
    roomQueryRows = await NewDbProvider.instance.queryRoom();
    print('qqqq ${roomQueryRows}');
    List roomTypeSingle = roomQueryRows;
    var id = roomQueryRows[0]['flt_id'].toString();

    roomQueryRows2 = roomQueryRows;
    List result = await NewDbProvider.instance.getRoomById(id);
    print('roomResult $result');
    room = List.generate(
        result.length,
            (index) =>
            RoomType(
              rId: result[index]['r_id'].toString(),
              fltId: result[index]['flt_id'].toString(),
              rName: result[index]['r_name'].toString(),
              user: result[index]['user'],
            ));
    // widget.rm=room;
    print('roomCheck123 ${widget.rm.length}');
    return room;
  }

  _createAlertDialogForAddRoom(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                      await addRoom(roomEditing.text);
                      // await getAllRoom();
                      roomQueryFunc();

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

  _createAlertDialogForPin19(BuildContext context, String dId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Any Text For Pin 19'),
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
                  controller: pin19Controller,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter ANy Text ',
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
                      await dataUpdateforPin19(dId);
                      // await getAllRoom();
                      // roomQueryFunc();

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

  _createAlertDialogForPin17(BuildContext context, String dId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Cell Number of your Device'),
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
                  controller: pin17Controller,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Mobile Number ',
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
                      await dataUpdateforPin19(dId);
                      // await getAllRoom();
                      // roomQueryFunc();

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
                      //  await addRoom2(roomEditing.text);
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

  _createAlertDialogForFlat(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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

  TextEditingController pinNameController = new TextEditingController();

  _createAlertDialogForNameDeviceBox(BuildContext context, int index) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Name of Device'),
            content: TextField(
              controller: pinNameController,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () {
                    // addDeviceName(index);
                    addPinsName(pinNameController.text, index);
                    Navigator.of(context).pop();
                    //

                    print(
                        'Device Name ----->>>> ${names.map((e) =>
                            addPinsName(pinNameController.text, index))}');
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

  _createAlertDialogForSSIDAndEmergencyNumber(BuildContext context,String dId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 165,
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowSsid(
                                      deviceId: dId,
                                    )));
                      },
                      child: Text(
                        'Set SSID and Password',
                        style: TextStyle(fontSize: 20),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowEmergencyNumber(
                                      deviceId: dId,
                                    )));
                      },
                      child: Text(
                        'Emergency Number',
                        style: TextStyle(fontSize: 20),
                      )),
                  TextButton(
                      onPressed: () {
                        _createAlertDialogForPin17(context, dId);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             ShowEmergencyNumber(
                        //               deviceId: widget.dv[index].dId,
                        //             )));
                      },
                      child: Text(
                        'Add Device Cell Number',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  _createAlertDialogForAddMembers(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 105,
              child: Column(
                children: [
                  TextButton(
                    child: Text(
                      'Sub User',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowSubUser()));
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Temporary User',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowTempUser()));
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  List listOfAllFloor;
  List listOfAllFlat;

  allFloor() async {
    listOfAllFloor = await NewDbProvider.instance.queryFloor();
  }


  allFlat() async {
    listOfAllFlat = await NewDbProvider.instance.queryFlat();
  }

  _createAlertDialogForAddRoomDeleteDevices(BuildContext context, String rId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                      _editRoomNameAlertDialog(context);
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

  deleteFloorOption(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                                  deleteFloor(
                                      listOfAllFloor[index]['f_id'].toString());
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

  deleteFlatOption(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                                  var flatId = widget.flat.fltId.toString();
                                  if (flatId.contains(selectedFlat)) {
                                    alertDialogExistingFloor(context);
                                  }
                                  deleteFlat(listOfAllFlat[index]['flt_id']
                                      .toString());
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

  _createAlertDialogForDeleteFloorAndAddFloor(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowSubUser()));
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
                    onPressed: () {
                      deleteFloorOption(context);
                      // _showDialogForDeleteRoomWithAllDevices(rId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowTempUser()));
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
                      _editFloorNameAlertDialog(context);
                      // deleteFloorOption(context);
                      // _showDialogForDeleteRoomWithAllDevices(rId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowTempUser()));
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  _createAlertDialogForlocalUpdateAndMessage(BuildContext context,String dId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  'Your Internet Connection is not working... ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Are you Connected On ?? ',
                  style: TextStyle(fontSize: 20),
                ),
              ],
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
                          'Local Update',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      localUpdate(dId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowSubUser()));
                    },
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 54,),
                        Text(
                          'Message',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      messageSms(context, dId);
                      // _showDialogForDeleteRoomWithAllDevices(rId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowTempUser()));
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
                      _editFloorNameAlertDialog(context);
                      // deleteFloorOption(context);
                      // _showDialogForDeleteRoomWithAllDevices(rId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowTempUser()));
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  _createAlertDialogForDeleteFlatAndAddFlat(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowSubUser()));
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Delete Flat',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      deleteFlatOption(context);
                      // _showDialogForDeleteRoomWithAllDevices(rId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowTempUser()));
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Edit Flat Name',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _editFlatNameAlertDialog(context);
                      // deleteFloorOption(context);
                      // _showDialogForDeleteRoomWithAllDevices(rId);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ShowTempUser()));
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[],
          );
        });
  }

  readId() {
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>addDynamic())).then((value) => addSlider());

    addDynamic();

    addSlider();
    final snackBar = SnackBar(
      content: Text('Device Added'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('slider');
  }

  var recipents = "9911757588";
  var message = "d_id:";
  var messageIOS = "This_is%20time";

  void messageSms(BuildContext context, String dId) {
    if (Platform.isAndroid) {
      launch("sms:" +
          recipents +
          "?body=" +
          message +
          dId +
          ":" +
          responseGetData[0].toString() +
          responseGetData[1].toString() +
          responseGetData[2].toString() +
          responseGetData[3].toString() +
          responseGetData[4].toString() +
          responseGetData[5].toString() +
          responseGetData[6].toString() +
          responseGetData[7].toString() +
          responseGetData[8].toString() +
          responseGetData[9].toString() +
          responseGetData[10].toString() +
          responseGetData[11].toString() +
          ":");
    } else if (Platform.isIOS) {
      launch("sms:" + recipents + "&body=" + messageIOS);
    }
  }

  var recipentEmail = "contact@genorion.com";
  var emailSubject = "hey";
  var emailBody = "hello how are you%20plugin";
  var emailBodyIOS = "hello_how_are_you%20plugin";

  void emailMessage(BuildContext context) {
    if (Platform.isAndroid) {
      launch("mailto:" +
          recipentEmail +
          "?subject=" +
          emailSubject +
          "&body=" +
          emailBody);
    } else if (Platform.isIOS) {
      launch("mailto:" +
          recipentEmail +
          "?subject=" +
          emailSubject +
          "&body=" +
          emailBodyIOS);
    }
  }

  loadImageFromPreferences() async {
    preferences = await SharedPreferences.getInstance();
    final _imageKeyValue = preferences.getString(IMAGE_KEY);
    if (_imageKeyValue != null) {
      final imageString = await Utility.getImagefrompreference();
      setState(() {
        setImage = Utility.imageFrom64BaseString(imageString);
      });
    }
  }

  getDatafunc2() {
    // getSensorData(deviceIdForSensor);
    // getPinsName();

    for (int i = 0; i < dv.length; i++) {
      print('yoooooooooooo');
      getData(widget.dv[i].dId);
    }
    print('deviceIdForSensor $deviceIdForSensor');
    // getPinNames(deviceIdForSensor);
  }

  // var getDataSql;

  // @override
  // void initState() {
  //
  //   if(roomResponse!=null){
  //     tabbarState = roomResponse;
  //     print('hahahah $tabbarState');
  //   }
  //   // print('roomLength ${widget.fl.fId}');
  //   // print('flatDetails ${widget.flat.fltId}');
  //   // devicePinNamesQueryFunc();
  //   // placeVal= returnPlaceQuery();
  //   // placeQueryFunc();
  //   // placeVal = fetchplace();
  //   // floorval = fetchFloor(placeVal.toString());
  //
  //   timer = Timer.periodic(Duration(minutes: 5), (timer) async {
  //
  //     getDevices(tabbarState);
  //     getDatafunc2();
  //
  //
  //     await devicePinStatusQueryFunc();
  //
  //
  //     // getData(controller.text);
  //   });
  //
  //
  //   tabC = new TabController(length: widget.rm.length, vsync: this);
  //   tabC.addListener(() {
  //
  //     setState(() {
  //       // tabbarState = rm[0].rId;
  //       tabbarState = widget.rm[index].rId;
  //
  //     });
  //   });
  //
  //   super.initState();
  //   loadImageFromPreferences();
  //   // tabbarState=rm[index].rId;
  //   // initSharedPreference();
  //
  //   // Timer.periodic(Duration(seconds: 5), (timer) {
  //   //   // getData();
  //   //   setState(() {
  //   //     deviceCurrentStatus[0] = widget.switch1_get;
  //   //     deviceCurrentStatus[1] = widget.switch2_get;
  //   //     deviceCurrentStatus[2] = widget.switch3_get;
  //   //     deviceCurrentStatus[3] = widget.switch4_get;
  //   //     deviceCurrentStatus[4] = widget.switch5_get;
  //   //     deviceCurrentStatus[5] = widget.switch6_get;
  //   //     deviceCurrentStatus[6] = widget.switch7_get;
  //   //     deviceCurrentStatus[7] = widget.switch8_get;
  //   //     deviceCurrentStatus[8] = widget.switch9_get;
  //   //     sliderContainer[0] = widget.Slider_get;
  //   //     sliderContainer[1] = widget.Slider_get2;
  //   //     sliderContainer[2] = widget.Slider_get3;
  //   //     j = widget.Slider_get;
  //   //     k = widget.Slider_get2;
  //   //     l = widget.Slider_get3;
  //   //
  //   //   });
  //   // });
  // }

  // loadData(){
  // getDataSql=databaseHelper.getPlaceData();
  // }

  @override
  void dispose() {
    super.dispose();
    print('super.dispose();');
    tabC.dispose();
    timer.cancel();
  }

  Future<List<Device>> deviceQueryFunc(String rId) async {
    deviceQueryRows = await NewDbProvider.instance.queryDevice();
    // List dv1= deviceQueryRows;
    // dv=deviceQueryRows;
    print('UnderTapRoomId $rId');
    var result = await NewDbProvider.instance.getDeviceByRId(rId);
    print('dvlouyeinitstate ${result}');
    return result;

    // var result= await NewDbProvider.instance.getRoomById(id);
    // print('deviceLocalDatais  ${dv.length}');
  }

  Future<String> getToken() async {
    final token = await storage.read(key: "token");
    return token;
  }

  var deviceResponse;

  // ignore: non_constant_identifier_names, missing_return
  Future<Device> send_DeviceId(String data) async {
    String token = await getToken();
    print('getUidVariable $getUidVariable');
    final url = 'http://genorion1.herokuapp.com/addyourdevice/';
    postData = {"user": getUidVariable, "r_id": tabbarState, "d_id": data};
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode > 0) {
      // print(roomResponse);
      print("CHECKDEVICE123CODE   ${response.statusCode}");
      print(response.body);
      deviceResponse = jsonDecode(response.body);
      getDeviceOffline(tabbarState);
      print(postData);
    } else {
      throw Exception('Failed to create Device.');
    }
  }

  var deviceIdForSensor;

  // ignore: missing_return
  Future<List<Device>> getDevices(String rId) async {
    print('tabbas ${tabbarState}');
    var query = {'r_id': tabbarState};
    final url = Uri.https('genorion1.herokuapp.com', '/addyourdevice/', query);
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print(response.statusCode);
      deviceData = jsonDecode(response.body);
      widget.dv = deviceData.map((data) => Device.fromJson(data)).toList();
      print('Room Id query ================================   $query');
      print('------Devicessssssssssssssssssssssssssssss Data $deviceData');

      getDatafunc2();
      return dv;
    }
  }

  Future<List<Device>> getDeviceOffline(String rId) async {
    String token = await getToken();
    var rId;
    for (int i = 0; i < roomQueryRows.length; i++) {
      //   print(NewDbProvider.instance.dogs());
      rId = roomQueryRows[i]['r_id'].toString();
      print('roomId  $rId');
      String url = "http://genorion1.herokuapp.com/addyourdevice/?r_id=" + rId;
      var response;
      // try {
      response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      deviceData = jsonDecode(response.body);
      // print('deviceData  ${deviceData}');
      deviceQueryRows=await NewDbProvider.instance.queryDevice();
      if(deviceData.length==deviceQueryRows.length){
        for (int i = 0; i < deviceData.length; i++) {
          var deviceQuery = Device(
              user: deviceData[i]['user'],
              rId: deviceData[i]['r_id'],
              dId: deviceData[i]['d_id']);
          print('deviceQueryFunc   $deviceData}');

          // await NewDbProvider.instance.insertDeviceModelData(deviceQuery);
          await NewDbProvider.instance.updateDevice(deviceQuery);
        }
      }else{
           await NewDbProvider.instance.deleteDeviceModel();
        for (int i = 0; i < deviceData.length; i++) {
          var deviceQuery = Device(
              user: deviceData[i]['user'],
              rId: deviceData[i]['r_id'],
              dId: deviceData[i]['d_id']);
          print('deviceQueryFunc   $deviceData}');

          await NewDbProvider.instance.insertDeviceModelData(deviceQuery);
          // await NewDbProvider.instance.updateDevice(deviceQuery);
        }
      }

    }
    // dv = deviceData.map((data) => Device.fromJson(data)).toList();
    return dv;
  }

  Future <void> deleteDevice(String rId, String dId) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addyourdevice/?r_id=${rId}&d_id=${dId}';
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        content: Text('Device Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> deleteRoomWithAllDevice(String rId) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addroom/?r_id=' + rId;
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      print('delete ${response.body}');
      final snackBar = SnackBar(
        content: Text('Device Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  Future<void> deleteFloor(String fId) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addyourfloor/?f_id=' + fId;
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      print('deleteFloor ${response.body}');
      final snackBar = SnackBar(
        content: Text('Floor Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      getAllFloor();
    } else {
      final snackBar = SnackBar(
        content: Text('Something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> deleteFlat(String flt_Id) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addyourflat/?flt_id=' + flt_Id;
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      print('deleteFloor ${response.body}');
      final snackBar = SnackBar(
        content: Text('Flat Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      getAllFlat();
    } else {
      final snackBar = SnackBar(
        content: Text('Something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

// List getIpVariable=["10.25.202.11","10.25.202.12"];
  var getVariable;
  var rIdForName;
  int counter = 0;

  getIp() async {
    print('no');
    while (counter <= dv.length - 1) {
      print('yes');
      final url = 'http://genorion1.herokuapp.com/addipaddress/?d_id=' +
          dv[counter].dId.toString();
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

    counter = 0;
  }

  IpAddress ip12;
  var ip;

  // ignore: missing_return
  Future<IpAddress> fetchIp(String dId) async {
    while (counter <= widget.dv.length) {
      String token = await getToken();
      final url = 'http://genorion1.herokuapp.com/addipaddress/?d_id=' + dId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      if (response.statusCode == 200) {
        ip = IpAddress
            .fromJson(jsonDecode(response.body))
            .ipaddress;
        print('IPCheck  ${ip.toString()}');
      }
      counter++;
    }
    counter = 0;
  }

  var localResponse;

  localUpdate(String dId) async {
    localResponse = http.get(Uri.parse('http://' +
        ip +
        '/d_id:' +
        dId +
        ':' +
        (responseGetData[0]).toString() +
        (responseGetData[1]).toString() +
        (responseGetData[2]).toString() +
        (responseGetData[3]).toString() +
        (responseGetData[4]).toString() +
        (responseGetData[5]).toString() +
        (responseGetData[6]).toString() +
        (responseGetData[7]).toString() +
        (responseGetData[8]).toString() +
        (responseGetData[9]).toString() +
        (responseGetData[10]).toString() +
        (responseGetData[11]).toString()));
    if (localResponse == 200) {
      print("Successfully Updated");
      print(localResponse);
    } else {
      print("Res12  $localResponse");
      print("Device not Available at LocalHost");
    }
  }

  dataUpdate(String dId) async {
    final String url =
        'http://genorion1.herokuapp.com/getpostdevicePinStatus/?d_id=' + dId;
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
      getData(dId);
      //jsonDecode only for get method
      //return place_type.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update data');
    }
  }

  dataUpdateforPin19(String dId) async {
    final String url =
        'http://genorion1.herokuapp.com/getpostdevicePinStatus/?d_id=' + dId;
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
      'pin13Status': m,
      'pin14Status': n,
      'pin15Status': o,
      'pin16Status': p,
      'pin17Status': pin17Controller.text,
      'pin18Status': r,
      'pin19Status': pin19Controller.text,
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
      getData(dId);
      //jsonDecode only for get method
      //return place_type.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to Update data');
    }
  }

  _logout() async {
    final deleteToken = await storage.delete(key: "token");
    return deleteToken;
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      print('cacheDir.existsSync() ${cacheDir.existsSync()}');
      cacheDir.deleteSync(recursive: true);
    }
  }

  /// this will delete app's storage
  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      print('cacheDir.existsSync() ${appDir.existsSync()}');
      appDir.deleteSync(recursive: true);
    }
  }

  Future getSensorData(String dId) async {
    String token = await getToken();
    final response = await http.get(
        'http://genorion1.herokuapp.com/tensensorsdata/?d_id=' + dId,
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
      var arr = jsonDecode(response.body);
      List listOfPinSensor = [
        arr,
      ];
      print('sensorData  ${listOfPinSensor}');
      for (int i = 0; i < listOfPinSensor.length; i++) {
        var sensorQuery = SensorData(
          dId: listOfPinSensor[i]['d_id'],
          sensor1: listOfPinSensor[i]['sensor1'],
          sensor2: listOfPinSensor[i]['sensor2'],
          sensor3: listOfPinSensor[i]['sensor3'],
          sensor4: listOfPinSensor[i]['sensor4'],
          sensor5: listOfPinSensor[i]['sensor5'],
          sensor6: listOfPinSensor[i]['sensor6'],
          sensor7: listOfPinSensor[i]['sensor7'],
          sensor8: listOfPinSensor[i]['sensor8'],
          sensor9: listOfPinSensor[i]['sensor9'],
          sensor10: listOfPinSensor[i]['sensor10'],
        );
        print('deviceSensorJson    ${sensorQuery.toJson()}');
        await NewDbProvider.instance.updateSensorData(sensorQuery);
      }
      return SensorData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future devicePinSensorQueryFunc() async {
    sensorQueryRows = await NewDbProvider.instance.querySensor();
    print('deviceSensorQueryFunc  $sensorQueryRows');

    return sensorQueryRows;
  }

  var sensorData;

  Future devicePinSensorLocalUsingDeviceId(String dId) async {
    print('ssse $dId');
    sensorData =
    await NewDbProvider.instance.getSensorByDeviceId(dId.toString());
    if (sensorData == null) {
      return Text('No Data');
    }
    return sensorData;
  }

  var nameData;

  Future devicePinNameLocalUsingDeviceId(String dId) async {
    print('ssse $dId');
    await devicePinSensorLocalUsingDeviceId(dId);

    nameData =
    await NewDbProvider.instance.getPinNamesByDeviceId(dId.toString());
    if (nameData == null) {
      return Text('No Data');
    }
    return nameData;
  }

  List listOfPinNames = [];

  // ignore: missing_return
  Future<RoomType> addRoom(String data) async {
    print('floorwidgetid ${widget.flat.fltId}');
    final url = 'http://genorion1.herokuapp.com/addroom/';
    String token = await getToken();
    var postData = {
      "user": getUidVariable2,
      "r_name": data,
      "flt_id": widget.flat.fltId,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
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
        getAllRoom();
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

  var flatResponseForRoom;

  Future<void> addFlat(String data) async {
    print('floorwidgetid ${widget.fl.fId}');
    final url = 'http://genorion1.herokuapp.com/addyourflat/';
    String token = await getToken();
    var postData = {
      "user": getUidVariable2,
      "flt_name": data,
      "f_id": widget.fl.fId,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
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

  Future<void> addFlat2(String data) async {
    print('floorwidgetid ${widget.fl.fId}');
    final url = 'http://genorion1.herokuapp.com/addyourflat/';
    String token = await getToken();
    var postData = {
      "user": getUidVariable2,
      "flt_name": data,
      "f_id": floorResponse,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
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

  var roomQuery;


  Future<void> fetchPlace() async {
    // await openPlaceBox();
    String token = await getToken();
    final url = 'https://genorion1.herokuapp.com/addyourplace/';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    try {
      if (response.statusCode > 0) {
        List placeData = jsonDecode(response.body);
        placeRows = await NewDbProvider.instance.queryPlace();
        if (placeData.length == placeRows.length) {
          for (int i = 0; i < placeData.length; i++) {
            var placeQuery = PlaceType(
                pId: placeData[i]['p_id'],
                pType: placeData[i]['p_type'],
                user: placeData[i]['user']
            );
            NewDbProvider.instance.updatePlace(placeQuery);
          }
        } else {
          await NewDbProvider.instance.deletePlaceModel();
          for (int i = 0; i < placeData.length; i++) {
            var placeQuery = PlaceType(
                pId: placeData[i]['p_id'],
                pType: placeData[i]['p_type'],
                user: placeData[i]['user']
            );
            NewDbProvider.instance.insertPlaceModelData(placeQuery);
          }
        }
        getAllFloor();


        // places = placeData.map((data) => PlaceType.fromJson(data)).toList();


      }
    } catch (e) {}
    return places;
// return PlaceType.fromJson(true);

  }


  Future<void> getAllFloor() async {
    String token = await getToken();
    placeRows = await NewDbProvider.instance.queryPlace();
    print('pId  $placeRows');
    var pId;
    var floorQuery;
    for (int i = 0; i < placeRows.length; i++) {
      // Box poop;
      pId = placeRows[i]['p_id'].toString();
      print('pId  $pId');

      final url = "https://genorion1.herokuapp.com/addyourfloor/?p_id=" + pId;
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if (response.statusCode > 0) {
        List floorData = jsonDecode(response.body);
        floorQueryRows = await NewDbProvider.instance.queryFloor();
        if (floorData.length == floorQueryRows.length) {
          print('updateFloor');
          for (int i = 0; i < floorData.length; i++) {
            floorQuery = FloorType(
              fId: floorData[i]['f_id'],
              pId: floorData[i]['p_id'],
              fName: floorData[i]['f_name'],
              user: floorData[i]['user'],
            );
            await NewDbProvider.instance.updateFloor(floorQuery);
          }
        } else {
          print('insertFloor');
          await NewDbProvider.instance.deleteFloorModel();
          for (int i = 0; i < floorData.length; i++) {
            floorQuery = FloorType(
              fId: floorData[i]['f_id'],
              pId: floorData[i]['p_id'],
              fName: floorData[i]['f_name'],
              user: floorData[i]['user'],
            );
            await NewDbProvider.instance.insertFloorModelData(floorQuery);
          }
        }
        print('floorData12 ${floorData}');
        for (int i = 0; i < floorData.length; i++) {
          var floorQuery = FloorType(
              fId: floorData[i]['f_id'],
              fName: floorData[i]['f_name'].toString(),
              pId: floorData[i]['p_id'],
              user: floorData[i]['user']
          );
          print('floorData12 ${floorQuery}');
          await NewDbProvider.instance.updateFloor(floorQuery);
        }
      }
      getAllFlat();
      // floors = floorData.map((data) => FloorType.fromJson(data)).toList();
      // floorData=floorData+floors;
// getAllFlat();

    }
  }

  Future<void> getAllFlat() async {
    var fId;
    floorQueryRows = await NewDbProvider.instance.queryFloor();
    String token = await getToken();
    for (int i = 0; i < floorQueryRows.length; i++) {
      fId = floorQueryRows[i]['f_id'].toString();
      print("AllFlatFloorId $fId");
      String url = 'https://genorion1.herokuapp.com/addyourflat/?f_id=' + fId;
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });
      if (response.statusCode > 0) {
        List flatData = jsonDecode(response.body);
        flatQueryRows2 = await NewDbProvider.instance.queryFlat();
        if (flatQueryRows2.length == flatData.length) {
          for (int i = 0; i < flatData.length; i++) {
            var flatQuery = Flat(
                fId: flatData[i]['f_id'],
                fltId: flatData[i]['flt_id'],
                fltName: flatData[i]['flt_name'],
                user: flatData[i]['user']
            );
            await NewDbProvider.instance.updateFlat(flatQuery);
            print('FlatFlatQuery  ${flatQuery.fltName}');
          }
        } else {
          await NewDbProvider.instance.deleteFlatModel();
          for (int i = 0; i < flatData.length; i++) {
            var flatQuery = Flat(
                fId: flatData[i]['f_id'],
                fltId: flatData[i]['flt_id'],
                fltName: flatData[i]['flt_name'],
                user: flatData[i]['user']
            );
            await NewDbProvider.instance.insertFlatModelData(flatQuery);
            print('FlatFlatQuery  ${flatQuery.fltName}');
          }
        }
        getAllRoom();
        print('flatData ${flatData}');
      }


      // floors = floorData.map((data) => FloorType.fromJson(data)).toList();


    }
  }


  Future<bool> getAllRoom() async {
    // String url="http://10.0.2.2:8000/api/data";
    // String token= await getToken();
    var flatId;
    flatQueryRows2 = await NewDbProvider.instance.queryFlat();
    String token = await getToken();
    for (int i = 0; i < flatQueryRows2.length; i++) {
      flatId = flatQueryRows2[i]['flt_id'].toString();

      String url =
          "https://genorion1.herokuapp.com/addroom/?flt_id=" + flatId;
      var response;

      response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      roomData = jsonDecode(response.body);
      print('checkRoomData $roomData');
      widget.rm = roomData.map((data) => RoomType.fromJson(data)).toList();
      List roomQueryRows = await NewDbProvider.instance.queryRoom();
      if (roomData.length == roomQueryRows.length) {
        for (int i = 0; i < roomData.length; i++) {
          roomQuery = RoomType(
              rId: roomData[i]['r_id'],
              rName: roomData[i]['r_name'].toString(),
              fltId: roomData[i]['flt_id'],
              user: roomData[i]['user']
          );
          await NewDbProvider.instance.updateRoom(roomQuery);
        }
      } else {
        await NewDbProvider.instance.deleteRoomModel();

        for (int i = 0; i < roomData.length; i++) {
          roomQuery = RoomType(
              rId: roomData[i]['r_id'],
              rName: roomData[i]['r_name'].toString(),
              fltId: roomData[i]['flt_id'],
              user: roomData[i]['user']
          );
          await NewDbProvider.instance.insertRoomModelData(roomQuery);
        }
      }
    }
    getDeviceOffline(tabbarState);
    // for (int i = 0; i < roomData.length; i++) {
    //    roomQuery = RoomType(
    //       rId: roomData[i]['r_id'],
    //       rName: roomData[i]['r_name'].toString(),
    //       fltId: roomData[i]['flt_id'],
    //       user: roomData[i]['user']);
    //   print('roomQuery147 ${roomQuery.rName} ${roomQuery.fltId}');
    //   await NewDbProvider.instance.insertRoomModelData(roomQuery);
    //   // await roomQueryFunc();
    //
    // }
    return Future.value(true);
  }

  // ignore: missing_return
  Future<RoomType> addRoom2(String data) async {
    final url = 'http://genorion1.herokuapp.com/addroom/';
    String token = await getToken();
    var postData = {
      "user": getUidVariable,
      "r_name": data,
      "flt_id": flatResponse,
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode > 0) {
      print(response.statusCode);
      print(response.body);
      tabbarState = jsonDecode(response.body);
      // setState(() {
      //   roomResponse2=roomResponse;
      //   // roomResponsePreference.setInt('r_id', roomResponse2);
      // });
      print(' RoomCrated --> $roomResponse');

      // return RoomType.fromJson(postData);
    } else {
      throw Exception('Failed to create Room.');
    }
  }

  // ignore: missing_return
  var flatResponse;

  Future<FloorType> addFloor(String data) async {
    String token = await getToken();
    final url = 'http://genorion1.herokuapp.com/addyourfloor/';
    var postData = {
      "user": getUidVariable,
      "p_id": widget.pt.pId,
      "f_name": data
    };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );
    if (response.statusCode > 0) {
      print(response.statusCode);
      floorResponse = jsonDecode(response.body);
      getAllFloor();
      print(' Floor--> $floorResponse');
    } else {
      throw Exception('Failed to create Floor.');
    }
    // return FloorType.fromJson(floorResponse);
  }

  void choiceAction(String choice) {
    if (choice == Constants.AddFloor) {
      _createAlertDialogForFloor(context);
      print('Floor ');
    } else if (choice == Constants.AddRoom) {
      _createAlertDialogForAddRoom(context);
      print('Add Room');
    } else {
      print('aa');
    }
  }

  Future returnPlaceQuery() async {
    placeVal = await placeQueryFunc();
    return NewDbProvider.instance.queryPlace();
  }

  Future placeQueryFunc() async {
    placeRows = await NewDbProvider.instance.queryPlace();
    print('qwe123 $placeRows');
  }

  Future returnFloorQuery(String pId) {
    return NewDbProvider.instance.queryFloor();
  }

  Future<List<RoomType>> getrooms(String fId) async {
    var query = {'f_id': fId};
    final url = Uri.https('genorion1.herokuapp.com', '/getallrooms/', query);
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode > 0) {
      print('-----------room function query -- ------ $query');
      roomData = jsonDecode(response.body);
      print('Room Response------->>>>      $roomData');
      rooms = roomData.map((data) => RoomType.fromJson(data)).toList();
      print('rooomssssss  ${rooms.toList()}');
    }
    return rooms;
  }

  Future floorval;
  Future floorval2;

  @override
  Widget build(BuildContext context) {
    // TabController tabC;
    // tabC=new TabController(length: widget.rm.length, vsync: this);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        color: change_toDark ? Colors.black : Colors.white,
        // key: key,
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          if (viewportConstraints.maxWidth > 600) {
            return Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: MenuWidget(
                      selectedIndex: _index,
                      onTapped: (selectedIndex) {
                        setState(() {
                          _index = selectedIndex;
                          widget.onTapped(_index);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IndexedStack(
                      index: _index,
                      children: allDestinations.map<Widget>((
                          Destination destination) {
                        // print('large');
                        return DestinationView(destination);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: _switchValue ? Colors.white12 : Colors.white,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: GestureDetector(
                  onLongPress: () {
                    _editPlaceNameAlertDialog(context);
                  },
                  child: Row(
                    children: [
                      Text('Place- ', style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      Text(widget.pt.pType),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  onTap: () async {
                    // placeVal=await NewDbProvider.instance.queryPlace();
                    _createAlertDialogDropDown(context);
                  },
                ),
                backgroundColor: Colors.blueAccent,
                actions: [
                  CircularProfileAvatar(
                    '',
                    child: setImage == null
                        ? Image.asset('assets/images/blank.png')
                        : setImage,
                    radius: 27.5,
                    elevation: 5,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(
                                    // fl: widget.fl,
                                    // fl: widget.fl,
                                  ))).then((value) =>
                      loadImageFromPreferences()
                          ? _deleteImage()
                          : loadImageFromPreferences());
                    },
                    cacheImage: true,
                  ),
                  PopupMenuButton<String>(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
              drawer: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: change_toDark ? Colors.black : Colors
                      .white, //This will change the drawer background to blue.
                  //other styles
                ),
                child: Drawer(
                  child: Container(
                    width: double.maxFinite,
                    color: change_toDark ? Colors.black : Colors.white,
                    height: 100,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          //padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff669df4),
                                    Color(0xff4e80f3)
                                  ]),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              )),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                ),
                                CircularProfileAvatar(
                                  '',
                                  child: setImage == null
                                      ? Image.asset('assets/images/blank.png')
                                      : setImage,
                                  radius: 60,
                                  elevation: 5,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage(
                                                  // fl: widget.fl,
                                                )));
                                  },
                                  cacheImage: true,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('Hello  ', style: TextStyle(

                                  // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.home_work_rounded),
                          title: Text(
                            'Add Place',
                            style: TextStyle(
                              color: change_toDark ? Colors.white : Colors
                                  .black,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DropDown1()),
                                ModalRoute.withName("/Home"));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => DropDown1()),
                            // );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.supervised_user_circle),
                          title: Text(
                            'Sub Access',
                            style: TextStyle(
                              color: change_toDark ? Colors.white : Colors
                                  .black,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubAccessList()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.supervised_user_circle),
                          title: Text(
                            'Temp Access',
                            style: TextStyle(
                              color: change_toDark ? Colors.white : Colors
                                  .black,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TempAccessPage()),
                            );
                          },
                        ),
                        ListTile(
                            leading: Icon(Icons.perm_identity),
                            title: Text(
                              'Add Members',
                              style: TextStyle(
                                color: change_toDark ? Colors.white : Colors
                                    .black,
                              ),
                            ),
                            onTap: () {
                              _createAlertDialogForAddMembers(context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ReadContacts(),
                              //   ),
                              // );
                            }),
                        ListTile(
                            leading: Icon(Icons.power_rounded),
                            title: Text('Bill Prediction',
                                style: TextStyle(
                                  color: change_toDark ? Colors.white : Colors
                                      .black,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BillPrediction2(),
                                ),
                              );
                            }),
                        ListTile(
                            leading: Icon(Icons.schedule),
                            title: Text('Scheduled device /pins ',
                                style: TextStyle(
                                  color: change_toDark ? Colors.white : Colors
                                      .black,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScheduledPin(),
                                ),
                              );
                            }),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text(
                            'Settings',
                            style: TextStyle(
                              color: change_toDark ? Colors.white : Colors
                                  .black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SETTINGS()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text(
                            'Help',
                            style: TextStyle(
                              color: change_toDark ? Colors.white : Colors
                                  .black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WhatsNew()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text(
                            'About GenOrion',
                            style: TextStyle(
                              color: change_toDark ? Colors.white : Colors
                                  .black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Information()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              color: change_toDark ? Colors.white : Colors
                                  .black,
                            ),
                          ),
                          onTap: () {
                            _showDialogForLogOut();

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())).then((_logout()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Container(
                width: double.maxFinite,
                color: change_toDark ? Colors.black : Colors.white,
                child: DefaultTabController(
                  length: widget.rm.length,
                  child: CustomScrollView(
                    // key: key,

                    // controller: _scrollController,
                      slivers: <Widget>[
                        //Upper Widget
                        SliverToBoxAdapter(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.38,
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
                                                    _editFloorNameAlertDialog(
                                                        context);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text('Floor -',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontStyle: FontStyle
                                                                .italic),),
                                                      Text(
                                                        widget.fl.fName,

                                                        // 'Hello ',
                                                        // + widget.fl.user.first_name,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            // fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                      Icon(Icons
                                                          .arrow_drop_down),
                                                      SizedBox(width: 10,),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    _createAlertDialogDropDown(
                                                        context);
                                                  },
                                                ),
                                                SizedBox(width: 10,),
                                                GestureDetector(
                                                  child: Icon(Icons.add),
                                                  onTap: () async {
                                                    await allFloor();
                                                    _createAlertDialogForDeleteFloorAndAddFloor(
                                                        context);
                                                    // _createAlertDialogForFloor(context);
                                                  },
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onLongPress: () {
                                                        _editFloorNameAlertDialog(
                                                            context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text('Flat- ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 22),),
                                                          Text(
                                                            widget.flat.fltName,
                                                            // 'Hello ',
                                                            // + widget.fl.user.first_name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                // fontWeight: FontWeight.bold,
                                                                fontStyle: FontStyle
                                                                    .italic,
                                                                fontSize: 22),
                                                          ),
                                                          Icon(Icons
                                                              .arrow_drop_down),
                                                          SizedBox(width: 10,),
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        _createAlertDialogDropDown(
                                                            context);
                                                      },
                                                    ),
                                                    SizedBox(width: 35),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          await allFlat();
                                                          _createAlertDialogForDeleteFlatAndAddFlat(
                                                              context);
                                                        },
                                                        child: Icon(Icons.add)),
                                                  ],
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        FutureBuilder(
                                          future: deviceSensorVal,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text('Sensors- ',
                                                        style: TextStyle(

                                                          // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Colors.white
                                                        ),),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Column(children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons.fire,
                                                          color: Colors.yellow,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  sensorData[index][
                                                                  'sensor1']
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
                                                        width: 35,
                                                      ),
                                                      Column(children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .temperatureLow,
                                                          color: Colors.orange,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  sensorData[index][
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
                                                                  sensorData[index][
                                                                  'sensor3']
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
                                                        width: 42,
                                                      ),
                                                      Column(children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .cloud,
                                                          color: Colors.orange,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  sensorData[index][
                                                                  'sensor4']
                                                                      .toString(),
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
                                        ),
                                      ],
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
                                      Column(
                                        children: <Widget>[
                                          Column(
                                            children: [
                                              Container(
                                                  color: Colors.yellow,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        _createAlertDialogForAddRoom(
                                                            context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text('Rooms-',
                                                            style: TextStyle(

                                                              // backgroundColor: _switchValue?Colors.white:Colors.blueAccent,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .white
                                                            ),),
                                                          Icon(Icons.add),
                                                        ],
                                                      ))),
                                            ],
                                          ),
                                        ],
                                      ),

                                      GestureDetector(
                                        onLongPress: () {
                                          print('longPress');
                                          print('longpress ${tabbarState}');
                                          _createAlertDialogForAddRoomDeleteDevices(
                                              context, tabbarState);
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
                                            print('Roomsssss RID-->>>>>>>   ${widget.rm[index].rId}');
                                            tabbarState = widget.rm[index].rId;
                                            setState(() {
                                              tabbarState =
                                                  widget.rm[index].rId;
                                              // devicePinNamesQueryFunc();
                                            });
                                            getDevices(tabbarState);
                                            print(
                                                "tabbarState Tabs->  $tabbarState");
                                            widget.dv =
                                            await NewDbProvider.instance
                                                .getDeviceByRoomId(tabbarState);
                                            getAllRoom();
                                            // widget.rm =await roomQueryFunc();
                                            print('getDevices123 }');
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
                          delegate: SliverChildBuilderDelegate((context,
                              index) {
                            if (index < widget.dv.length) {
                              Text(
                                "Loading",
                                style: TextStyle(fontSize: 44),
                              );

                              return Container(
                                child: Column(
                                  children: [
                                    deviceContainer2(
                                        widget.dv[index].dId, index),
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
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                              TextSpan(text: "   "),
                                              WidgetSpan(
                                                  child: Icon(
                                                    Icons.settings,
                                                    size: 18,
                                                  ))
                                            ]),
                                          ),
                                          onTap: () {
                                            _createAlertDialogForSSIDAndEmergencyNumber(context,widget.dv[index].dId);
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
            );
          }
        }),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: BottomNavyBar(
          backgroundColor: Colors.white38,
          animationDuration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCirc,
          selectedIndex: _currentIndex,
          //type: BottomNavigationBarType.fixed,
          items: [
            BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.microphone),
                activeColor: Colors.blue,
                title: Text('')),
            BottomNavyBarItem(
              title: Text(''),
              icon: Icon(Icons.add),
              activeColor: Colors.blue,
            ),
            BottomNavyBarItem(
              title: Text(''),
              icon: Icon(Icons.settings),
              activeColor: Colors.blue,
            ),
          ],

          onItemSelected: (newIndex) {
            // _createAlertDialog(context);
            setState(() {
              _currentIndex = newIndex;
            });
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                isSelected[index] = !isSelected[index];
                if (index == 0) {
                  print('index 0 $index');
                  return _openGoggleAssistant();
                }
                if (index == 1) {
                  print('print -->  $tabbarState');
                  return _createAlertDialog(context);
                }
              }
              if (index == 2) {
                print(index);
                return Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              }
            }
          },
        ),
      ),
    );
  }

  _openGoggleAssistant() async {
    try {
      bool isInstalled = await DeviceApps.isAppInstalled(
          'com.google.android.apps.googleassistant');
      if (isInstalled) {
        // _playSound('g');
        DeviceApps.openApp('com.google.android.apps.googleassistant');
      } else {
        String url =
            'https://play.google.com/store/apps/details?id=com.google.android.apps.googleassistant&hl=en';
        if (await canLaunch(url)) {
          await launch(url);
          print('launch(url) ${launch(url)}');
        } else
          throw 'Could not launch $url';
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  List responseGetData;

  // List responseGetData2;
  var catchReturn;
  Future deviceSensorVal;

  deviceContainer(String dId, int index) async {
    getData(dId);
    // getPinStatusData();
    getPinsName(dId);
    // devicePinSensorLocalUsingDeviceId(dId);
    await devicePinNameLocalUsingDeviceId(dId);
    setState(() {
      deviceSensorVal = devicePinSensorLocalUsingDeviceId(dId);
    });
    catchReturn = await NewDbProvider.instance.getPinStatusByDeviceId(dId);
    print('catchReturn123 ${catchReturn}');
    var namesDataList12 =
    await NewDbProvider.instance.getPinNamesByDeviceId(dId);
    // var sensorData=

    print('namesList123 ${namesDataList}');
    // catchReturn =  getData(dId);
    setState(() {
      responseGetData = [
        widget.switch1_get = catchReturn[index]["pin1Status"],
        widget.switch2_get = catchReturn[index]["pin2Status"],
        widget.switch3_get = catchReturn[index]["pin3Status"],
        widget.switch4_get = catchReturn[index]["pin4Status"],
        widget.switch5_get = catchReturn[index]["pin5Status"],
        widget.switch6_get = catchReturn[index]["pin6Status"],
        widget.switch7_get = catchReturn[index]["pin7Status"],
        widget.switch8_get = catchReturn[index]["pin8Status"],
        widget.switch9_get = catchReturn[index]["pin9Status"],
        widget.Slider_get = catchReturn[index]["pin10Status"],
        widget.Slider_get2 = catchReturn[index]["pin11Status"],
        widget.Slider_get3 = catchReturn[index]["pin12Status"],
      ];
      namesDataList = [
        widget.switch1Name = namesDataList12[index]['pin1Name'].toString(),
        widget.switch2Name = namesDataList12[index]['pin2Name'].toString(),
        widget.switch3Name = namesDataList12[index]['pin3Name'].toString(),
        widget.switch4Name = namesDataList12[index]['pin4Name'].toString(),
        widget.switch5Name = namesDataList12[index]['pin5Name'].toString(),
        widget.switch6Name = namesDataList12[index]['pin6Name'].toString(),
        widget.switch7Name = namesDataList12[index]['pin7Name'].toString(),
        widget.switch8Name = namesDataList12[index]['pin8Name'].toString(),
        widget.switch9Name = namesDataList12[index]['pin9Name'].toString(),
        widget.switch10Name = namesDataList12[index]['pin10Name'].toString(),
        widget.switch11Name = namesDataList12[index]['pin11Name'].toString(),
        widget.switch12Name = namesDataList12[index]['pin12Name'].toString(),
      ];
    });
  }

  _showDialog(String dId) {
    // dialog implementation
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Alert"),
            content: Text("Would to like to turn off all the appliances ?"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    for (int i = 0; i < responseGetData.length; i++) {
                      setState(() {
                        // responseGetData[newIndex - 1]=0 ;
                        if (responseGetData[i] > 0) {
                          responseGetData[i] = 0;
                          print('AllChange ${responseGetData.toString()}');
                        }
                      });
                    }
                    var result = await Connectivity().checkConnectivity();
                    if (result == ConnectivityResult.wifi) {
                      print("True2-->   $result");
                      // await localUpdate(dId);
                      await dataUpdate(dId);
                    } else if (result == ConnectivityResult.mobile) {
                      await dataUpdate(dId);
                      await NewDbProvider.instance.getPinStatusByDeviceId(dId);
                    } else {
                      messageSms(context, dId);
                    }

                    Navigator.of(context).pop();
                  }),
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
                    await deleteRoomWithAllDevice(rId);
                    Navigator.pop(context);
                  }
              ),
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    // Navigator.of(context).pop();
                  }),
            ],
          ),
    );
  }

  _showDialogForLogOut() {
    // dialog implementation

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("LogOut"),
            content: Text("Would to like to Log Out from this App ?"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    await _logout();
                    await _deleteCacheDir();
                    await _deleteAppDir();
                    CircularProgressIndicator();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GettingStartedScreen()));
                    // await  _logout()
                    //     .then((value) => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => GettingStartedScreen())));
                    //
                  }),
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

  Future schedulingDevicePin(String dId, index) async {
    final url = 'http://genorion1.herokuapp.com/schedulingpinsalltheway/';
    String token = await getToken();
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
    }
  }

  var cutDate;
  TimeOfDay pickedTime;
  var cutTime;

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
  double _value = 0.0;
  int checkSwitch;
  int sliderValue;

  deviceContainer2(String dId, int x) {
    deviceContainer(dId, x);
    // schedulingDevicePin(dId,x);
    fetchIp(dId);
    return Column(
      children: [
        Container(
          color:Colors.red,
          height: MediaQuery
              .of(context)
              .size
              .height * 1.95,
          // color: Colors.redAccent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Turn Off All Appliances',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _switchValue ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(12),
                  //   child: GestureDetector(
                  //     child: Icon(Icons.mobile_screen_share_sharp),
                  //     onTap: () {
                  //       _createAlertDialogForPin17(context, dId);
                  //     },
                  //   ),
                  // ),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                        color: statusOfDevice == 1 ? Colors.green : Colors.grey,
                        shape: BoxShape.circle),
                    // child: ...
                  ),
                  Switch(
                    value: responseGetData == 0 ? val2 : val1,
                    //boolean value
                    onChanged: (val) async {
                      _showDialog(dId);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      child: Icon(Icons.settings_remote),
                      onTap: () {
                        _createAlertDialogForPin19(context, dId);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.yellow,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 1.32,
                // color: Colors.amber,
                child: GridView.count(
                    crossAxisSpacing: 8,
                    childAspectRatio: 2 / 1.8,
                    mainAxisSpacing: 4,
                    physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    crossAxisCount: 2,
                    children:
                    List.generate(responseGetData.length - 3, (index) {
                      print('Something');
                      print('catch return --> $catchReturn');

                      return Container(
                        // color: Colors.green,
                        height: 2030,
                        child: Column(
                          children: [
                            GestureDetector(
                              // onTap:Text(),
                              onLongPress: () async {
                                _alarmTimeString =
                                    DateFormat('HH:mm').format(DateTime.now());
                                cutDate = DateFormat('dd-MM-yyyy').format(
                                    DateTime.now());
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
                                                padding: const EdgeInsets.all(
                                                    32),
                                                child: Column(children: [
                                                  // ignore: deprecated_member_use
                                                  Container(
                                                    width: 145,
                                                    child: GestureDetector(
                                                        child: Text(cutDate
                                                            .toString() == null
                                                            ? _dateString
                                                            : cutDate.toString()
                                                            .toString()),
                                                        onTap: () {
                                                          pickDate();
                                                        }

                                                    ),
                                                  ),

                                                  FlatButton(
                                                    onPressed: () async {
                                                      pickTime(index);
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
                                                      style:
                                                      TextStyle(fontSize: 32),
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
                                                      labels: ['Off', 'On'],
                                                      onToggle: (index) {
                                                        print(
                                                            'switched to: $index');
                                                        checkSwitch = index;
                                                        // changeIndex(index);
                                                        // setState(() {
                                                        //
                                                        // });
                                                      },
                                                    ),
                                                    // trailing: Icon(Icons.arrow_forward_ios),
                                                  ),

                                                  FloatingActionButton.extended(
                                                    onPressed: () async {
                                                      await schedulingDevicePin(
                                                          dId, index);
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
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    alignment: new FractionalOffset(1.0, 0.0),
                                    // alignment: Alignment.bottomRight,
                                    height: 120,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 10),
                                    margin: index % 2 == 0
                                        ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                                        : EdgeInsets.fromLTRB(
                                        7.5, 7.5, 15, 7.5),
                                    // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
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
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Column(
                                      // crossAxisAlignment:
                                      // CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  print(
                                                      'tabbarstateDelete ${tabbarState}');
                                                  print(
                                                      'tabbarstateDelete ${dId}');

                                                  deleteDevice(tabbarState, dId);
                                                },
                                                child: Icon(Icons.auto_delete)
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                child: Text(
                                                  // '$index',
                                                  '${namesDataList[index]
                                                      .toString()} ',
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style:
                                                  TextStyle(fontSize: 10),
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'indexpinNames->  $index');
//                                                   setState(() {
//
//                                                     names[index] =pinNames;
//                                                     // pinNameController.text;
// // /                                                    }
//                                                   });

                                                  _createAlertDialogForNameDeviceBox(
                                                      context, index);

                                                  // return addDeviceName(index);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 4.5,
                                                // vertical: 10
                                              ),
                                              child: Switch(
                                                value:
                                                responseGetData[index] == 0
                                                    ? val2
                                                    : val1,
                                                //boolean value
                                                onChanged: (val) async {
                                                  print(
                                                      '12365 ${responseGetData[index]}');
                                                  setState(() {
                                                    if (responseGetData[index] == 0) {
                                                      responseGetData[index] =
                                                      1;
                                                    } else {
                                                      responseGetData[index] = 0;
                                                    }
                                                    print('yooooooooo ${responseGetData[index]}');
                                                  });

                                                  // if Internet is not available then _checkInternetConnectivity = true
                                                  var result = await Connectivity()
                                                      .checkConnectivity();
                                                  if (result ==
                                                      ConnectivityResult.none) {
                                                    messageSms(context, dId);
                                                  }
                                                  if (result == ConnectivityResult.wifi && statusOfDevice == 1) {
                                                    print("True2-->   $result");
                                                    localUpdate(dId);
                                                    dataUpdate(dId);
                                                  } else if (result == ConnectivityResult.mobile && result ==ConnectivityResult.none && statusOfDevice == 1) {
                                                    dataUpdate(dId);
                                                  } else if(result==ConnectivityResult.wifi && result ==ConnectivityResult.none && statusOfDevice == 1){
                                                    _createAlertDialogForlocalUpdateAndMessage(context,dId);

                                                  }
                                                },
                                              ),
                                            ),
                                            // Padding(
                                            //     padding: EdgeInsets.symmetric(
                                            //       horizontal: 5.5,
                                            //       // vertical: 10
                                            //     ),
                                            //     child: ElevatedButton(
                                            //       onPressed: () {
                                            //         print("Message}");
                                            //         messageSms(context, dId);
                                            //       },
                                            //       child: Text('Click'),
                                            //     )),
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
              Flexible(
                child: Container(

                  height: MediaQuery
                      .of(context)
                      .size
                      .height *1.92,
                  // color: Colors.black,
                  color: Colors.amber,
                  child: GridView.count(
                      crossAxisSpacing: 8,
                      childAspectRatio: 2 / 1.8,
                      mainAxisSpacing: 4,
                      physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      crossAxisCount: 2,
                      children:
                      List.generate(responseGetData.length - 9, (index) {
                        print('Slider Start');
                        print('catch return --> $catchReturn');
                        var newIndex = index + 10;
                        return Container(
                          // color: Colors.green,
                          height: 2030,
                          child: Column(
                            children: [
                              GestureDetector(
                                // onTap:Text(),
                                onLongPress: () async {
                                  _alarmTimeString = DateFormat('HH:mm')
                                      .format(DateTime.now());
                                  _dateString = DateFormat('dd-MM-yyyy').format(
                                      DateTime.now());
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
                                                padding: const EdgeInsets.all(
                                                    32),
                                                child: Column(children: [
                                                  Container(
                                                    width: 145,
                                                    child: GestureDetector(
                                                        child: Text(cutDate
                                                            .toString() == null
                                                            ? _dateString
                                                            : cutDate
                                                            .toString()),
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
                                              print(
                                              "index --> $index");
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
                                                  style:
                                                  TextStyle(fontSize: 32),
                                                ),
                                              ),
                                              ListTile(
                                              title: Text(
                                              'What Do You Want ??'),
                                              trailing: Icon(
                                              Icons.timer),
                                              ),
                                              ListTile(
                                              title:  Slider(
                                                min: 0.0,
                                                max: 10.0,
                                                value: double.parse(
                                                    responseGetData[
                                                    newIndex - 1]
                                                        .toString()),
                                                divisions: 500,
                                                activeColor: Colors.blue,
                                                inactiveColor: Colors.black,
                                                onChanged: (double value) {
                                                  // print('valuecheck ${value}');
                                                  // setState(() {
                                                  _value = value;
                                                  // });
                                                  var roundVar = value.round();
                                                  sliderValue=roundVar.round();
                                                  // sliderValue=int.parse(_value.toString());
                                                  print('valuecheck $sliderValue');
                                                },
                                              ),
                                              // trailing: Icon(Icons.arrow_forward_ios),
                                              ),
                                              FloatingActionButton
                                                  .extended(
                                              onPressed: ()async {
                                              // pickTime(index);
                                                await schedulingDevicePin(
                                                    dId, newIndex-1);
                                              Navigator.pop(context);

                                              print('Sceduled');
                                              },
                                              icon: Icon(Icons.alarm),
                                              label: Text('Save'),
                                              ),
                                              ]
                                              )
                                              );
                                            });
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      alignment: new FractionalOffset(1.0, 0.0),
                                      // alignment: Alignment.bottomRight,
                                      height: 120,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1, vertical: 10),
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
                                                offset: Offset(8, 10),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 109,
                                                child: Slider(
                                                  // value: 5.0,
                                                  value: double.parse(
                                                      responseGetData[
                                                      newIndex - 1]
                                                          .toString()),
                                                  min: 0,
                                                  max: 10,
                                                  divisions: 500,
                                                  activeColor: Colors.blue,
                                                  inactiveColor: Colors.black,
                                                  label: '${double.parse(
                                                      responseGetData[newIndex -
                                                          1].toString())}',
                                                  onChanged:
                                                      (double newValue) async {
                                                    print(
                                                        'index of data $index --> ${responseGetData[newIndex -
                                                            1]}');
                                                    print(
                                                        'index of $index --> ${newIndex -
                                                            1}');

                                                    setState(() {
                                                      // if (responseGetData[newIndex-1] != null) {
                                                      //   responseGetData[newIndex-1] = widget.Slider_get.round();
                                                      // }

                                                      print("Round-->  ${newValue.round()}");
                                                      var roundVar = newValue.round();
                                                      print("Round 2-->  $roundVar");
                                                      responseGetData[newIndex - 1] = roundVar;
                                                      print("Response Round-->  ${responseGetData[newIndex - 1]}");
                                                    });

                                                    // if Internet is not available then _checkInternetConnectivity = true
                                                    var result =
                                                    await Connectivity()
                                                        .checkConnectivity();
                                                    if (result ==
                                                        ConnectivityResult
                                                            .wifi) {
                                                      print(
                                                          "True2-->   $result");
                                                      await localUpdate(dId);
                                                      await dataUpdate(dId);
                                                    } else if (result ==
                                                        ConnectivityResult
                                                            .mobile) {
                                                      print(
                                                          "mobile-->   $result");
                                                      // await localUpdate(d_id);
                                                      await dataUpdate(dId);
                                                    } else {
                                                      messageSms(context, dId);
                                                    }
                                                  },
                                                  // semanticFormatterCallback: (double newValue) {
                                                  //   return '${newValue.round()}';
                                                  // }
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: TextButton(
                                              child: Text(
                                                '${namesDataList[index + 9]
                                                    .toString()} ',
                                                // '${namesDataList[index].toString()} ',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              onPressed: () {
                                                _createAlertDialogForNameDeviceBox(
                                                    context, index);

                                                // return addDeviceName(index);
                                              },
                                            ),
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
        ),
      ],
    );
  }

  _deleteImage() async {
    preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  void scheduleAlarm(DateTime scheduledNotificationDateTime,
      AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Office', alarmInfo.title,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }

  getData(String dId) async {
    print("Vice Id $dId");
    deviceIdForSensor = dId;
    print('getDataFunction $deviceIdForSensor');
    getSensorData(deviceIdForSensor);
    final String url =
        'http://genorion1.herokuapp.com/getpostdevicePinStatus/?d_id=' + dId;
    String token = await getToken();
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      print(data);
      data = jsonDecode(response.body);
      var arr = jsonDecode(response.body);
      List listOfPinStatus = [
        arr,
      ];
      print('sensorData  ${listOfPinStatus}');
      for (int i = 0; i < listOfPinStatus.length; i++) {
        var pinStatus = PinStatus(
          dId: listOfPinStatus[i]['d_id'],
          pin1Status: listOfPinStatus[i]['pin1Status'],
          pin2Status: listOfPinStatus[i]['pin2Status'],
          pin3Status: listOfPinStatus[i]['pin3Status'],
          pin4Status: listOfPinStatus[i]['pin4Status'],
          pin5Status: listOfPinStatus[i]['pin5Status'],
          pin6Status: listOfPinStatus[i]['pin6Status'],
          pin7Status: listOfPinStatus[i]['pin7Status'],
          pin8Status: listOfPinStatus[i]['pin8Status'],
          pin9Status: listOfPinStatus[i]['pin9Status'],
          pin10Status: listOfPinStatus[i]['pin10Status'],
          pin11Status: listOfPinStatus[i]['pin11Status'],
          pin12Status: listOfPinStatus[i]['pin12Status'],
          pin13Status: listOfPinStatus[i]['pin13Status'],
          pin14Status: listOfPinStatus[i]['pin14Status'],
          pin15Status: listOfPinStatus[i]['pin15Status'],
          pin16Status: listOfPinStatus[i]['pin16Status'],
          pin17Status: listOfPinStatus[i]['pin17Status'],
          pin18Status: listOfPinStatus[i]['pin18Status'],
          pin19Status: listOfPinStatus[i]['pin19Status'],
          pin20Status: listOfPinStatus[i]['pin20Status'],
        );
        await NewDbProvider.instance.updatePinStatusData(pinStatus);
        print('devicePinJson    ${pinStatus.toJson()}');
        String a = listOfPinStatus[i]['pin20Status'].toString();
        print('ForLoop123 ${a}');
        int aa = int.parse(a);
        print('double $aa');
        // int aa=int.parse(a);

        int ms =
        // ((DateTime.now().millisecondsSinceEpoch) / 1000).round() + 19700;
        ((DateTime
            .now()
            .millisecondsSinceEpoch) / 1000).round() -
            100; // -100 for checking a difference for 100 seconds in current time
        print('CheckMs ${ms}');
        print('Checkaa ${aa}');
        if (aa >= ms) {
          print('ifelse');
          statusOfDevice = 1;
        } else {
          print('ifelse2');
          statusOfDevice = 0;
        }
      }
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
      for (int i = 0; i < data.length; i++) {}

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



  _launchURL() async {
    const url = 'https://genorion1.herokuapp.com/change_password_phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
        print('device is going to on');
        // ignore: unnecessary_statements
        // listDynamic[index];
        // print("index -> ${listDynamic[index]}");
        // dataUpdate(index);
        return;
      } else if (index == 1) {
        print('device is going to off');
        // ignore: unnecessary_statements
        // listDynamic[index];
        // dataUpdate(index);
        return;
      }
      // dataUpdate(index);
    }
  }


  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<Future<List<AlarmInfo>>>('_alarms', _alarms));
  }
}
