import 'package:flutter/material.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

import 'ProductClass.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    fetchProductsFromFirestore();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        color: Theme.of(context).colorScheme.background,
        home: SafeArea(
            child: Scaffold(
          body: Center(
              child: Container(
            child: Text(
              "Loading G-Store ...",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 30,
                  fontStyle: FontStyle.italic),
            ),
          )),
        )));
  }
}
