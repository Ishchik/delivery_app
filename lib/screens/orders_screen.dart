import 'package:delivery_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/order_data.dart';
import 'package:delivery_app/widgets/order_future_builder.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                  'Items in order: ${Provider.of<OrderData>(context).currentOrderItems}'),
              Text(
                  'Order price: ${Provider.of<OrderData>(context).currentOrderPrice}'),
              FlatButton(
                child: Text('Checkout'),
                onPressed: () {
                  Provider.of<OrderData>(context, listen: false).checkOut();
                },
              )
            ],
          ),
        ),
        Expanded(
          child: OrderFutureBuilder(),
        ),
      ],
    );
  }
}
