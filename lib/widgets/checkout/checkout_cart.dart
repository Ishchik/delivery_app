import 'package:flutter/material.dart';
import 'checkout_list.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/new_order_data.dart';
import 'package:delivery_app/models/user_data.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/widgets/common_widgets/bottom_sheet_container.dart';

class CheckoutCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String address = '';

    return BottomSheetContainer(
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
                if (address.isEmpty) {
                  print('delivery address will be set to default');
                  address = Provider.of<UserData>(context, listen: false)
                      .userDefaultAddress;
                  if (address != null) {
                    if (Provider.of<NewOrderData>(context, listen: false)
                        .hasItems) {
                      Provider.of<NewOrderData>(context, listen: false)
                          .checkOut(address);
                      Navigator.pop(context);
                    } else {
                      print('seems like your cart is empty. try to fill it');
                    }
                  } else {
                    print('set up your address ot enter it in the field');
                  }
                } else {
                  if (Provider.of<NewOrderData>(context, listen: false)
                      .hasItems) {
                    Provider.of<NewOrderData>(context, listen: false)
                        .checkOut(address);
                    Navigator.pop(context);
                  } else {
                    print('seems like your cart is empty. try to fill it');
                  }
                }
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
    );
  }
}
