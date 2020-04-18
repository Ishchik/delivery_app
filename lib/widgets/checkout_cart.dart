import 'package:flutter/material.dart';
import 'checkout_list.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/new_order_data.dart';

class CheckoutCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Checkout',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Container(
              height: 200,
              child: CheckoutList(),
            ),
            Text(
                'Total price ${Provider.of<NewOrderData>(context).currentOrderPrice}'),
            FlatButton(
              child: Text('Checkout'),
              onPressed: () {
                Provider.of<NewOrderData>(context, listen: false).checkOut();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
