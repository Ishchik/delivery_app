import 'package:flutter/material.dart';
import 'product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/firestore_product.dart';

class ProductFutureBuilder extends StatelessWidget {
  final String productTab;
  ProductFutureBuilder({this.productTab});

  Future<List<Map<String, dynamic>>> getData() async {
    var _firestore = Firestore.instance;
    var _querySnapshot = await _firestore
        .collection('product_info')
        .document('${productTab}_info')
        .collection(productTab)
        .getDocuments();

    return _querySnapshot.documents.map((snap) => snap.data).toList();
  }

  Widget listViewBuilder(BuildContext context, AsyncSnapshot snapshot) {
    List<Map<String, dynamic>> list = snapshot.data;

    return ListView.builder(
      itemBuilder: (context, index) {
        FirestoreProduct product = FirestoreProduct(list[index]);
        return ProductItem(
          productTitle: product.name,
          productPrice: product.price,
          productContent: product.listString(),
          imageUrl: product.imageUrl,
        );
      },
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
//          return CircularProgressIndicator();
          return Text('Loading...');
        }
        return listViewBuilder(context, snapshot);
      },
    );
  }
}
