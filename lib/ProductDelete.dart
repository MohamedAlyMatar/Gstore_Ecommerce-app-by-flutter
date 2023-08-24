import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';

class ProductDelete extends StatefulWidget {
  @override
  _ProductDeleteState createState() => _ProductDeleteState();
}

class _ProductDeleteState extends State<ProductDelete> {
  TextEditingController productIdController = TextEditingController();

  // Function to delete a product
  Future<void> deleteProductFromFirestore(String documentId) async {
    try {
      // Check if the document exists before attempting to delete it
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(documentId)
          .get();

      if (docSnapshot.exists) {
        // Document exists, so delete it
        await FirebaseFirestore.instance
            .collection('products')
            .doc(documentId)
            .delete();

        print('Product deleted from Firestore.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product deleted successfully.'),
          ),
        );
      } else {
        print('Product with ID $documentId does not exist.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product with ID $documentId does not exist.'),
          ),
        );
      }
    } catch (e) {
      print('Error deleting product from Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting product: $e'),
        ),
      );
    }
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
              'Delete Products',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: productIdController,
                  decoration:
                      InputDecoration(labelText: 'Product ID to Delete'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String productIdToDelete = productIdController.text;
                    // Call the function to delete the product using the entered ID
                    deleteProductFromFirestore(productIdToDelete);
                  },
                  child: Text(
                    'Delete Product',
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
