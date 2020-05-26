import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/models/firestore_product.dart';
import 'package:delivery_app/widgets/common_widgets/info_list_tile.dart';
import 'package:delivery_app/widgets/common_widgets/small_bottom_sheet_container.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/widgets/common_widgets/flexible_bottom_sheet.dart';
import 'package:delivery_app/constants.dart';

class ProductEditScreen extends StatelessWidget {
  final FirestoreProduct product;
  final String tabName;

  ProductEditScreen({this.product, this.tabName});

  Widget addIngredientBuilder(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SmallBottomSheetContainer(
          hintText: 'Enter new ingredient',
          onPressed: (value) async {
            if (value != null) {
              await Provider.of<FirestoreProductService>(context, listen: false)
                  .addProductIngredient(product, tabName, value);
            }
          },
        ),
      ),
    );
  }

  Widget removeIngredientBuilder(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FlexibleBottomSheet(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(Provider.of<FirestoreProductService>(context)
                        .getProductData(product)
                        .list[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await Provider.of<FirestoreProductService>(context,
                                listen: false)
                            .deleteProductIngredient(product, tabName, index);
                      },
                    ),
                  ),
                );
              },
              itemCount: Provider.of<FirestoreProductService>(context)
                  .getProductData(product)
                  .list
                  .length,
            ),
          ),
        ),
      ),
    );
  }

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
            onPressed: () async {
              await Provider.of<FirestoreProductService>(context, listen: false)
                  .deleteProduct(product, tabName);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  child: Container(
                    height: 150,
                    width: 150,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Icon(
                        Icons.image,
                        size: 30,
                      ),
                      imageUrl: Provider.of<FirestoreProductService>(context)
                          .getProductData(product)
                          .imageUrl,
                    ),
                  ),
                  onTap: () async {
                    await Provider.of<FirestoreProductService>(context,
                            listen: false)
                        .changeProductImage(product, tabName);
                  },
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
          InfoListTile(
            title:
                '${Provider.of<FirestoreProductService>(context).getProductData(product).price} USD',
            child: SmallBottomSheetContainer(
              hintText: 'Enter new price',
              keyboardType: TextInputType.number,
              onPressed: (value) async {
                if (value != null) {
                  await Provider.of<FirestoreProductService>(context,
                          listen: false)
                      .editProductPrice(product, tabName, value);
                }
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
                  style: kParagraph2TextStyle,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: addIngredientBuilder,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: removeIngredientBuilder,
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
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InfoListTile(
                  title: Provider.of<FirestoreProductService>(context)
                      .getProductData(product)
                      .list[index],
                  child: SmallBottomSheetContainer(
                    hintText: 'Enter new name',
                    keyboardType: TextInputType.text,
                    onPressed: (value) async {
                      if (value != null) {
                        await Provider.of<FirestoreProductService>(context,
                                listen: false)
                            .editProductIngredientName(
                                product, index, tabName, value);
                      }
                    },
                  ),
                );
              },
              itemCount: Provider.of<FirestoreProductService>(context)
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
