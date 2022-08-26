import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/firebase/loading_status.dart';
import 'package:quizzle/screens/quiz/quiz_overview_screen.dart';
import 'package:quizzle/widgets/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

String audio = "hi";
dynamic finalResult = '          ';
dynamic text = '          ';
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
              // padding: const EdgeInsets.symmetric(vertical: 4),
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Text(
                                controller.currentQuestion.value!.question,
                                style: kQuizeTS,
                              ),
                              Calculator(),
                              Speech(),
                              /*  GestureDetector(onDoubleTap: () {
                                Speech();
                              }),*/
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
                              padding: const EdgeInsets.only(right: 1.0),
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
                                    finalResult = finalResult.substring(
                                        10, finalResult.length);
                                    controller.selectAnswer(finalResult);
                                    finalResult = '          ';
                                    text = '          ';
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
    return speak(controller.currentQuestion.value!.question);
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
          speak(btntxt);
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
        padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 40),
      ),
    );
  }

  var check;
  dynamic numOne = '';
  dynamic result = '';

  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onDoubleTap: () {
            Speech();
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            print('horizontal');
            speak("back space");
            if (finalResult != null && finalResult.length > 10) {
              text = text.substring(0, text.length - 1);
              finalResult = finalResult.substring(0, finalResult.length - 1);

              setState(
                () {
                  num length = finalResult.length - 10;

                  if (length <= 1) {
                    text = finalResult.substring(
                        finalResult.length - 9, finalResult.length);
                  } else if (length < 5) {
                    text = finalResult.substring(
                        finalResult.length - (9 - (1.5 * (length - 1)).ceil()),
                        finalResult.length);
                  } else {
                    text = finalResult.substring(
                        finalResult.length - (5), finalResult.length);
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
                  num length = finalResult.length - 10;

                  if (length <= 1) {
                    text = finalResult.substring(
                        finalResult.length - 9, finalResult.length);
                  } else if (length < 5) {
                    text = finalResult.substring(
                        finalResult.length - (9 - (1.5 * (length - 1)).ceil()),
                        finalResult.length);
                  } else {
                    text = finalResult.substring(
                        finalResult.length - (5), finalResult.length);
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
        num length = finalResult.length - 10;

        if (length <= 1) {
          text =
              finalResult.substring(finalResult.length - 9, finalResult.length);
        } else if (length < 5) {
          text = finalResult.substring(
              finalResult.length - (9 - (1.5 * (length - 1)).ceil()),
              finalResult.length);
        } else {
          text = finalResult.substring(
              finalResult.length - (5), finalResult.length);
        }
      },
    );
  }
}
