import 'package:delivery_app/models/firestore_product.dart';

class NewOrder {
  String productName;
  final int quantity = 1;
  int price;

  NewOrder(FirestoreProduct product) {
    this.productName = product.name;
    this.price = product.price;
  }
}
