import 'package:delivery_app/constants.dart';
import 'package:delivery_app/screens/product_edit_screen.dart';
import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/widgets/common_widgets/flexible_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewProductSheet extends StatefulWidget {
  @override
  _NewProductSheetState createState() => _NewProductSheetState();
}

class _NewProductSheetState extends State<NewProductSheet> {
  var newValue;
  String _group = 'soups';

  void _setGroup(value) {
    setState(() {
      _group = value;
    });
  }

  void _createProduct() async {
    if (newValue != null) {
      var product =
          await Provider.of<FirestoreProductService>(context, listen: false)
              .createProduct(newValue, _group);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductEditScreen(
            tabName: _group,
            product: product,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'New product',
              style: kHeaderTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (value) => newValue = value,
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter new name'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: 'soups',
                    groupValue: _group,
                    onChanged: _setGroup,
                  ),
                  Text('Soups'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'dishes',
                    groupValue: _group,
                    onChanged: _setGroup,
                  ),
                  Text('Dishes'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'drinks',
                    groupValue: _group,
                    onChanged: _setGroup,
                  ),
                  Text('Drinks'),
                ],
              ),
            ],
          ),
          FlatButton(
            child: Text('Done'),
            onPressed: _createProduct,
          )
        ],
      ),
    );
  }
}
