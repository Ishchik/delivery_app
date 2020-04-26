import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';

class SmallBottomSheetContainer extends StatelessWidget {
  final String hintText;
  final Function onPressed;
  final TextInputType keyboardType;

  SmallBottomSheetContainer({this.hintText, this.onPressed, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    String newValue;
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
              keyboardType: keyboardType,
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                newValue = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: hintText),
            ),
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                if (keyboardType == TextInputType.number) {
                  onPressed(int.parse(newValue));
                } else {
                  onPressed(newValue);
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
