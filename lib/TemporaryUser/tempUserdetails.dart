import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class TempUserDetails extends StatefulWidget {
  final tempUserAllDetails;
  const TempUserDetails({Key key, this.tempUserAllDetails}) : super(key: key);

  @override
  _TempUserDetailsState createState() => _TempUserDetailsState();
}

class _TempUserDetailsState extends State<TempUserDetails> {
var placeName;



@override
void initState(){
  super.initState();
  getSinglePlaceName();
  // timer= Timer.periodic(Duration(milliseconds: 1), (timer) { getSinglePlaceName();});


}

  Future getSinglePlaceName()async{
    String token= await getToken();
    final url='http://genorionofficial.herokuapp.com/getyouplacename/?p_id='+widget.tempUserAllDetails.toString();
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
        title: Text('Temp User Details'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: Text(placeName==null?"Loading...":placeName.toString()),
      ),
    );
  }
}
