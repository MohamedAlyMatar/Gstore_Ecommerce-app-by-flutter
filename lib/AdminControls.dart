import 'package:flutter/material.dart';
import 'package:gstore/addProduct.dart';
import 'package:gstore/classes.dart';

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
                  "Admin Controls",
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
                                    "Add Products",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                trailing: Icon(Icons.add),
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
                              child: const ListTile(
                                // leading: SizedBox(),
                                title: Text(
                                  "Delete Products",
                                  style: TextStyle(color: Colors.black87),
                                ),
                                trailing: Icon(Icons.delete_forever),
                              ),
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => addProduct()));
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
