import 'package:flutter/material.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

class about extends StatefulWidget {
  about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: Icon(
                const IconData(
                  0xe093,
                  fontFamily: 'MaterialIcons',
                  matchTextDirection: true,
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "About",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Container(
                    // color: Theme.of(context).colorScheme.background,
                    // Change the background color of the entire drawer
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset("assets/logos/flutter.png",
                              height: 150, width: 150),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Welcome to my first app!",
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "This app was built as a final project\nfor my flutter course with GDSC-ASU",
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Under the super-vision of the instructors\nMohamed Mahmoud and George Joseph",
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "It's basically an e-commerce app\nfor the products of Google company",
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
