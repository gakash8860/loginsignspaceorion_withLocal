import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../main.dart';

var API = 'http://genorion1.herokuapp.com/';
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
Box scheduledPinBox;
Timer timer;
DateTime pickedDate;
  var cutDate;

  int checkSwitch;

  @override
  void initState(){
    super.initState();
    openScedulePinBox();
    pickedDate = DateTime.now();
    timer=Timer.periodic(Duration(seconds: 10), (timer) {
      print('qwertyuiop');
      scheduled=getScheduledPins();
      // getScheduledPins();
      // tempAutoDelete();
      });
    scheduled=getScheduledPins();
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

Future putScheduledPins(data)async{
  await scheduledPinBox.clear();
  for(var d in data){

    scheduledPinBox.add(d);
  }

}
var postData;
Future schedulingDevicePin(var postData) async {
  final url = 'http://genorion1.herokuapp.com/schedulingpinsalltheway/';
  String token = await getToken();
  //  postData={
  //   "user":getUidVariable2,
  //   "date1":cutDate.toString(),
  //   "timing1":cutTime.toString(),
  //   "d_id":dId,
  //   "id":id,
  //   "pin1Status":checkSwitch,
  //
  //
  // };
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
// Future deleteScheduling(String dId,String date,String time,String pinStatus)async{
//   String token = await getToken();
//   print('pinstst $pinStatus');
//   // String token = "be43f6166fce6faef0525c610402b332debdb232";
//   String url1=API;
//
//   // if(url1+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin10Status=${pinStatus}'!=null){
//   //   url1+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin1Status=${pinStatus}';
//   // }
//   // String url=API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&${pinStatus}=${pinStatus}';
//   String url;
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin1Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin2Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin3Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin4Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin5Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin6Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin7Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin8Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin9Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin10Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin11Status=${pinStatus}';
//  url= API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin12Status=${pinStatus}';
//
//
//
//
//
//  if( listOfScheduledPins[1]['pin1Status'].toString() != null){
//     print('check1 ${listOfScheduledPins[1]['pin1Status'].toString()}' );
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin1Status=${pinStatus}';
//   }else if(listOfScheduledPins[1]['pin2Status'].toString() != null){
//     print('check2');
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin2Status=${pinStatus}';
//   }else if(API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin3Status='!=null){
//     print('check3');
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin3Status=${pinStatus}';
//   }else if(API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin4Status='!=null){
//     print('check4');
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin5Status=${pinStatus}';
//   }else if(API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin6Status='!=null){
//     print('check5');
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin6Status=${pinStatus}';
//   }else if(API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin7Status='!=null){
//     print('check6');
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin7Status=${pinStatus}';
//   }else if(API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin8Status='!=null){
//     print('check7');
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin8Status=${pinStatus}';
//   }else if(API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin9Status='!=null){
//
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin9Status=${pinStatus}';
//   }else if(API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin10Status='!=null){
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin10Status=${pinStatus}';
//   }else if(API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin11Status='!=null){
//     url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin11Status=${pinStatus}';
//   }
//
//   final response = await http.delete(url,headers: {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Token $token',
//   });
//   if(response.statusCode>0){
//     print('deleteScheduling ${response.body}');
//     if(response.statusCode==200){
//
//         final snackBar = SnackBar(
//           content: Text('Pin Scheduled Deleted'),
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       }
//
//   }
// }


// Future deleteSchedulingUsingUrl(String url)async{
//   String token = await getToken();
//   String tr=url;
//   final response = await http.delete(tr,headers: {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Token $token',
//   });
//   if(response.statusCode>0){
//     print('deleteScheduling ${response.body}');
//     print('deleteScheduling ${response.statusCode}');
//     if(response.statusCode==200){
//
//       final snackBar = SnackBar(
//         content: Text('Pin Scheduled Deleted'),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//
//   }
// }
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Container();
      }else{
        return Scaffold(
          appBar: AppBar(
            title: Text("Scheduled Pin"),
          ),
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
                          Center(child: Text('Sorry we cannot find any Temp User please add',style: TextStyle(fontSize: 18),)),
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
                                                title: Text(listOfScheduledPins[index]['d_id'].toString()==null?"Loading":listOfScheduledPins[index]['d_id'].toString()),
                                                trailing: Text(listOfScheduledPins[index]['date1'].toString()==null?"Loading":listOfScheduledPins[index]['date1'].toString()),
                                                leading: IconButton(
                                                  icon: Icon(Icons.delete_forever,color: Colors.black,semanticLabel: 'Delete',),
                                                  onPressed: (){
                                                    deleteSchedulingUsingId(listOfScheduledPins[index]['id'].toString());
                                                    // print('listOfScheduledPins[index] ${listOfScheduledPins[index]}');
                                                    // // if(listOfScheduledPins[index]['pin1Status']!=null){
                                                    // //   pinStatus=listOfScheduledPins[index]['pin1Status'];
                                                    // // }else if(listOfScheduledPins[index]['pin2Status']!=null){
                                                    // //   pinStatus=listOfScheduledPins[index]['pin2Status'];
                                                    // // }else if(listOfScheduledPins[index]['pin3Status']!=null){
                                                    // //   pinStatus=listOfScheduledPins[index]['pin3Status'];
                                                    // // }else if(listOfScheduledPins[index]['pin4Status']!=null){
                                                    // //   pinStatus=listOfScheduledPins[index]['pin4Status'];
                                                    // // }else if(listOfScheduledPins[index]['pin5Status']!=null){
                                                    // //   pinStatus=listOfScheduledPins[index]['pin6Status'];
                                                    // // }else if(listOfScheduledPins[index]['pin7Status']!=null){
                                                    // //   pinStatus=listOfScheduledPins[index]['pin7Status'];
                                                    // // }else if(listOfScheduledPins[index]['pin8Status']!=null){
                                                    // //   pinStatus=listOfScheduledPins[index]['pin8Status'];
                                                    // // }else if(listOfScheduledPins[index]['pin9Status']!=null){
                                                    // //   pinStatus=listOfScheduledPins[index]['pin9Status'];
                                                    // // }
                                                    // // print('pinStatus ${pinStatus}');
                                                    // // print('pinStatus ${listOfScheduledPins[index]}');
                                                    // String  url_delete_api;
                                                    // if( listOfScheduledPins[index]['pin1Status'].toString() != null){
                                                    //
                                                    //   url_delete_api =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${listOfScheduledPins[index]['d_id'].toString()}&date1=${listOfScheduledPins[index]['date1'].toString()}&timing1=${listOfScheduledPins[index]['timing1'].toString()}&pin1Status=${listOfScheduledPins[index]['pin1Status'].toString()}';
                                                    //   deleteSchedulingUsingUrl(url_delete_api);
                                                    // print('check1254 ${url_delete_api}' );
                                                    // }else if(listOfScheduledPins[index]['pin2Status'].toString() != null){
                                                    //   print('check2');
                                                    //
                                                    //   // url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin2Status=${pinStatus}';
                                                    // }
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin1Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin2Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin3Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin4Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin5Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin6Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin7Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin8Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin9Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin10Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin11Status'].toString());
                                                    // // deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index]['pin12Status'].toString());
                                                    // // deleteSchedulingUsingIndex(index);
                                                    // // _showDialogForDeleteSubUser(index);
                                                  },
                                                ),
                                                subtitle: Text(listOfScheduledPins[index]['timing1'].toString()),

                                                onTap: (){
                                                  print('printSubUser ${listOfScheduledPins[index]['name']}');

                                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>TempUserDetails(tempUserPlaceName: tempUserDecodeList[index]['p_id'],
                                                  //   tempUserFloorName: tempUserDecodeList[index]['f_id'] ,)));

                                                },
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Pin 1 -> '),
                                                      Text(listOfScheduledPins[index]['pin1Status'].toString()==null? "No ":listOfScheduledPins[index]['pin1Status'].toString(),textAlign: TextAlign.end,),
                                                    SizedBox(width: 14,),
                                                      Text('Pin 2 -> '),
                                                      Text(listOfScheduledPins[index]['pin2Status'].toString(),textAlign: TextAlign.end,),
                                                      SizedBox(width: 14,),
                                                      Text('Pin 3 -> '),
                                                      Text(listOfScheduledPins[index]['pin3Status'].toString(),textAlign: TextAlign.end,),
                                                      SizedBox(width: 14,),
                                                      Text('Pin 4 -> '),
                                                      Text(listOfScheduledPins[index]['pin4Status'].toString(),textAlign: TextAlign.end,),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Pin 5 ->'),
                                                      Text(listOfScheduledPins[index]['pin5Status'].toString(),textAlign: TextAlign.end,),
                                                      SizedBox(width: 14,),
                                                      Text('Pin 6 -> '),
                                                      Text(listOfScheduledPins[index]['pin6Status'].toString(),textAlign: TextAlign.end,),
                                                      SizedBox(width: 14,),
                                                      Text('Pin 7 -> '),
                                                      Text(listOfScheduledPins[index]['pin7Status'].toString(),textAlign: TextAlign.end,),
                                                      SizedBox(width: 14,),
                                                      Text('Pin 8 -> '),
                                                      Text(listOfScheduledPins[index]['pin8Status'].toString(),textAlign: TextAlign.end,),

                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Pin 9 ->'),
                                                      Text(listOfScheduledPins[index]['pin9Status'].toString(),textAlign: TextAlign.end,),

                                                    ],
                                                  ),
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
