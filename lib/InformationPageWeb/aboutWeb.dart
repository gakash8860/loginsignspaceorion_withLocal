import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

void main()=>runApp(MaterialApp(
  home: AboutWebPage(),
));
class AboutWebPage extends StatefulWidget {
  final AnimationController animationController;
  AboutWebPage({
    Key key,
    this.animationController
  }) : super(key: key);

  @override
  State<AboutWebPage> createState() => _AboutWebPageState();
}

class _AboutWebPageState extends State<AboutWebPage> with SingleTickerProviderStateMixin{
  AnimationController _animationController;

  @override
  void initState(){
    super.initState();
    _animationController= AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    _animationController.forward();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff814cbe),

      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 2076.0, middle: 0.5),
            Pin(start: 1.0, end: -05.0),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 402.0,
                  height: 1280.0,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 5.0),
                        Pin(size: 258.0, start: 47.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 45.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  // color: Colors.red
                                  color: const Color(0x7d25587f),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 0.0, middle: 0.2569),
                              Pin(size: 0.0, middle: 0.5659),
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 50,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 10.0, end: 3.0),
                              Pin(size: 196.0, end: 2.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 185),
                                  child: Text(
                                    '• Take a few steps to safeguard and secure your place.\n• Configure the module with GenOrion’s Mobile \n   Application &  add your credentials.\n• Add your device ID and rooms in the application to \n   complete  the process.\n• Add users to share the control (Go to Settings).\n• And you are good to go!\n',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 16,
                                      color: const Color(0xffffffff),
                                      height: 1.5625,
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 167.0, start: 10.0),
                              Pin(size: 27.0, start: 0.0),
                              child: Text(
                                'Mobile Application',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 18,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 4.0, end: 0.0),
                        Pin(size: 269.0, middle: 0.4111),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(31.0),
                            color: const Color(0x7d25587f),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 71.0, start: 10.0),
                        Pin(size: 25.0, middle: 0.2829),
                        child: Text(
                          'Website',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 16.0),
                        Pin(size: 196.0, middle: 0.4148),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 64),
                          child: InkWell(
                            onTap: (){_launchURL();},
                            child: Text('Link -  www.genorion.com \n\n'
                              '• Just log in with your credentials in the GenOrion’s  user portal on your Laptop or computer and the set-up is ready\n\nOr Haven’t configured yet?\n\n• Then you can also do it from the website just follow the same steps given above and configure the device.\n',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 16,
                                color: const Color(0xffffffff),
                                height: 1.5625,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 154.0, start: 7.5),
                        Pin(size: 27.0, middle: 0.5793),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                'Product Features ',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 18,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 4.0, end: 0.0),
                        Pin(size: 420.0, end: 34.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(31.0),
                                        color: const Color(0x7d25587f),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 17.0, end: 20.0),
                              Pin(start: 16.0, end: 0.0),
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 255),
                                      child: Text(
                                        '• Only 1 device is required.\n• Can work standalone or as Main module.\n• Supports calling feature (With sim).\n• Control up to 12 devices.\n• 3 speed control switches.\n• 8 loads upto 10A and 1 heavy load upto 15A.\n• Access sharing with admin roles.\n• Lifetime free Software upgrades for device.\n• Continuous Notification via app, calls and SMS.\n• Fire, gas, light, temperature & humidity sensing.\n• IR support for controlling remote based devices. \n• Battery backup of 6-12 hours.\n• Power consumption analysis.\n• Easy upgrades with plug & play devices. \n• Can be controlled via SMS & Bluetooth.\n\n',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 16,
                                          color: const Color(0xfffffbfb),
                                          height: 1.5625,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 121.0, start: 0.5),
                        Pin(size: 34.5, start: 1.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 3.5, end: 13.5),
                              Pin(size: 27.0, start: 0.0),
                              child: Text(
                                'Information',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(size: 1.0, end: 0.0),
                              child: SvgPicture.string(
                                _svg_pp81w4,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 51.1, end: 20.0),
                        Pin(size: 150.5, end: -151.0),
                        child:
                        // Adobe XD layer: 'arrow-left-circle-l…' (group)
                        Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 61.8, start: 0.0),
                              Pin(size: 61.8, middle: 0.2901),
                              child: SvgPicture.string(
                                _svg_lsew89,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 51.5, end: 0.0),
                              Pin(size: 51.5, start: 0.0),
                              child: SvgPicture.string(
                                _svg_yeef8,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 13.9, end: 45.0),
                              Pin(size: 55.0, end: 0.0),
                              child: Text(
                                'COPYRIGHT © 2020 SPACESTATION AUTOMATION PVT. LTD. - ALL RIGHTS RESERVED.',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 10,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    var url = 'https://genorion.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

const String _svg_pp81w4 =
    '<svg viewBox="0.5 46.5 121.0 1.0" ><path transform="translate(0.5, 46.5)" d="M 0 1 L 121 0" fill="none" stroke="#ffffff" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_lsew89 =
    '<svg viewBox="0.0 0.0 61.8 61.8" ><path  d="M 0 0 L 61.7745361328125 0 L 61.7745361328125 61.7745361328125 L 0 61.7745361328125 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yeef8 =
    '<svg viewBox="279.4 -25.7 51.5 51.5" ><path transform="translate(277.41, -27.74)" d="M 27.73938941955566 2.000000238418579 C 41.94753646850586 2.000000238418579 53.47878265380859 13.53124713897705 53.47878265380859 27.73938941955566 C 53.47878265380859 41.94753646850586 41.94753646850586 53.47878265380859 27.73938941955566 53.47878265380859 C 13.53124713897705 53.47878265380859 2.000000238418579 41.94753646850586 2.000000238418579 27.73938941955566 C 2.000000238418579 13.53124713897705 13.53124713897705 2.000000238418579 27.73938941955566 2.000000238418579 Z M 27.73938941955566 48.33090591430664 C 39.11620330810547 48.33090591430664 48.33090591430664 39.11620330810547 48.33090591430664 27.73938941955566 C 48.33090591430664 16.36257934570312 39.11620330810547 7.147878646850586 27.73938941955566 7.147878646850586 C 16.36257934570312 7.147878646850586 7.147878646850586 16.36257934570312 7.147878646850586 27.73938941955566 C 7.147878646850586 39.11620330810547 16.36257934570312 48.33090591430664 27.73938941955566 48.33090591430664 Z M 27.73938941955566 25.16545104980469 L 38.03514862060547 25.16545104980469 L 38.03514862060547 30.31332969665527 L 27.73938941955566 30.31332969665527 L 27.73938941955566 38.03514862060547 L 17.44363403320312 27.73938941955566 L 27.73938941955566 17.44363403320312 L 27.73938941955566 25.16545104980469 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
