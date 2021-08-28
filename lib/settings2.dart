import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: Setting2(),
));
class Setting2 extends StatefulWidget {
  const Setting2({Key key}) : super(key: key);

  @override
  _Setting2State createState() => _Setting2State();
}

class _Setting2State extends State<Setting2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff814cbe),
    body: Container(
      child: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: -18.0, end: 10.0),
            Pin(start: 4.0, end: -4.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 132.0, start: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0x14ffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0x14707070)),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Pinned.fromPins(
                    Pin(start: 34.0, end: 0.0),
                    Pin(size: 181.0, middle: 0.4215),
                    child: Stack(
                      children: <Widget>[
                        Container(color: Colors.amber,),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Pinned.fromPins(
                            Pin(start: 0.0, end: 0.0),
                            Pin(start: 0.0, end: 0.0),
                            child: const Text(
                              'Change Password',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
    );
  }
}
