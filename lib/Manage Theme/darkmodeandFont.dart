import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Setting_Page.dart';
import '../changeFont.dart';

void main()=>runApp(MaterialApp(
  home: DarkModeAndFont(),
));
class DarkModeAndFont extends StatefulWidget {
  static const routeName = '/DarkModeAndFont';
  const DarkModeAndFont({Key key}) : super(key: key);

  @override
  _DarkModeAndFontState createState() => _DarkModeAndFontState();
}

class _DarkModeAndFontState extends State<DarkModeAndFont> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Scaffold(

        );
      }else{
        return Scaffold(
          appBar: AppBar(
            title: Text('Manage Theme'),
          ),
          body: Container(
            color: change_toDark ? Colors.black : Colors.white,
            child: Card(
              color: change_toDark ? Colors.black : Colors.white,
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.home)),
                    title: Text('Dark Mode',style: TextStyle(color: change_toDark ? Colors.white : Colors.black,fontFamily: fonttest==null?'RobotoMono':fonttest),),
                    selectedTileColor: Colors.blue,
                    // onTap: ,
                    trailing: Row(
                      mainAxisSize:MainAxisSize.min ,
                      children: <Widget>[
                        Switch(
                            value: change_toDark,
                            onChanged: (newValue) {
                              setState(() {
                                change_toDark = newValue;
                                setToDark(change_toDark);
                              });
                              setToDark(change_toDark);
                            }),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.font_download_sharp)),
                    title: Text('Change Fonts',style: TextStyle( color: change_toDark ? Colors.white : Colors.black,fontFamily: fonttest==null?'RobotoMono':fonttest),),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangeFont()),
                      );
                    },
                    trailing: Row(
                      mainAxisSize:MainAxisSize.min ,
                      children: <Widget>[
                        Icon(Icons.arrow_forward_ios),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
        }
    );
  }
  setToDark(value)async{
    final pref= await SharedPreferences.getInstance();
    pref.setBool('darkmode', value);
  }
}
