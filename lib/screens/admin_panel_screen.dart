import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/product/product_list_builder.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/services/user_data_service.dart';
import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/screens/welcome_screen.dart';
import 'package:delivery_app/widgets/product/new_product_sheet.dart';

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
                Provider.of<FirestoreProductService>(context, listen: false)
                    .clearProducts();
                await Provider.of<UserDataService>(context, listen: false)
                    .signOut();
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
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: NewProductSheet(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
