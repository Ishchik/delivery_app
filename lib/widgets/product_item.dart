import 'package:flutter/material.dart';
import 'order_button.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductItem extends StatelessWidget {
  final String productTitle;
  final String productContent;
  final int productPrice;
  final String imageUrl;

  ProductItem(
      {this.productTitle,
      this.productContent,
      this.productPrice,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[500],
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: FutureBuilder(
                  future: FirebaseStorage.instance
                      .ref()
                      .child(imageUrl)
                      .getDownloadURL(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text('Loading...'),
                      );
                    }
                    return Image(
                      image: NetworkImage(snapshot.data.toString()),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFBDBDBD),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        '$productTitle',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '$productContent',
                        style: TextStyle(
                          color: Color(0xFF757575),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '$productPrice   UAH',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          OrderButton(
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
