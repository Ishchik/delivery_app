import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/firestore_product_data.dart';
import 'package:delivery_app/models/new_order_data.dart';
import 'package:delivery_app/models/new_order.dart';
import 'package:delivery_app/widgets/common_widgets/card_button.dart';
import 'package:delivery_app/screens/product_edit_screen.dart';

enum type { USER, ADMIN }

class ProductListBuilder extends StatelessWidget {
  final String productTab;
  final type futureBuilderType;

  ProductListBuilder({this.futureBuilderType, this.productTab});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var product = Provider.of<FirestoreProductData>(context)
            .getList(productTab)[index];
        return ProductItem(
          product: product,
          button: futureBuilderType == type.USER
              ? CardButton(
                  onPressed: () {
                    NewOrder _order = NewOrder(product);
                    Provider.of<NewOrderData>(context, listen: false)
                        .addToCart(_order);
                  },
                  text: 'Add to cart',
                )
              : CardButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductEditScreen(
                          product: product,
                          tabName: productTab,
                        ),
                      ),
                    );
                  },
                  text: 'Edit',
                ),
        );
      },
      itemCount:
          Provider.of<FirestoreProductData>(context).listLength(productTab),
    );
  }
}
