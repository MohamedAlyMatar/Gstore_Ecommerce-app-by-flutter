import 'package:firebase_auth/firebase_auth.dart';
import 'package:gstore/about.dart';
import 'package:gstore/favorites.dart';
import 'package:gstore/profile.dart';
import 'package:gstore/register.dart';
import 'package:gstore/settings.dart';
import 'package:gstore/signin.dart';
import 'package:flutter/material.dart';
import 'package:gstore/util.dart';
import 'auth.dart';
import 'garden.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: MyColors.LightPrimaryColor,
                    // title: MyText("G-Store", MyColors.LightText, 25.0),
                    title: const Text("G-Store",
                        style: TextStyle(color: Colors.white)),
                    centerTitle: true,

                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconData(0xe3b2,
                                    fontFamily: 'MaterialIcons',
                                    matchTextDirection: true),
                                color: Colors.white,
                              ),
                              Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
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
                                color: Colors.white,
                              ),
                              Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  drawer: Builder(
                    builder: (BuildContext drawerContext) => Drawer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            color: MyColors.LightPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey.shade200,
                                      child: const CircleAvatar(
                                        radius: 37,
                                        backgroundImage:
                                            AssetImage('assets/logos/fin.png'),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        user != null
                                            ? Text("${user?.displayName}")
                                            : const Text(
                                                "Finn The Manager",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          InkWell(
                            child: const ListTile(
                              leading: SizedBox(),
                              title: Text("Settings"),
                              trailing: Icon(Icons.settings),
                            ),
                            onTap: () {
                              Navigator.of(drawerContext).push(
                                MaterialPageRoute(
                                    builder: (context) => settings()),
                              );
                            },
                          ),
                          const Divider(),
                          InkWell(
                            child: const ListTile(
                              leading: SizedBox(),
                              title: Text("About"),
                              trailing: Icon(Icons.question_mark),
                            ),
                            onTap: () {
                              Navigator.of(drawerContext).push(
                                MaterialPageRoute(
                                    builder: (context) => about()),
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
                ))));
  }
}
