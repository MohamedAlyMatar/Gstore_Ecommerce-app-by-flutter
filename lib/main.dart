import 'package:flutter/material.dart';
import 'package:gstore/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gstore/classes.dart';
import 'package:provider/provider.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      child: home(), // Use your own app widget here
    ),
  );
}

class MyApp extends StatelessWidget {
  Future<void> initializeApp() async {
    // Simulate an asynchronous task (e.g., Firebase initialization)
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen(); // Display loading screen while waiting
          } else {
            return home(); // Replace with your main app screen
          }
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // You can use any loading indicator widget here
      ),
    );
  }
}