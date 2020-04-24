import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/top_bar_button.dart';
import 'package:delivery_app/widgets/common_widgets/top_bar.dart';
import 'package:delivery_app/widgets/product/product_list_builder.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String currentProductTab = 'soups';
  List<bool> buttonStates = [true, false, false];

  void checkActive(currentIndex) {
    if (currentIndex == 0) {
      currentProductTab = 'soups';
      buttonStates[0] = true;
      buttonStates[1] = false;
      buttonStates[2] = false;
    } else if (currentIndex == 1) {
      currentProductTab = 'dishes';
      buttonStates[0] = false;
      buttonStates[1] = true;
      buttonStates[2] = false;
    } else if (currentIndex == 2) {
      currentProductTab = 'drinks';
      buttonStates[0] = false;
      buttonStates[1] = false;
      buttonStates[2] = true;
    }
  }

  void setIndex(index) {
    setState(() {
      checkActive(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TopBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TopBarButton(
                title: 'Soups',
                onPressed: () {
                  setIndex(0);
                },
                isActive: buttonStates[0],
              ),
              TopBarButton(
                title: 'Main Dishes',
                onPressed: () {
                  setIndex(1);
                },
                isActive: buttonStates[1],
              ),
              TopBarButton(
                title: 'Drinks',
                onPressed: () {
                  setIndex(2);
                },
                isActive: buttonStates[2],
              ),
            ],
          ),
        ),
        Expanded(
          child: ProductListBuilder(
            productTab: currentProductTab,
            futureBuilderType: type.USER,
          ),
        ),
      ],
    );
  }
}
