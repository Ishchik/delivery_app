import 'package:flutter/material.dart';
import 'package:delivery_app/models/firestore_product.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/new_order_data.dart';
import 'package:delivery_app/models/new_order.dart';
import 'package:delivery_app/widgets/common_widgets/card_button.dart';

class ProductItem extends StatelessWidget {
  final FirestoreProduct product;

  ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4)),
                child: Image(
                  image: NetworkImage(product.imageUrl),
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          product.listString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Price',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${product.price} USD',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    CardButton(
                      onPressed: () {
                        NewOrder _order = NewOrder(product);
                        Provider.of<NewOrderData>(context, listen: false)
                            .addToCart(_order);
                      },
                      text: 'Add to cart',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
