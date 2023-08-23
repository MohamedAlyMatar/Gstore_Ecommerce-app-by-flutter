import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: const Text(
          "Loading G-Store ...",
          style: TextStyle(
              color: Colors.blue, fontSize: 30, fontStyle: FontStyle.italic),
        ),
      )),
    );
  }
}
