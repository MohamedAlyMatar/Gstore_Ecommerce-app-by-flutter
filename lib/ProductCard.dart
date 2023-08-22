import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gstore/classes.dart';
import 'package:provider/provider.dart';
import './ClassProduct.dart';
import 'description.dart';

class productCard extends StatefulWidget {
  final Product p;
  final bool isFavorite;
  productCard({Key? key, required this.p, required this.isFavorite})
      : super(key: key);

  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<Favorites>(context);

    return Card(
      child: SizedBox(
        width: 170,
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                  child: Image.network(
                    widget.p.imgURL,
                    width: 100,
                    height: 100,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => description(product: widget.p,)));
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.p.name,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.p.category,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              RatingBar.builder(
                initialRating: widget.p.rate,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 12,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  if (kDebugMode) {
                    print(rating);
                  }
                },
              ),
              // const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$ ${widget.p.price}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.isFavorite) {
                              favorites.removeFromFavorites(widget.p);
                            } else {
                              favorites.addToFavorites(widget.p);
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: 15,
                        )),
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: MyColors.LightAccentColor,
                    child: IconButton(
                        onPressed: () {
                          final bucket = Provider.of<Bucket>(context, listen: false);
                          bucket.addToBucket(widget.p);
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart_outlined,
                          color: Colors.white,
                          size: 15,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
