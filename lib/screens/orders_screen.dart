import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/order/order_future_builder.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
//          TopBar(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text(
//                    'Items in order: ${Provider.of<NewOrderData>(context).currentOrderItems}'),
//                Text(
//                    'Order price: ${Provider.of<NewOrderData>(context).currentOrderPrice}'),
//                FlatButton(
//                  child: Text('Checkout'),
//                  onPressed: () {
//                    Provider.of<NewOrderData>(context, listen: false)
//                        .checkOut();
//                  },
//                )
//              ],
//            ),
//          ),
          Expanded(
            child: OrderFutureBuilder(),
          ),
        ],
      ),
    );
  }
}
