import 'package:delivery_app/widgets/order/order_future_builder.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrderFutureBuilder(),
    );
  }
}
