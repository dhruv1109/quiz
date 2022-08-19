import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/controllers/auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzle/widgets/widgets.dart';

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