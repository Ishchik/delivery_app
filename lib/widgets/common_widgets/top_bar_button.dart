import 'package:flutter/material.dart';

class TopBarButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function onPressed;

  TopBarButton({this.title, this.onPressed, this.isActive});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('$title'),
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textColor: isActive ? Color(0xFF03A9F4) : Colors.black,
    );
  }
}
