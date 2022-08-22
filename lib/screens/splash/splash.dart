import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004D40),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: const Image(
              image: AssetImage('assets/l1.png'),
              width: 400,
            ),
          ),
          const SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
        ],
      ),
    );
  }
}
