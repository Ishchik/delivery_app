import 'package:delivery_app/models/firestore_product.dart';

class NewOrderItem {
  String productName;
  int quantity = 1;
  int price;

  NewOrderItem(FirestoreProduct product)
      : productName = product.productName,
        price = product.productPrice;
}
