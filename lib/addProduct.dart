import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gstore/util.dart';

import 'classes.dart'; // Import your Product class

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
        'price': product.price,
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.LightPrimaryColor,
        title: const Text('Add Products'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _imgURLController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _rateController,
              decoration: InputDecoration(labelText: 'Rate'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
            ),
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
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('ID: ${product.productID}'),
                  // Add more details as needed
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
