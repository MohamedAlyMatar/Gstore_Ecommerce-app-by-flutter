import 'package:flutter/material.dart';
import 'package:gstore/ProductList.dart';
import 'package:gstore/ProductAdd.dart';
import 'package:gstore/classes.dart';

import 'ProductDelete.dart';
import 'ProfileEdit.dart';
import 'auth.dart';
import 'home.dart';

class ProfileSettings extends StatefulWidget {
  ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  Future<void> deleteUser() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => home()));
    await Auth().deleteUserAndFirestoreData();
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: MyColors.LightPrimaryColor,
            leading: IconButton(
              icon: const Icon(IconData(0xe093,
                  fontFamily: 'MaterialIcons', matchTextDirection: true)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "Profile Settings",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/logos/resume.png",
                            height: 150, width: 150),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: const ListTile(
                            // leading: SizedBox(),
                            title: Text(
                              "Edit Profile",
                              style: TextStyle(color: Colors.black87),
                            ),
                            trailing: Icon(Icons.edit),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfileEdit()));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            color: Colors.red,
                            // Set the background color to red
                            child: const ListTile(
                              // leading: SizedBox(),
                              title: Text(
                                "Delete Account",
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: Icon(Icons.delete_forever),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Are you sure?"),
                                content:
                                    const Text("This action can't be undone"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      deleteUser();
                                    },
                                    child: const Text("DELETE"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
