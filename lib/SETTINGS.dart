import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main()=>runApp(MaterialApp(
  home: SETTINGS(),
));


class SETTINGS extends StatelessWidget {
  SETTINGS({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff814cbe),
      body: Stack(
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
                Pinned.fromPins(
                  Pin(start: 34.0, end: 0.0),
                  Pin(size: 181.0, middle: 0.4215),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 101.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38.0),
                            color: const Color(0x6e1b4e76),
                            border: Border.all(
                                width: 1.0, color: const Color(0x6e707070)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 74.0, start: 0.0),
                        Pin(size: 48.0, middle: 0.3684),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                'Change \nPassword',
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
                        Pin(size: 94.1, end: 34.7),
                        Pin(size: 25.9, end: 14.8),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52.0),
                                  color: const Color(0xff8b3c7e),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 50.0, middle: 0.4936),
                              Pin(start: 1.8, end: 3.2),
                              child: Text(
                                'Submit',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 262.7, end: 13.2),
                  Pin(size: 106.6, middle: 0.4113),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 137.1, end: 0.0),
                        Pin(size: 25.9, start: 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(52.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 137.1, end: 0.0),
                        Pin(size: 25.9, middle: 0.5019),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(52.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xff707070)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 137.1, end: 0.0),
                        Pin(size: 25.9, end: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(52.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xff707070)),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 90.0, start: 0.0),
                        Pin(size: 20.0, start: 0.0),
                        child: Text(
                          'Old Password',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 90.0, start: 0.0),
                        Pin(size: 19.0, middle: 0.4623),
                        child: Text(
                          'New Password',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 111.0, start: 0.0),
                        Pin(size: 19.0, end: 8.4),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 29.0, end: 0.0),
                  Pin(size: 102.0, middle: 0.6468),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 86.0, start: 0.0),
                        Pin(size: 72.0, start: 14.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                'Enter \nnetwork \ncredentials',
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
                        Pin(start: 106.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: const Color(0x6e1a4d75),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 8.7, end: 9.6),
                              Pin(size: 24.5, middle: 0.2311),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(size: 173.6, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(52.0),
                                        color: const Color(0xffffffff),
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xff707070)),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 98.0, start: 0.0),
                                    Pin(start: 0.0, end: 3.5),
                                    child: Text(
                                      'Device Name ',
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
                              Pin(start: 10.9, end: 9.6),
                              Pin(size: 24.5, middle: 0.7197),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(size: 173.6, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(52.0),
                                        color: const Color(0xffffffff),
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xff707070)),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 67.0, start: 0.0),
                                    Pin(start: 0.0, end: 3.5),
                                    child: Text(
                                      'Device ID',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 37.3, end: 1.0),
                  Pin(size: 189.0, start: 86.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 53.0, start: 0.0),
                        Pin(size: 24.0, middle: 0.5121),
                        child: Text(
                          'Users  ',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 96.7, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(38.0),
                                  color: const Color(0x6e1b4e76),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0x6e707070)),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 1.0, middle: 0.5952),
                              Pin(size: 1.0, middle: 0.2826),
                              child: SvgPicture.string(
                                _svg_s6foev,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 38.0, end: 42.0),
                              Pin(start: 11.0, end: 8.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(size: 104.0, end: 0.0),
                                    Pin(size: 26.0, start: 0.0),
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
                                                child: Stack(
                                                  children: <Widget>[
                                                    Pinned.fromPins(
                                                      Pin(start: 0.0, end: 0.0),
                                                      Pin(start: 0.0, end: 0.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      55.0),
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 16.9,
                                                          start: 9.5),
                                                      Pin(
                                                          size: 13.4,
                                                          middle: 0.5062),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Pinned.fromPins(
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      size: 1.0,
                                                                      middle:
                                                                          0.5315),
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    _svg_gh70u,
                                                                    allowDrawingOutsideViewBox:
                                                                        true,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  Pin(
                                                                      size: 1.0,
                                                                      middle:
                                                                          0.5404),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    _svg_qhh2x,
                                                                    allowDrawingOutsideViewBox:
                                                                        true,
                                                                    fit: BoxFit
                                                                        .fill,
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
                                            ],
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 36.0, middle: 0.4517),
                                          Pin(size: 17.0, start: 3.3),
                                          child: Text(
                                            'User 1',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 13,
                                              color: const Color(0xff1d5077),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 104.0, end: 0.0),
                                    Pin(size: 26.0, middle: 0.3333),
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
                                                child: Stack(
                                                  children: <Widget>[
                                                    Pinned.fromPins(
                                                      Pin(start: 0.0, end: 0.0),
                                                      Pin(start: 0.0, end: 0.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      55.0),
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 16.9,
                                                          start: 9.5),
                                                      Pin(
                                                          size: 13.4,
                                                          middle: 0.5342),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Pinned.fromPins(
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      size: 1.0,
                                                                      middle:
                                                                          0.5315),
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    _svg_gh70u,
                                                                    allowDrawingOutsideViewBox:
                                                                        true,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  Pin(
                                                                      size: 1.0,
                                                                      middle:
                                                                          0.5404),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    _svg_qhh2x,
                                                                    allowDrawingOutsideViewBox:
                                                                        true,
                                                                    fit: BoxFit
                                                                        .fill,
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
                                            ],
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 36.0, middle: 0.4517),
                                          Pin(size: 17.0, start: 3.6),
                                          child: Text(
                                            'User 2',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 13,
                                              color: const Color(0xff1d5077),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 104.0, end: 0.0),
                                    Pin(size: 25.0, middle: 0.6621),
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
                                                child: Stack(
                                                  children: <Widget>[
                                                    Pinned.fromPins(
                                                      Pin(start: 0.0, end: 0.0),
                                                      Pin(start: 0.0, end: 0.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      55.0),
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 16.9,
                                                          start: 9.5),
                                                      Pin(
                                                          size: 13.4,
                                                          middle: 0.5865),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Pinned.fromPins(
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      size: 1.0,
                                                                      middle:
                                                                          0.5315),
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    _svg_gh70u,
                                                                    allowDrawingOutsideViewBox:
                                                                        true,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  Pin(
                                                                      size: 1.0,
                                                                      middle:
                                                                          0.5404),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    _svg_qhh2x,
                                                                    allowDrawingOutsideViewBox:
                                                                        true,
                                                                    fit: BoxFit
                                                                        .fill,
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
                                            ],
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 36.0, middle: 0.4517),
                                          Pin(size: 17.0, start: 3.7),
                                          child: Text(
                                            'User 3',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 13,
                                              color: const Color(0xff1d5077),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 104.0, end: 0.0),
                                    Pin(size: 25.0, end: 0.0),
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
                                                        BorderRadius.circular(
                                                            55.0),
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                              Pinned.fromPins(
                                                Pin(size: 18.0, start: 9.0),
                                                Pin(start: 3.0, end: 3.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Pinned.fromPins(
                                                      Pin(start: 0.0, end: 0.0),
                                                      Pin(start: 0.0, end: 0.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.elliptical(
                                                                      9999.0,
                                                                      9999.0)),
                                                          color: const Color(
                                                              0xff3d7097),
                                                        ),
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(start: 0.5, end: 0.6),
                                                      Pin(size: 13.4, end: 2.3),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Pinned.fromPins(
                                                            Pin(
                                                                size: 1.0,
                                                                middle: 0.5315),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child: SvgPicture
                                                                .string(
                                                              _svg_gh70u,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          Pinned.fromPins(
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            Pin(
                                                                size: 1.0,
                                                                middle: 0.5404),
                                                            child: SvgPicture
                                                                .string(
                                                              _svg_qhh2x,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Pinned.fromPins(
                                                Pin(size: 60.0, end: 13.8),
                                                Pin(size: 17.0, start: 3.4),
                                                child: Text(
                                                  'ADD USER',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 13,
                                                    color:
                                                        const Color(0xff44779e),
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
                                    Pin(size: 62.0, start: 0.0),
                                    Pin(size: 85.0, start: 0.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 2.0, end: 0.0),
                                          Pin(size: 21.0, end: 0.0),
                                          child: Text(
                                            'Admin   ',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 16,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 2.0),
                                          Pin(size: 60.0, start: 0.0),
                                          child:
                                              // Adobe XD layer: 'ankit' (shape)
                                              Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.elliptical(
                                                      9999.0, 9999.0)),
                                              image: DecorationImage(
                                                image: const AssetImage(''),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 10.4, middle: 0.5549),
                              Pin(size: 12.0, end: 14.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(size: 1.0, middle: 0.5355),
                                    child: SvgPicture.string(
                                      _svg_wl9bhy,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 1.0, middle: 0.5854),
                                    Pin(start: 0.0, end: 0.0),
                                    child: SvgPicture.string(
                                      _svg_nlc2x6,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
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
                  Pin(size: 100.0, start: 24.0),
                  Pin(size: 35.0, start: 10.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 26,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 84.0, start: 21.5),
                  Pin(size: 1.0, start: 48.5),
                  child: SvgPicture.string(
                    _svg_l3ndwd,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 281.0, start: 34.0),
                  Pin(size: 83.0, middle: 0.7995),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 62.0, start: 0.0),
                              Pin(size: 24.0, middle: 0.5085),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Text(
                                      'Themes',
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
                              Pin(size: 177.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: const Color(0x6e1a4d75),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 96.6, middle: 0.4938),
                                    Pin(size: 24.5, end: 10.3),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(start: 0.0, end: 0.0),
                                          Pin(start: 0.0, end: 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(52.0),
                                              color: const Color(0xffffffff),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color:
                                                      const Color(0xff707070)),
                                            ),
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 33.0, middle: 0.4956),
                                          Pin(start: 0.0, end: 3.5),
                                          child: Text(
                                            'Dark',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 16,
                                              color: const Color(0xff972a39),
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
                        Pin(size: 96.6, end: 40.7),
                        Pin(size: 24.7, start: 10.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.3, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52.0),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xff707070)),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 35.0, middle: 0.5081),
                              Pin(size: 21.0, start: 0.0),
                              child: Text(
                                'Light',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                  color: const Color(0xff972a39),
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
                  Pin(size: 330.9, end: 13.2),
                  Pin(size: 61.8, end: 17.9),
                  child:
                      // Adobe XD layer: 'arrow-left-circle-l…' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 61.8, start: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: SvgPicture.string(
                          _svg_lsew89,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 51.5, end: 0.0),
                        Pin(start: 5.1, end: 5.1),
                        child: SvgPicture.string(
                          _svg_rhoh35,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
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

const String _svg_gh70u =
    '<svg viewBox="8.4 0.0 1.0 13.4" ><path transform="translate(8.43, 0.0)" d="M 0 0 L 0 13.36848068237305" fill="none" stroke="none" stroke-width="6" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_qhh2x =
    '<svg viewBox="0.0 6.7 16.9 1.0" ><path transform="matrix(0.0, 1.0, -1.0, 0.0, 16.85, 6.68)" d="M 0 0 L 0 16.85149383544922" fill="none" stroke="none" stroke-width="6" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_s6foev =
    '<svg viewBox="287.2 139.1 1.0 1.0" ><path transform="translate(-491.78, 139.13)" d="M 779 0" fill="none" stroke="#ffffff" stroke-width="5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wl9bhy =
    '<svg viewBox="291.5 177.9 10.4 1.0" ><path transform="translate(291.5, 177.89)" d="M 0 0 L 10.39559745788574 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_nlc2x6 =
    '<svg viewBox="297.0 172.0 1.0 12.0" ><path transform="translate(297.0, 172.0)" d="M 0 0 L 0 12" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_l3ndwd =
    '<svg viewBox="4.5 48.5 84.0 1.0" ><path transform="translate(4.5, 48.5)" d="M 0 0 L 84 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lsew89 =
    '<svg viewBox="0.0 0.0 61.8 61.8" ><path  d="M 0 0 L 61.7745361328125 0 L 61.7745361328125 61.7745361328125 L 0 61.7745361328125 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rhoh35 =
    '<svg viewBox="279.4 5.1 51.5 51.5" ><path transform="translate(277.41, 3.15)" d="M 27.73938941955566 2.000000238418579 C 41.94753646850586 2.000000238418579 53.47878265380859 13.53124713897705 53.47878265380859 27.73938941955566 C 53.47878265380859 41.94753646850586 41.94753646850586 53.47878265380859 27.73938941955566 53.47878265380859 C 13.53124713897705 53.47878265380859 2.000000238418579 41.94753646850586 2.000000238418579 27.73938941955566 C 2.000000238418579 13.53124713897705 13.53124713897705 2.000000238418579 27.73938941955566 2.000000238418579 Z M 27.73938941955566 48.33090591430664 C 39.11620330810547 48.33090591430664 48.33090591430664 39.11620330810547 48.33090591430664 27.73938941955566 C 48.33090591430664 16.36257934570312 39.11620330810547 7.147878646850586 27.73938941955566 7.147878646850586 C 16.36257934570312 7.147878646850586 7.147878646850586 16.36257934570312 7.147878646850586 27.73938941955566 C 7.147878646850586 39.11620330810547 16.36257934570312 48.33090591430664 27.73938941955566 48.33090591430664 Z M 27.73938941955566 25.16545104980469 L 38.03514862060547 25.16545104980469 L 38.03514862060547 30.31332969665527 L 27.73938941955566 30.31332969665527 L 27.73938941955566 38.03514862060547 L 17.44363403320312 27.73938941955566 L 27.73938941955566 17.44363403320312 L 27.73938941955566 25.16545104980469 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
