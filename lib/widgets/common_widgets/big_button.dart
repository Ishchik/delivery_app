import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Function onPressed;
  final String text;

  BigButton(
      {@required this.buttonColor,
      @required this.textColor,
      @required this.onPressed,
      @required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: RawMaterialButton(
        elevation: 6,
        fillColor: buttonColor,
        constraints: BoxConstraints(
          minHeight: 45,
          minWidth: 150,
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          style: kParagraph2TextStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
