import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: WhatsNew(),
));

class WhatsNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('SpaceOrion'),
      ),
      body: Center(
        child: Text('Whats New',style:
        TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45
        ),),
      ),
    );
  }
}
