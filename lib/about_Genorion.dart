// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'SQLITE_database/testinghome2.dart';
import 'changeFont.dart';

void main() => runApp(const MaterialApp(
      home: AboutGen(),
    ));

class AboutGen extends StatelessWidget {
  const AboutGen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent])),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        if (viewportConstraints.maxWidth > 600) {
          return  Container(

            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            child: Column(
              children: <Widget>[
                Text(
                  '●	GenOrion is a part of SpaceStation Automation Pvt. Ltd.',
                  style: TextStyle(fontFamily: fonttest ?? changeFont,fontSize: 20, color: Colors.black54),
                ),
                const SizedBox(height: 40,),
                Text(
                    '●	Developing smart switching and control systems for Automation.',
                    style: TextStyle(fontFamily: fonttest ?? changeFont,fontSize: 20, color: Colors.black54)),
                const SizedBox(height: 40,),
                Text(
                    '●	Systems can be used in Home, office, warehouses and Automobiles',
                    style: TextStyle(fontFamily: fonttest ?? changeFont,fontSize: 20, color: Colors.black54)),
                const SizedBox(height: 40,),
                Text(
                    '●	Motto is to make Automation affordable to reach each and every house.',
                    style: TextStyle(fontFamily: fonttest ?? changeFont,fontSize: 20, color: Colors.black54)),
              ],
            ),
          );
        }else{
          return  Scaffold(
            appBar: AppBar(
              title: const Text('SpaceOrion'),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              child: Column(
                children: <Widget>[
                  Text(
                    '●	GenOrion is a part of SpaceStation Automation Pvt. Ltd.',
                    style: TextStyle(
                      fontFamily: fonttest ?? changeFont,
                        fontSize: 20, color: Colors.black54),
                  ),
                  Text(
                      '●	Developing smart switching and control systems for Automation.',
                      style: TextStyle(                      fontFamily: fonttest ?? changeFont,fontSize: 20, color: Colors.black54)),
                  Text(
                      '●	Systems can be used in Home, office, warehouses and Automobiles',
                      style: TextStyle(                      fontFamily: fonttest ?? changeFont,fontSize: 20, color: Colors.black54)),
                  Text(
                      '●	Motto is to make Automation affordable to reach each and every house.',
                      style: TextStyle(                      fontFamily: fonttest ?? changeFont,fontSize: 20, color: Colors.black54)),
                ],
              ),
            ),
          );
        }
        }
          // child: Container(
          //   margin: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          //
          // ),
        ),
      ),
    );
  }
}
