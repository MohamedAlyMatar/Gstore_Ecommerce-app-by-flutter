import 'package:gstore/BucketScreen.dart';
import 'package:gstore/products.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gstore/util.dart';
import 'package:provider/provider.dart';
import 'classes.dart';

class garden extends StatefulWidget {
  garden({Key? key}) : super(key: key);
  @override
  State<garden> createState() => _gardenState();
}

class _gardenState extends State<garden> {
  final controller = TextEditingController();
  List<Product> items = allItems; // Your complete list of products
  List<Product> filteredItems = allItems; // Initially, it contains all products

  void searchItems(String query) {
    final suggestions = allItems.where((item) {
      final itemTitle = item.name.toLowerCase();
      final input = query.toLowerCase();
      return itemTitle.contains(input);
    }).toList();
    setState(() => filteredItems = suggestions);
  }

  //////////////////////////////////////////////////



  @override
  Widget build(BuildContext context) {
    final bucket = Provider.of<Bucket>(context);
    fetchProductsFromFirestore();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            // color: MyColors.LightBackgroundColor,
            child: SingleChildScrollView(
              child: Center(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Headphones',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.blue))),
                        onChanged: searchItems,
                      ),
                    ),
                    Expanded(
                        child: Center(
                      child: Wrap(
                        // children: allItems.map((item) => productCard(p: item)).toList(),
                        children: filteredItems
                            .map((item) => productCard(p: item, isFavorite: false, ))
                            .toList(),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: MyColors.LightAccentColor,
            child: badges.Badge(
              badgeContent:  Text('${bucket.totalCount}', style: TextStyle(color: Colors.white),),
              badgeStyle:
                  const badges.BadgeStyle(shape: badges.BadgeShape.circle),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      _createPageRoute(),
                    );
                  }, icon: const Icon(Icons.shopping_bag)),
            ),
          ),
        ),
      ),
    );
  }

  PageRouteBuilder _createPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BucketScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        // If the user swiped right-to-left, change the animation direction accordingly.
        if (animation.status == AnimationStatus.reverse) {
          begin = Offset(-1.0, 0.0);
          end = Offset.zero;
        }

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}