import 'package:flutter/material.dart';
import 'package:gstore/util.dart';

class help extends StatefulWidget {
  help({Key? key}) : super(key: key);

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {

  /////////////////////////////////////////////////////////////////////////////

  Widget _textField(String text) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////

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
          "Help Desk",
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
                    child: Image.asset("assets/logos/help-desk.png",
                        height: 150, width: 150),
                  ),
                  _textField("Don't worry traveler, I am CJ, here to guide you"),
                  _textField("In the market page:"),
                  _textField("you can search for any products using the search bar"),
                  _textField("press the product image to see its full description"),
                  _textField("press the cart button to add it to your list"),
                  _textField("(notice how the counter increments)"),
                  _textField("press the heart button"),
                  _textField("to add the product to the favorites page"),
                  _textField("pressing the floating bag button"),
                  _textField("will take you to your cart list"),
                  _textField("at the bottom you"),
                  _textField("will see a navigation bar that switch you"),
                  _textField("between the pages store, favorites, and your profile"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
