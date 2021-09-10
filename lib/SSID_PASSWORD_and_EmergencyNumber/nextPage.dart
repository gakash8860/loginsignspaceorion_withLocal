import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
import 'package:loginsignspaceorion/home.dart';

import '../changeFont.dart';
import '../dropdown2.dart';

void main()=>runApp(MaterialApp(
  home:NextPageSSID() ,
));

class NextPageSSID extends StatefulWidget {
  const NextPageSSID({Key key}) : super(key: key);

  @override
  _NextPageSSIDState createState() => _NextPageSSIDState();
}

class _NextPageSSIDState extends State<NextPageSSID> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GenOrion'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200,),
            Text('Your Network Credentials have been successfully updated',style: TextStyle(fontFamily: fonttest==null?changeFont:fonttest,),),
            ElevatedButton(onPressed: (){
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(pt: places.last, fl: floors.last, rm: [rm.last], )));
            }, child: Text('Goto Home Page'))

          ],
        ),
      ),
    );
  }
}
