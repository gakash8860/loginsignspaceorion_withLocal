
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BillPrediction2 extends StatelessWidget {
  BillPrediction2({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff814cbe),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 108.5, start: 0.0),
            Pin(start: 0.0, end: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x14ffffff),
                border: Border.all(width: 1.0, color: const Color(0x14707070)),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 329.9, end: 19.1),
            Pin(size: 244.6, end: 18.1),
            child:
            // Adobe XD layer: 'arrow-left-circle-l…' (group)
            Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 61.8, start: 0.0),
                  Pin(size: 61.8, start: 0.0),
                  child: SvgPicture.string(
                    _svg_lsew89,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 51.5, end: 0.0),
                  Pin(size: 51.5, end: 0.0),
                  child: SvgPicture.string(
                    _svg_vnu4e7,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 96.0, start: 4.0),
            Pin(size: 25.3, start: 7.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 21.0, start: 0.0),
                  child: Text(
                    'Bill Prediction',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 1.4, end: 1.7),
                  Pin(size: 1.0, end: -1.0),
                  child: SvgPicture.string(
                    _svg_qbduur,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 46.0, start: 21.2),
            Pin(size: 21.0, start: 134.5),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 10,
                        color: const Color(0xffffffff),
                      ),
                      children: [
                        TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: 'Graph',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 95.0, start: 6.7),
            Pin(size: 42.0, middle: 0.3661),
            child: Text(
              'Electricity \nConsumption',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 16,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 289.0, end: 12.0),
            Pin(size: 188.0, start: 31.0),
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
                          width: 1.0, color: const Color(0x17707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 162.5, start: 15.5),
                  Pin(size: 138.5, end: 19.7),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 100.0, start: 4.6),
                        Pin(size: 20.0, end: 0.0),
                        child: Text(
                          'Monthly Graph',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 1.0, start: 0.0),
                        Pin(size: 112.7, start: 0.0),
                        child: SvgPicture.string(
                          _svg_kth42g,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.1, end: 0.0),
                        Pin(size: 1.0, middle: 0.7969),
                        child: SvgPicture.string(
                          _svg_pilwap,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 76.3, start: 12.8),
                        Pin(size: 39.0, middle: 0.4594),
                        child: SvgPicture.string(
                          _svg_b66it6,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 103.5, end: 1.1),
                  Pin(size: 82.7, middle: 0.3969),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 29.0, start: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48.0),
                                  color: const Color(0xff6693b7),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xff707070)),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 24.0, middle: 0.4571),
                              Pin(size: 16.0, middle: 0.3406),
                              child: Text(
                                'Start',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 12,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 29.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48.0),
                                  color: const Color(0xff6693b7),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xff707070)),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 22.0, middle: 0.4458),
                              Pin(size: 17.0, middle: 0.369),
                              child: Text(
                                'End',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 13,
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
            Pin(size: 211.8, end: 40.2),
            Pin(size: 30.8, middle: 0.6384),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48.0),
                      color: const Color(0xff5789b0),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 45.0, middle: 0.5367),
                  Pin(size: 21.0, start: 2.7),
                  child: Text(
                    'Pridict',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 96.0, start: 6.7),
            Pin(size: 49.0, middle: 0.606),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 16,
                  color: const Color(0xffffffff),
                ),
                children: [
                  TextSpan(
                    text: 'Bill Prediction\n',
                  ),
                  TextSpan(
                    text: '           ',
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
              textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 186.0, middle: 0.6978),
            Pin(size: 40.0, middle: 0.5999),
            child: Text(
              'Set price per unit ___________\n',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 255.0, end: 33.0),
            Pin(size: 167.0, middle: 0.3939),
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
                          width: 1.0, color: const Color(0x17707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 66.0, start: 19.0),
                  Pin(size: 20.0, start: 24.6),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Text(
                          'Start Date',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 60.0, start: 19.0),
                  Pin(size: 20.0, middle: 0.385),
                  child: Text(
                    'End Date',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 94.0, middle: 0.6553),
                  Pin(size: 1.0, middle: 0.238),
                  child: SvgPicture.string(
                    _svg_tv4brl,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 94.0, middle: 0.6553),
                  Pin(size: 1.0, middle: 0.4367),
                  child: SvgPicture.string(
                    _svg_tve3hr,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 118.1, middle: 0.6826),
                  Pin(size: 33.1, middle: 0.7241),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48.0),
                            color: const Color(0xff5789b0),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 18.3, end: 18.3),
                        Pin(start: 4.3, end: 4.3),
                        child: Text(
                          'Calculate',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                            height: 0.8,
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
    );
  }
}

const String _svg_lsew89 =
    '<svg viewBox="0.0 0.0 61.8 61.8" ><path  d="M 0 0 L 61.7745361328125 0 L 61.7745361328125 61.7745361328125 L 0 61.7745361328125 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vnu4e7 =
    '<svg viewBox="278.4 193.1 51.5 51.5" ><path transform="translate(276.41, 191.15)" d="M 27.73938941955566 2.000000238418579 C 41.94753646850586 2.000000238418579 53.47878265380859 13.53124713897705 53.47878265380859 27.73938941955566 C 53.47878265380859 41.94753646850586 41.94753646850586 53.47878265380859 27.73938941955566 53.47878265380859 C 13.53124713897705 53.47878265380859 2.000000238418579 41.94753646850586 2.000000238418579 27.73938941955566 C 2.000000238418579 13.53124713897705 13.53124713897705 2.000000238418579 27.73938941955566 2.000000238418579 Z M 27.73938941955566 48.33090591430664 C 39.11620330810547 48.33090591430664 48.33090591430664 39.11620330810547 48.33090591430664 27.73938941955566 C 48.33090591430664 16.36257934570312 39.11620330810547 7.147878646850586 27.73938941955566 7.147878646850586 C 16.36257934570312 7.147878646850586 7.147878646850586 16.36257934570312 7.147878646850586 27.73938941955566 C 7.147878646850586 39.11620330810547 16.36257934570312 48.33090591430664 27.73938941955566 48.33090591430664 Z M 27.73938941955566 25.16545104980469 L 38.03514862060547 25.16545104980469 L 38.03514862060547 30.31332969665527 L 27.73938941955566 30.31332969665527 L 27.73938941955566 38.03514862060547 L 17.44363403320312 27.73938941955566 L 27.73938941955566 17.44363403320312 L 27.73938941955566 25.16545104980469 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qbduur =
    '<svg viewBox="-2.0 21.2 92.9 1.0" ><path transform="translate(-2.0, 21.15)" d="M 0 0 L 92.93479156494141 0" fill="none" stroke="#ffffff" stroke-width="3" stroke-miterlimit="4" stroke-linecap="square" /></svg>';
const String _svg_kth42g =
    '<svg viewBox="0.0 0.0 1.0 112.7" ><path transform="translate(-0.01, 0.0)" d="M 0.0078125 0 L 0 112.6943969726562" fill="none" stroke="#000000" stroke-width="8" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pilwap =
    '<svg viewBox="0.1 109.6 162.4 1.0" ><path transform="translate(0.11, 109.56)" d="M 162.4055023193359 0 L 0 0" fill="none" stroke="#000000" stroke-width="8" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_b66it6 =
    '<svg viewBox="12.8 45.7 76.3 39.0" ><path transform="translate(693.51, -2415.84)" d="M -680.73876953125 2487.74072265625 L -677.244140625 2461.53076171875 L -658.0235595703125 2481.333984375 L -642.8800048828125 2461.53076171875 L -625.40673828125 2500.554443359375 L -604.4388427734375 2461.53076171875" fill="none" stroke="#ffffff" stroke-width="3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tv4brl =
    '<svg viewBox="231.5 338.5 94.0 1.0" ><path transform="translate(231.5, 338.5)" d="M 0 0 L 94 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tve3hr =
    '<svg viewBox="231.5 371.5 94.0 1.0" ><path transform="translate(231.5, 371.5)" d="M 0 0 L 94 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';