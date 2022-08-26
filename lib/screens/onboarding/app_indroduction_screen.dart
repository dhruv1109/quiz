import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/controllers/auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzle/widgets/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../home/home_screen.dart';

class AppIntroductionScreen extends GetView<AuthController> {
  const AppIntroductionScreen({Key? key}) : super(key: key);
  static const String routeName = '/introduction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF004D40),
        // rgb(37, 150, 190)
        body: Container(
          color: Color(0xFF004D40),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage("assets/l1.png"),
                height: 350,
              ),
              MainButton(
                onTap: () {
                  controller.siginInWithGoogle();
                },
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/icons/google.svg',
                        )),
                    Center(
                      child: Text(
                        'Sign in  with google',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // vna(),
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
// CircularButton(
//                   onTap: () => Get.offAndToNamed(HomeScreen.routeName),
//                   child: const Icon(
//                     Icons.arrow_forward,
//                     size: 35,
//                   ))

// class vna extends StatefulWidget {
//   vna({Key? key}) : super(key: key);

//   @override
//   vnaState createState() => vnaState();
// }

// class vnaState extends State<vna> {
  
//   SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _lastWords = '';

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//     setState(() {});
//   }

//   void _startListening() async {
//     await _speechToText.listen(onResult: _onSpeechResult);
//     setState(() {});
//   }

//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }

//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _lastWords = result.recognizedWords;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     if(_lastWords == "home")
//     {
//       _lastWords="";
//       Navigator.of(context).pushNamedAndRemoveUntil(
//    "/home",
//    (route) => route.isCurrent && route.settings.name == "/home"
//   ? false
//   : true);
//     }
    
//     return Scaffold(
      
//       floatingActionButton: FloatingActionButton(
//         onPressed:
//             // If not yet listening for speech start, otherwise stop
//             _speechToText.isNotListening ? _startListening : _stopListening,
//         tooltip: 'Listen',
//         child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//       ),
//     );
//   }
// }