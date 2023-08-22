import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  String _operationHistory = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';
  final List<String> _buttonTexts = [
    '^','C','X','/',
    '(',')','%','*',
    '1', '2', '3', '-',
    '4', '5', '6', '+',
    '7', '8', '9', '=',
    '0', '00', '.',
  ];

  void _updateOutput(String value) {
    setState(() {
      _output += value;
      if (value == '+' || value == '-' || value == '*' || value == '/' || value == '%' ) {
        _operator = value;
      }
    });
  }

  void _clear() {
    setState(() {
      _output = '';
      _operationHistory = '';
      _num1 = 0;
      _num2 = 0;
      _operator = '';
    });
  }
  double _evaluateExpression(String expression) {
    // Implement a method to evaluate the expression
    // This could involve handling nested brackets, operator precedence, etc.
    // For simplicity, I'm leaving it as a placeholder here.
    return double.parse(expression);
  }
  void _calculate() {
    if (_output.isNotEmpty) {
      var parts = _output.split(_operator);
      if (parts.length == 2) {
        _num1 = double.parse(parts[0]);
        _num2 = double.parse(parts[1]);

        double result = 0;
        if (_output.contains('(') && _output.contains(')')) {
          int openingBracketIndex = _output.lastIndexOf('(');
          int closingBracketIndex = _output.lastIndexOf(')');
          String expressionInsideBrackets = _output.substring(
              openingBracketIndex + 1,
              closingBracketIndex
          );

          result = _evaluateExpression(expressionInsideBrackets);
          _output = _output.replaceRange(
              openingBracketIndex,
              closingBracketIndex + 1,
              result.toString()
          );
        }else{
          switch (_operator) {
            case '%':
              result = _num1 * ( _num2 / 100 );
              break;
            case '+':
              result = _num1 + _num2;
              break;
            case '-':
              result = _num1 - _num2;
              break;
            case '*':
              result = _num1 * _num2;
              break;
            case '/':
              result = _num1 / _num2;
              break;
          }

        }


        setState(() {
          _operationHistory= _output;
          _output = result.toString();
          _num1 = result;
          _num2 = 0;
          _operator = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
          'Calculator',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),

      ),
        centerTitle: true,
        backgroundColor: Color(0xFF0E2433),
      ),
      body: Container(
        color: Color(0xFF0B344F),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 12.0),
              color: Color(0xFF0E2433),
              child: Text(
                _operationHistory,
                style: TextStyle(fontSize: 28.0, color: Colors.grey),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 44.0, horizontal: 12.0),
              color: Color(0xFF0E2433),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 0.9,
                  mainAxisSpacing: 0.9,
                ),

                itemCount: 23,
                itemBuilder: (BuildContext context, int index) {
                  return Container(color: Color(0xFF0B344F),
                      child: _buildButton(index));

                },
              ),
            ),
            // Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // children: [
                // _buildButton(),
                // _buildCalculateButton(),
                // _buildNumberButton('^'),
                // _buildClearButton(),
                // _buildNumberButton('X'),
                // _buildOperatorButton('/'),
              // ],
            // )
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('('),
                _buildNumberButton(')'),
                _buildNumberButton('%'),
                _buildOperatorButton('*'),
              ],
            ),*/
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
                _buildOperatorButton('-'),
              ],
            ),*/
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
                _buildOperatorButton('+'),
              ],
            ),*/
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
                // _buildCalculateButton(),
                Expanded(child: _buildCalculateButton()),
              ],
            ),*/
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('0'),
                _buildNumberButton('00'),
                _buildNumberButton('.'),
                // Expanded(child: _buildCalculateButton()),
                // _buildClearButton(),
                // _buildCalculateButton(),
                // _buildOperatorButton('+'),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _updateOutput(value),
        child: Text(value),
      ),
    );
  }

  Widget _buildOperatorButton(String value) {
    return ElevatedButton(
      onPressed: () {
        if (_output.isNotEmpty) {
          _num1 = double.parse(_output);
          _operator = value;
          setState(() {
            _output = '';
          });
        }
      },
      child: Text(value),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      onPressed: _clear,
      child: Text('C'),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: _calculate,
      child: Text('='),
    );
  }
  Widget _buildButton(int index) {
    // final buttonText = _buttonTexts[index];
    final buttonText = _buttonTexts[index];
    if (buttonText == '=') {
      return Expanded(
        child: AspectRatio(
          aspectRatio: 20.0, // Adjust this value to control tht
          child: ElevatedButton(
            onPressed: _calculate,
            child: Text(buttonText, style: TextStyle(fontSize: 18, color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF296D97)),
          ),
        ),
      );
    } else if(buttonText == 'C') {
      return Expanded(
        child: ElevatedButton(
          onPressed: _clear,
          child: Text(buttonText,style: TextStyle(fontSize: 18,color: Colors.white)),
          style: ElevatedButton.styleFrom(
            elevation: 0, // Remove the elevation
            shadowColor: Colors.red, // Remove the shadow color
            backgroundColor:Color(0xFF0B344F),
          ),
        ),
      );

    }else {
      return Container(
        color: Color(0x0B344FFF),
        child: ElevatedButton(
          onPressed: () => _updateOutput(buttonText),
          child: Text(buttonText,style: TextStyle(fontSize: 18,color: Colors.white)),
          style: ElevatedButton.styleFrom(
            elevation: 0, // Remove the elevation
            shadowColor: Colors.transparent, // Remove the shadow color
            backgroundColor:Color(0xFF0B344F),
          ),
        ),
      );
    }
  }
}

