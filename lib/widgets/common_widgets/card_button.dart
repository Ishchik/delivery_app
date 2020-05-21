import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CardButton({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6,
      fillColor: Colors.red,
      splashColor: Colors.red[900],
      constraints: BoxConstraints(
        minHeight: 35,
        minWidth: MediaQuery.of(context).size.width / 3,
      ),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
