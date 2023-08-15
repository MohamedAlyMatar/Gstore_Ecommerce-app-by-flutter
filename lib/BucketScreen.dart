import 'package:flutter/material.dart';
import 'package:gstore/util.dart';
import 'package:provider/provider.dart';

class BucketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bucket = Provider.of<Bucket>(context);

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.LightAccentColor,
          // title: MyText("G-Store", MyColors.LightText, 25.0),
          title: Text(
            "Cloud Cart",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true),
      body: ListView.builder(
        itemCount: bucket.products.length,
        itemBuilder: (context, index) {
          final product = bucket.products[index];
          final count = bucket.getProductCount(product.id);
          return Card(
            child: ListTile(
              leading: Image.network(
                product.imgURL,
                width: 40,
                height: 40,
              ),
              title: Text(product.name),
              subtitle: Text('\$ ${product.price * product.count}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      bucket.removeFromBucket(product);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  Text('Count: ${product.count}'),
                  // Display the product count
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total Cost: \$ ${bucket.total}', // Display the total cost
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
