import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double _currentValue =0;
  @override
  Widget build(BuildContext context) {
    return SimpleCalculator(
      value: _currentValue,
      hideExpression: true,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged:(key,value,expression){
        setState(() {
          _currentValue=value??0;
        });
        if (kDebugMode) {
          print('$key\t$value\t$expression');
        }
      },
      theme: const CalculatorThemeData(
        borderColor: Colors.black,
        borderWidth: 2,
        displayColor: Colors.black,
        displayStyle: TextStyle(fontSize: 80, color: Colors.yellow),
        expressionColor: Colors.indigo,
        expressionStyle: TextStyle(fontSize: 20, color: Colors.white),
        operatorColor: Colors.pink,
        operatorStyle: TextStyle(fontSize: 30, color: Colors.white),
        commandColor: Colors.orange,
        commandStyle: TextStyle(fontSize: 30, color: Colors.white),
        numColor: Colors.grey,
        numStyle: TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
}
