import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:delivery_app/models/firestore_order.dart';
import 'order_card.dart';

class OrderFutureBuilder extends StatelessWidget {
  Future<List<Map<String, dynamic>>> getData() async {
    var _user = await FirebaseAuth.instance.currentUser();
    var _firestore = Firestore.instance;
    var _querySnapshot = await _firestore
        .collection('order_info')
        .document('orders')
        .collection(_user.email)
        .orderBy('order_id')
        .getDocuments();

    return _querySnapshot.documents.map((snap) => snap.data).toList();
  }

  Widget orderListViewBuilder(BuildContext context, AsyncSnapshot snapshot) {
    List<Map<String, dynamic>> list = snapshot.data;

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        FirestoreOrder order = FirestoreOrder(list[index]);
        return OrderCard(
          orderAddress: order.orderAddress,
          orderDate: order.orderTime,
          orderID: order.orderID,
          orderList: order.orderList,
          totalPrice: order.totalPrice,
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return orderListViewBuilder(context, snapshot);
      },
    );
  }
}
