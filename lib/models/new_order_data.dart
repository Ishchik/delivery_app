import 'package:flutter/foundation.dart';
import 'new_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewOrderData extends ChangeNotifier {
  List<NewOrder> _orders = [];

  void addToCart(NewOrder order) {
    var index =
        _orders.indexWhere((item) => item.productName == order.productName);

    if (index != -1) {
      _orders[index].quantity++;
      _orders[index].price += order.price;
    } else {
      _orders.add(order);
    }

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

  void checkOut() async {
    if (_orders.isNotEmpty) {
      try {
        DateTime now = DateTime.now();
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
          var snap = await transaction.get(counterDocRef);
          int id = snap.data['counter'];
          await transaction
              .update(counterDocRef, {'counter': snap['counter'] + 1});

          var dataDocRef = _firestore
              .collection('order_info')
              .document('orders')
              .collection(_user.email)
              .document(time);
          await transaction.set(dataDocRef, {
            'order_id': id,
            'order_time': time,
            'order_address': 'some address',
            'total_price': currentOrderPrice,
            'list': list,
          });
        });

        _orders.clear();
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }
}
