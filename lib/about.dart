import 'package:flutter/material.dart';
import 'package:gstore/util.dart';

class about extends StatefulWidget {
  about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "About",
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
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset("assets/logos/flutter.png",
                        height: 150, width: 150),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Welcome to my first app!",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "This app was built as a final project\nfor my flutter course with GDSC-ASU",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Under the super-vision of the instructors\nMohamed Mahmoud and George Joseph",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "It's basically an e-commerce app\nfor the products of Google company",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
