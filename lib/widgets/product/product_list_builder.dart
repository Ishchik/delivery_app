import 'package:delivery_app/screens/product_edit_screen.dart';
import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/services/new_order_service.dart';
import 'package:delivery_app/models/new_order_item.dart';
import 'package:delivery_app/models/firestore_product.dart';
import 'package:delivery_app/widgets/common_widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

enum type { USER, ADMIN }

class ProductListBuilder extends StatelessWidget {
  final String productTab;
  final type futureBuilderType;

  ProductListBuilder(
      {@required this.futureBuilderType, @required this.productTab});

  void _userButtonAction(FirestoreProduct product, BuildContext context) {
    NewOrderItem _order = NewOrderItem(product);
    Provider.of<NewOrderService>(context, listen: false).addOrderItem(_order);
  }

  void _adminButtonAction(FirestoreProduct product, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductEditScreen(
          product: product,
          tabName: productTab,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProductService>(
        builder: (_, firestoreProduct, __) {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final product = firestoreProduct.getList(productTab)[index];
          return ProductItem(
            product: product,
            button: futureBuilderType == type.USER
                ? CardButton(
                    onPressed: () => _userButtonAction(product, context),
                    text: 'Add to cart',
                  )
                : CardButton(
                    onPressed: () => _adminButtonAction(product, context),
                    text: 'Edit',
                  ),
          );
        },
        itemCount: firestoreProduct.listLength(productTab),
      );
    });
  }
}
