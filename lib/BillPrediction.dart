import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Billprediction extends StatelessWidget {
  Billprediction({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff083b63),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 1848.4, middle: 0.0),
            Pin(start: 0.0, end: 0.0),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 1848.0,
                  height: 2335.0,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: -1255.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 482.0, start: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x14ffffff),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0x14707070)),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 0.5, end: 0.0),
                              Pin(size: 1908.5, start: 47.5),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(size: 447.2, start: 0.0),
                                    Pin(size: 94.0, start: 0.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 25.2, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child: Text(
                                            'Bill Prediction',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 70,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 34.2),
                                          Pin(size: 1.0, end: -1.0),
                                          child: SvgPicture.string(
                                            _svg_aavnct,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 124.8, end: 0.0),
                                    Pin(size: 882.4, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'arrow-left-circle-f…' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(size: 124.8, start: 0.0),
                                          child: SvgPicture.string(
                                            _svg_bcyl,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 10.4, end: 10.4),
                                          Pin(size: 104.0, end: 0.0),
                                          child: PageLink(
                                            links: [
                                              PageLinkInfo(
                                                transition: LinkTransition.Fade,
                                                ease: Curves.easeOut,
                                                duration: 0.3,
                                                // pageBuilder: () => Bedroom(),
                                              ),
                                            ],
                                            child: SvgPicture.string(
                                              _svg_pvre,
                                              allowDrawingOutsideViewBox: true,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 149.0, start: 94.1),
                                    Pin(size: 67.0, middle: 0.2133),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child: Text(
                                            ' Graph',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 50,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 297.0, start: 77.6),
                                    Pin(size: 134.0, middle: 0.4648),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child: Text(
                                            'Electricity \nConsumption',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 50,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 677.5, middle: 0.488),
                                    Pin(size: 473.5, start: 189.8),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 333.0, start: 20.5),
                                          Pin(size: 67.0, end: 0.0),
                                          child: Text(
                                            'Monthly Graph',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 50,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 1.0, start: 0.0),
                                          Pin(size: 373.0, start: 0.0),
                                          child: SvgPicture.string(
                                            _svg_rrrxws,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.5, end: 0.0),
                                          Pin(size: 1.0, middle: 0.7905),
                                          child: SvgPicture.string(
                                            _svg_yaq0,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 339.1, start: 56.8),
                                          Pin(size: 173.4, middle: 0.4566),
                                          child: SvgPicture.string(
                                            _svg_wpa998,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 339.0, end: 124.8),
                                    Pin(size: 271.0, middle: 0.1941),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(size: 95.0, start: 0.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            48.0),
                                                    color:
                                                        const Color(0xff6693b7),
                                                    border: Border.all(
                                                        width: 1.0,
                                                        color: const Color(
                                                            0xff707070)),
                                                  ),
                                                ),
                                              ),
                                              Pinned.fromPins(
                                                Pin(
                                                    size: 102.0,
                                                    middle: 0.5021),
                                                Pin(size: 67.0, end: 13.5),
                                                child: Text(
                                                  'Start',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 50,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(size: 95.0, end: 0.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            48.0),
                                                    color:
                                                        const Color(0xff6693b7),
                                                    border: Border.all(
                                                        width: 1.0,
                                                        color: const Color(
                                                            0xff707070)),
                                                  ),
                                                ),
                                              ),
                                              Pinned.fromPins(
                                                Pin(size: 83.0, middle: 0.4648),
                                                Pin(size: 67.0, end: 13.5),
                                                child: Text(
                                                  'End',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 50,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 653.0, middle: 0.7056),
                                    Pin(size: 95.0, end: 204.2),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(48.0),
                                              color: const Color(0xff5789b0),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color:
                                                      const Color(0xff707070)),
                                            ),
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 139.0, middle: 0.537),
                                          Pin(size: 67.0, end: 13.5),
                                          child: Text(
                                            'Pridict',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 50,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 99.1, end: 275.8),
                                    Pin(size: 188.0, end: 251.7),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 302.0, start: 0.0),
                                          Pin(start: 26.5, end: 27.5),
                                          child: Text(
                                            'Bill Prediction\n           ',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 50,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 867.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child: Text(
                                            'Set price per unit ___________\n',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 70,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 920.0, middle: 0.6667),
                        Pin(size: 603.0, end: -286.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26.0),
                                  color: const Color(0x172495ed),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0x17707070)),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 232.0, start: 68.5),
                              Pin(size: 70.0, start: 88.7),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Text(
                                      'Start Date',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 53,
                                        color: const Color(0xffffffff),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 212.0, start: 68.5),
                              Pin(size: 70.0, middle: 0.383),
                              child: Text(
                                'End Date',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 53,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 339.1, middle: 0.6551),
                              Pin(size: 1.0, middle: 0.2367),
                              child: SvgPicture.string(
                                _svg_iy5e0i,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 339.1, middle: 0.6551),
                              Pin(size: 1.0, middle: 0.4344),
                              child: SvgPicture.string(
                                _svg_mr8ket,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 426.0, middle: 0.6824),
                              Pin(size: 119.4, middle: 0.7232),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(48.0),
                                        color: const Color(0xff04497f),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 65.9, end: 65.9),
                                    Pin(start: 15.4, end: 15.4),
                                    child: Text(
                                      'Calculate',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 50,
                                        color: const Color(0xffffffff),
                                        height: 0.24,
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
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
}

const String _svg_aavnct =
    '<svg viewBox="20.9 116.7 413.0 1.0" ><path transform="translate(20.89, 116.7)" d="M 0 0 L 413 0" fill="none" stroke="#ffffff" stroke-width="5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bcyl =
    '<svg viewBox="0.0 0.0 124.8 124.8" ><path  d="M 0 0 L 124.778564453125 0 L 124.778564453125 124.778564453125 L 0 124.778564453125 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pvre =
    '<svg viewBox="10.4 778.4 104.0 104.0" ><path transform="translate(8.4, 776.4)" d="M 53.99106597900391 2 C 82.69014739990234 2 105.9821395874023 25.2919979095459 105.9821395874023 53.99106597900391 C 105.9821395874023 82.69014739990234 82.69014739990234 105.9821395874023 53.99106597900391 105.9821395874023 C 25.29199600219727 105.9821395874023 2 82.69014739990234 2 53.99106597900391 C 2 25.29199600219727 25.2919979095459 2 53.99106597900391 2 Z M 53.99106597900391 48.79196166992188 L 53.99106597900391 33.19464111328125 L 33.19464111328125 53.99106597900391 L 53.99106597900391 74.78749847412109 L 53.99106597900391 59.1901741027832 L 74.78749847412109 59.1901741027832 L 74.78749847412109 48.79196166992188 L 53.99106597900391 48.79196166992188 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rrrxws =
    '<svg viewBox="182.5 363.5 1.0 373.0" ><path transform="translate(182.5, 363.5)" d="M 0 0 L 0 373" fill="none" stroke="#000000" stroke-width="8" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yaq0 =
    '<svg viewBox="183.0 737.0 677.0 1.0" ><path transform="translate(183.0, 737.0)" d="M 677 0 L 0 0" fill="none" stroke="#000000" stroke-width="8" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wpa998 =
    '<svg viewBox="239.3 500.5 339.1 173.4" ><path transform="translate(920.0, -1961.0)" d="M -680.7388305664062 2578.007080078125 L -665.2086791992188 2461.53076171875 L -579.7927856445312 2549.53515625 L -512.495361328125 2461.53076171875 L -434.8445739746094 2634.950927734375 L -341.6636047363281 2461.53076171875" fill="none" stroke="#ffffff" stroke-width="10" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_iy5e0i =
    '<svg viewBox="506.6 441.5 339.1 1.0" ><path transform="translate(506.57, 441.49)" d="M 0 0 L 339.0905151367188 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_mr8ket =
    '<svg viewBox="506.6 560.5 339.1 1.0" ><path transform="translate(506.57, 560.53)" d="M 0 0 L 339.0905151367188 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
