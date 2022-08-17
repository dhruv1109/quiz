import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/firebase/loading_status.dart';
import 'package:quizzle/screens/quiz/quiz_overview_screen.dart';
import 'package:quizzle/widgets/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

String audio = "hi";
dynamic finalResult = '';
dynamic text = ' ';
final FlutterTts flutterTts = FlutterTts();

speak(String text) {
  flutterTts.setLanguage("hi-IN");
  flutterTts.setPitch(1);
  flutterTts.speak(text);
}

class QuizeScreen extends GetView<QuizController> {
  const QuizeScreen({Key? key}) : super(key: key);

  static const String routeName = '/quizescreen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onExitOfQuiz,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Obx(
                () => CountdownTimer(
                  time: controller.time.value,
                  color: kOnSurfaceTextColor,
                ),
              ),
              decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: kOnSurfaceTextColor, width: 2)),
              ),
            ),
            showActionIcon: true,
            titleWidget: Obx(() => Text(
                  'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                  style: kAppBarTS,
                )),
          ),
          body: BackgroundDecoration(
            child: Obx(
              () => Column(
                children: [
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    const Expanded(
                        child: ContentArea(child: QuizScreenPlaceHolder())),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                      child: ContentArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                controller.currentQuestion.value!.question,
                                style: kQuizeTS,
                              ),
                              Calculator(),
                              Speech(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: UIParameters.screenPadding,
                      child: Row(
                        children: [
                          Visibility(
                            visible: controller.isFirstQuestion,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: SizedBox(
                                height: 55,
                                width: 55,
                                child: MainButton(
                                  onTap: () {
                                    controller.prevQuestion();
                                  },
                                  child: const Icon(Icons.arrow_back_ios_new),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Visibility(
                                visible: controller.loadingStatus.value ==
                                    LoadingStatus.completed,
                                child: MainButton(
                                  onTap: () {
                                    controller.selectAnswer(finalResult);
                                    finalResult = '';
                                    text = ' ';
                                    controller.islastQuestion
                                        ? Get.toNamed(
                                            QuizOverviewScreen.routeName)
                                        : controller.nextQuestion();
                                  },
                                  title: controller.islastQuestion
                                      ? 'Complete'
                                      : 'Next',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class Speech extends GetView<QuizController> {
  const Speech({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Row(
      children: speak(controller.currentQuestion.value!.question),
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

  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            print('start');
            if (finalResult != null && finalResult.length > 0) {
              text = text.substring(0, text.length - 1);
              finalResult = finalResult.substring(0, finalResult.length - 1);

              setState(
                () {
                  text = finalResult;
                },
              );
            }
          },

          onVerticalDragEnd: (DragEndDetails details) {
            print('start');
            if (finalResult != null && finalResult.length > 0) {
              text = text + ' ';
              finalResult = finalResult + ' ';

              setState(
                () {
                  text = finalResult;
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
                      check = 'ok';
                      print('tap');
                      if (numOne == '') {
                        numOne = result;
                        result = '';
                      } else {
                        numTwo = result;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              // Calculator display
              // SingleChildScrollView(
              // scrollDirection: Axis.vertical,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('1', Colors.grey, Colors.white),
                  calcbutton('2', Colors.grey, Colors.white),
                  // calcbutton('%', Colors.grey, Colors.black),
                  // calcbutton('/', Colors.amber, Colors.white),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('3', Colors.grey, Colors.white),
                  calcbutton('4', Colors.grey, Colors.white),
                  // calcbutton('9', Colors.grey, Colors.white),
                  // calcbutton('x', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // calcbutton('4', Colors.grey, Colors.white),
                  calcbutton('5', Colors.grey, Colors.white),
                  calcbutton('6', Colors.grey, Colors.white),
                  // calcbutton('-', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // calcbutton('', Colors.grey, Colors.white),
                  calcbutton('ok', Colors.grey, Colors.white),
                  // calcbutton('3', Colors.grey, Colors.white),
                  // calcbutton('+', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[
              //     //this is button Zero
              //     RaisedButton(
              //       padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
              //       onPressed: () {
              //         calculation('0');
              //       },
              //       shape: StadiumBorder(),
              //       child: Text(
              //         '0',
              //         style: TextStyle(fontSize: 35, color: Colors.white),
              //       ),
              //       color: Colors.grey[850],
              //     ),
              //     calcbutton('.', Colors.grey, Colors.white),
              //     calcbutton('=', Colors.amber, Colors.white),
              //   ],
              // ),
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

  //Calculator logic

  dynamic numOne = '';
  dynamic numTwo = '';

  dynamic result = '';

  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (check == 'ok' || btnText == 'ok') {
      if (numOne == '') {
        numOne = result;
        check = '';
        result = '';
      } else {
        numTwo = result;
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      // finalResult = result;
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
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
