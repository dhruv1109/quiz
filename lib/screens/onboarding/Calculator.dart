import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

speak(String text) {
  flutterTts.setLanguage("hi-IN");
  flutterTts.setPitch(1);
  flutterTts.speak(text);
}

dynamic text = '      ';
dynamic numOne = '';
dynamic result = '';
dynamic finalResult = '      ';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  //Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: btncolor,
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      ),
    );
  }

  var check;

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Braille'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            print('horizontal');
            if (finalResult != null && finalResult.length > 11) {
              text = text.substring(0, text.length - 1);
              finalResult = finalResult.substring(0, finalResult.length - 1);

              setState(
                () {
                  num length = finalResult.length - 10;

                  if (length == 0) {
                    text = finalResult.substring(
                        finalResult.length - 11, finalResult.length);
                  } else if (length < 6) {
                    text = finalResult.substring(
                        finalResult.length - (11 - (1.5 * (length - 1)).ceil()),
                        finalResult.length);
                  } else {
                    text = finalResult.substring(
                        finalResult.length - (6), finalResult.length);
                  }
                },
              );
            }
          },

          onVerticalDragEnd: (DragEndDetails details) {
            print('vertical');
            if (finalResult != null && finalResult.length > 6) {
              text = text + ' ';
              finalResult = finalResult + ' ';

              setState(
                () {
                  num length = finalResult.length - 11;

                  if (length == 0) {
                    text = finalResult.substring(
                        finalResult.length - 11, finalResult.length);
                  } else if (length < 6) {
                    text = finalResult.substring(
                        finalResult.length - (11 - (1.5 * (length - 1)).ceil()),
                        finalResult.length);
                  } else {
                    text = finalResult.substring(
                        finalResult.length - (6), finalResult.length);
                  }
                },
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    // children: <Widget>[
                    onTap: () {
                      print('tap');
                      calculation('ok');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        '$text',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                        ),
                      ),
                    ),
                    // ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('1', Colors.grey, Colors.white),
                  calcbutton('2', Colors.grey, Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('3', Colors.grey, Colors.white),
                  calcbutton('4', Colors.grey, Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('5', Colors.grey, Colors.white),
                  calcbutton('6', Colors.grey, Colors.white),
                ],
              ),
            ],
          ),
          // ],
        ),
        // ),
      ),
    );
  }

  void calculation(btnText) {
    if (check == 'ok' || btnText == 'ok') {
      if (numOne == '') {
        numOne = result;
        check = '';
        result = '';
      }
      result = '';
    } else {
      result = result + btnText;
    }

    switch (numOne) {
      case '1':
        {
          finalResult += 'a';
          speak("a");
          numOne = '';
          break;
        }
      case '13':
        {
          finalResult += 'b';
          speak("b");
          numOne = '';
          break;
        }
      case '12':
        {
          finalResult += 'c';
          speak("c");
          numOne = '';
          break;
        }
      case '124':
        {
          finalResult += 'd';
          speak("d");
          numOne = '';
          break;
        }
      case '14':
        {
          finalResult += 'e';
          speak("e");
          numOne = '';
          break;
        }
      case '123':
        {
          finalResult += 'f';
          speak("f");
          numOne = '';
          break;
        }
      case '1234':
        {
          finalResult += 'g';
          speak("g");
          numOne = '';
          break;
        }
      case '134':
        {
          finalResult += 'h';
          speak("h");
          numOne = '';
          break;
        }
      case '23':
        {
          finalResult += 'i';
          speak("i");
          numOne = '';
          break;
        }
      case '234':
        {
          finalResult += 'j';
          speak("j");
          numOne = '';
          break;
        }
      case '15':
        {
          finalResult += 'k';
          speak("k");
          numOne = '';
          break;
        }
      case '135':
        {
          finalResult += 'l';
          speak("l");
          numOne = '';
          break;
        }
      case '125':
        {
          finalResult += 'm';
          speak("m");
          numOne = '';
          break;
        }
      case '1245':
        {
          finalResult += 'n';
          speak("n");
          numOne = '';
          break;
        }
      case '145':
        {
          finalResult += 'o';
          speak("o");
          numOne = '';
          break;
        }
      case '1235':
        {
          finalResult += 'p';
          speak("p");
          numOne = '';
          break;
        }
      case '12345':
        {
          finalResult += 'q';
          speak("q");
          numOne = '';
          break;
        }
      case '1345':
        {
          finalResult += 'r';
          speak("r");
          numOne = '';
          break;
        }
      case '235':
        {
          finalResult += 's';
          speak("s");
          numOne = '';
          break;
        }
      case '2345':
        {
          finalResult += 't';
          speak("t");
          numOne = '';
          break;
        }
      case '156':
        {
          finalResult += 'u';
          speak("u");
          numOne = '';
          break;
        }
      case '1356':
        {
          finalResult += 'v';
          speak("v");
          numOne = '';
          break;
        }
      case '2346':
        {
          finalResult += 'w';
          speak("w");
          numOne = '';
          break;
        }
      case '1256':
        {
          finalResult += 'x';
          speak("x");
          numOne = '';
          break;
        }
      case '12456':
        {
          finalResult += 'y';
          speak("y");
          numOne = '';
          break;
        }
      case '1456':
        {
          finalResult += 'z';
          speak("z");
          numOne = '';
          break;
        }
      default:
        {
          numOne = '';
          break;
        }
    }

    setState(
      () {
        num length = finalResult.length - 11;

        if (length == 0) {
          text = finalResult.substring(
              finalResult.length - 11, finalResult.length);
        } else if (length < 6) {
          text = finalResult.substring(
              finalResult.length - (11 - (1.5 * (length - 1)).ceil()),
              finalResult.length);
        } else {
          text = finalResult.substring(
              finalResult.length - (6), finalResult.length);
        }
      },
    );
  }
}
