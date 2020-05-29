import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/models/firestore_product.dart';
import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/widgets/common_widgets/flexible_bottom_sheet.dart';
import 'package:delivery_app/widgets/common_widgets/info_list_tile.dart';
import 'package:delivery_app/widgets/common_widgets/small_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductEditScreen extends StatelessWidget {
  final FirestoreProduct product;
  final String tabName;

  ProductEditScreen({this.product, this.tabName});

  void _showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => child,
    );
  }

  void _deleteProduct(BuildContext context) async {
    await Provider.of<FirestoreProductService>(context, listen: false)
        .deleteProduct(product, tabName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () => _deleteProduct(context),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ImageContainer(
                  product: product,
                  tabName: tabName,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Tap on image to change it',
                  style: kHintTextStyle,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Price',
              style: kParagraph2TextStyle,
            ),
          ),
          PriceListTile(
            product: product,
            tabName: tabName,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Ingredients',
                  style: kParagraph2TextStyle,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _showBottomSheet(
                          context,
                          AddIngredientBuilder(
                            product: product,
                            tabName: tabName,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        _showBottomSheet(
                          context,
                          RemoveIngredientBuilder(
                            product: product,
                            tabName: tabName,
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: IngredientListBuilder(
              product: product,
              tabName: tabName,
            ),
          )
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final FirestoreProduct product;
  final String tabName;

  ImageContainer({this.product, this.tabName});

  void _changeProductImage(FirestoreProductService firestoreProduct) async {
    await firestoreProduct.changeProductImage(product, tabName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProductService>(
      builder: (_, firestoreProduct, __) {
        return InkWell(
          child: Container(
            height: 150,
            width: 150,
            child: CachedNetworkImage(
              placeholder: (context, url) => Icon(
                Icons.image,
                size: 30,
              ),
              imageUrl:
                  firestoreProduct.getProductData(product).productImageUrl,
            ),
          ),
          onTap: () => _changeProductImage(firestoreProduct),
        );
      },
    );
  }
}

class PriceListTile extends StatelessWidget {
  final FirestoreProduct product;
  final String tabName;

  PriceListTile({this.product, this.tabName});

  void _editProductPrice(
      FirestoreProductService firestoreProduct, int newPrice) async {
    if (newPrice != null) {
      await firestoreProduct.editProductPrice(product, tabName, newPrice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProductService>(
      builder: (_, firestoreProduct, __) {
        return InfoListTile(
          title: '${firestoreProduct.getProductData(product).productPrice} USD',
          child: SmallBottomSheetContainer(
            hintText: 'Enter new price',
            keyboardType: TextInputType.number,
            onPressed: (value) => _editProductPrice(firestoreProduct, value),
          ),
        );
      },
    );
  }
}

class AddIngredientBuilder extends StatelessWidget {
  final FirestoreProduct product;
  final String tabName;

  AddIngredientBuilder({this.product, this.tabName});

  void _editProductIngredient(BuildContext context, String newName) async {
    if (newName != null) {
      await Provider.of<FirestoreProductService>(context, listen: false)
          .addProductIngredient(product, tabName, newName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SmallBottomSheetContainer(
          hintText: 'Enter new ingredient',
          onPressed: (value) => _editProductIngredient(context, value),
        ),
      ),
    );
  }
}

class RemoveIngredientBuilder extends StatelessWidget {
  final FirestoreProduct product;
  final String tabName;

  RemoveIngredientBuilder({this.product, this.tabName});

  void _deleteProductIngredient(
      FirestoreProductService firestoreProduct, int index) async {
    await firestoreProduct.deleteProductIngredient(product, tabName, index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProductService>(
      builder: (_, firestoreProduct, __) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FlexibleBottomSheet(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        title: Text(firestoreProduct
                            .getProductData(product)
                            .ingredientsList[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              _deleteProductIngredient(firestoreProduct, index),
                        ),
                      ),
                    );
                  },
                  itemCount: firestoreProduct
                      .getProductData(product)
                      .ingredientsList
                      .length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class IngredientListBuilder extends StatelessWidget {
  final FirestoreProduct product;
  final String tabName;

  IngredientListBuilder({this.product, this.tabName});

  void _editProductIngredientName(FirestoreProductService firestoreProduct,
      int index, String newName) async {
    await firestoreProduct.editProductIngredientName(
        product, index, tabName, newName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreProductService>(
      builder: (_, firestoreProduct, __) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            return InfoListTile(
              title: firestoreProduct
                  .getProductData(product)
                  .ingredientsList[index],
              child: SmallBottomSheetContainer(
                hintText: 'Enter new name',
                keyboardType: TextInputType.text,
                onPressed: (value) =>
                    _editProductIngredientName(firestoreProduct, index, value),
              ),
            );
          },
          itemCount:
              firestoreProduct.getProductData(product).ingredientsList.length,
        );
      },
    );
  }
}
