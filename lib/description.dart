import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

import 'ProductClass.dart';

class description extends StatefulWidget {
  final Product product;

  description({Key? key, required this.product}) : super(key: key);

  @override
  State<description> createState() => _descriptionState();
}

class _descriptionState extends State<description> {
  /////////////////////////////////////////////////////////////////////////////

  Widget _textField(String text) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            // children: myContacts.map((e) => contactCard(e)).toList()
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  child: ListTile(
                      // tileColor: Theme.of(context).colorScheme.primary,
                      leading: IconButton(
                        icon: Icon(
                          const IconData(0xe093,
                              fontFamily: 'MaterialIcons',
                              matchTextDirection: true),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      title: Text(
                        "Back to store",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary),
                      )
                      // trailing: Icon(Icons.hail_rounded),
                      ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Image.network(
                widget.product.imgURL,
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.product.name,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: ExpansionTile(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  leading: Icon(Icons.description, color: Theme.of(context).colorScheme.secondary,),
                  title: Text(
                    "Description",
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 15),
                  ),
                  children: [
                    _textField("Official name: Google ${widget.product.name}"),
                    _textField("Category:${widget.product.category}"),
                    _textField("Rate: ${widget.product.rate} stars"),
                    _textField("Price: ${widget.product.price}"),
                    _textField("More information will be added soon...")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
