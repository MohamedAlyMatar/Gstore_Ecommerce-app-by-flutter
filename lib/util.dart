import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:gstore/classes.dart';

////////////////////////////////////////////////////////////////////////////////

class Favorites extends ChangeNotifier {
  final List<Product> _selectedFavorites = [];

  List<Product> get selectedFavorites => _selectedFavorites;

  void SetFavorites(Product product) {
    if (_selectedFavorites.contains(product)) {
      _selectedFavorites.remove(product);
      product.isFavorite = false;
    } else {
      _selectedFavorites.add(product);
      product.isFavorite = true;
    }
    notifyListeners();
  }

  void addToFavorites(Product card) {
    if (!_selectedFavorites.contains(card)) {
      _selectedFavorites.add(card);
    } else {
      removeFromFavorites(card);
    }
    notifyListeners();
  }

  void removeFromFavorites(Product card) {
    _selectedFavorites.remove(card);
    notifyListeners();
  }
}

////////////////////////////////////////////////////////////////////////////////

class Bucket extends ChangeNotifier {
  final List<Product> _products = [];
  double total = 0;
  double totalCount = 0;

  List<Product> get products => _products;

  // A map to store the count of each product.
  final Map<int, int> _productCountMap = {};

  int getProductCount(int productId) {
    return _productCountMap[productId] ?? 0;
  }

  Future<void> addToBucket(Product product) async {
    if (product.count == 0) {
      _products.add(product);
    }
    int newCount = product.count++;
    try {
      // Update the count in Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.productID)
          .update({'count': newCount});

      // Update the count in the local list (allItems)
      final index = allItems.indexWhere((p) => p.productID == product.productID);
      if (index != -1) {
        allItems[index].count = newCount;
      }
    } catch (e) {
      print('Error updating product count: $e');
    }
    totalCount++;
    total += (product.price); // Increment the count for the added product
    notifyListeners();
  }

  void removeFromBucket(Product product) {
    if (product.count > 0) {
      product.count--;
      totalCount--;
      total -= (product.price); // Decrement the count for the removed product
    } else {
      _products.remove(product);
    }
    notifyListeners();
  }
}

////////////////////////////////////////////////////////////////////////////////

final ThemeData myThemeData = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 30, fontWeight: FontWeight.w300, color: Colors.white),
    titleMedium: TextStyle(fontSize: 20, color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(fontSize: 18, color: Colors.green),
    bodySmall: TextStyle(
      fontSize: 14,
      color: Colors.indigo,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    ),
  ),
);


////////////////////////////////////////////////////////////////////////////////

class MyColors {
  static Color LightText = Colors.white;
  static Color DarkText = Colors.black45;

  // Light theme colors
  static Color LightPrimaryColor = HexColor("#005792");
  static Color LightAccentColor = HexColor("#E55807");
  static Color LightBackgroundColor = HexColor("#F6F6E9");

// Dark theme colors
// static Color DarkPrimaryColor = HexColor("#2F2519");
// static Color DarkAccentColor = HexColor("#FF4301");
// static Color DarkBackgroundColor = HexColor("#4A3F35");
}

class AppThemes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: MyColors.LightPrimaryColor,
    hintColor: MyColors.LightAccentColor,
  );

// static final ThemeData darkTheme = ThemeData.dark().copyWith(
//   brightness: Brightness.dark,
//   primaryColor: MyColors.DarkPrimaryColor,
//   hintColor: MyColors.DarkAccentColor,
// );
}
