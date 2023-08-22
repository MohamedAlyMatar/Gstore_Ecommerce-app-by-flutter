import 'package:flutter/material.dart';
import 'package:gstore/classes.dart';

class settings extends StatefulWidget {
  settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
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
                  "Settings",
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
                        child: Image.asset("assets/logos/cogwheel.png",
                            height: 150, width: 150),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: const ListTile(
                              // leading: SizedBox(),
                              title: Text(
                            "Option 1",
                            style: TextStyle(color: Colors.black87),
                          )
                              // trailing: Icon(Icons.hail_rounded),
                              ),
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => market()));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: const ListTile(
                              // leading: SizedBox(),
                              title: Text(
                            "Option 2",
                            style: TextStyle(color: Colors.black87),
                          )
                              // trailing: Icon(Icons.hail_rounded),
                              ),
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => market()));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          child: const ListTile(
                            // leading: SizedBox(),
                            title: Text(
                              "Switch to Dark Mode",
                              style: TextStyle(color: Colors.black87),
                            ),
                            trailing: Icon(Icons.dark_mode_rounded),
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
        )));
  }
}
