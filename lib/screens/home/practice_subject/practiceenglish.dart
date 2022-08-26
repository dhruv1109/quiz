import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/screens/home/PracticeTest.dart';
import 'package:quizzle/widgets/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../onboarding/custom_drawer.dart';
import '../practicetopic/english/grammar.dart';
import '../practicetopic/english/letter.dart';
import '../practicetopic/english/word.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class english extends GetView<MyDrawerController> {
  english({Key? key}) : super(key: key);

  final FlutterTts flutterTts = FlutterTts();

  Widget build(BuildContext context) {
    Future _speakk() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("select the english topic you wish to practice");
    }

    Future _speak() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Grammar");
    }

    Future _speak1() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("letter");
    }

    Future _speak2() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("word");
    }

    QuizPaperController _quizePprContoller = Get.find();
    return Scaffold(
        body: GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        borderRadius: 50.0,
        showShadow: true,
        angle: 0.0,
        style: DrawerStyle.DefaultStyle,
        menuScreen: const CustomDrawer(),
        backgroundColor: Color.fromARGB(255, 53, 44, 112).withOpacity(0.5),
        slideWidth: MediaQuery.of(context).size.width * 0.6,
        mainScreen: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kMobileScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(-10, 0),
                        child: CircularButton(
                          child: const Icon(AppIcons.menuleft),
                          onTap: controller.toggleDrawer,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(AppIcons.peace),
                            Builder(
                              builder: (_) {
                                final AuthController _auth = Get.find();
                                final user = _auth.getUser();
                                String _label = '  Hello mate';
                                if (user != null) {
                                  _label = '  Hello ${user.displayName}';
                                }
                                _speakk();
                                return Text(_label,
                                    style: kDetailsTS.copyWith(
                                        color: kOnSurfaceTextColor));
                              },
                            ),
                          ],
                        ),
                      ),
                      const Text('Select the topic of English',
                          style: kHeaderTS),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ContentArea(
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Card(
                            child: InkWell(
                              onTap: () => _speak(),
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const grammar()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/grammar.jpg'),
                                      height: 120,
                                    ),
                                  ),
                                  const Text('Grammar'),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: InkWell(
                              onTap: () => _speak1(),
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const letter()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/letter.png'),
                                      height: 120,
                                    ),
                                  ),
                                  const Text('Letter'),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: InkWell(
                              onTap: () => _speak2(),
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const word()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image:
                                          AssetImage('assets/images/word.png'),
                                      height: 120,
                                    ),
                                  ),
                                  const Text('Word'),
                                ],
                              ),
                            ),
                          ),
                          /*Card(
                            child: InkWell(
                              onTap: () => _speak3(),
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PracticeTopic()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(
                                    "https://st2.depositphotos.com/5425740/9532/v/380/depositphotos_95328970-stock-illustration-vector-group-of-students.jpg",
                                    height: 120,
                                  ),
                                  Text('Maths practop'),
                                ],
                              ),
                            ),
                          ),*/
                          vnav2(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class vnav2 extends StatefulWidget {
  vnav2({Key? key}) : super(key: key);

  @override
  vnavState createState() => vnavState();
}

class vnavState extends State<vnav2> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    /* if(_lastWords == "back")
    {
      _lastWords="";
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
    PracticeTest()));
    }*/

    if (_lastWords == "grammar") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => grammar()));
    } else if (_lastWords == "words") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => word()));
    } else if (_lastWords == "letters") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => letter()));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
