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
    timer=Timer.periodic(Duration(seconds: 10), (timer) {
      print('qwertyuiop');
      getScheduledPins();
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

Future deleteScheduling(String dId,String date,String time,String pinStatus)async{
  String token = await getToken();
  // String token = "be43f6166fce6faef0525c610402b332debdb232";
  String url1=API;

  // if(url1+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin10Status=${pinStatus}'!=null){
  //   url1+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin1Status=${pinStatus}';
  // }
  // String url=API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&${pinStatus}=${pinStatus}';
  String url;
  if(pinStatus!=null){
    url =API+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&${pinStatus}=${pinStatus}';
  }
  final response = await http.delete(url,headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Token $token',
  });
  if(response.statusCode>0){
    print('deleteScheduling ${response.body}');
    if(response.statusCode==200){

        final snackBar = SnackBar(
          content: Text('Pin Scheduled Deleted'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

  }
}


Future deleteSchedulingUsingIndex(int index)async{
  String token = await getToken();
  // String token = "be43f6166fce6faef0525c610402b332debdb232";
  String url1=API;

  // if(url1+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin10Status=${pinStatus}'!=null){
  //   url1+'schedulingpinsalltheway/?user=${getUidVariable}&d_id=${dId}&date1=${date}&timing1=${time}&pin1Status=${pinStatus}';
  // }
  final url=API+'schedulingpinsalltheway/?${index}';
  final response = await http.delete(url,headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Token $token',
  });
  if(response.statusCode>0){
    print('deleteScheduling ${response.body}');
    if(response.statusCode==200){

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
                                                                // await schedulingDevicePin(
                                                                //     dId, index);
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
                                                    print('listOfScheduledPins[index] ${listOfScheduledPins[index]}');
                                                    if(listOfScheduledPins[index]['pin1Status']!=null){
                                                      pinStatus=listOfScheduledPins[index]['pin1Status'];
                                                    }else if(listOfScheduledPins[index]['pin2Status']!=null){
                                                      pinStatus=listOfScheduledPins[index]['pin2Status'];
                                                    }else if(listOfScheduledPins[index]['pin3Status']!=null){
                                                      pinStatus=listOfScheduledPins[index]['pin3Status'];
                                                    }else if(listOfScheduledPins[index]['pin4Status']!=null){
                                                      pinStatus=listOfScheduledPins[index]['pin4Status'];
                                                    }else if(listOfScheduledPins[index]['pin5Status']!=null){
                                                      pinStatus=listOfScheduledPins[index]['pin6Status'];
                                                    }else if(listOfScheduledPins[index]['pin7Status']!=null){
                                                      pinStatus=listOfScheduledPins[index]['pin7Status'];
                                                    }else if(listOfScheduledPins[index]['pin8Status']!=null){
                                                      pinStatus=listOfScheduledPins[index]['pin8Status'];
                                                    }else if(listOfScheduledPins[index]['pin9Status']!=null){
                                                      pinStatus=listOfScheduledPins[index]['pin9Status'];
                                                    }
                                                    print('pinStatus ${pinStatus}');
                                                    deleteScheduling(listOfScheduledPins[index]['d_id'].toString(),listOfScheduledPins[index]['date1'].toString(),listOfScheduledPins[index]['timing1'].toString(),listOfScheduledPins[index][pinStatus]);
                                                    // deleteSchedulingUsingIndex(index);
                                                    // _showDialogForDeleteSubUser(index);
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
                                                  Text(listOfScheduledPins[index]['pin1Status'].toString()==null? "No ":listOfScheduledPins[index]['pin1Status'].toString(),textAlign: TextAlign.end,),
                                                  Text(listOfScheduledPins[index]['pin2Status'].toString(),textAlign: TextAlign.end,),
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
