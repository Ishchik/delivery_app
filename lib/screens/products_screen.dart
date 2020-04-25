import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/product/product_list_builder.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TabBar(
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
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductListBuilder(
              productTab: 'soups',
              futureBuilderType: type.USER,
            ),
            ProductListBuilder(
              productTab: 'dishes',
              futureBuilderType: type.USER,
            ),
            ProductListBuilder(
              productTab: 'drinks',
              futureBuilderType: type.USER,
            ),
          ],
        ),
      ),
    );
  }
}
