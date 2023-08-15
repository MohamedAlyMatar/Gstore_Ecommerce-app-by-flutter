import 'package:flutter/material.dart';
import 'package:gstore/products.dart';
import 'package:gstore/util.dart';
import 'package:provider/provider.dart';

class favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<Favorites>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.LightPrimaryColor,
        title: Text('Favorites', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favorites.selectedFavorites.length,
        itemBuilder: (context, index) {
          final product = favorites.selectedFavorites[index];
          return productCard(
            p: product,
            isFavorite: favorites.selectedFavorites.contains(product),
          );
        },
      ),
    );
  }
}