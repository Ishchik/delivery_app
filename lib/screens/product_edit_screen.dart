import 'package:flutter/material.dart';
import 'package:delivery_app/models/firestore_product.dart';
import 'package:delivery_app/widgets/common_widgets/info_list_tile.dart';
import 'package:delivery_app/widgets/common_widgets/small_bottom_sheet_container.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/firestore_product_data.dart';

class ProductEditScreen extends StatelessWidget {
  final FirestoreProduct product;
  final String productTab;

  ProductEditScreen({this.product, this.productTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {
              print('deleted item');
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    child: Image(
                      image: NetworkImage(product.imageUrl),
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      print('tapped on image');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Tap on image to change it',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InfoListTile(
            title: '${product.price} USD',
            subtitle: 'Price',
            child: SmallBottomSheetContainer(
              hintText: 'Enter new price',
              keyboardType: TextInputType.number,
              onPressed: (int value) {
                Provider.of<FirestoreProductData>(context, listen: false)
                    .editProductPrice(product, productTab, value);
                Navigator.pop(context);
              },
            ),
          ),
          InfoListTile(
            title: product.listString(),
            subtitle: 'Ingredients',
            child: null,
          )
        ],
      ),
    );
  }
}
