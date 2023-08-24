import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';
import 'package:gstore/widgets.dart';

import 'auth.dart';
import 'market.dart';

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _register();
}

class _register extends State<register> {
  MyWidgets w = MyWidgets();

  //////////////////////////////////////////////////////////////////////////////

  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final authResult = await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        username: _controllerUsername.text,
        phoneNumber: _controllerPhoneNumber.text,
      );

      final user = authResult?.user;
      if (user != null) {
        // Update user display name
        await user.updateDisplayName(_controllerUsername.text);

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'displayName': _controllerUsername.text,
          'email': _controllerEmail.text,
          'phoneNumber': _controllerPhoneNumber.text,
        });

        // Navigate to the market page
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => market()));
        w.showToast("Registration Success");
      } else {
        // Handle the case where the user object is null
        w.showToast("Registration failed: Unable to create user.");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.grey.shade200,
                        child: const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/logos/fin.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(Icons.add_a_photo, color: Colors.black),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.white,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  50,
                                ),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 4),
                                  color: Colors.black.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 3,
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    return w.entryField2(
                        Theme.of(context).colorScheme,
                        "Enter your name",
                        "Name",
                        false,
                        const Icon(Icons.face),
                        _controllerUsername);
                  },
                ),
                Builder(
                  builder: (BuildContext context) {
                    return w.entryField2(
                      Theme.of(context).colorScheme,
                      "Enter your phone number",
                      "phone number",
                      false,
                      const Icon(Icons.phone_android_rounded),
                      _controllerPhoneNumber,
                    );
                  },
                ),
                Builder(
                  builder: (BuildContext context) {
                    return w.entryField2(
                        Theme.of(context).colorScheme,
                        "Enter your email",
                        "Email",
                        false,
                        const Icon(Icons.email),
                        _controllerEmail);
                  },
                ),
                Builder(
                  builder: (BuildContext context) {
                    return w.entryField2(
                        Theme.of(context).colorScheme,
                        "Enter your password",
                        "password",
                        true,
                        const Icon(Icons.lock),
                        _controllerPassword);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Builder(
                  builder: (BuildContext context) {
                    return w.submitButton(Theme.of(context).colorScheme,
                        "Sign-up", createUserWithEmailAndPassword);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
