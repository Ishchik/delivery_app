import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(15),
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[500],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order #1',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Order time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Order adress',
            ),
            FlatButton(
              child: Text(
                'repeat',
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
