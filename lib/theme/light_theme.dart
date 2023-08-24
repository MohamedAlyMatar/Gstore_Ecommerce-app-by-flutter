import "package:flutter/material.dart";
import "package:hexcolor/hexcolor.dart";

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.deepOrange,
    //   elevation: 0,
    //   iconTheme: IconThemeData(color: Colors.white),
    //   titleTextStyle: TextStyle(fontSize: 30, color: Colors.white),
    // ),
    colorScheme: const ColorScheme.light(
      background: Colors.white,
      // primary: HexColor("#005792"),
      primary: Colors.deepOrange,
      secondary: Colors.white,
      tertiary: Colors.black,
    )
);