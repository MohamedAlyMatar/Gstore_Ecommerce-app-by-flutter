import 'package:flutter/material.dart';
import 'package:gstore/ProductList.dart';
import 'package:gstore/ProductAdd.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

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
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: const Icon(IconData(0xe093,
                  fontFamily: 'MaterialIcons', matchTextDirection: true)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Profile Settings",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
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
                          child: ListTile(
                            // leading: SizedBox(),
                            tileColor: Theme.of(context).colorScheme.primary,
                            title: Text(
                              "Edit Profile",
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            ),
                            trailing: Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary,),
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
                          child: ListTile(
                            // leading: SizedBox(),
                            tileColor: Colors.red,
                            title: Text(
                              "Delete Account",
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            ),
                            trailing: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.secondary,),
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
                                    child: Text("Cancel", style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      deleteUser();
                                    },
                                    child: const Text("DELETE", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
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
