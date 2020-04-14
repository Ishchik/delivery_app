import 'package:delivery_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopBar(),
        Expanded(
          flex: 12,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    OrderCard(),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
