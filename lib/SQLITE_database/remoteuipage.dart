import 'package:control_pad/views/joystick_view.dart';
import 'package:flutter/material.dart';

class RemoteUIPage extends StatefulWidget {
  const RemoteUIPage({Key key}) : super(key: key);

  @override
  _RemoteUIPageState createState() => _RemoteUIPageState();
}

class _RemoteUIPageState extends State<RemoteUIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remote'),
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: ClipOval(
                    child: Material(
                      child: InkWell(
                        splashColor: Colors.white24,
                        child:SizedBox(
                          height: 56,
                          width: 56,
                          child: Icon(Icons.dialpad),
                        ),
                        onTap: (){},
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ClipOval(
                    child: Material(
                      color: Colors.red,
                      child: InkWell(
                        splashColor: Colors.white24,
                        child:SizedBox(
                          height: 56,
                          width: 56,
                          child: Icon(Icons.power_settings_new),
                        ),
                        onTap: (){},
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ClipOval(
                    child: Material(
                      child: InkWell(
                        splashColor: Colors.white24,
                        child:SizedBox(
                          height: 56,
                          width: 56,
                          child: Icon(Icons.bubble_chart),
                        ),
                        onTap: (){},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 156,
                    width: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.arrow_drop_up),
                        Text('VOL',style: TextStyle(fontWeight: FontWeight.bold),),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  SizedBox(width: 14,),
                  JoystickView(

                    innerCircleColor: Colors.grey,
                    backgroundColor: Colors.grey.shade400,
                    iconsColor: Colors.white,
                    showArrows: true,
                    size: 200.0,
                  ),
                  SizedBox(width: 14,),
                  Container(
                    height: 156,
                    width: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.arrow_drop_up),
                        Text('CH',style: TextStyle(fontWeight: FontWeight.bold),),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(18.0),
                    // color: Colors.white,
                  ),
                  child: Padding(padding: EdgeInsets.all(2.0),
                    // child: Image.asset('assets/netflix.png'),
                  ),
                ),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(18.0),
                    // color: Colors.white,
                  ),
                  child: Padding(padding: EdgeInsets.all(8.0),
                    // child: Image.asset('assets/prime.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
