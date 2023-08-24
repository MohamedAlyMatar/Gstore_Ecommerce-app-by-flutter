import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

import 'ProductClass.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
                IconData(0xe093,
                    fontFamily: 'MaterialIcons', matchTextDirection: true),
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Products ID List',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 32.0),
                const Text(
                  'Product List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                // Display the list of products
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: allItems.length,
                  itemBuilder: (context, index) {
                    Product product = allItems[index];
                    return InkWell(
                      child: ListTile(
                        // leading: SizedBox(),
                        title: Text(
                          "${product.name}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        subtitle: Text(
                          "${product.productID}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        trailing: Icon(
                          Icons.copy,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      onTap: () {
                        FlutterClipboard.copy(product.productID).then((value) {
                          const snackBar = SnackBar(
                            content: Text('Product ID copied to clipboard'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
