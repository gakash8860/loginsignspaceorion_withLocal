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
  Box scheduledPinBox;
  Box scheduledPinNameBox;
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
      // getPinsName();
      scheduled=getScheduledPins();
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


String on="On";
String off="Off";
List namesDataList;
allPinNames(String dId)async{
  namesDataList =await  NewDbProvider.instance.getPinNamesByDeviceId(dId);
  print('names123654 ${namesDataList}');
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
            title: Text("Scheduled Pin",style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
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
                                    allPinNames(listOfScheduledPins[index]['d_id']);
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
                                                                Text(namesDataList[index]['pin1Name'].toString()==null?"Wait":namesDataList[index]['pin1Name'].toString(),style: TextStyle(fontFamily: fonttest==null?'RobotoMono':fonttest,),),
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
