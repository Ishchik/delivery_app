import 'package:delivery_app/constants.dart';
import 'package:delivery_app/services/new_order_service.dart';
import 'package:delivery_app/services/user_data_service.dart';
import 'package:delivery_app/widgets/common_widgets/big_button.dart';
import 'package:delivery_app/widgets/common_widgets/flexible_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'checkout_list.dart';

class CheckoutCart extends StatefulWidget {
  @override
  _CheckoutCartState createState() => _CheckoutCartState();
}

class _CheckoutCartState extends State<CheckoutCart> {
  String address = '';

  bool _isHomeChecked = false;

  void _setChecked(bool value) {
    if (value) {
      address = Provider.of<UserDataService>(context, listen: false)
          .userDefaultAddress;
      if (address.isEmpty) {
        Fluttertoast.showToast(msg: 'No home address specified');
        return;
      }
    } else {
      address = '';
    }
    setState(() {
      _isHomeChecked = value;
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
    );
  }

  void _checkOut() {
    try {
      var newOrderServiceProvider =
          Provider.of<NewOrderService>(context, listen: false);
      if (newOrderServiceProvider.hasItems) {
        if (address.isNotEmpty) {
          newOrderServiceProvider.checkOut(address);
          Navigator.pop(context);
          _showToast('Thanks for the order. Wait for it...');
        } else {
          _showToast('Enter the address first');
        }
      } else {
        _showToast('Seems like your cart is empty');
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              border: Border.all(),
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              enabled: !_isHomeChecked,
              textAlign: TextAlign.center,
              onChanged: (value) => address = value,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter address'),
            ),
          ),
          CheckboxListTile(
            title: Text('Deliver to home'),
            value: _isHomeChecked,
            onChanged: _setChecked,
          ),
          Text(
            'Total price ${Provider.of<NewOrderService>(context).totalPrice}',
            style: kParagraph2TextStyle,
            textAlign: TextAlign.center,
          ),
          BigButton(
            buttonColor: Colors.red,
            text: 'Checkout',
            textColor: Colors.white,
            onPressed: () => _checkOut(),
          ),
        ],
      ),
    );
  }
}
