import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'flexible_bottom_sheet.dart';

class SmallBottomSheetContainer extends StatelessWidget {
  final String hintText;
  final Function onPressed;
  final TextInputType keyboardType;

  SmallBottomSheetContainer(
      {@required this.hintText, @required this.onPressed, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    String newValue;
    return FlexibleBottomSheet(
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
    );
  }
}
