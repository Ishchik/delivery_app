class FirestoreOrder {
  String orderAddress;
  String orderTime;
  int totalPrice;
  List orderList;

  FirestoreOrder(Map<String, dynamic> map) {
    orderAddress = map['order_address'];
    orderTime = map['order_time'];
    totalPrice = map['total_price'];
    orderList = map['list'];
  }
}
