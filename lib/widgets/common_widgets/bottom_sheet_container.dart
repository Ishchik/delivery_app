import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;

  BottomSheetContainer({this.child});

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
        child: child,
      ),
    );
  }
}
