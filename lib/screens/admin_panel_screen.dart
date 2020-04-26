import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/product/product_list_builder.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';
import 'package:delivery_app/models/firestore_product_data.dart';
import 'package:delivery_app/screens/welcome_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ADMIN PANNEL'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                Provider.of<FirestoreProductData>(context, listen: false)
                    .clearProducts();
                await Provider.of<UserData>(context, listen: false).signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            )
          ],
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Soups'),
              ),
              Tab(
                child: Text('Dishes'),
              ),
              Tab(
                child: Text('Drinks'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductListBuilder(
              productTab: 'soups',
              futureBuilderType: type.ADMIN,
            ),
            ProductListBuilder(
              productTab: 'dishes',
              futureBuilderType: type.ADMIN,
            ),
            ProductListBuilder(
              productTab: 'drinks',
              futureBuilderType: type.ADMIN,
            ),
          ],
        ),
      ),
    );
  }
}
