import 'package:flutter/material.dart';
import 'package:delivery_app/models/firestore_product.dart';
import 'package:delivery_app/widgets/common_widgets/info_list_tile.dart';
import 'package:delivery_app/widgets/common_widgets/small_bottom_sheet_container.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/firestore_product_data.dart';
import 'package:delivery_app/widgets/common_widgets/flexible_bottom_sheet.dart';

class ProductEditScreen extends StatelessWidget {
  final FirestoreProduct product;
  final String tabName;

  ProductEditScreen({this.product, this.tabName});

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
              Provider.of<FirestoreProductData>(context, listen: false)
                  .deleteProduct(product, tabName);
              Navigator.pop(context);
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
                      image: NetworkImage(
                          Provider.of<FirestoreProductData>(context)
                              .getProductData(product)
                              .imageUrl),
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    onTap: () async {
                      await Provider.of<FirestoreProductData>(context,
                              listen: false)
                          .changeProductImage(product, tabName);
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
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Price',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InfoListTile(
            title:
                '${Provider.of<FirestoreProductData>(context).getProductData(product).price} USD',
            child: SmallBottomSheetContainer(
              hintText: 'Enter new price',
              keyboardType: TextInputType.number,
              onPressed: (value) {
                Provider.of<FirestoreProductData>(context, listen: false)
                    .editProductPrice(product, tabName, value);
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: SmallBottomSheetContainer(
                                  hintText: 'Enter new ingredient',
                                  onPressed: (value) {
                                    Provider.of<FirestoreProductData>(context,
                                            listen: false)
                                        .addProductIngredient(
                                            product, tabName, value);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: FlexibleBottomSheet(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Text(Provider.of<
                                                        FirestoreProductData>(
                                                    context)
                                                .getProductData(product)
                                                .list[index]),
                                            trailing: IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                Provider.of<FirestoreProductData>(
                                                        context,
                                                        listen: false)
                                                    .deleteProductIngredient(
                                                        product,
                                                        tabName,
                                                        index);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          Provider.of<FirestoreProductData>(
                                                  context)
                                              .getProductData(product)
                                              .list
                                              .length,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InfoListTile(
                  title: Provider.of<FirestoreProductData>(context)
                      .getProductData(product)
                      .list[index],
                  child: SmallBottomSheetContainer(
                    hintText: 'Enter new name',
                    keyboardType: TextInputType.text,
                    onPressed: (value) {
                      Provider.of<FirestoreProductData>(context, listen: false)
                          .editProductIngredientName(
                              product, index, tabName, value);
                    },
                  ),
                );
              },
              itemCount: Provider.of<FirestoreProductData>(context)
                  .getProductData(product)
                  .list
                  .length,
            ),
          )
        ],
      ),
    );
  }
}
