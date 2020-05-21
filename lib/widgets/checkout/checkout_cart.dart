import 'package:flutter/material.dart';
import 'checkout_list.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/services/new_order_service.dart';
import 'package:delivery_app/services/user_data_service.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/widgets/common_widgets/flexible_bottom_sheet.dart';
import 'package:delivery_app/widgets/common_widgets/big_button.dart';

class CheckoutCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String address = '';
    return FlexibleBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Checkout',
              style: kHeaderTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 200,
            child: CheckoutList(),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Total price ${Provider.of<NewOrderService>(context).totalPrice}',
              style: kParagraph2TextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          TextField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              address = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter address'),
          ),
          BigButton(
            buttonColor: Colors.red,
            text: 'Checkout',
            textColor: Colors.white,
            onPressed: () {
              try {
                if (address.isEmpty) {
                  print('delivery address will be set to default');
                  address = Provider.of<UserDataService>(context, listen: false)
                      .userDefaultAddress;
                  if (address != null) {
                    if (Provider.of<NewOrderService>(context, listen: false)
                        .hasItems) {
                      Provider.of<NewOrderService>(context, listen: false)
                          .checkOut(address);
                      Navigator.pop(context);
                    } else {
                      print('enter your address');
                    }
                  } else {
                    print('set up your address ot enter it in the field');
                  }
                } else {
                  if (Provider.of<NewOrderService>(context, listen: false)
                      .hasItems) {
                    Provider.of<NewOrderService>(context, listen: false)
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
          ),
        ],
      ),
    );
  }
}
