import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gstore/SplashScreen.dart';
import 'package:gstore/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gstore/classes.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'home.dart';
import 'market.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final User? user = Auth().currentUser;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Favorites>(
          create: (_) => Favorites(),
        ),
        ChangeNotifierProvider<Bucket>(
          create: (_) => Bucket(),
        ),
      ],
      // child: user != null ? market() : home(),
      child: LoadApp(),
    ),
  );
}

class LoadApp extends StatelessWidget {
  Future<void> initializeApp() async {
    // Simulate an asynchronous task (e.g., Firebase initialization)
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen(); // Display loading screen while waiting
          } else {
            return home(); // Replace with your main app screen
          }
        },
      ),
    );
  }
}
