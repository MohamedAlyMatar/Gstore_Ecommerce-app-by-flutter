import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gstore/AdminControls.dart';
import 'package:gstore/favorites.dart';
import 'package:gstore/profile.dart';
import 'package:gstore/settings.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';
import 'about.dart';
import 'auth.dart';
import 'ProductsGarden.dart';
import 'help.dart';

void main() => runApp(market());

class market extends StatefulWidget {
  @override
  _marketState createState() => _marketState();
}

class _marketState extends State<market> {
  final User? user = Auth().currentUser;

  int selectedIndex = 0;
  int badge = 0;
  final padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  double gap = 10;

  PageController controller = PageController();

  final List<Widget> screens = [
    garden(),
    favorites(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Enjoy The Quality",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => help()));
                },
                icon: Icon(Icons.question_mark, color: Theme.of(context).colorScheme.secondary,))
          ],
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
                  leading: Icon(Icons.settings,
                      color: Theme.of(context).colorScheme.tertiary),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => settings()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  // tileColor: Theme.of(context).colorScheme.secondary,
                  leading: Icon(Icons.question_mark,
                      color: Theme.of(context).colorScheme.tertiary),
                  title: Text(
                    "About",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => about()),
                    );
                  },
                ),
                const Divider(),
                user?.uid == "RIGw9i6U0jXGRqUpdmvHYWLeKkl2"
                    ? ListTile(
                        // tileColor: Theme.of(context).colorScheme.secondary,
                        leading: Icon(Icons.admin_panel_settings_rounded,
                            color: Theme.of(context).colorScheme.tertiary),
                        title: Text(
                          "Admin Controls",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AdminControls()),
                          );
                        },
                      )
                    : const Divider()
              ],
            ),
          ),
        ),
        // drawer: SafeArea(
        //     child: Builder(
        //   builder: (BuildContext drawerContext) => Drawer(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Container(
        //           height: 120,
        //           color: Theme.of(context).colorScheme.primary,
        //           child: Padding(
        //             padding: const EdgeInsets.all(5.0),
        //             child: InkWell(
        //               child: Row(
        //                 children: [
        //                   CircleAvatar(
        //                     radius: 40,
        //                     backgroundColor: Colors.grey.shade200,
        //                     child: const CircleAvatar(
        //                       radius: 37,
        //                       backgroundImage:
        //                           AssetImage('assets/logos/fin.png'),
        //                     ),
        //                   ),
        //                   const SizedBox(
        //                     width: 10,
        //                   ),
        //                   Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       user != null
        //                           ? Text(
        //                               "${user?.displayName}",
        //                               style: const TextStyle(
        //                                   color: Colors.white, fontSize: 17),
        //                             )
        //                           : const Text(
        //                               "Finn The Manager",
        //                               style: TextStyle(
        //                                   color: Colors.white, fontSize: 17),
        //                             ),
        //                       const SizedBox(
        //                         width: 10,
        //                       ),
        //                     ],
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //         InkWell(
        //           child: const ListTile(
        //             leading: SizedBox(),
        //             title: Text("Settings"),
        //             trailing: Icon(Icons.settings),
        //           ),
        //           onTap: () {
        //             Navigator.of(drawerContext).push(
        //               MaterialPageRoute(builder: (context) => settings()),
        //             );
        //           },
        //         ),
        //         const Divider(),
        //         InkWell(
        //           child: const ListTile(
        //             leading: SizedBox(),
        //             title: Text("About"),
        //             trailing: Icon(Icons.info),
        //           ),
        //           onTap: () {
        //             Navigator.of(drawerContext).push(
        //               MaterialPageRoute(builder: (context) => about()),
        //             );
        //           },
        //         ),
        //         const Divider(),
        //         user?.uid == "RIGw9i6U0jXGRqUpdmvHYWLeKkl2"
        //             ? InkWell(
        //                 child: const ListTile(
        //                   leading: SizedBox(),
        //                   title: Text("Admin Controls"),
        //                   trailing: Icon(Icons.admin_panel_settings_rounded),
        //                 ),
        //                 onTap: () {
        //                   Navigator.of(drawerContext).push(
        //                     MaterialPageRoute(
        //                         builder: (context) => AdminControls()),
        //                   );
        //                 },
        //               )
        //             : const Divider()
        //       ],
        //     ),
        //   ),
        // )),
        body: PageView.builder(
          onPageChanged: (page) {
            setState(() {
              selectedIndex = page;
              badge = badge + 1;
            });
          },
          controller: controller,
          itemBuilder: (context, position) {
            return screens[position];
          },
          itemCount: screens.length,
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(.4),
                  offset: Offset(0, 25),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
              child: GNav(
                tabs: [
                  GButton(
                    gap: gap,
                    iconActiveColor: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Colors.white.withOpacity(.2),
                    iconSize: 24,
                    padding: padding,
                    icon: Icons.home,
                    text: 'Store',
                  ),
                  GButton(
                    gap: gap,
                    iconActiveColor: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Colors.white.withOpacity(.2),
                    iconSize: 24,
                    padding: padding,
                    icon: Icons.star,
                    text: 'Favorites',
                  ),
                  GButton(
                    gap: gap,
                    iconActiveColor: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Colors.white.withOpacity(.2),
                    iconSize: 24,
                    padding: padding,
                    icon: Icons.person,
                    leading: const CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage(
                        'assets/logos/fin.png',
                      ),
                    ),
                    text: user != null ? "${user?.displayName}" : "Finn",
                  ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  controller.jumpToPage(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
