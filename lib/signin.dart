import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gstore/market.dart';
import 'package:gstore/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth.dart';

class signIn extends StatefulWidget {
  signIn({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  //////////////////////////////////////////////////////////////////////////////

  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void _showPopupMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    final email = _controllerEmail.text;
    final password = _controllerPassword.text;

    if (email.isEmpty || password.isEmpty) {
      // Show an error message if email or password is empty
      _showPopupMessage("Error", "Please enter email and password.");
      return;
    }
    try {
      await Auth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _showToast("Login Success");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => market()));
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException (other Firebase-related issues)
      setState(() {
        errorMessage = e.message;
      });
      _showPopupMessage("Firebase Authentication Error",
          "Please enter valid email and password.");
    } catch (e) {
      // Handle other exceptions
      print("Unexpected error: $e");
    }
  }

  Widget _entryField(String title, String hint, bool isobsecure,
      TextEditingController controller, Icon entryicon) {
    return TextField(
        controller: controller,
        obscureText: isobsecure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: title,
          hintText: hint,
          prefixIcon: entryicon,
        ));
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
      onPressed: signInWithEmailAndPassword,
      child: Text("Login"),
    );
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/logos/shopping.png',
                      height: 200, width: 200),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: _entryField(
                                  "Username",
                                  "Enter your name",
                                  false,
                                  _controllerEmail,
                                  const Icon(Icons.email))),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: _entryField(
                                  "Password",
                                  "Enter your password",
                                  true,
                                  _controllerPassword,
                                  const Icon(Icons.lock_outline_rounded))),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: _submitButton(),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "No account? ",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      decoration: TextDecoration.none),
                                ),
                                Text(
                                  "Swipe to register",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      decoration: TextDecoration.none),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            child: const ListTile(
                              // leading: SizedBox(),
                              title: Text("Continue as a guest?"),
                              trailing: Icon(Icons.hail_rounded),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => market()));
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
