import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/firebase/loading_status.dart';
import 'package:quizzle/screens/quiz/quiz_overview_screen.dart';
import 'package:quizzle/widgets/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

String audio = '';
dynamic finalResult = '';
dynamic text = ' ';
final FlutterTts flutterTts = FlutterTts();

class QuizeScreen extends GetView<QuizController> {
  const QuizeScreen({Key? key}) : super(key: key);

  static const String routeName = '/quizescreen';

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak(controller.currentQuestion.value!.question);
    }

    
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
                              // GetBuilder<QuizController>(
                              //     id: 'answers_list',
                              //     builder: (context) {
                              //       return ListView.separated(
                              //         itemCount: controller.currentQuestion
                              //             .value!.answers.length,
                              //         shrinkWrap: true,
                              //         padding: const EdgeInsets.only(top: 25),
                              //         physics:
                              //             const NeverScrollableScrollPhysics(),
                              //         separatorBuilder:
                              //             (BuildContext context, int index) {
                              //           return const SizedBox(
                              //             height: 10,
                              //           );
                              //         },
                              //         itemBuilder:
                              //             (BuildContext context, int index) {
                              //           final answer = controller
                              //               .currentQuestion
                              //               .value!
                              //               .answers[index];
                              //           return AnswerCard(
                              //             isSelected: answer.identifier ==
                              //                 controller.currentQuestion.value!
                              //                     .selectedAnswer,
                              //             onTap: () {
                              //               controller.selectAnswer(
                              //                   answer.identifier);
                              //             },
                              //             answer:
                              //                 '${answer.identifier}. ${answer.answer}',
                              //           );
                              //         },
                              //       );
                              //     }),
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
          numOne = '';
          break;
        }
      case '13':
        {
          finalResult += 'b';
          numOne = '';
          break;
        }
      case '12':
        {
          finalResult += 'c';
          numOne = '';
          break;
        }
      case '124':
        {
          finalResult += 'd';
          numOne = '';
          break;
        }
      case '14':
        {
          finalResult += 'e';
          numOne = '';
          break;
        }
      case '123':
        {
          finalResult += 'f';
          numOne = '';
          break;
        }
      case '1234':
        {
          finalResult += 'g';
          numOne = '';
          break;
        }
      case '134':
        {
          finalResult += 'h';
          numOne = '';
          break;
        }
      case '23':
        {
          finalResult += 'i';
          numOne = '';
          break;
        }
      case '234':
        {
          finalResult += 'j';
          numOne = '';
          break;
        }
      case '15':
        {
          finalResult += 'k';
          numOne = '';
          break;
        }
      case '135':
        {
          finalResult += 'l';
          numOne = '';
          break;
        }
      case '125':
        {
          finalResult += 'm';
          numOne = '';
          break;
        }
      case '1245':
        {
          finalResult += 'n';
          numOne = '';
          break;
        }
      case '145':
        {
          finalResult += 'o';
          numOne = '';
          break;
        }
      case '1235':
        {
          finalResult += 'p';
          numOne = '';
          break;
        }
      case '12345':
        {
          finalResult += 'q';
          numOne = '';
          break;
        }
      case '1345':
        {
          finalResult += 'r';
          numOne = '';
          break;
        }
      case '235':
        {
          finalResult += 's';
          numOne = '';
          break;
        }
      case '2345':
        {
          finalResult += 't';
          numOne = '';
          break;
        }
      case '156':
        {
          finalResult += 'u';
          numOne = '';
          break;
        }
      case '1356':
        {
          finalResult += 'v';
          numOne = '';
          break;
        }
      case '2346':
        {
          finalResult += 'w';
          numOne = '';
          break;
        }
      case '1256':
        {
          finalResult += 'x';
          numOne = '';
          break;
        }
      case '12456':
        {
          finalResult += 'y';
          numOne = '';
          break;
        }
      case '1456':
        {
          finalResult += 'z';
          numOne = '';
          break;
        }
    }

    // if (numOne == '1') {
    //   text = 'a';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    //   numOne = '';
    // } else if (numOne == '13') {
    //   text = 'b';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    // } else if (numOne == '12') {
    //   text = 'c';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    // } else if (numOne == '124') {
    //   text = 'd';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    // } else if (numOne == '14') {
    //   text = 'e';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    // }

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
