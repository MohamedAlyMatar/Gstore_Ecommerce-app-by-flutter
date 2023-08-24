import 'package:flutter/material.dart';
import 'package:gstore/ProductCard.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/theme/dark_theme.dart';
import 'package:gstore/theme/light_theme.dart';
import 'package:provider/provider.dart';

class favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<Favorites>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        color: Theme.of(context).colorScheme.background,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              'Favorites',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
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
        ));
  }
}
