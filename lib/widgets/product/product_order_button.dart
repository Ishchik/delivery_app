import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  final Function onPressed;

  OrderButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6,
      fillColor: Colors.red,
      splashColor: Colors.red[900],
      constraints: BoxConstraints(minHeight: 35, minWidth: 120),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text(
        'Add to cart',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
