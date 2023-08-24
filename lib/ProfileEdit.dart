import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';
import 'auth.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final User? user = Auth().currentUser;

  TextEditingController displayNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // Method to fetch and display the user's current profile info
  Future<void> fetchProfileInfo() async {
    // Fetch the user's profile info from Firestore and set it in the text controllers
    // You can adapt this code to retrieve the user's info as needed
    // For simplicity, I'm assuming the user's data is stored in a 'users' collection
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();

    if (userDoc.exists) {
      final userData = userDoc.data();
      if (userData != null) {
        setState(() {
          displayNameController.text = userData['displayName'] ?? '';
          phoneNumberController.text = userData['phoneNumber'] ?? '';
        });
      }
    }
  }

  // Method to update the user's profile info in Firebase
  Future<void> updateProfileInfo() async {
    final updatedDisplayName = displayNameController.text;
    final updatedPhoneNumber = phoneNumberController.text;

    // Update the user's profile info in Firestore
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .update({
        'displayName': updatedDisplayName,
        'phoneNumber': updatedPhoneNumber,
      });

      // Inform the user that the changes were saved
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully.'),
        ),
      );
      setState(() {});
    } catch (e) {
      // Handle errors if the update fails
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch and display the user's current profile info when the page loads
    fetchProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: const Icon(IconData(0xe093,
                  fontFamily: 'MaterialIcons', matchTextDirection: true)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Edit Profile",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: displayNameController,
                  decoration: InputDecoration(
                    labelText: 'Display Name',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateProfileInfo(); // Call the method to save changes
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
