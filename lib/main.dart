import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  double _num1 = 0;
  double _num2 = 0;
  String _operation = '';
  bool _isOperationChosen = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _num1 = 0;
        _num2 = 0;
        _operation = '';
        _isOperationChosen = false;
      } else if (buttonText == '+' ||
          buttonText == '−' ||
          buttonText == '×' ||
          buttonText == '÷' ||
          buttonText == '!x' ||
          buttonText == '|x|' ||
          buttonText == 'e^x') { // Добавлена кнопка для операции e^x
        _operation = buttonText;
        _num1 = double.parse(_output);
        if (_operation == '|x|') {
          _output = _num1.abs().toString();
          _operation = '';
        } else if (_operation == 'e^x') { // Добавлена обработка операции e^x
          _output = (exp(_num1)).toString(); // Вычисляем e в степени num1
          _operation = ''; // Сброс операции
        }
        _isOperationChosen = true;
      } else if (buttonText == '=') {
        _num2 = double.parse(_output);
        if (_operation == '+') {
          _output = (_num1 + _num2).toString();
        } else if (_operation == '−') {
          _output = (_num1 - _num2).toString();
        } else if (_operation == '×') {
          _output = (_num1 * _num2).toString();
        } else if (_operation == '÷') {
          _output = (_num1 / _num2).toString();
        } else if (_operation == '%') {
          _output = (_num1 % _num2).toString();
        } else if (_operation == '^') {
          _output = pow(_num1, _num2).toString();
        } else if (_operation == '!x') {
          _output = _factorial(_num1).toString();
        }
        _operation = '';
        _isOperationChosen = false;
      } else if (buttonText == '(-)') {
        _output =
        _output.startsWith('-') ? _output.substring(1) : '-' + _output;
      } else {
        if (_isOperationChosen) {
          _output = buttonText;
          _isOperationChosen = false;
        } else {
          _output += buttonText;
        }
      }
    });
  }


  int _factorial(double n) {
    if (n == 0) {
      return 1;
    } else {
      return (n * _factorial(n - 1)).toInt();
    }
  }

  Widget _buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        child: FlatButton(
          onPressed: () => _onButtonPressed(buttonText),
          color: Color(0xFF8AA6D1),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(
              color: Colors.black,
              width: 1,
              style: BorderStyle.none,
            ),
          ),
          splashColor: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildButton('|x|', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('e^x', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('!x', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('÷', 1, Color(0xFF8AA6D1)),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildButton('7', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('8', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('9', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('×', 1, Color(0xFF8AA6D1)),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildButton('4', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('5', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('6', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton(
                    '−', 1, Color(0xFFF2F2F2)), // заменяем "-" на символ "−"
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildButton('1', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('2', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('3', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('+', 1, Color(0xFF8AA6D1)),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildButton('C', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('0', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('.', 1, Color(0xFF8AA6D1)),
              ),
              Expanded(
                child: _buildButton('=', 1, Color(0xFF385FC2)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
