import 'package:flutter/material.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/ThemeManager.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

class settings extends StatefulWidget {
  settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
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
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: Icon(
                IconData(0xe093,
                    fontFamily: 'MaterialIcons', matchTextDirection: true),
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Settings",
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
                        child: Image.asset("assets/logos/cogwheel.png",
                            height: 150, width: 150),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: ListTile(
                            tileColor: Theme.of(context).colorScheme.primary,
                            title: Text(
                              ThemeManager.isDarkMode
                                  ? 'Switch to Light Mode'
                                  : 'Switch to Dark Mode',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            trailing: Icon(
                              ThemeManager.isDarkMode
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          onTap: () {
                            ThemeManager.toggleTheme(context); // Toggle the theme
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
                              "Option 2",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            trailing: Icon(
                              Icons.keyboard_option_key_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => market()));
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
