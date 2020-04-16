import 'package:flutter/foundation.dart';
import 'order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderData extends ChangeNotifier {
  List<Order> _orders = [];

  void addToCart(Order order) {
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

  int get currentOrderItems {
    return _orders.length;
  }

  int get currentOrderPrice {
    int price = 0;
    for (Order order in _orders) {
      price += order.price;
    }

    return price;
  }

  void checkOut() async {
    if (_orders.isNotEmpty) {
      DateTime now = DateTime.now();
      String time =
          '${now.day.toString()}-${now.month.toString()}-${now.year.toString()} ${now.hour.toString()}:${now.minute.toString()}';

      var _auth = FirebaseAuth.instance;
      var _user = await _auth.currentUser();
      var _firestore = Firestore.instance;

      List<Map<String, dynamic>> list = [];

      for (Order order in _orders) {
        list.add({
          'name': order.productName,
          'quantity': order.quantity,
          'price': order.price
        });
      }

      await _firestore
          .collection('order_info')
          .document('orders')
          .collection(_user.email)
          .document(time)
          .setData({
        'order_time': time,
        'order_address': 'some address',
        'total_price': currentOrderPrice,
        'list': list
      });

      _orders.clear();
      notifyListeners();
    }
  }
  //TODO: implement checkout method

}
