import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/new_order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewOrderService extends ChangeNotifier {
  List<NewOrderItem> _orders = [];

  bool get hasItems {
    if (_orders.length > 0) {
      return true;
    }
    return false;
  }

  int get orderedItems {
    int counter = 0;
    for (NewOrderItem orderItem in _orders) {
      counter += orderItem.quantity;
    }
    return counter;
  }

  int get orderListLength {
    return _orders.length;
  }

  int get totalPrice {
    int totalPrice = 0;
    for (NewOrderItem orderItem in _orders) {
      totalPrice += orderItem.price;
    }
    return totalPrice;
  }

  UnmodifiableListView<NewOrderItem> get orders {
    return UnmodifiableListView(_orders);
  }

  void addOrderItem(NewOrderItem orderItem) {
    var index =
        _orders.indexWhere((item) => item.productName == orderItem.productName);

    if (index != -1) {
      var priceForPiece = orderItem.price / orderItem.quantity;
      _orders[index].quantity++;
      _orders[index].price += priceForPiece.toInt();
    } else {
      _orders.add(orderItem);
//      _orders.sort((a, b) =>
//          a.productName.toLowerCase().compareTo(b.productName.toLowerCase()));
    }

    notifyListeners();
  }

  void deleteOrderItem(NewOrderItem orderItem) {
    if (orderItem.quantity > 1) {
      var priceForPiece = orderItem.price / orderItem.quantity;
      orderItem.quantity--;
      orderItem.price -= priceForPiece.toInt();
    } else {
      _orders.remove(orderItem);
    }

    notifyListeners();
  }

  void clearOrder() {
    _orders.clear();
  }

  void checkOut(String address) async {
    try {
      DateTime now = DateTime.now();
      String time =
          '${now.day.toString()}-${now.month.toString()}-${now.year.toString()} ${now.hour.toString()}:${now.minute.toString()}';

      var _auth = FirebaseAuth.instance;
      var _user = await _auth.currentUser();
      var _firestore = Firestore.instance;

      List<Map<String, dynamic>> list = [];

      for (NewOrderItem orderItem in _orders) {
        list.add({
          'name': orderItem.productName,
          'quantity': orderItem.quantity,
          'price': orderItem.price
        });
      }

      await _firestore.runTransaction((transaction) async {
        var counterDocRef =
            _firestore.collection('order_info').document('orders');
        var idSnap = await transaction.get(counterDocRef);
        int id = idSnap.data['counter'];
        await transaction
            .update(counterDocRef, {'counter': idSnap['counter'] + 1});

        var dataDocRef = _firestore
            .collection('order_info')
            .document('orders')
            .collection(_user.email)
            .document(time);
        await transaction.set(dataDocRef, {
          'order_id': id,
          'order_time': time,
          'order_address': address,
          'total_price': totalPrice,
          'list': list,
        });
      });

      clearOrder();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
