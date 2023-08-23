import 'package:flutter/material.dart';
import 'package:gstore/classes.dart';
import 'package:clipboard/clipboard.dart';

import 'ProductClass.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.LightPrimaryColor,
        title: const Text('Products ID List'),
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
                      style: TextStyle(color: Colors.black87),
                    ),
                    subtitle: Text(
                      "${product.productID}",
                      style: TextStyle(color: Colors.black87),
                    ),
                    trailing: Icon(Icons.copy),
                  ),
                  onTap: () {
                    FlutterClipboard.copy(product.productID).then((value) {
                      const snackBar =  SnackBar(
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
    );
  }
}
