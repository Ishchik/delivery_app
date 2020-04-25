import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/firestore_product_data.dart';
import 'package:delivery_app/models/new_order_data.dart';
import 'package:delivery_app/models/new_order.dart';
import 'package:delivery_app/widgets/common_widgets/card_button.dart';
import 'package:delivery_app/screens/product_edit_screen.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:delivery_app/models/firestore_product.dart';

enum type { USER, ADMIN }

//            IT ALSO WORK BUT LOADING UP FIRESTORE MORE

//class ProductFutureBuilder extends StatelessWidget {
//  final type futureBuilderType;
//  final String productTab;
//  ProductFutureBuilder({this.productTab, this.futureBuilderType});
//
//  Future<List<Map<String, dynamic>>> getData() async {
//    var _firestore = Firestore.instance;
//    var _querySnapshot = await _firestore
//        .collection('product_info')
//        .document('${productTab}_info')
//        .collection(productTab)
//        .getDocuments();
//
//    return _querySnapshot.documents.map((snap) => snap.data).toList();
//  }
//
//  Widget listViewBuilder(BuildContext context, AsyncSnapshot snapshot) {
//    List<Map<String, dynamic>> list = snapshot.data;
//
//    return ListView.builder(
//      itemBuilder: (context, index) {
//        FirestoreProduct product = FirestoreProduct(list[index]);
//        return futureBuilderType == type.USER
//            ? ProductItem(
//                product: product,
//              )
//            : Text('admin');
//      },
//      itemCount: list.length,
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//      future: getData(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//            child: CircularProgressIndicator(),
//          );
//        }
//        return listViewBuilder(context, snapshot);
//      },
//    );
//  }
//}

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
                            builder: (context) =>
                                ProductEditScreen(product: product)));
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
