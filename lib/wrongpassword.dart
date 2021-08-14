import 'package:flutter/material.dart';


class WrongPassword extends StatelessWidget {
  const WrongPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent])),
        child: LayoutBuilder(
          builder: (BuildContext context,
          BoxConstraints viewportConstraints) {
        if(viewportConstraints.maxWidth>600){
          return Container(
            child: Center(
              child: Text('Oops Wrong password'),
            ),
          );
        }else{
          return Container(
            child: Center(
              child: Text('Oops Wrong password'),
            ),
          );
        }

          }
        ),
      ),
    );
  }
}
