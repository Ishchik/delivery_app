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
            final orderItemData = orderData.orders[index];
            return Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            '${orderItemData.productName} ',
                            style: kParagraph1TextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Total - ${orderItemData.price} USD',
                            style: kParagraph3TextStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add),
                          iconSize: 25,
                          onPressed: () =>
                              orderData.addOrderItem(orderItemData),
                        ),
                        Container(
                          child: Text(
                            '${orderItemData.quantity}',
                            style: kParagraph2TextStyle,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(3),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          iconSize: 25,
                          onPressed: () =>
                              orderData.deleteOrderItem(orderItemData),
                        ),
                      ],
                    ),
                  ],
                ),
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
