import 'package:flutter/material.dart';
import 'checkout_list.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/services/new_order_service.dart';
import 'package:delivery_app/services/user_data_service.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/widgets/common_widgets/flexible_bottom_sheet.dart';
import 'package:delivery_app/widgets/common_widgets/big_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          Card(
            elevation: 7,
            child: Container(
              height: 200,
              child: CheckoutList(),
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
                  Fluttertoast.showToast(
                    msg: 'Delivery address will be set to default',
                  );
                  address = Provider.of<UserDataService>(context, listen: false)
                      .userDefaultAddress;
                  if (address != null) {
                    if (Provider.of<NewOrderService>(context, listen: false)
                        .hasItems) {
                      Provider.of<NewOrderService>(context, listen: false)
                          .checkOut(address);
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'Thanks for the order. Wait for it...',
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Enter eddress",
                      );
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg:
                          'Set up your address in profile menu or enter it in the field',
                    );
                  }
                } else {
                  if (Provider.of<NewOrderService>(context, listen: false)
                      .hasItems) {
                    Provider.of<NewOrderService>(context, listen: false)
                        .checkOut(address);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: 'Thanks for the order. Wait for it...',
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Seems like your cart is empty',
                    );
                  }
                }
              } catch (e) {
                print(e);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
