import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chnagedTheme.dart';

bool change_toDark = false;
void main()=>runApp(MaterialApp(
  home: SettingPage(),
));

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {




  _launchURL() async {
    const url = 'https://genorionofficial.herokuapp.com/change_password_phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[114],
      body: Container(
        color: change_toDark ? Colors.black : Colors.white,
        child: ListView(

          padding: EdgeInsets.all(19.0),
          children: <Widget>[

            Card(
              color: change_toDark ? Colors.black : Colors.white,
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: _launchURL,
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 15.0,
                          child: Icon(Icons.password_sharp)),
                      title: Text('Change Password',style: TextStyle(        color: change_toDark ? Colors.white : Colors.black,),),
                      selectedTileColor: Colors.blue,
                      // onTap: ,
                      trailing: Row(
                        mainAxisSize:MainAxisSize.min ,
                        children: <Widget>[
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),

                    ),
                  ),ListTile(

                    leading: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.home)),
                    title: Text('Dark Mode',style: TextStyle(        color: change_toDark ? Colors.white : Colors.black,),),
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
                              });
                            }),
                      ],
                    ),
                  ),

                ],
              ),
            ),Padding(padding: EdgeInsets.all(16.0)),

            Card(
              color: change_toDark ? Colors.black : Colors.white,

              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.home_work_outlined)),
                    title: Text('Change Home Screen Layout',style: TextStyle( color: change_toDark ? Colors.white : Colors.black,),),
                    // onTap: ,
                    trailing: Row(
                      mainAxisSize:MainAxisSize.min ,
                      children: <Widget>[
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),ListTile(
                    leading: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.drive_file_rename_outline)),
                    title: Text('Rename House',style: TextStyle( color: change_toDark ? Colors.white : Colors.black,),),
                    selectedTileColor: Colors.blue,
                    // onTap: ,
                    trailing: Row(
                      mainAxisSize:MainAxisSize.min ,
                      children: <Widget>[
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.perm_device_information_sharp)),
                    title: Text('Manage Devices',style: TextStyle( color: change_toDark ? Colors.white : Colors.black,),),
                    // onTap: ,
                    trailing: Row(
                      mainAxisSize:MainAxisSize.min ,
                      children: <Widget>[
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),

                  ),
                  ListTile(
                    leading: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.change_history_sharp)),
                    title: Text('Manage Themes',style: TextStyle( color: change_toDark ? Colors.white : Colors.black,),),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangedTheme()),
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
            )
          ],
        ),
      ),
    );
  }
}
