import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: BillPrediction(),
));

class BillPrediction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GenOrion'),
      ),
      body: Center(
        child: Text('Bill Prediction',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      ),
    );
  }
}
