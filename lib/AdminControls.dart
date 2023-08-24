import 'package:flutter/material.dart';
import 'package:gstore/ProductList.dart';
import 'package:gstore/ProductAdd.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

import 'ProductDelete.dart';

class AdminControls extends StatefulWidget {
  AdminControls({Key? key}) : super(key: key);

  @override
  State<AdminControls> createState() => _AdminControlsState();
}

class _AdminControlsState extends State<AdminControls> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        color: Theme.of(context).colorScheme.background,
        home: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: Icon(IconData(0xe093,
                  fontFamily: 'MaterialIcons', matchTextDirection: true),color: Theme.of(context).colorScheme.secondary,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Admin Controls",
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
                        child: Image.asset("assets/logos/user.png",
                            height: 150, width: 150),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: ListTile(
                            // leading: SizedBox(),
                            tileColor: Theme.of(context).colorScheme.primary,
                            title: Text(
                              "View Products",
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            ),
                            trailing: Icon(Icons.list, color: Theme.of(context).colorScheme.secondary,),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductList()));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: ListTile(
                            // leading: SizedBox(),
                            tileColor: Theme.of(context).colorScheme.primary,
                            title: Text(
                              "Add Products",
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            ),
                            trailing: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary,),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => addProduct()));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: ListTile(
                            // leading: SizedBox(),
                            tileColor: Theme.of(context).colorScheme.primary,
                            title: Text(
                              "Delete Products",
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            ),
                            trailing: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.secondary,),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductDelete()));
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
