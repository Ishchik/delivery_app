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
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(4.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 150.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
