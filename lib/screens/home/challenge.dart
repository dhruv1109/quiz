import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/screens/home/challenge/physics.dart';
import 'package:quizzle/widgets/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../onboarding/Calculator.dart';
import '../onboarding/custom_drawer.dart';
import 'challenge/physics.dart';
import 'challenge/chemistry.dart';
import 'challenge/maths.dart';
import 'challenge/english.dart';

class Challenge extends GetView<MyDrawerController> {
  Challenge({Key? key}) : super(key: key);

  final FlutterTts flutterTts = FlutterTts();

  Widget build(BuildContext context) {
    Future _speakk() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("select the subject you want to learn");
    }

    Future _speak() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Physics");
    }

    Future _speak1() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Chemistry");
    }

    Future _speak2() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("English");
    }

    Future _speak3() async {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setPitch(1);
      await flutterTts.speak("Maths");
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
                      const Text(
                          'Which subject do you want to select for the test ?',
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
                                      builder: (context) => physics()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/physics.jpg'),
                                      height: 120,
                                    ),
                                  ),
                                  Text(
                                      'Physics'), //english is to be there right  instead of physics
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
                                      builder: (context) => chemistry()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: const Image(
                                      image:
                                          AssetImage('assets/images/chem.jpg'),
                                      height: 120,
                                    ),
                                  ),
                                  Text(
                                      'Chemistry'), //maths is to be there instead of chemistry change it later
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
                                  Text(
                                      'English'), //science is to be there right instead of english change it
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
                                  Text(
                                      'Maths'), //SST is to be there instead of mats change it later
                                ],
                              ),
                            ),
                          ),
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
