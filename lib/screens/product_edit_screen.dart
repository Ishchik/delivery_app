import 'package:flutter/material.dart';
import 'package:delivery_app/models/firestore_product.dart';

class ProductEditScreen extends StatelessWidget {
  final FirestoreProduct product;

  ProductEditScreen({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Edit product'),
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
          Card(
            child: ListTile(
              title: Text(
                product.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Name'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  print('edited name');
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                '${product.price.toString()} USD',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Price'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  print('edited price');
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
//                  isThreeLine: true,
              title: Text(
                product.listString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Ingredients'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  print('edited price');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
