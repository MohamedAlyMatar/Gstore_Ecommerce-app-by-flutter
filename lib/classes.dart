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
        price: productData['price'],
        rate: productData['rate'],
        isFavorite: productData['isFavorite'],
        count: productData['count'],
      );

      allItems.add(newProduct);
    });
  } catch (e) {
    print('Error fetching products from Firestore: $e');
  }
}

// Product p7 = Product(
//     id: 00,
//     imgURL:
//     "https://lh3.googleusercontent.com/85EO9xl-z4JGi-tvUQ7DqKQh4AnU38vdj6TxIFHY3fSUV17HST3Cqzxq5TYED-JBrabjOnx4Z-wq_O7FEfE5VT1tdciZBzZu6Q=rw-e365-w240",
//     name: "Pixel 7",
//     category: "Smart Phones",
//     price: 599.00,
//     rate: 4.5);
//
// Product p7pro = Product(
//     id: 01,
//     imgURL:
//     "https://lh3.googleusercontent.com/Ik_RrezCQ6CWZIaSx-hsMu5URzSo7SJURy2nNHkcHYRInLCd2B7OfIQBsMi4NYVbZkwU1rutpmzxFP0XxapgoVq_C5yYe3s-_VU=rw-e365-w240",
//     name: "Pixel 7 Pro",
//     category: "Smart Phones",
//     price: 899.00,
//     rate: 4.5);
//
// Product p7a = Product(
//     id: 02,
//     imgURL:
//     "https://lh3.googleusercontent.com/dGdPH5SnqyGKlEAWu4cm6ADFIPggrx0vHLSDO-2R6mKL6Il2wkiI5b8NwPYq-fIIi6xtOJB7WrZys4FGHBg2n6Opqkig8tW2e28=rw-e365-w240",
//     name: "Pixel 7 a",
//     category: "Smart Phones",
//     price: 499.00,
//     rate: 4.5);
//
// Product p6a = Product(
//     id: 03,
//     imgURL:
//     "https://lh3.googleusercontent.com/k2Mz52d45JuRb5bVNbifywMqcNEDLvVV2IcM_Qgk2_6mmhwC0RxBukYqrSkjzbuEUEBLRHnYcUw6P1EIC1oreSZaOMbbzd6-TTo=rw-e365-w240",
//     name: "Pixel 6 a",
//     category: "Smart Phones",
//     price: 349.00,
//     rate: 3.5);
//
// Product pfold = Product(
//     id: 04,
//     imgURL:
//     "https://lh3.googleusercontent.com/YZsppiADx5gGay9PVIUxblsAo-cissssFnnbpDZ954sn7IXK8ctWPexj4L-5ckpwgtnyxdwAdynmzUg-ag8Gw0SzACd7nCdTug=rw-e365-w240",
//     name: "Pixel Fold",
//     category: "Smart Phones",
//     price: 1799.00,
//     rate: 4.0);



///////////////////////////////////////////////////////////////////////////////