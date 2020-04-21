import 'package:flutter/material.dart';
import 'package:delivery_app/models/new_order_data.dart';
import 'package:provider/provider.dart';

class CheckoutList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewOrderData>(
      builder: (context, orderData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final data = orderData.orders[index];
            return ListTile(
              title: Text('${data.productName} (${data.quantity})'),
              trailing: Text('${data.price}'),
              onLongPress: () {
                orderData.deleteOrderItem(data);
              },
            );
          },
          itemCount: orderData.currentOrderItems,
        );
      },
    );
  }
}