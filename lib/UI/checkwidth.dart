import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: ,
));

class CheckWidth extends StatefulWidget {
  const CheckWidth({Key key}) : super(key: key);

  @override
  _CheckWidthState createState() => _CheckWidthState();
}

class _CheckWidthState extends State<CheckWidth> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return LoginSmallScreen(_currentIndex, (index) {
              setState(() {
                _currentIndex = index;
              });
            });
          } else {
            return HomeViewLarge(_currentIndex, (index) {
              setState(() {
                _currentIndex = index;
              });
            });
          }
        },
      ),
    );
  }
}
