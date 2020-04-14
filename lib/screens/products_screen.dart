import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/product_tab_bar_button.dart';
import 'package:delivery_app/widgets/top_bar.dart';
import 'package:delivery_app/widgets/product_future_builder.dart';

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
      children: <Widget>[
        TopBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ProductTabBarButton(
                title: 'Soups',
                onPressed: () {
                  setIndex(0);
                },
                isActive: buttonStates[0],
              ),
              ProductTabBarButton(
                title: 'Main Dishes',
                onPressed: () {
                  setIndex(1);
                },
                isActive: buttonStates[1],
              ),
              ProductTabBarButton(
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
          flex: 12,
          child: ProductFutureBuilder(
            productTab: currentProductTab,
          ),
        ),
      ],
    );
  }
}
