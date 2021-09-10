import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home:NoSubUser() ,
));
class NoSubUser extends StatefulWidget {
  const NoSubUser({Key key}) : super(key: key);

  @override
  _NoSubUserState createState() => _NoSubUserState();
}

class _NoSubUserState extends State<NoSubUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {

      if(viewportConstraints.maxWidth>600){
        return Center();
      }else{
        return Scaffold(
          body: Container(
          child: Center(
            child: Text('Your are eligible to access this page'),
          ),
          ),
        );
      }
        }
      ),
    );
  }
}
