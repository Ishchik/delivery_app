import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/product_item.dart';
import 'package:delivery_app/widgets/product_tab_bar_button.dart';
import 'package:delivery_app/widgets/top_bar.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final List<SliverList> sliverList = [
//    SliverList(
//      delegate: SliverChildListDelegate([
//        ProductItem(
//          productTitle: 'soup1',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//        ProductItem(
//          productTitle: 'soup2',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//        ProductItem(
//          productTitle: 'soup3',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//      ]),
//    ),
//    SliverList(
//      delegate: SliverChildListDelegate([
//        ProductItem(
//          productTitle: 'dish1',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//        ProductItem(
//          productTitle: 'dish2',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//        ProductItem(
//          productTitle: 'dish3',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//      ]),
//    ),
//    SliverList(
//      delegate: SliverChildListDelegate([
//        ProductItem(
//          productTitle: 'drink1',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//        ProductItem(
//          productTitle: 'drink2',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//        ProductItem(
//          productTitle: 'drink3',
//          productContent: 'lkhdbgksbdfkbgdlkfbgsldkfjs',
//          productPrice: 200.00,
//        ),
//      ]),
//    ),
  ];

  int _currentIndex = 0;

  List<bool> buttonStates = [true, false, false];

  void checkActive(currentIndex) {
    if (currentIndex == 0) {
      buttonStates[0] = true;
      buttonStates[1] = false;
      buttonStates[2] = false;
    } else if (currentIndex == 1) {
      buttonStates[0] = false;
      buttonStates[1] = true;
      buttonStates[2] = false;
    } else if (currentIndex == 2) {
      buttonStates[0] = false;
      buttonStates[1] = false;
      buttonStates[2] = true;
    }
  }

  void setIndex(index) {
    setState(() {
      _currentIndex = index;
      checkActive(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
              child: CustomScrollView(
                slivers: <Widget>[
                  sliverList.elementAt(_currentIndex),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
