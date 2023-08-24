import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

import 'ProductClass.dart'; // Import your Product class

class addProduct extends StatefulWidget {
  @override
  _addProductState createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _imgURLController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  // Function to add a new product to Firebase
  Future<void> addProductToFirestore(Product product) async {
    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('products').add({
        'productID': product.productID,
        'imgURL': product.imgURL,
        'name': product.name,
        'category': product.category,
        'price': product.price.toDouble(),
        'rate': product.rate,
        'isFavorite': product.isFavorite,
        'count': product.count,
      });

      // Get the auto-generated document ID
      String documentId = docRef.id;

      // Store the document ID in your Product object or wherever you need it
      product.productID = documentId;

      print('Product added to Firestore.');
    } catch (e) {
      print('Error adding product to Firestore: $e');
    }
  }

  void _addProduct() {
    Product newProduct = Product(
      productID: _idController.text,
      imgURL: _imgURLController.text,
      name: _nameController.text,
      category: _categoryController.text,
      price: double.parse(_priceController.text),
      rate: double.parse(_rateController.text),
    );

    addProductToFirestore(newProduct);

    setState(() {
      // Update the list of products (assuming you have a list called 'allItems')
      allItems.add(newProduct);
    });

    // Clear the input fields
    _idController.clear();
    _imgURLController.clear();
    _nameController.clear();
    _categoryController.clear();
    _priceController.clear();
    _rateController.clear();
  }

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
              'Add Products',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                TextField(
                  controller: _imgURLController,
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary)),
                ),
                TextField(
                  controller: _rateController,
                  decoration: InputDecoration(
                    labelText: 'Rate',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _addProduct,
                  child: Text(
                    'Add Product',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
