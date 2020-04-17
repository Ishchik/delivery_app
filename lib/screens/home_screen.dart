import 'package:flutter/material.dart';
import 'package:delivery_app/screens/orders_screen.dart';
import 'package:delivery_app/screens/products_screen.dart';
import 'package:provider/provider.dart';
import 'profile_screen.dart';
import 'package:delivery_app/models/new_order_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void onTabTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget setScreen(currentIndex) {
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
    return ChangeNotifierProvider(
      create: (context) => NewOrderData(),
      child: Scaffold(
        body: setScreen(_currentIndex),
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
          onTap: onTabTap,
          selectedItemColor: Color(0xFF03A9F4),
        ),
      ),
    );
  }
}
