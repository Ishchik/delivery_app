import 'package:delivery_app/screens/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/firestore_product_data.dart';

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  var newValue;
  String group = 'soups';

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
                var product = await Provider.of<FirestoreProductData>(context,
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
              },
            )
          ],
        ),
      ),
    );
  }
}
