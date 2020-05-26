import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/services/new_order_service.dart';
import 'package:provider/provider.dart';

class CheckoutList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewOrderService>(
      builder: (context, orderData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final data = orderData.orders[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  '${data.productName} (${data.quantity})',
                  style: kParagraph2TextStyle,
                ),
                trailing: Text(
                  '${data.price}',
                  style: kParagraph2TextStyle,
                ),
                onLongPress: () {
                  orderData.deleteOrderItem(data);
                },
              ),
            );
          },
          itemCount: orderData.orderListLength,
          physics: BouncingScrollPhysics(),
        );
      },
    );
  }
}
