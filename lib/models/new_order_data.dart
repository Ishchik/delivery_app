import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'new_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewOrderData extends ChangeNotifier {
  List<NewOrder> _orders = [];

  void addToCart(NewOrder order) {
//    var index =
//        _orders.indexWhere((item) => item.productName == order.productName);
//
//    if (index != -1) {
//      _orders[index].quantity++;
//      _orders[index].price += order.price;
//    } else {
//      _orders.add(order);
//    }
    _orders.add(order);
    _orders.sort((a, b) =>
        a.productName.toLowerCase().compareTo(b.productName.toLowerCase()));

    notifyListeners();
  }

  bool get hasItems {
    if (_orders.length > 0) {
      return true;
    }
    return false;
  }

  int get currentOrderItems {
    return _orders.length;
  }

  int get currentOrderPrice {
    int totalPrice = 0;
    for (NewOrder order in _orders) {
      totalPrice += order.price;
    }
    return totalPrice;
  }

  UnmodifiableListView<NewOrder> get orders {
    return UnmodifiableListView(_orders);
  }

  void deleteOrderItem(NewOrder order) {
    _orders.remove(order);
    notifyListeners();
  }

  void clearOrder() {
    _orders.clear();
  }

  void checkOut(String address) async {
    try {
      DateTime now = DateTime.now();
      //TODO: reimplement with server datestamp
      String time =
          '${now.day.toString()}-${now.month.toString()}-${now.year.toString()} ${now.hour.toString()}:${now.minute.toString()}:${now.second.toString()}';

      var _auth = FirebaseAuth.instance;
      var _user = await _auth.currentUser();
      var _firestore = Firestore.instance;

      List<Map<String, dynamic>> list = [];

      for (NewOrder order in _orders) {
        list.add({
          'name': order.productName,
          'quantity': order.quantity,
          'price': order.price
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
          'total_price': currentOrderPrice,
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
