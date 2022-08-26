import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/widgets/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../onboarding/custom_drawer.dart';
import 'learn.dart';
import 'challenge.dart';
import 'PracticeTest.dart';
import 'read.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'global.dart' as global;
import 'hl.dart';

class HomeScreen extends GetView<MyDrawerController> {
  HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  final FlutterTts flutterTts = FlutterTts();
  String x = "";

  @override
  Widget build(BuildContext context) {
    Future _speakk(String text) async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    }

    Future _speak() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Double Tap to learn");
    }

    Future _speak1() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Double Tap to go give test");
    }

    Future _speak2() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Double Tap to Practice");
    }

    Future _speak3() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Double Tap to Read notes ");
    }

    Future _speak4() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Braille in hindi ");
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
                                String promote =
                                    _label + '  goga is here to assist you';
                                _speakk(promote);
                                return Text(_label,
                                    style: kDetailsTS.copyWith(
                                        color: kOnSurfaceTextColor));
                              },
                            ),
                          ],
                        ),
                      ),
                      Text(global.check),
                      const Text('What Do You Want To Improve Today ?',
                          style: kHeaderTS),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Expanded(
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
                              MaterialPageRoute(builder: (context) => Learn()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/braille_learn.jpeg'),
                                  height: 120,
                                ),
                              ),
                              Text('Braille Learn'),
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
                                  builder: (context) => Challenge()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/challenges.jpg'),
                                  height: 120,
                                ),
                              ),
                              Text('Challenges'),
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
                                  builder: (context) => PracticeTest()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/challenges.jpg'),
                                  height: 120,
                                ),
                              ),
                              Text('Practice'),
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
                                  builder: (context) => PdfRead()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: const Image(
                                  image:
                                      AssetImage('assets/images/progress.jpg'),
                                  height: 120,
                                ),
                              ),
                              Text('E-books'),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () => _speak4(),
                          onDoubleTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HL()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/braille_learn.jpeg'),
                                  height: 120,
                                ),
                              ),
                              Text('Braille In Hindi'),
                            ],
                          ),
                        ),
                      ),
                      vnav(),
                    ],
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

class vnav extends StatefulWidget {
  vnav({Key? key}) : super(key: key);

  @override
  vnavState createState() => vnavState();
}

class vnavState extends State<vnav> {
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
    if (_lastWords == "learn") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Learn()));
    } else if (_lastWords == "Challenge") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Challenge()));
    } else if (_lastWords == "practice") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PracticeTest()));
    } else if (_lastWords == "read") {
      _lastWords = "";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PdfRead()));
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
          size: 700,
        ),
      ),
    );
  }
}
