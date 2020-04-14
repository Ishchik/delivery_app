import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final Widget child;

  TopBar({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.5,
            spreadRadius: 0.25,
            offset: Offset(0, 2),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }
}
