import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: AboutGen(),
    ));

class AboutGen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpaceOrion'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Column(
          children: <Widget>[
            Text(
              '●	GenOrion is a part of SpaceStation Automation Pvt. Ltd.',
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            Text(
                '●	Developing smart switching and control systems for Automation.',
                style: TextStyle(fontSize: 20, color: Colors.black54)),
            Text(
                '●	Systems can be used in Home, office, warehouses and Automobiles',
                style: TextStyle(fontSize: 20, color: Colors.black54)),
            Text(
                '●	Motto is to make Automation affordable to reach each and every house.',
                style: TextStyle(fontSize: 20, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
