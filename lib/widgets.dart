import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'classes.dart';

class MyWidgets {
  Widget entryField1(String title, String hint, bool isobsecure,
      TextEditingController controller, Icon entryicon) {
    return TextField(
        controller: controller,
        obscureText: isobsecure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: title,
          hintText: hint,
          prefixIcon: entryicon,
        ));
  }

  Widget entryField2(String title, String hint, bool isobsecure, Icon entryicon,
      [TextEditingController? controller]) {
    return TextField(
      controller: controller,
      obscureText: isobsecure,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: title,
        hintText: hint,
        prefixIcon: entryicon,
      ),
    );
  }

  Widget entryField3(String title, String hint, bool isobsecure,
      [Icon? entryicon]) {
    return TextField(
      obscureText: isobsecure,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: title,
        hintText: hint,
        prefixIcon: entryicon,
      ),
    );
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

  Widget submitButton(String text, void Function() action) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: MyColors.LightPrimaryColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: action,
      child: Text(text),
    );
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
