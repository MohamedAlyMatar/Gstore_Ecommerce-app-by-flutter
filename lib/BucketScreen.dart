import 'package:flutter/material.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/payment.dart';
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
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0), // Add padding
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the payment page
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => payment(), // Replace with your payment page
            ));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.orange, // Match the button color with the background color
            padding: EdgeInsets.symmetric(vertical: 12.0), // Adjust the vertical padding
            shape: StadiumBorder(), // Oval or rounded rectangular shape
          ),
          child: Padding( 
            padding:EdgeInsets.all(5),
            child: Text(
            '\$ ${bucket.total}', // Display the total cost
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color (usually white on colored backgrounds)
            ),
          ),
        ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(), // This is optional and can be an empty SizedBox
      ),
    );
  }
}
