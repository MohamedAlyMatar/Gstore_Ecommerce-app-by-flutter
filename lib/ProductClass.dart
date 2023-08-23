import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late final String productID;
  final String imgURL;
  final String name;
  final String category;
  final double price;
  final double rate;
  late final bool isFavorite;

  int count; // The count for the product

  Product({
    required this.productID,
    required this.imgURL,
    required this.name,
    required this.category,
    required this.price,
    required this.rate,
    this.count = 0, // Default count is 0
    this.isFavorite = false // Default is false
  });
}

List<Product> allItems = [];

Future<void> fetchProductsFromFirestore() async {
  try {
    final QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('products').get();

    allItems.clear();

    querySnapshot.docs.forEach((doc) {
      var productData = doc.data() as Map<String, dynamic>;
      Product newProduct = Product(
        productID: productData['productID'],
        imgURL: productData['imgURL'],
        name: productData['name'],
        category: productData['category'],
        price: productData['price'].toDouble(),
        rate: productData['rate'].toDouble(),
        isFavorite: productData['isFavorite'],
        count: productData['count'],
      );

      allItems.add(newProduct);
    });
  } catch (e) {
    print('Error fetching products from Firestore: $e');
  }
}