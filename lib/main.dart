import 'package:flutter/material.dart';
import 'calculator.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  static const _blackPrimaryValue = Color(34564);
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator App",
      theme: new ThemeData(primarySwatch:Colors.grey),
      home: new CalculatorScreen(),
    );
  }
}