import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';

dynamic finalResult = '           ';
dynamic text = '           ';
dynamic flag = 0;
final FlutterTts flutterTts = FlutterTts();

speak(String text) {
  flutterTts.setLanguage("hi-IN");
  flutterTts.setPitch(1);
  flutterTts.speak(text);
}

class HL extends StatefulWidget {
  @override
  _HLState createState() => _HLState();
}

class _HLState extends State<HL> {
  @override
  void initState() {
    super.initState();

    AlanVoice.addButton(
        "3b3f8b63af760e8e2883fc51192072f02e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

    AlanVoice.onCommand.add((command) async {
      debugPrint("got new command ${command}");
      debugPrint("got new command ${command.data['command']}");
    });
  }

  dynamic displaytxt = 20;
  //Button Widget
  dynamic numOne = '';
  dynamic result = '';

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          speak(btntxt);
          if (btntxt == "1") {
            Vibration.vibrate(duration: 100);
          } else if (btntxt == "2") {
            Vibration.vibrate(duration: 200);
          } else if (btntxt == "3") {
            Vibration.vibrate(duration: 300);
          } else if (btntxt == "4") {
            Vibration.vibrate(duration: 400);
          } else if (btntxt == "5") {
            Vibration.vibrate(duration: 500);
          } else if (btntxt == "6") {
            Vibration.vibrate(duration: 600);
          }
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
            speak("back space");
            if (finalResult != null && finalResult.length > 11) {
              text = text.substring(0, text.length - 1);
              finalResult = finalResult.substring(0, finalResult.length - 1);

              setState(
                () {
                  num length = finalResult.length - 11;
                  speak('braille');
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
            speak("space");
            if (finalResult != null && finalResult.length > 0) {
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
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('5', Colors.grey, Colors.white),
                  calcbutton('6', Colors.grey, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
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
          finalResult += 'अ ';
          speak("अ ");
          numOne = '';
          break;
        }
      case '12':
        {
          finalResult += 'च';
          speak("च");
          numOne = '';
          break;
        }
      case '15':
        {
          finalResult += 'क';
          speak("क");
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
