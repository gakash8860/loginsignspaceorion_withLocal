import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loginsignspaceorion/SubAccessPage/subaccesshomepage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
void main()=>runApp(MaterialApp(
  home: SubAccessList(),
));



class SubAccessList extends StatefulWidget {
  @override
  _SubAccessListState createState() => _SubAccessListState();
}

class _SubAccessListState extends State<SubAccessList> {
  var ownerName;
  var listOfFloorId;
  List data;
  Box subUserBox;




  void initState(){
    super.initState();
    getSubUsers();
  }






  List subUserDecodeList;

  Future openSubUserBox()async{

    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    subUserBox=await Hive.openBox('tempUser');
    print('tempUserBox  ${subUserBox.values.toString()}');
    return;
  }




  Future<void> getSubUsers()async{
    String token ='fc8a8de66981014125077cadbf12bb12cbfe95fb';
    await openSubUserBox();

    final url ='http://genorion1.herokuapp.com/subfindsubdata/?email=test@gmail.com';
    try{
      final response= await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',

      });

      await subUserBox.clear();

      var  subUserDecode=jsonDecode(response.body);


      print('tempResponse ${subUserDecode}');
      setState(() {
        subUserDecodeList=subUserDecode;
        putSubUser(subUserDecodeList);
      });
      print('subUserDecode ${subUserDecodeList}');
      print('Number1123->  ${subUserDecodeList}');


    }catch(e){
      // print('Status Exception $e');

    }

    var myMap=subUserBox.toMap().values.toList();
    if(myMap.isEmpty){
      subUserBox.add('empty');

    }else{
      subUserDecodeList=myMap ;

    }
    return Future.value(true);
  }

  Future putSubUser(data)async{
    await subUserBox.clear();
    for(var d in data){

      subUserBox.add(d);
    }

  }
  var placeName;

  Future getSinglePlaceName()async{
    String token ='fc8a8de66981014125077cadbf12bb12cbfe95fb';
    final url='http://genorion1.herokuapp.com/getyouplacename/?p_id=8746347';
    final response = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if(response.statusCode>0){
      print('getSinglePlaceName${response.statusCode}');
      print('getSinglePlaceName${response.body}');
      var placeDecode=  jsonDecode(response.body);
      setState(() {
        placeName=placeDecode;
      });
      print('placeName${placeName}');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SubUser'),
      ),
      body:  RefreshIndicator(
        onRefresh: getSubUsers,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.lightBlueAccent])),
            child:Container(
              // color: Colors.green,
              // height: 789,
              width:MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              child: FutureBuilder(
                  future: getSubUsers(),
                  builder: ( context,  snapshot){
                    // getSinglePlaceName();
                    if(snapshot.hasData){
                      if(subUserDecodeList.isEmpty){
                        return Column(
                          children: [
                            SizedBox(height: 250,),
                            Center(child: Text('Sorry we cannot find any Temp User please add',style: TextStyle(fontSize: 18),)),
                          ],
                        );
                      }else{
                        return Column(
                          children: [
                            SizedBox(height: 5,),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: subUserDecodeList.length,
                                    itemBuilder: (context,index){
                                      // getSinglePlaceName(index);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          semanticContainer:true,
                                          shadowColor: Colors.grey,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(subUserDecodeList[index]['name']),
                                                trailing: Text(subUserDecodeList[index]['email']),

                                                subtitle: Text(subUserDecodeList[index]['p_id'].toString()),

                                                onTap: ()async{
                                                  print('printSubUser ${subUserDecodeList[index]['p_id']}');
                                                 await Navigator.push(context, MaterialPageRoute(builder: (context)=>SubAccessHome(
                                                    email:subUserDecodeList[index]['email'] ,
                                                  pt: subUserDecodeList[index]['p_id'].toString(),)));
                                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>TempUserDetails(tempUserPlaceName: tempUserDecodeList[index]['p_id'],
                                                  //   tempUserFloorName: tempUserDecodeList[index]['f_id'] ,)));

                                                },
                                              ),

                                              Row(
                                                children: [
                                                  SizedBox(width: 25,),
                                                  Text('Owner Name = ${subUserDecodeList[index]['owner_name']}'.toString(),textAlign: TextAlign.end,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );

                                    }
                                )),


                          ],
                        );
                      }
                    }else{
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child:Shimmer.fromColors(
                            baseColor: Colors.red,
                            highlightColor: Colors.yellow,
                            child: Text('Wait'),)
                      );
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Loading'),
                            CircularProgressIndicator(
                              color: Colors.red,
                              semanticsLabel: 'Loading...',
                              semanticsValue: 'Loading',
                            ),
                          ],
                        ),
                      );
                    }

                  }

              ),
            ),
          ),
        ),
      ),
    );
  }
}