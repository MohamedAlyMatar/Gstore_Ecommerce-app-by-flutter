import 'package:firebase_auth/firebase_auth.dart';
import 'package:gstore/about.dart';
import 'package:gstore/favorites.dart';
import 'package:gstore/profile.dart';
import 'package:gstore/register.dart';
import 'package:gstore/settings.dart';
import 'package:gstore/signin.dart';
import 'package:flutter/material.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';
import 'ProductClass.dart';
import 'auth.dart';
import 'ProductsGarden.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    fetchProductsFromFirestore();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text("G-Store",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconData(0xe3b2,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Text(
                        'Sign In',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
                Tab(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconData(0xe08c,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Text(
                        'Register',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              // Change the background color of the entire drawer
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: user != null
                        ? Text("${user?.displayName}")
                        : Text("Finn The Manager"),
                    accountEmail: user != null
                        ? Text("${user?.email}")
                        : Text("finn@gstore.com"),
                    // You can provide an email address here if needed
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: CircleAvatar(
                        radius: 37,
                        backgroundImage: AssetImage('assets/logos/fin.png'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Change the background color of the header
                    ),
                  ),
                  ListTile(
                    // tileColor: Theme.of(context).colorScheme.secondary,
                    leading: Icon(Icons.settings, color:Theme.of(context).colorScheme.tertiary),
                    title: Text("Settings", style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => settings()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    // tileColor: Theme.of(context).colorScheme.secondary,
                    leading: Icon(Icons.question_mark, color:Theme.of(context).colorScheme.tertiary),
                    title: Text("About", style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => about()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              signIn(),
              register(),
            ],
          ),
        ),
      ),
    );
  }
}
