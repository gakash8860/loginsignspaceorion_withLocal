import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class PlaceBill extends StatefulWidget {
  const PlaceBill({Key key}) : super(key: key);

  @override
  _PlaceBillState createState() => _PlaceBillState();
}

class _PlaceBillState extends State<PlaceBill> {


  Future placeVal;
  DateTime pickedDate;
  DateTime pickedDate2;
  PlaceType pt;
  FloorType fl;
  Flat flt;
  List<RoomType> rm;
  double _valueMinute;
  var pleaseSelect = 'Please Select';
  RoomType rm2;
  int length=0;
  Device dv2;
  String chooseValueMinute;
  // List tenMinuteEnergy;
  List<Device> dv;
  var selectedflat;
  var selectedroom;
  var selecteddeviceId;
  Future floorVal;
  List<dynamic> allFlatId;
  var allDeviceId=List.empty(growable: true);
  Future flatVal;
  Future roomVal;
  List allRoomId;
  List allFloorId;
  List minute = [
    '10 minute',
    '20 minute',
    '30 minute',
    '40 minute',
    '50 minute',
    '60 minute'
  ];
  String r_id;
  List dataResponse=List.empty(growable: true);
  List tenMinuteEnergy;
  double total=0.0;
  double totalValue;
  bool completeTask=false;
  double changeValue;



  void initState() {
    super.initState();
    placeVal = getplaces();
    pickedDate = DateTime.now();
    pickedDate2 = DateTime.now();
  }


  Future<List<PlaceType>> getplaces() async {
    String token = await getToken();
    // final url = 'https://genorion.herokuapp.com/place/';
    final url = API + 'addyourplace/';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      print('place');
      List<dynamic> data = jsonDecode(response.body);
      List<PlaceType> places =
      data.map((data) => PlaceType.fromJson(data)).toList();

      // print(places);
      // floorVal = getfloors(places[0].p_id);

      return places;
    }else{
      return null;
    }
  }

  Future getfloors(String pId) async {
    final url = API + 'addyourfloor/?p_id=' + pId;
    String token = await getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      allFloorId=List.from(data);
      print('allFLoorId $allFloorId');
      await getFlat();
    }
  }

  Future getFlat() async {
    String fId;
    List data=List.empty(growable: true);
    String token = await getToken();
    for(int i=0;i<allFloorId.length;i++){
      fId=allFloorId[i]['f_id'];
      final url = API + 'addyourflat/?f_id=' + fId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        data.addAll(jsonDecode(response.body));
        allFlatId=List.from(data);
        print('allFlatId $allFlatId');
        print('allFlatId ${allFlatId.length}');

        await getrooms();


      }else{
        return null;
      }
    }


  }

  Future getrooms() async {
    List data= List.empty(growable: true);
    String flt_id;
    String token = await getToken();
    print('allFlatId147852 ${allFlatId.length}');
    for(int i=0;i<allFlatId.length;i++) {

      // print('allFlatId147852 ${allFlatId[i][j]['flt_id']}');
      flt_id=allFlatId[i]['flt_id'];

      final url = API + 'addroom/?flt_id=' + flt_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        data.addAll(jsonDecode(response.body)) ;
        print('allRoomData $data');
        allRoomId=List.from(data);
        // await getDevice();

      }

    }
    setState(() {

      print('allRoomData45859 ${allRoomId.length}');

    });
    await getDevice();
  }

  Future getDevice() async {
    String token = await getToken();
    String r_id;

    for(int i=0;i<allRoomId.length;i++){
      print('aagye $i');
      r_id=allRoomId[i]['r_id'];

      final url = API + 'addyourdevice/?r_id=' + r_id;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        print('rrrrr ${response.body}');
        dataResponse.addAll(jsonDecode(response.body))  ;
        print('allDeviceIdDeviceIddata-->  ${dataResponse}');

      }else{
        return null;
      }
    }
    allDeviceId=List.from(dataResponse);
    print('allDeviceIdDeviceIddataallDeviceId-->  ${allDeviceId.length}');
    // print('allDeviceIdDeviceIdtenMinuteEnergy-->  ${tenMinuteEnergy}');

    //
    // print('allDeviceIdDeviceId14785-->  ${allDeviceId}');
    // print('allDeviceIdDeviceId14785-->  ${allDeviceId.length}');

    // await getEnergyTenMinutes();
    await getEnergyTenMinutes();
  }
  Future getEnergyTenMinutes() async {
    List dataResponse=List.empty(growable: true);
    tenMinuteEnergy= List.empty(growable: true);
    var dId;
    String token = await getToken();
    for(int i=0;i<allDeviceId.length;i++){
      dId=allDeviceId[i]['d_id'];
      print('deviceIdEnergyRoom $dId');
      final url = API + 'pertenminuteenergy?d_id=' + dId;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('tenMinuteEnergy ${response.statusCode}');
      if (response.statusCode == 200){
        dataResponse.addAll(jsonDecode(response.body));
        tenMinuteEnergy=List.from(dataResponse);
        print('tenMinuteRoomdata2 $dataResponse');


      }


    }


    print('finaltenminuteenergy  ${tenMinuteEnergy.length}');


  }
  sumOfEnergyTenMinutes()async{
    setState(() {
      length=tenMinuteEnergy.length;
    });
    if(chooseValueMinute == '10 minute'){
      for(int i=0;i<tenMinuteEnergy.length;i++){
        setState(() {
          changeValue=double.parse(tenMinuteEnergy[i]['enrgy10']);
          totalValue=totalValue+changeValue;
          _valueMinute = totalValue;
        });
      }
      print('totalans $totalValue');
    }
    if(chooseValueMinute == '20 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          totalValue=totalValue+op1+op2;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '30 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i]['enrgy30']);
          totalValue=totalValue+op1+op2+op3;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }
    if(chooseValueMinute == '40 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i]['enrgy40']);
          totalValue=totalValue+op1+op2+op3+op4;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i][0]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '50 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i]['enrgy40']);
          double op5=double.parse(tenMinuteEnergy[i]['enrgy50']);
          totalValue=totalValue+op1+op2+op3+op4+op5;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }

    if(chooseValueMinute == '60 minute'){
      for(int i=0;i<length;i++){
        setState(() {
          double op1=double.parse(tenMinuteEnergy[i]['enrgy10']);
          double op2=double.parse(tenMinuteEnergy[i]['enrgy20']);
          double op3=double.parse(tenMinuteEnergy[i]['enrgy30']);
          double op4=double.parse(tenMinuteEnergy[i]['enrgy40']);
          double op5=double.parse(tenMinuteEnergy[i]['enrgy50']);
          double op6=double.parse(tenMinuteEnergy[i]['enrgy60']);
          totalValue=totalValue+op1+op2+op3+op4+op5+op6;
          _valueMinute = totalValue;
        });
        print('totalans ${tenMinuteEnergy[i]['enrgy20']}');
      }
      print('totalans $totalValue');
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Bill'),
      ),
      body:SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              FutureBuilder<List<PlaceType>>(
                  future: placeVal,
                  builder: (context,
                      AsyncSnapshot<List<PlaceType>> snapshot) {
                    if (snapshot.hasData) {
                      // print(snapshot.hasData);
                      // setState(() {
                      //   floorVal = getfloors(snapshot.data[0].p_id);
                      // });
                      if (snapshot.data.length == 0) {
                        return Center(
                            child:
                            Text("No Devices on this place"));
                      }
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 58),
                          child: SizedBox(
                            // width: double.infinity,
                            height: 50.0,
                            child: Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width /
                                  2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(7, 7)
                                      // offset: Offset(20,20)
                                    )
                                  ],
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  )),
                              child: DropdownButtonFormField<PlaceType>(
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.all(15),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  enabledBorder:
                                  UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black),
                                    borderRadius:
                                    BorderRadius.circular(50),
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
                                items: snapshot.data
                                    .map((selectedPlace) {
                                  return DropdownMenuItem<
                                      PlaceType>(
                                    value: selectedPlace,
                                    child:
                                    Text(selectedPlace.pType),
                                  );
                                }).toList(),
                                onChanged:
                                    (PlaceType selectedPlace) async{
                                  setState(() {
                                    fl = null;
                                    pt = selectedPlace;
                                  });
                                  await getfloors(selectedPlace.pId);
                                  setState(() {
                                    completeTask=true;
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
                  }),

              SizedBox(
                height: 15,
              ),
              completeTask? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  DropdownButton(
                      value: chooseValueMinute,
                      onChanged: (index) async {
                        setState(() {
                          chooseValueMinute = index;
                        });
                        totalValue=0.0;
                        await sumOfEnergyTenMinutes();
                      },
                      items: minute.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList()),
                  Text(_valueMinute == null
                      ? pleaseSelect
                      : _valueMinute.toString()),
                ],
              ):Text('Wait'),
            ],
          ),

        ),
      ) ,

    );
  }
}
