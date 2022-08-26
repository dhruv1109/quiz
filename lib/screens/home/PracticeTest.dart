import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/screens/home/practice_subject/practicesst.dart';
import 'package:quizzle/widgets/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../onboarding/custom_drawer.dart';
import 'practice_subject/practicemaths.dart';
import 'practice_subject/practicescience.dart';
import 'practice_subject/practicesst.dart';
import 'practice_subject/practiceenglish.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PracticeTest extends GetView<MyDrawerController> {
  PracticeTest({Key? key}) : super(key: key);

  final FlutterTts flutterTts = FlutterTts();

  Widget build(BuildContext context) {
    Future _speakk() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("select the topic you wish to practice");
    }

    Future _speak() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("English");
    }

    Future _speak1() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Maths");
    }

    Future _speak2() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Science");
    }

    Future _speak3() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("SST");
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
        backgroundColor: Colors.white.withOpacity(0.5),
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
                      const Text('What Do You Want To Improve Today ?',
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
                                      builder: (context) => english()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/english.png'),
                                      height: 120,
                                    ),
                                  ),
                                  Text('English'),
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
                                      builder: (context) => maths()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image:
                                          AssetImage('assets/images/maths.png'),
                                      height: 120,
                                    ),
                                  ),
                                  Text('Maths'),
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
                                      builder: (context) => science()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/science.jpg'),
                                      height: 120,
                                    ),
                                  ),
                                  Text('Science'),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: InkWell(
                              onTap: () => _speak3(),
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => sst()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image:
                                          AssetImage('assets/images/sst.jpg'),
                                      height: 120,
                                    ),
                                  ),
                                  Text('SST'),
                                ],
                              ),
                            ),
                          ),
                          vnav1(),
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

class vnav1 extends StatefulWidget {
  vnav1({Key? key}) : super(key: key);

  @override
  vnavState createState() => vnavState();
}

class vnavState extends State<vnav1> {
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
    if (_lastWords == "back") {
      _lastWords = "";
      Navigator.pop(context);
    } else if (_lastWords == "english") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => english()));
    } else if (_lastWords == "maths") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => maths()));
    } else if (_lastWords == "science") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => science()));
    } else if (_lastWords == "SST") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => sst()));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.5),
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(
          (_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          color: Colors.white.withOpacity(0.5),
          size: 900,
        ),
      ),
    );
  }
}
