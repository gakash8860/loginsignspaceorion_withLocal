import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loginsignspaceorion/SQLITE_database/NewDatabase.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../changeFont.dart';
import '../main.dart';


void main()=>runApp(MaterialApp(
  home: ScheduledPin(),
));
class ScheduledPin extends StatefulWidget {
  const ScheduledPin({Key key}) : super(key: key);

  @override
  _ScheduledPinState createState() => _ScheduledPinState();
}

class _ScheduledPinState extends State<ScheduledPin> {
Future scheduled;
Future scheduledWeb;
  Box scheduledPinBox;
  Box scheduledPinNameBox;
  Timer timer;
  DateTime pickedDate;
  var cutDate;
  int checkSwitch;

  var tokenWeb;


  @override
  void initState(){
    super.initState();
    openScedulePinBox();
    pickedDate = DateTime.now();
    timer=Timer.periodic(Duration(seconds: 10), (timer) {
      print('qwertyuiop');
      // getPinsName();
      scheduled=getScheduledPins();
      scheduledWeb=getScheduledPinsWeb();
      // getScheduledPins();
      // tempAutoDelete();
      });
    scheduled=getScheduledPins();
    // getPinsName();
  }

Future openScedulePinBox()async{

  var dir= await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  scheduledPinBox=await Hive.openBox('scheduledPinStatus');
  print('tempUserBox  ${scheduledPinBox.values.toString()}');
  return;
}

var pinDecode;
List listOfScheduledPins=[];
List listOfScheduledPinsWeb=[];
Future getTokenWeb()async{
  final pref= await SharedPreferences.getInstance();
  tokenWeb=pref.getString('tokenWeb');
  return tokenWeb;
}
  Future getScheduledPins()async{
   await openScedulePinBox();
   String token = await getToken();
   // String token = "be43f6166fce6faef0525c610402b332debdb232";
    final url=API+'schedulingpinsalltheway/?user='+getUidVariable;
    try{
      final response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      });
      await scheduledPinBox.clear();
      if(response.statusCode>0){
        print('ScheduledPins  ${response.statusCode}');
        print('ScheduledPins  ${response.body}');
        if(response.statusCode==200){
          pinDecode = jsonDecode(response.body);
          setState(() {
            listOfScheduledPins = pinDecode;

            putScheduledPins(listOfScheduledPins);
          });
          print('listOfScheduledPins ${listOfScheduledPins}');
          // allPinNames(listOfScheduledPins);
        }
      }
    }catch(e){
    }
    var myMap=scheduledPinBox.toMap().values.toList();
    if(myMap.isEmpty){
      scheduledPinBox.add('empty');
    }else{
      listOfScheduledPins=myMap ;
    }
  }

  Future getScheduledPinsWeb()async{
   String token = await getTokenWeb();
   // String token = "be43f6166fce6faef0525c610402b332debdb232";
    final url=API+'schedulingpinsalltheway/?user='+getUidVariable;
    try{
      final response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      });
      if(response.statusCode>0){
        print('ScheduledPins  ${response.statusCode}');
        print('ScheduledPins  ${response.body}');
        if(response.statusCode==200){
         var pinDecode = jsonDecode(response.body);
          setState(() {
            listOfScheduledPinsWeb = pinDecode;


          });
          print('listOfScheduledPins ${listOfScheduledPins}');
          // allPinNames(listOfScheduledPins);
        }
      }
    }catch(e){
    }
  }

Future putScheduledPins(data)async{
  await scheduledPinBox.clear();
  for(var d in data){

    scheduledPinBox.add(d);
  }

}
var dId;


var postData;
Future schedulingDevicePin(var postData) async {
  final url = 'http://genorion1.herokuapp.com/schedulingpinsalltheway/';
  String token = await getToken();

  print("PostData ${postData}");
  final response = await http.put(url, body: jsonEncode(postData), headers: {
    'Content-Type': 'application/json',
    // 'Accept': 'application/json',
    'Authorization': 'Token $token',
  });
  if (response.statusCode > 0) {
    print("SchedulingStatus ${response.statusCode}");
    print("SchedulingStatus ${response.body}");
    scheduled=getScheduledPins();
  }
}

Future deleteSchedulingUsingId(String id)async{
  String token = await getToken();
  String url= API+'schedulingpinsalltheway/?user=${getUidVariable}&id=${id}';
  final response = await http.delete(url,headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Token $token',
  });
  if(response.statusCode>0){
    print('deleteScheduling ${response.body}');
    print('deleteScheduling ${response.statusCode}');
    if(response.statusCode==200){
      scheduled=getScheduledPins();
      final snackBar = SnackBar(
        content: Text('Pin Scheduled Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}

Future deleteSchedulingUsingIdWeb(String id)async{
  String token = await getTokenWeb();
  String url= API+'schedulingpinsalltheway/?user=${getUidVariable}&id=${id}';
  final response = await http.delete(url,headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Token $token',
  });
  if(response.statusCode>0){
    print('deleteScheduling ${response.body}');
    print('deleteScheduling ${response.statusCode}');
    if(response.statusCode==200){
      scheduled=getScheduledPins();
      final snackBar = SnackBar(
        content: Text('Pin Scheduled Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}
var pinStatus;
String _alarmTimeString;
String _dateString = "";
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


TimeOfDay time23;
TimeOfDay time;
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
   var namesDataList12 = json.decode(response.body);
    print('QWERTY  $namesDataList12');
    namesDataListWeb = [
      namesDataList12['pin1Name'].toString(),
      namesDataList12['pin2Name'].toString(),
      namesDataList12['pin3Name'].toString(),
      namesDataList12['pin4Name'].toString(),
      namesDataList12['pin5Name'].toString(),
      namesDataList12['pin6Name'].toString(),
     namesDataList12['pin7Name'].toString(),
    namesDataList12['pin8Name'].toString(),
    namesDataList12['pin9Name'].toString(),
    namesDataList12['pin10Name'].toString(),
    namesDataList12['pin11Name'].toString(),
    namesDataList12['pin12Name'].toString(),
    ];
    print('namesDataList  $namesDataList');
    return namesDataList12;
  }
}

String on="On";
String off="Off";
List namesDataList;
List namesDataListWeb;
allPinNames(String dId,int index)async{
   namesDataList =await  NewDbProvider.instance.getPinNamesByDeviceId(dId);
  // print('names123654 ${namesDataList}');
  // String pin1=namesDataList12[index]['pin1Name'].toString();
  // var indexOfPin1Name=pin1.indexOf(',');
  // var pin1FinalName=pin1.substring(0,indexOfPin1Name);
  // print('indexofppppnamesDataList12 $pin1');
  //
  //
  // String pin2=namesDataList12[index]['pin2Name'].toString();
  // var indexOfPin2Name=pin2.indexOf(',');
  // var pin2FinalName=pin2.substring(0,indexOfPin2Name);
  // print('indexofpppppin2 $pin2');
  //
  // String pin3=namesDataList12[index]['pin3Name'].toString();
  // var indexOfPin3Name=pin3.indexOf(',');
  // var pin3FinalName=pin3.substring(0,indexOfPin3Name);
  // print('indexofpppppin2 $pin3');
  //
  // String pin4=namesDataList12[index]['pin4Name'].toString();
  // var indexOfPin4Name=pin4.indexOf(',');
  // var pin4FinalName=pin4.substring(0,indexOfPin4Name);
  // print('indexofpppppin2 $pin3');
  //
  // String pin5=namesDataList12[index]['pin5Name'].toString();
  // var indexOfPin5Name=pin5.indexOf(',');
  // var pin5FinalName=pin5.substring(0,indexOfPin5Name);
  // print('indexofpppppin2 $pin3');
  //
  // String pin6=namesDataList12[index]['pin6Name'].toString();
  // var indexOfPin6Name=pin6.indexOf(',');
  // var pin6FinalName=pin6.substring(0,indexOfPin6Name);
  // print('indexofpppppin2 $pin3');
  //
  // String pin7=namesDataList12[index]['pin7Name'].toString();
  // var indexOfPin7Name=pin7.indexOf(',');
  // var pin7FinalName=pin7.substring(0,indexOfPin7Name);
  // print('indexofpppppin2 $pin3');
  //
  // String pin8=namesDataList12[index]['pin8Name'].toString();
  // var indexOfPin8Name=pin8.indexOf(',');
  // var pin8FinalName=pin8.substring(0,indexOfPin8Name);
  // print('indexofpppppin2 $pin3');
  //
  // String pin9=namesDataList12[index]['pin9Name'].toString();
  // var indexOfPin9Name=pin9.indexOf(',');
  // var pin9FinalName=pin9.substring(0,indexOfPin9Name);
  // print('indexofpppppin2 $pin3');
  //
  // String pin10=namesDataList12[index]['pin10Name'].toString();
  // var indexOfPin10Name=pin10.indexOf(',');
  // var pin10FinalName=pin9.substring(0,indexOfPin10Name);
  // print('indexofpppppin2 $pin3');
  //
  // String pin11=namesDataList12[index]['pin11Name'].toString();
  // var indexOfPin11Name=pin11.indexOf(',');
  // var pin11FinalName=pin11.substring(0,indexOfPin11Name);
  // print('indexofpppppin2 $pin3');
  //
  //
  // String pin12=namesDataList12[index]['pin12Name'].toString();
  // var indexOfPin12Name=pin12.indexOf(',');
  // var pin12FinalName=pin12.substring(0,indexOfPin12Name);
  // print('indexofpppppin2 $pin3');
  //
  // setState(() {
  //   namesDataList = [
  //      pin1FinalName,
  //      pin2FinalName,
  //     pin3FinalName,
  //      pin4FinalName,
  //      pin5FinalName,
  //      pin6FinalName,
  //      pin7FinalName,
  //      pin8FinalName,
  //      pin9FinalName,
  //     pin10FinalName,
  //     pin11FinalName,
  //      pin12FinalName,
  //   ];
  // });
  // print('names12365147854 ${namesDataList[index]}');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scheduled Pins",style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Container(
          color: Colors.green,
          // height: 789,
          // width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: scheduledWeb,
              builder: ( context,  snapshot){
                print('snapShot ${snapshot.connectionState}');
                if(snapshot.connectionState ==ConnectionState.done){
                  if(listOfScheduledPinsWeb==null || listOfScheduledPinsWeb.isEmpty){
                    return Column(
                      children: [
                        SizedBox(height: 250,),
                        Center(child: Text('Sorry we cannot find any Temp User please add',style: TextStyle(fontSize: 18,fontFamily: fonttest==null?'RobotoMono':fonttest,),)),
                      ],
                    );
                  }else{
                    return Column(
                      children: [
                        SizedBox(height: 25,),
                        Expanded(
                            child: ListView.builder(
                                itemCount: listOfScheduledPinsWeb.length,
                                itemBuilder: (context,index){
                                  print('length ${listOfScheduledPinsWeb.length}');
                                  getPinsName(listOfScheduledPinsWeb[index]['d_id']);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onLongPress: (){
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
                                                                    .toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
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
                                                              TextStyle(fontSize: 32,fontFamily: fonttest==null?'RobotoMono':fonttest,),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            title:
                                                            Text('What Do You Want ??',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
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
                                                              if(listOfScheduledPinsWeb[index]['pin1Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin1Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin2Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin2Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin3Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin3Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin4Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin4Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin5Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin5Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin6Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin6Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin7Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin7Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin8Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin8Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin8Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin8Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin9Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin9Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin10Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin10Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }else if(listOfScheduledPinsWeb[index]['pin11Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin11Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }
                                                              else if(listOfScheduledPinsWeb[index]['pin12Status']!=null){
                                                                postData={
                                                                  "user":getUidVariable2,
                                                                  "date1":cutDate.toString(),
                                                                  "timing1":cutTime.toString(),
                                                                  "d_id":listOfScheduledPinsWeb[index]['d_id'],
                                                                  "id":listOfScheduledPinsWeb[index]['id'],
                                                                  "pin12Status":checkSwitch,
                                                                };
                                                                await schedulingDevicePin(postData);
                                                                Navigator.pop(context);
                                                                return;
                                                              }
                                                              // await schedulingDevicePin(postData);
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
                                      child: Card(
                                        semanticContainer:true,
                                        shadowColor: Colors.grey,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(listOfScheduledPinsWeb[index]['d_id'].toString()==null?"Loading":listOfScheduledPinsWeb[index]['d_id'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                              trailing: Text(listOfScheduledPinsWeb[index]['date1'].toString()==null?"Loading":listOfScheduledPinsWeb[index]['date1'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                              leading: IconButton(
                                                icon: Icon(Icons.delete_forever,color: Colors.black,semanticLabel: 'Delete',),
                                                onPressed: ()async{
                                                  await deleteSchedulingUsingIdWeb(listOfScheduledPinsWeb[index]['id'].toString());

                                                },
                                              ),
                                              subtitle: Text(listOfScheduledPinsWeb[index]['timing1'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),

                                              onTap: (){
                                                print('printSubUser ${listOfScheduledPinsWeb[index]['id']}');

                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>TempUserDetails(tempUserPlaceName: tempUserDecodeList[index]['p_id'],
                                                //   tempUserFloorName: tempUserDecodeList[index]['f_id'] ,)));

                                              },
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  height: 54,
                                                  color:Colors.red,
                                                  child: ListView.builder(
                                                      itemCount: 1,
                                                      itemBuilder: (context,index){
                                                        if(listOfScheduledPinsWeb[index]['pin1Status']==1){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]==null?"Wait":namesDataListWeb[index]['pin1Name'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(on,style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin1Status']==0){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin1Name'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(off,style: TextStyle(fontSize: 22,fontFamily:  fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin2Status']==1){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin2Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(on,style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin2Status']==0){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin2Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(off,style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin3Status']==1){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin3Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(on,style: TextStyle(fontSize: 22,
                                                                fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin3Status']==0){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin3Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(off,style: TextStyle(fontSize: 22,
                                                                fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        } else if(listOfScheduledPinsWeb[index]['pin4Status']==0){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin4Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(off,style: TextStyle(fontSize: 22,
                                                                fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin4Status']==1){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin4Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(on,style: TextStyle(fontSize: 22,
                                                                fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin5Status']==1){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin5Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(on,style: TextStyle(fontSize: 22,
                                                                fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin5Status']==0){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin5Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(off,style: TextStyle(fontSize: 22,
                                                                fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin6Status']==0){
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin6Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(width: 14,),
                                                              Text(off,style: TextStyle(fontSize: 22,
                                                                fontFamily: fonttest==null?changeFont:fonttest,),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin6Status']==1) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin6Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(on,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin7Status']==1) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin7Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(on,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin7Status']==0) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin7Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(off,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin8Status']==0) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin8Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(off,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin8Status']==1) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin8Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(on,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin9Status']==1) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin9Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(on,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin9Status']==0) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin8Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(off,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin10Status']==0) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin10Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(off,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin10Status']==1) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                namesDataListWeb[index]['pin10Name']
                                                                    .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(on,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin11Status']==1) {
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin11Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(on,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin11Status']==0) {
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin11Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(off,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin12Status']==0) {
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin12Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(off,
                                                                style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else if(listOfScheduledPinsWeb[index]['pin12Status']==1) {
                                                          return Row(
                                                            children: [
                                                              Text(namesDataListWeb[index]['pin12Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              SizedBox(
                                                                width: 14,),
                                                              Text(on,
                                                                style: TextStyle(
                                                                    fontFamily: fonttest==null?changeFont:fonttest,
                                                                    fontSize: 22),),
                                                            ],
                                                          );
                                                        }else{return null;}
                                                      }),
                                                )
                                                // Row(
                                                //   children: [
                                                //
                                                //     Text(namesDataList[index]['pin1Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin1Status'].toString()==null? "Off ":"On",textAlign: TextAlign.end,),
                                                //   SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin2Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin2Status'].toString()==null?"check":"",textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin3Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin3Status'].toString(),textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin4Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin4Status'].toString(),textAlign: TextAlign.end,),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(namesDataList[index]['pin5Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin5Status'].toString(),textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin6Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin6Status'].toString(),textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin7Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin7Status'].toString(),textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin8Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin8Status'].toString(),textAlign: TextAlign.end,),
                                                //
                                                //   ],
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(namesDataList[index]['pin9Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin9Status'].toString(),textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin10Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin10Status'].toString(),textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin11Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin11Status'].toString(),textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //     Text(namesDataList[index]['pin12Name'].toString()),
                                                //     Text(' -> '),
                                                //     Text(listOfScheduledPins[index]['pin12Status'].toString(),textAlign: TextAlign.end,),
                                                //     SizedBox(width: 14,),
                                                //   ],
                                                // ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );


                                  //   Column(
                                  //   children: <Widget>[
                                  //     SizedBox(height: 100,),
                                  //     Text('Sub User List',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  //     SizedBox(height: 15,),
                                  //     Row(
                                  //       children: [
                                  //         SizedBox(width: 55,),
                                  //         Text('Number 1',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                  //         SizedBox(width: 15,),
                                  //         Container(
                                  //           height: 45,
                                  //           width: 195,
                                  //           child:Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Text(subUserDecode[0]['email'].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                  //           ),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //               color: Colors.black38 ,
                                  //               width: 5.0 ,
                                  //             ),
                                  //             borderRadius: BorderRadius.circular(20),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //
                                  //
                                  //   ],
                                  //
                                  //   // trailing: Text("Place Id->  ${statusData[index]['d_id']}"),
                                  //   // subtitle: Text("${statusData[index]['id']}"),
                                  //
                                  // );
                                }
                            )),


                      ],
                    );
                  }
                }else{
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      semanticsLabel: 'Loading...',
                    ),
                  );
                }

              }

          ),
        );
      }else{
        return Scaffold(

          body: Container(
            color: Colors.green,
            // height: 789,
            // width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            child: FutureBuilder(
                future: scheduled,
                builder: ( context,  snapshot){

                  print('snapShot ${snapshot.connectionState}');
                  if(snapshot.connectionState ==ConnectionState.done){
                    if(listOfScheduledPins==null){
                      return Column(
                        children: [
                          SizedBox(height: 250,),
                          Center(child: Text('Sorry we cannot find any Temp User please add',style: TextStyle(fontSize: 18,fontFamily: fonttest==null?'RobotoMono':fonttest,),)),
                        ],
                      );
                    }else{
                      return Column(
                        children: [
                          SizedBox(height: 25,),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: listOfScheduledPins.length,
                                  itemBuilder: (context,index){
                                    print('length ${listOfScheduledPins.length}');
                                    allPinNames(listOfScheduledPins[index]['d_id'],index);
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onLongPress: (){
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
                                                                      .toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
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
                                                                TextStyle(fontSize: 32,fontFamily: fonttest==null?'RobotoMono':fonttest,),
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title:
                                                              Text('What Do You Want ??',style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
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
                                                                if(listOfScheduledPins[index]['pin1Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin1Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin2Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin2Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin3Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin3Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin4Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin4Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin5Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin5Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin6Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin6Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin7Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin7Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin8Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin8Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin8Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin8Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin9Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin9Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin10Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin10Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }else if(listOfScheduledPins[index]['pin11Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin11Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }
                                                                else if(listOfScheduledPins[index]['pin12Status']!=null){
                                                                  postData={
                                                                    "user":getUidVariable2,
                                                                    "date1":cutDate.toString(),
                                                                    "timing1":cutTime.toString(),
                                                                    "d_id":listOfScheduledPins[index]['d_id'],
                                                                    "id":listOfScheduledPins[index]['id'],
                                                                    "pin12Status":checkSwitch,
                                                                  };
                                                                  await schedulingDevicePin(postData);
                                                                  Navigator.pop(context);
                                                                  return;
                                                                }
                                                                // await schedulingDevicePin(postData);
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
                                        child: Card(
                                          semanticContainer:true,
                                          shadowColor: Colors.grey,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(listOfScheduledPins[index]['d_id'].toString()==null?"Loading":listOfScheduledPins[index]['d_id'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                trailing: Text(listOfScheduledPins[index]['date1'].toString()==null?"Loading":listOfScheduledPins[index]['date1'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                leading: IconButton(
                                                  icon: Icon(Icons.delete_forever,color: Colors.black,semanticLabel: 'Delete',),
                                                  onPressed: ()async{
                                                    await deleteSchedulingUsingId(listOfScheduledPins[index]['id'].toString());

                                                  },
                                                ),
                                                subtitle: Text(listOfScheduledPins[index]['timing1'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),

                                                onTap: (){
                                                  print('printSubUser ${listOfScheduledPins[index]['id']}');

                                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>TempUserDetails(tempUserPlaceName: tempUserDecodeList[index]['p_id'],
                                                  //   tempUserFloorName: tempUserDecodeList[index]['f_id'] ,)));

                                                },
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 54,
                                                    color:Colors.red,
                                                    child: ListView.builder(
                                                        itemCount: 1,
                                                        itemBuilder: (context,index){
                                                          if(listOfScheduledPins[index]['pin1Status']==1){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]==null?"Wait":namesDataList[index]['pin1Name'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(on,style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin1Status']==0){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin1Name'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(off,style: TextStyle(fontSize: 22,fontFamily:  fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin2Status']==1){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin2Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(on,style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin2Status']==0){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin2Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(off,style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin3Status']==1){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin3Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(on,style: TextStyle(fontSize: 22,
                                                                  fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin3Status']==0){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin3Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(off,style: TextStyle(fontSize: 22,
                                                                  fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          } else if(listOfScheduledPins[index]['pin4Status']==0){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin4Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(off,style: TextStyle(fontSize: 22,
                                                                  fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin4Status']==1){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin4Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(on,style: TextStyle(fontSize: 22,
                                                                  fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin5Status']==1){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin5Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(on,style: TextStyle(fontSize: 22,
                                                                  fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin5Status']==0){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin5Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(off,style: TextStyle(fontSize: 22,
                                                                  fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin6Status']==0){
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin6Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(width: 14,),
                                                                Text(off,style: TextStyle(fontSize: 22,
                                                                  fontFamily: fonttest==null?changeFont:fonttest,),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin6Status']==1) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin6Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(on,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin7Status']==1) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin7Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(on,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin7Status']==0) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin7Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(off,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin8Status']==0) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin8Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(off,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin8Status']==1) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin8Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(on,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin9Status']==1) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin9Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(on,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin9Status']==0) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin8Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(off,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin10Status']==0) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin10Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(off,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin10Status']==1) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                    namesDataList[index]['pin10Name']
                                                                        .toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(on,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin11Status']==1) {
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin11Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(on,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin11Status']==0) {
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin11Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(off,
                                                                  style: TextStyle(
                                                                      fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin12Status']==0) {
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin12Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(off,
                                                                  style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else if(listOfScheduledPins[index]['pin12Status']==1) {
                                                            return Row(
                                                              children: [
                                                                Text(namesDataList[index]['pin12Name'].toString(),style: TextStyle(fontSize: 22,fontFamily: fonttest==null?changeFont:fonttest,),),
                                                                SizedBox(
                                                                  width: 14,),
                                                                Text(on,
                                                                  style: TextStyle(
                                                                  fontFamily: fonttest==null?changeFont:fonttest,
                                                                      fontSize: 22),),
                                                              ],
                                                            );
                                                          }else{return null;}
                                                        }),
                                                  )
                                                  // Row(
                                                  //   children: [
                                                  //
                                                  //     Text(namesDataList[index]['pin1Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin1Status'].toString()==null? "Off ":"On",textAlign: TextAlign.end,),
                                                  //   SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin2Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin2Status'].toString()==null?"check":"",textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin3Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin3Status'].toString(),textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin4Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin4Status'].toString(),textAlign: TextAlign.end,),
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     Text(namesDataList[index]['pin5Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin5Status'].toString(),textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin6Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin6Status'].toString(),textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin7Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin7Status'].toString(),textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin8Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin8Status'].toString(),textAlign: TextAlign.end,),
                                                  //
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     Text(namesDataList[index]['pin9Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin9Status'].toString(),textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin10Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin10Status'].toString(),textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin11Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin11Status'].toString(),textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //     Text(namesDataList[index]['pin12Name'].toString()),
                                                  //     Text(' -> '),
                                                  //     Text(listOfScheduledPins[index]['pin12Status'].toString(),textAlign: TextAlign.end,),
                                                  //     SizedBox(width: 14,),
                                                  //   ],
                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );


                                    //   Column(
                                    //   children: <Widget>[
                                    //     SizedBox(height: 100,),
                                    //     Text('Sub User List',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    //     SizedBox(height: 15,),
                                    //     Row(
                                    //       children: [
                                    //         SizedBox(width: 55,),
                                    //         Text('Number 1',textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                    //         SizedBox(width: 15,),
                                    //         Container(
                                    //           height: 45,
                                    //           width: 195,
                                    //           child:Padding(
                                    //             padding: const EdgeInsets.all(8.0),
                                    //             child: Text(subUserDecode[0]['email'].toString(),textDirection:TextDirection.ltr ,textAlign: TextAlign.center,),
                                    //           ),
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.white,
                                    //             border: Border.all(
                                    //               color: Colors.black38 ,
                                    //               width: 5.0 ,
                                    //             ),
                                    //             borderRadius: BorderRadius.circular(20),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //
                                    //
                                    //   ],
                                    //
                                    //   // trailing: Text("Place Id->  ${statusData[index]['d_id']}"),
                                    //   // subtitle: Text("${statusData[index]['id']}"),
                                    //
                                    // );
                                  }
                              )),


                        ],
                      );
                    }
                  }else{
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                        semanticsLabel: 'Loading...',
                      ),
                    );
                  }

                }

            ),
          ),
        );
      }
        }
      ),
    );
  }
}
