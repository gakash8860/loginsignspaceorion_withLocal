import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'bill_estimation.dart';

// final DatabaseReference _database =
//     FirebaseDatabase().reference().child('data/2020');

class TotalUsage extends StatefulWidget {
  var totalEnergy;
  var chooseValueMinute;
  double totalAmountInRs;
  Map<String ,double> deviceId;
  static const routeName = '/total-usage';
  TotalUsage({
    this.deviceId,
    this.totalEnergy,
    this.totalAmountInRs,
    this.chooseValueMinute,
});
  @override
  _TotalUsageState createState() => _TotalUsageState();
}

class _TotalUsageState extends State<TotalUsage> {

  var _totalDays = 0;
  var _totalTime = 0;
  var _totalAmount = 0.0;
  var _totalPower = 0.0;
  var _monthlyPower = 0.0;
  var _timeString='14:12';
  var _isLoading = false;
  var _chartType = true;
  Map<String, double> _monthMap = {};


  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration >= Duration(seconds: 3600)) {
      return "${twoDigits(duration.inHours)} hour & $twoDigitMinutes minute";
    } else if (duration >= Duration(seconds: 60)) {
      return "$twoDigitMinutes minute & $twoDigitSeconds second";
    } else {
      return "$twoDigitSeconds seconds";
    }
  }

  // void _getTotal() async {
  //   _isLoading = true;
  //   _totalDays = 0;
  //   _totalTime = 0;
  //   _totalAmount = 0.0;
  //   _totalPower = 0.0;
  //
  //   DataSnapshot snapshot = await _database.once();
  //   var data = snapshot.value as Map<dynamic, dynamic>;
  //
  //   data.forEach((month, dates) {
  //     var date = dates as Map<dynamic, dynamic>;
  //     date.forEach((date, values) {
  //       _totalDays = _totalDays + 1;
  //       _totalAmount = _totalAmount + values['amount'];
  //       _totalTime = _totalTime + values['time'];
  //       _totalPower = _totalPower + values['power'];
  //       _monthlyPower = _monthlyPower + values['power'];
  //     });
  //     _monthMap.addAll({monthName(month): _monthlyPower});
  //     _monthlyPower = 0.0;
  //   });
  //   _timeString = _printDuration(Duration(seconds: _totalTime));
  //   _monthMap.updateAll((key, value) {
  //     return double.parse(((value / _totalPower) * 100).toStringAsFixed(2));
  //   });
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  String monthName(var number) {
    String name = 'default';
    switch (number) {
      case '01':
        name = 'January';
        break;
      case '02':
        name = 'February';
        break;
      case '03':
        name = 'March';
        break;
      case '04':
        name = 'April';
        break;
      case '05':
        name = 'May';
        break;
      case '06':
        name = 'June';
        break;
      case '07':
        name = 'july';
        break;
      case '08':
        name = 'August';
        break;
      case '09':
        name = 'September';
        break;
      case '10':
        name = 'October';
        break;
      case '11':
        name = 'November';
        break;
      case '12':
        name = 'December';
        break;
    }
    return name;
  }


  Widget createCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            children: <TextSpan>[
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // _getTotal();
    super.initState();
    dataMap=widget.deviceId;
    print('datamap $dataMap');
  }
  Map<String, double> dataMap;
  // Map<String, double> dataMap = {
  //   "Bedroom": 5,
  //   "Kitchen": 3,
  //   "Living Room": 2,
  //   "Bathroom": 2,
  // };
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Total Usage'),
            ),
            body:  LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  if(viewportConstraints.maxWidth>600){
                    return _isLoading? Center(child: SpinKitCircle(size: 60, color: Colors.lightBlue),)
                        : Container(
                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Power Usage Chart Month Wise',
                                style: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  _chartType=!_chartType;
                                });
                              },
                              child: PieChart(
                                  dataMap: dataMap,
                                  chartRadius: MediaQuery.of(context).size.width / 5,
                                  animationDuration: Duration(milliseconds: 2200),
                                  chartType:ChartType.disc
                                // _chartType ? ChartType.disc : ChartType.ring,
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                createCard('📆 Total Days : ', '$_totalDays days'),
                                createCard('📊 Total Power : ',
                                    '${_totalPower.toStringAsFixed(2)} Kwh'),
                                createCard('⏰  Total Time : ', _timeString),
                                createCard('💰 Total Amount :  ',
                                    '${_totalAmount.toStringAsFixed(3)} ₹'),
                              ],
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Container(
                            //   child: Center(
                            //     child: RaisedButton(
                            //       color: Colors.lightBlue,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(6.0)),
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 12, horizontal: 60),
                            //         child: Text(
                            //           'Bill Estimation',
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 18.0,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         Navigator.of(context)
                            //             .pushReplacementNamed(BillEstimation.routeName);
                            //       },
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }else{
                    return _isLoading ? Center(
                      child: SpinKitCircle(size: 60, color: Colors.lightBlue),
                    )
                        : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Power Usage Chart Month Wise',
                                style: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 8,
                              margin:
                              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    _chartType=!_chartType;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: PieChart(

                                      dataMap: dataMap,
                                      animationDuration: Duration(milliseconds: 2200),
                                      chartType:ChartType.disc
                                    // _chartType ? ChartType.disc : ChartType.ring,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                createCard('📆 Total Days : ', '$_totalDays days'),
                                createCard('📊 Total Power : ',
                                    '${widget.totalEnergy} Kwh'),
                                createCard('⏰  Total Time : ', widget.chooseValueMinute),
                                createCard('💰 Total Amount : ',
                                    '${_totalAmount.toStringAsFixed(3)} ₹'),
                                // createCard('⏰  Based On : ', widget.chooseValueMinute),
                                // createCard('⏰  Based On : ', widget.totalEnergy),
                              ],
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Container(
                            //   child: Center(
                            //     child: RaisedButton(
                            //       color: Colors.lightBlue,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(6.0)),
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 12, horizontal: 60),
                            //         child: Text(
                            //           'Bill Estimation',
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 18.0,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         Navigator.of(context)
                            //             .pushReplacementNamed(BillEstimation.routeName);
                            //       },
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
            )

        );
      }else{
        return Scaffold(
            appBar: AppBar(
              title: Text('Total Usage'),
            ),
            body:  LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  if(viewportConstraints.maxWidth>600){
                    return _isLoading? Center(child: SpinKitCircle(size: 60, color: Colors.lightBlue),)
                        : Container(
                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Power Usage Chart Month Wise',
                                style: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  _chartType=!_chartType;
                                });
                              },
                              child: PieChart(
                                  dataMap: dataMap,
                                  chartRadius: MediaQuery.of(context).size.width / 3,
                                  animationDuration: Duration(milliseconds: 2200),
                                  chartType:ChartType.disc
                                // _chartType ? ChartType.disc : ChartType.ring,
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                createCard('📆 Total Days : ', '$_totalDays days'),
                                createCard('📊 Total Power : ',
                                    '${_totalPower.toStringAsFixed(2)} Kwh'),
                                createCard('⏰  Total Time : ', _timeString),
                                createCard('💰 Total Amount :  ',
                                    '${_totalAmount.toStringAsFixed(3)} ₹'),
                              ],
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Container(
                            //   child: Center(
                            //     child: RaisedButton(
                            //       color: Colors.lightBlue,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(6.0)),
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 12, horizontal: 60),
                            //         child: Text(
                            //           'Bill Estimation',
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 18.0,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         Navigator.of(context)
                            //             .pushReplacementNamed(BillEstimation.routeName);
                            //       },
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }else{
                    return _isLoading ? Center(
                      child: SpinKitCircle(size: 60, color: Colors.lightBlue),
                    )
                        : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Power Usage Chart Month Wise',
                                style: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 8,
                              margin:
                              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    _chartType=!_chartType;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: PieChart(

                                      dataMap: dataMap,
                                      animationDuration: Duration(milliseconds: 2200),
                                      chartType:ChartType.disc
                                    // _chartType ? ChartType.disc : ChartType.ring,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                createCard('📆 Total Days : ', '$_totalDays days'),
                                createCard('📊 Total Power : ',
                                    '${widget.totalEnergy} Kwh'),
                                createCard('⏰  Total Time : ', widget.chooseValueMinute),
                                createCard('💰 Total Amount : ',
                                    '${widget.totalAmountInRs.toStringAsFixed(3)} ₹'),
                                // createCard('⏰  Based On : ', widget.chooseValueMinute),
                                // createCard('⏰  Based On : ', widget.totalEnergy),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Container(
                            //   child: Center(
                            //     child: RaisedButton(
                            //       color: Colors.lightBlue,
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(6.0)),
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 12, horizontal: 60),
                            //         child: Text(
                            //           'Bill Estimation',
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 18.0,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         Navigator.of(context)
                            //             .pushReplacementNamed(BillEstimation.routeName);
                            //       },
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
            )

        );
      }
        }
        );
  }
}
