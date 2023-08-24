import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gstore/signin.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/ProfileSettings.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';
import 'auth.dart';
import 'home.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  //////////////////////////////////////////////////////////////////////////////

  final User? user = Auth().currentUser;

  // Method to retrieve user data from Firestore
  Future<String?> fetchPhoneNumber() async {
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();
      final userData = userDoc.data();

      if (userData != null && userData.containsKey('phoneNumber')) {
        return userData['phoneNumber'];
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => home()));
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      color: Theme.of(context).colorScheme.background,
      home: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              user != null
                  ? Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.grey.shade200,
                                  child: const CircleAvatar(
                                    radius: 70,
                                    backgroundImage:
                                        AssetImage('assets/logos/fin.png'),
                                  ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: Container(
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
                                            offset: const Offset(2, 4),
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 3,
                                          ),
                                        ]),
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Text("Welcome!", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,
                            decoration: TextDecoration.none),),
                        Text("${user?.displayName}", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,
                            decoration: TextDecoration.none),),
                        FutureBuilder<String?>(
                          future: fetchPhoneNumber(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Phone Number: Loading...", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,
                                  decoration: TextDecoration.none),);
                            } else if (snapshot.hasError) {
                              return Text("Phone Number: Error", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,
                                  decoration: TextDecoration.none),);
                            } else {
                              final phoneNumber = snapshot.data ?? 'N/A';
                              return Text("Phone Number: $phoneNumber", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,
                                  decoration: TextDecoration.none),);
                            }
                          },
                        ),
                        Text("Email: ${user?.email}", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,
                            decoration: TextDecoration.none),),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            signOut();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          child: Text("Sign-Out", style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            child: ListTile(
                              // leading: ,
                              tileColor: Theme.of(context).colorScheme.primary,
                              title: Text(
                                "Profile Settings",
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary,),
                              ),
                              trailing: Icon(Icons.settings_applications, color: Theme.of(context).colorScheme.secondary,),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfileSettings()));
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Text("Guest", style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 15,
                            decoration: TextDecoration.none),), // Display "Guest" if not logged in
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => home()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          child: Text("Sign In", style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
