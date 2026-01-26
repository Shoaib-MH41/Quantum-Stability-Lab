import 'package:flutter/material.dart';

class ExperimentHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تجرباتی تاریخ'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'تجرباتی تاریخ جلد ہی دستیاب ہوگی',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
