import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings2 extends StatelessWidget {
  Settings2({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff083b63),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 1868.0, middle: 0.0),
            Pin(start: 0.0, end: 0.0),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 1868.0,
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
                              Pin(size: 389.0, start: 32.0),
                              Pin(size: 67.0, middle: 0.4343),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Text(
                                      'Change Password',
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
                              Pin(size: 1302.0, end: 0.0),
                              Pin(size: 699.0, middle: 0.4694),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(137.0),
                                        color: const Color(0x6e1a4d75),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 92.9, end: 77.0),
                                    Pin(size: 104.0, start: 76.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 737.6, end: 0.0),
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
                                          Pin(size: 325.0, start: 0.0),
                                          Pin(size: 53.0, middle: 0.5),
                                          child: Text(
                                            'Previous Password',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 40,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 92.9, end: 77.0),
                                    Pin(size: 104.0, middle: 0.3983),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 737.6, end: 0.0),
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
                                          Pin(size: 256.0, start: 0.0),
                                          Pin(size: 53.0, middle: 0.5),
                                          child: Text(
                                            'New Password',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 40,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 92.9, end: 77.4),
                                    Pin(size: 104.0, middle: 0.6689),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 737.6, end: 0.0),
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
                                          Pin(size: 318.0, start: 0.0),
                                          Pin(size: 53.0, middle: 0.5),
                                          child: Text(
                                            'Confirm Password',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 40,
                                              color: const Color(0xffffffff),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 491.0, middle: 0.7534),
                                    Pin(size: 104.0, end: 36.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(46.0),
                                        color: const Color(0xff1c448a),
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xff707070)),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 156.0, middle: 0.6798),
                                    Pin(size: 67.0, end: 54.0),
                                    child: Text(
                                      'Submit',
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
                            Pinned.fromPins(
                              Pin(size: 148.0, start: 132.0),
                              Pin(size: 67.0, start: 388.5),
                              child: Text(
                                'Users  ',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 50,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 1065.0, end: 178.0),
                              Pin(size: 501.0, start: 171.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(137.0),
                                        color: const Color(0x6e1b4e76),
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0x6e707070)),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 1.0, middle: 0.6396),
                                    Pin(size: 1.0, middle: 0.281),
                                    child: SvgPicture.string(
                                      _svg_wdpjmn,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 622.0, middle: 0.5011),
                                    Pin(size: 387.0, start: 34.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 281.0, end: 0.0),
                                          Pin(size: 70.0, start: 0.0),
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
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            55.0),
                                                                color: const Color(
                                                                    0xffffffff),
                                                                border: Border.all(
                                                                    width: 1.0,
                                                                    color: const Color(
                                                                        0xff707070)),
                                                              ),
                                                            ),
                                                          ),
                                                          Pinned.fromPins(
                                                            Pin(
                                                                size: 45.4,
                                                                start: 26.9),
                                                            Pin(
                                                                size: 36.0,
                                                                middle: 0.4991),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  child: Stack(
                                                                    children: <
                                                                        Widget>[
                                                                      Pinned
                                                                          .fromPins(
                                                                        Pin(
                                                                            size:
                                                                                1.0,
                                                                            middle:
                                                                                0.5113),
                                                                        Pin(
                                                                            start:
                                                                                0.0,
                                                                            end:
                                                                                0.0),
                                                                        child: SvgPicture
                                                                            .string(
                                                                          _svg_optzbw,
                                                                          allowDrawingOutsideViewBox:
                                                                              true,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                      Pinned
                                                                          .fromPins(
                                                                        Pin(
                                                                            start:
                                                                                0.0,
                                                                            end:
                                                                                0.0),
                                                                        Pin(
                                                                            size:
                                                                                1.0,
                                                                            middle:
                                                                                0.5143),
                                                                        child: SvgPicture
                                                                            .string(
                                                                          _svg_jsvmpa,
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
                                                Pin(size: 112.0, middle: 0.497),
                                                Pin(start: 8.5, end: 8.5),
                                                child: Text(
                                                  'User 1',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 40,
                                                    color:
                                                        const Color(0xff1d5077),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 281.0, end: 0.0),
                                          Pin(size: 70.0, middle: 0.3344),
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
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            55.0),
                                                                color: const Color(
                                                                    0xffffffff),
                                                                border: Border.all(
                                                                    width: 1.0,
                                                                    color: const Color(
                                                                        0xff707070)),
                                                              ),
                                                            ),
                                                          ),
                                                          Pinned.fromPins(
                                                            Pin(
                                                                size: 45.4,
                                                                start: 26.9),
                                                            Pin(
                                                                size: 36.0,
                                                                middle: 0.4991),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  child: Stack(
                                                                    children: <
                                                                        Widget>[
                                                                      Pinned
                                                                          .fromPins(
                                                                        Pin(
                                                                            size:
                                                                                1.0,
                                                                            middle:
                                                                                0.5113),
                                                                        Pin(
                                                                            start:
                                                                                0.0,
                                                                            end:
                                                                                0.0),
                                                                        child: SvgPicture
                                                                            .string(
                                                                          _svg_optzbw,
                                                                          allowDrawingOutsideViewBox:
                                                                              true,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                      Pinned
                                                                          .fromPins(
                                                                        Pin(
                                                                            start:
                                                                                0.0,
                                                                            end:
                                                                                0.0),
                                                                        Pin(
                                                                            size:
                                                                                1.0,
                                                                            middle:
                                                                                0.5143),
                                                                        child: SvgPicture
                                                                            .string(
                                                                          _svg_jsvmpa,
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
                                                Pin(size: 112.0, middle: 0.497),
                                                Pin(start: 8.5, end: 8.5),
                                                child: Text(
                                                  'User 2',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 40,
                                                    color:
                                                        const Color(0xff1d5077),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 281.0, end: 0.0),
                                          Pin(size: 70.0, middle: 0.6656),
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
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            55.0),
                                                                color: const Color(
                                                                    0xffffffff),
                                                                border: Border.all(
                                                                    width: 1.0,
                                                                    color: const Color(
                                                                        0xff707070)),
                                                              ),
                                                            ),
                                                          ),
                                                          Pinned.fromPins(
                                                            Pin(
                                                                size: 45.4,
                                                                start: 26.9),
                                                            Pin(
                                                                size: 36.0,
                                                                middle: 0.4991),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  child: Stack(
                                                                    children: <
                                                                        Widget>[
                                                                      Pinned
                                                                          .fromPins(
                                                                        Pin(
                                                                            size:
                                                                                1.0,
                                                                            middle:
                                                                                0.5113),
                                                                        Pin(
                                                                            start:
                                                                                0.0,
                                                                            end:
                                                                                0.0),
                                                                        child: SvgPicture
                                                                            .string(
                                                                          _svg_optzbw,
                                                                          allowDrawingOutsideViewBox:
                                                                              true,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                      Pinned
                                                                          .fromPins(
                                                                        Pin(
                                                                            start:
                                                                                0.0,
                                                                            end:
                                                                                0.0),
                                                                        Pin(
                                                                            size:
                                                                                1.0,
                                                                            middle:
                                                                                0.5143),
                                                                        child: SvgPicture
                                                                            .string(
                                                                          _svg_jsvmpa,
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
                                                Pin(size: 112.0, middle: 0.497),
                                                Pin(start: 8.5, end: 8.5),
                                                child: Text(
                                                  'User 3',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 40,
                                                    color:
                                                        const Color(0xff1d5077),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 281.0, end: 0.0),
                                          Pin(size: 70.0, end: 0.0),
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
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff707070)),
                                                        ),
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 49.0,
                                                          start: 25.0),
                                                      Pin(
                                                          start: 10.0,
                                                          end: 10.0),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Pinned.fromPins(
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            Pin(
                                                                start: 0.0,
                                                                end: 0.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.elliptical(
                                                                        9999.0,
                                                                        9999.0)),
                                                                color: const Color(
                                                                    0xff3d7097),
                                                                border: Border.all(
                                                                    width: 5.0,
                                                                    color: const Color(
                                                                        0xffffffff)),
                                                              ),
                                                            ),
                                                          ),
                                                          Pinned.fromPins(
                                                            Pin(
                                                                start: 1.9,
                                                                end: 1.7),
                                                            Pin(
                                                                start: 6.9,
                                                                end: 7.0),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Pinned.fromPins(
                                                                  Pin(
                                                                      size: 1.0,
                                                                      middle:
                                                                          0.5113),
                                                                  Pin(
                                                                      start:
                                                                          0.0,
                                                                      end: 0.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    _svg_optzbw,
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
                                                                          0.5143),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    _svg_jsvmpa,
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
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 121.0,
                                                          middle: 0.5759),
                                                      Pin(
                                                          size: 35.0,
                                                          middle: 0.4891),
                                                      child: Text(
                                                        'ADD USER',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Segoe UI',
                                                          fontSize: 26,
                                                          color: const Color(
                                                              0xff44779e),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 192.0, start: 0.0),
                                          Pin(size: 240.0, start: 0.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 6.0, end: 0.0),
                                                Pin(size: 67.0, end: 0.0),
                                                child: Text(
                                                  'Admin   ',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 50,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Pinned.fromPins(
                                                Pin(size: 159.0, start: 0.0),
                                                Pin(size: 159.0, start: 0.0),
                                                child:
                                                    // Adobe XD layer: 'ankit' (shape)
                                                    Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.elliptical(
                                                                9999.0,
                                                                9999.0)),
                                                    image: DecorationImage(
                                                      image:
                                                          const AssetImage(''),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    border: Border.all(
                                                        width: 2.0,
                                                        color: const Color(
                                                            0xff083b63)),
                                                  ),
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
                              Pin(size: 420.0, start: 0.5),
                              Pin(size: 110.6, start: 26.9),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(size: 249.0, start: 56.5),
                                    Pin(size: 94.0, start: 0.0),
                                    child: Text(
                                      'Settings',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 70,
                                        color: const Color(0xffffffff),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(size: 1.0, end: -0.5),
                                    child: SvgPicture.string(
                                      _svg_byc7,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 124.8, end: 0.0),
                              Pin(size: 124.8, end: 24.7),
                              child:
                                  // Adobe XD layer: 'arrow-left-circle-f…' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: SvgPicture.string(
                                      _svg_bcyl,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(start: 10.4, end: 10.4),
                                    Pin(start: 10.4, end: 10.4),
                                    child: SvgPicture.string(
                                      _svg_ydn8x,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 27.0, end: 0.0),
                              Pin(size: 553.0, end: 217.0),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 321.0, start: 0.0),
                                          Pin(size: 134.0, middle: 0.3532),
                                          child: Stack(
                                            children: <Widget>[
                                              Pinned.fromPins(
                                                Pin(start: 0.0, end: 0.0),
                                                Pin(start: 0.0, end: 0.0),
                                                child: Text(
                                                  'Enter network \ncredentials',
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
                                          Pin(start: 539.0, end: 0.0),
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
                                                            137.0),
                                                    color:
                                                        const Color(0x6e1a4d75),
                                                  ),
                                                ),
                                              ),
                                              Pinned.fromPins(
                                                Pin(start: 92.9, end: 77.0),
                                                Pin(size: 104.0, start: 76.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 737.6,
                                                          end: 0.0),
                                                      Pin(start: 0.0, end: 0.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      52.0),
                                                          color: const Color(
                                                              0xffffffff),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff707070)),
                                                        ),
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 245.0,
                                                          start: 0.0),
                                                      Pin(
                                                          size: 53.0,
                                                          middle: 0.5),
                                                      child: Text(
                                                        'Device Name ',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Segoe UI',
                                                          fontSize: 40,
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Pinned.fromPins(
                                                Pin(start: 92.9, end: 77.4),
                                                Pin(
                                                    size: 104.0,
                                                    middle: 0.5278),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 737.6,
                                                          end: 0.0),
                                                      Pin(start: 0.0, end: 0.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      52.0),
                                                          color: const Color(
                                                              0xffffffff),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xff707070)),
                                                        ),
                                                      ),
                                                    ),
                                                    Pinned.fromPins(
                                                      Pin(
                                                          size: 167.0,
                                                          start: 0.0),
                                                      Pin(
                                                          size: 53.0,
                                                          middle: 0.5),
                                                      child: Text(
                                                        'Device ID',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Segoe UI',
                                                          fontSize: 40,
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
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
                                    Pin(size: 491.0, end: 200.0),
                                    Pin(size: 104.0, end: 50.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(46.0),
                                        color: const Color(0xff1c448a),
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xff707070)),
                                      ),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 156.0, middle: 0.7834),
                                    Pin(size: 67.0, end: 68.0),
                                    child: Text(
                                      'Submit',
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

const String _svg_optzbw =
    '<svg viewBox="22.7 0.0 1.0 36.0" ><path transform="translate(22.72, 0.0)" d="M 0 0 L 0 36.0432243347168" fill="none" stroke="#ffffff" stroke-width="6" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_jsvmpa =
    '<svg viewBox="0.0 18.0 45.4 1.0" ><path transform="matrix(0.0, 1.0, -1.0, 0.0, 45.43, 18.02)" d="M 8.881784197001252e-16 0 L 0 45.43389511108398" fill="none" stroke="#ffffff" stroke-width="6" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_wdpjmn =
    '<svg viewBox="1022.5 282.5 1.0 1.0" ><path transform="translate(243.5, 282.5)" d="M 779 0" fill="none" stroke="#ffffff" stroke-width="5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_byc7 =
    '<svg viewBox="0.5 137.0 420.0 1.0" ><path transform="translate(0.5, 137.0)" d="M 0 0 L 420 0.5" fill="none" stroke="#ffffff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bcyl =
    '<svg viewBox="0.0 0.0 124.8 124.8" ><path  d="M 0 0 L 124.778564453125 0 L 124.778564453125 124.778564453125 L 0 124.778564453125 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ydn8x =
    '<svg viewBox="10.4 10.4 104.0 104.0" ><path transform="translate(8.4, 8.4)" d="M 53.99106597900391 2 C 82.69014739990234 2 105.9821395874023 25.2919979095459 105.9821395874023 53.99106597900391 C 105.9821395874023 82.69014739990234 82.69014739990234 105.9821395874023 53.99106597900391 105.9821395874023 C 25.29199600219727 105.9821395874023 2 82.69014739990234 2 53.99106597900391 C 2 25.29199600219727 25.2919979095459 2 53.99106597900391 2 Z M 53.99106597900391 48.79196166992188 L 53.99106597900391 33.19464111328125 L 33.19464111328125 53.99106597900391 L 53.99106597900391 74.78749847412109 L 53.99106597900391 59.1901741027832 L 74.78749847412109 59.1901741027832 L 74.78749847412109 48.79196166992188 L 53.99106597900391 48.79196166992188 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
