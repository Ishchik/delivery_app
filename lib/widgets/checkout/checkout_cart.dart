import 'package:flutter/material.dart';
import 'checkout_list.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/new_order_data.dart';
import 'package:delivery_app/constants.dart';

class CheckoutCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String address = '';

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
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                address = value;
              },
              decoration:
              kTextFieldDecoration.copyWith(hintText: 'Enter address'),
            ),
            FlatButton(
              child: Text('Checkout'),
              onPressed: () {
                try {
                  if (address.isNotEmpty) {
                    if (Provider
                        .of<NewOrderData>(context, listen: false)
                        .hasItems) {
                      Provider.of<NewOrderData>(context, listen: false)
                          .checkOut(address);
                      Navigator.pop(context);
                    } else {
                      print('seems like your cart is empty. try to fill it');
                    }
                  } else {
                    print('enter address');
                  }
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
