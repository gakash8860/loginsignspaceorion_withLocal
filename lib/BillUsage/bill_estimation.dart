import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginsignspaceorion/BillUsage/total_usage.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import '../main.dart';


void  main()=>runApp(MaterialApp(
  home: BillEstimation(),
));



class BillEstimation extends StatefulWidget {
  static const routeName = '/bill-estimation';

  @override
  _BillEstimationState createState() => _BillEstimationState();
}

class _BillEstimationState extends State<BillEstimation> {
//  ProgressDialog pr;

  var _months = ['1 month', '2 month', '3 month'];
  var _selectedMonth = '1 month';
  var _selectedMonthNumber = 1;
  var _totalPower = 0.0;
  var _totalDays = 0;
  var _isLoading = false;
  bool value12=false;
  var _averagePower = 0.0;

  // var _totalDays = 0;
  var _totalTime = 0;
  var _totalAmount = 0.0;
  // var _totalPower = 0.0;
  var _monthlyPower = 0.0;
  var _timeString='14:12';
  // var _isLoading = false;
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
List<dynamic> tenMinuteEnergy;
  var last10Minute;
  Future getEnergyTenMinutes(String dId)async{
    String token = await getToken();
    final url=API+'pertenminuteenergy?d_id='+dId;
    final response = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    print('tenMinuteEnergy ${response.statusCode}');
    if(response.statusCode==200){
      tenMinuteEnergy=jsonDecode(response.body);
      last10Minute=tenMinuteEnergy[0]['enrgy10'];
      print('tenMinuteEnergy $tenMinuteEnergy');
      print('tenMinuteEnergy $last10Minute');
    }
  }


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
  }
  Map<String, double> dataMap = {
    "Bedroom": 5,
    "Kitchen": 3,
    "Living Room": 2,
    "Bathroom": 2,
  };
  // void _getTotal() async {
  //   _isLoading = true;
  //   _totalDays = 0;
  //   _totalPower = 0.0;
  //
  //   DataSnapshot snapshot = await _database.once();
  //   var data = snapshot.value as Map<dynamic, dynamic>;
  //
  //   data.forEach((month, dates) {
  //     var date = dates as Map<dynamic, dynamic>;
  //     date.forEach((date, values) {
  //       _totalDays = _totalDays + 1;
  //       _totalPower = _totalPower + values['power'];
  //     });
  //   });
  //   _averagePower = ((_totalPower / _totalDays) * 30 * 0.0008);
  //   print(_totalPower);
  //   print(_totalDays);
  //   print(_averagePower);
  //
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 600) {
        return  _isLoading
            ? Center(
          child: CircularProgressIndicator(backgroundColor: Colors.red,),
          // child: SpinKitCircle(size: 60, color: Colors.lightBlue),
        ):
        value12==true?
        total():Scaffold(
          appBar: AppBar(
            title: Text('Bill Estimation'),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: Center(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/Bill.png',
                  height: 130,
                  width: 130,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 5,
                  ),
                  child: Text(
                    '👉🏻  The estimated electricity bill 🧾 of $_selectedMonth based on average usage of power will be :-',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),

                DropdownButton(


                    iconEnabledColor: Colors.lightBlue,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                    ),
                    value: _selectedMonth,
                    elevation: 8,
                    items: _months.map((String month) {
                      return DropdownMenuItem<String>(
                        child: Container(

                            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10,),
                            child: Text(month)),
                        value: month,
                      );
                    }).toList(),
                    onChanged: (String newMonth) {
                      setState(() {
                        _selectedMonth = newMonth;
                        _selectedMonthNumber = (_months.indexOf(newMonth) + 1);
                        print('sss $_selectedMonthNumber');
                      });
                    }),
                SizedBox(
                  height: 12,
                ),
                Card(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: FlatButton(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      color: Colors.teal,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      child: Text(
                        '${(_averagePower * _selectedMonthNumber).toStringAsFixed(3)} ₹',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  elevation: 8,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 60),
                        child: Text('Total Usage',style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed:() {
                        setState(() {
                          value12=true;
                          total();
                        });
                        total();
                        // Navigator.of(context)
                        //     .pushReplacementNamed(TotalUsage.routeName);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ) ;

      }else{
        return  _isLoading
            ? Center(
          child: CircularProgressIndicator(backgroundColor: Colors.red,),
          // child: SpinKitCircle(size: 60, color: Colors.lightBlue),
        )
            : Scaffold(
          appBar: AppBar(
            title: Text('Bill Estimation'),
          ),
              body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10,
                ),
                // Image(image: AssetImage('assets/images/Bill.png'),),
                Image.asset(
                  'assets/images/Bill.png',
                  height: 130,
                  width: 130,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 5,
                  ),
                  child: Text(
                    '👉🏻  The estimated electricity bill 🧾 of $_selectedMonth based on average usage of power will be :-',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),

                DropdownButton(

                    iconEnabledColor: Colors.lightBlue,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                    ),
                    value: _selectedMonth,
                    elevation: 8,
                    items: _months.map((String month) {
                      return DropdownMenuItem<String>(
                        child: Container(

                            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10,),
                            child: Text(month)),
                        value: month,
                      );
                    }).toList(),
                    onChanged: (String newMonth) {
                      setState(() {
                        _selectedMonth = newMonth;
                        _selectedMonthNumber = (_months.indexOf(newMonth) + 1);
                        print('sss $_selectedMonthNumber');
                      });
                    }),
                SizedBox(
                  height: 12,
                ),
                Card(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: FlatButton(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      color: Colors.teal,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      child: Text(
                        '${(_averagePower * _selectedMonthNumber).toStringAsFixed(3)} ₹',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  elevation: 8,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 60),
                        child: Text('Total Usage',style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed:() async{
                       await getEnergyTenMinutes("DIDM12932021AAAAAB");
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalUsage(
                         totalEnergy: last10Minute,
                       )));
                        // Navigator.of(context)
                        //     .pushReplacementNamed(TotalUsage.routeName);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
          ),
        ),
            );
      }
        }
      ),
    );
  }
  Widget total(){
    return Container(
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
            Container(
              child: Center(
                child: RaisedButton(
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 60),
                    child: Text(
                      'Bill Estimation',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      value12=false;
                    });
                    // Navigator.of(context)
                    //     .pushReplacementNamed(BillEstimation.routeName);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
