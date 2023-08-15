import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gstore/util.dart';

import 'auth.dart';
import 'market.dart';

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _register();
}

class _register extends State<register> {
  //////////////////////////////////////////////////////////////////////////////

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => market()));
        _showToast("Registration Success");
      } else {
        // Handle the case where the user object is null
        _showToast("Registration failed: Unable to create user.");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, String hint, bool isobsecure, Icon entryicon,
      [TextEditingController? controller]) {
    return TextField(
      controller: controller,
      obscureText: isobsecure,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: title,
        hintText: hint,
        prefixIcon: entryicon,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == "" ? "" : "Hmm ? $errorMessage");
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: MyColors.LightPrimaryColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: createUserWithEmailAndPassword,
      child: Text("Register"),
    );
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: _entryField("Enter your name", "Name", false,
                        const Icon(Icons.face), _controllerUsername)),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: _entryField(
                        "Enter your phone number",
                        "phone number",
                        false,
                        const Icon(Icons.phone_android_rounded),
                        _controllerPhoneNumber,
                      )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: _entryField("Enter your email", "Email", false,
                        const Icon(Icons.email), _controllerEmail)),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: _entryField("Enter your password", "password", true,
                        const Icon(Icons.lock), _controllerPassword)),
                const SizedBox(
                  height: 10,
                ),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
