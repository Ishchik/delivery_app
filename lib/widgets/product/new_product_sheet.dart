import 'package:delivery_app/screens/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/widgets/common_widgets/flexible_bottom_sheet.dart';

class NewProductSheet extends StatefulWidget {
  @override
  _NewProductSheetState createState() => _NewProductSheetState();
}

class _NewProductSheetState extends State<NewProductSheet> {
  var newValue;
  String group = 'soups';

  @override
  Widget build(BuildContext context) {
    return FlexibleBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (value) {
              newValue = value;
            },
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
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        group = value;
                      });
                    },
                  ),
                  Text('Soups'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'dishes',
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        group = value;
                      });
                    },
                  ),
                  Text('Dishes'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'drinks',
                    groupValue: group,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        group = value;
                      });
                    },
                  ),
                  Text('Drinks'),
                ],
              ),
            ],
          ),
          FlatButton(
            child: Text('Done'),
            onPressed: () async {
              if (newValue != null) {
                var product = await Provider.of<FirestoreProductService>(
                        context,
                        listen: false)
                    .createProduct(newValue, group);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (build) => ProductEditScreen(
                      tabName: group,
                      product: product,
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
