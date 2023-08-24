import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'classes.dart';

class MyWidgets {
  Widget entryField1(
      // BuildContext context,
      String title,
      String hint,
      bool isobsecure,
      TextEditingController controller,
      Icon entryicon,
      ColorScheme colorScheme) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
            controller: controller,
            obscureText: isobsecure,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.tertiary, width: 0.0),
                borderRadius: BorderRadius.circular(20),
              ),
              // fillColor: colorScheme.primary,
              // filled: true,
              labelText: title,
              hintText: hint,
              labelStyle: TextStyle(color: colorScheme.tertiary),
              hintStyle: TextStyle(color: colorScheme.tertiary),
              prefixIcon: entryicon != null
                  ? Icon(entryicon.icon, color: colorScheme.tertiary)
                  : null,
            )));
  }

  Widget entryField2(ColorScheme colorScheme, String title, String hint,
      bool isobsecure, Icon entryicon,
      [TextEditingController? controller]) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: controller,
          obscureText: isobsecure,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            // fillColor: colorScheme.primary,
            // filled: true,
            labelText: title,
            hintText: hint,
            labelStyle: TextStyle(color: colorScheme.tertiary),
            hintStyle: TextStyle(color: colorScheme.tertiary),
            prefixIcon: entryicon != null
                ? Icon(entryicon.icon, color: colorScheme.tertiary)
                : null,
          ),
        ));
  }

  Widget entryField3(String title, String hint, bool isobsecure,
      [Icon? entryicon]) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          obscureText: isobsecure,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: title,
            hintText: hint,
            prefixIcon: entryicon,
          ),
        ));
  }

  Widget inkButton(String text, Color c, [Icon? entryicon]) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          color: c,
          // Set the background color to red
          child: ListTile(
            leading: entryicon,
            title: Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
            // trailing: ,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget submitButton(
      ColorScheme colorScheme, String text, void Function() action) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colorScheme.primary,
            onPrimary: colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: action,
          child: Text(text),
        ));
  }

  void showPopupMessage(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
