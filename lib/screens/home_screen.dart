import 'package:flutter/material.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/screens/orders_screen.dart';
import 'package:delivery_app/screens/products_screen.dart';
import 'package:delivery_app/services/new_order_service.dart';
import 'package:delivery_app/widgets/checkout/checkout_cart.dart';
import 'package:provider/provider.dart';

import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTabTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _setScreen(currentIndex) {
    switch (currentIndex) {
      case (0):
        return ProductsScreen();
        break;
      case (1):
        return OrdersScreen();
        break;
      case (2):
        return ProfileScreen();
        break;
    }
    return ProductsScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _setScreen(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant,
            ),
            title: Text('Products'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt,
            ),
            title: Text('Orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text('User profile'),
          ),
        ],
        onTap: _onTabTap,
      ),
      floatingActionButton: FloatingActionButtonWidget(),
    );
  }
}

class FloatingActionButtonWidget extends StatelessWidget {
  void _showBottomSheet(
      BuildContext context, NewOrderService newOrder, Widget child) {
    if (newOrder.hasItems) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: child,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewOrderService>(
      builder: (_, newOrder, __) {
        return FloatingActionButton(
          onPressed: () => _showBottomSheet(context, newOrder, CheckoutCart()),
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Icon(
                Icons.shopping_cart,
                size: 35,
              ),
              newOrder.hasItems
                  ? Positioned(
                      left: 25,
                      bottom: 25,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 15,
                        child: Text(
                          '${newOrder.orderedItems}',
                          style: kNotificationTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
