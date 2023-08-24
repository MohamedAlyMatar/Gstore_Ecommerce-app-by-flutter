import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gstore/market.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';
import 'auth.dart';
import 'widgets.dart';

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
  MyWidgets w = MyWidgets();

  //////////////////////////////////////////////////////////////////////////////

  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    final email = _controllerEmail.text;
    final password = _controllerPassword.text;

    if (email.isEmpty || password.isEmpty) {
      // Show an error message if email or password is empty
      w.showPopupMessage(context, "Error", "Please enter email and password.");
      return;
    }
    try {
      await Auth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      w.showToast("Login Success");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => market()));
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException (other Firebase-related issues)
      setState(() {
        errorMessage = e.message;
      });
      w.showPopupMessage(context, "Firebase Authentication Error",
          "Please enter valid email and password.");
    } catch (e) {
      // Handle other exceptions
      print("Unexpected error: $e");
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
                          Builder(
                            builder: (BuildContext context) {
                              return w.entryField1(
                                  "Username",
                                  "Enter your name",
                                  false,
                                  _controllerEmail,
                                  const Icon(Icons.email),
                                  Theme.of(context).colorScheme);
                            },
                          ),
                          Builder(
                            builder: (BuildContext context) {
                              return w.entryField1(
                                "Password",
                                "Enter your password",
                                true,
                                _controllerPassword,
                                const Icon(Icons.lock_outline_rounded),
                                Theme.of(context).colorScheme,
                              );
                            },
                          ),
                          Builder(
                            builder: (BuildContext context) {
                              return w.submitButton(
                                  Theme.of(context).colorScheme,
                                  "Sign-in",
                                  signInWithEmailAndPassword);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Builder(
                                  builder: (BuildContext context) {
                                    return Text(
                                      "No account? ",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontSize: 15,
                                          decoration: TextDecoration.none),
                                    );
                                  },
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
