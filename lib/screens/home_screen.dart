import 'package:flutter/material.dart';
import 'package:delivery_app/screens/orders_screen.dart';
import 'package:delivery_app/screens/products_screen.dart';
import 'profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/services/new_order_service.dart';
import 'package:delivery_app/widgets/checkout/checkout_cart.dart';
import 'package:delivery_app/constants.dart';

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
    return Scaffold(
      body: SafeArea(child: setScreen(_currentIndex)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!Provider.of<NewOrderService>(context, listen: false).hasItems) {
          } else {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CheckoutCart(),
                  ),
                );
              },
            );
          }
        },
        child: Stack(
          overflow: Overflow.visible,
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 35,
            ),
            Provider.of<NewOrderService>(context).hasItems
                ? CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      '${Provider.of<NewOrderService>(context).orderedItems}',
                      style: kNotificationTextStyle,
                      textAlign: TextAlign.justify,
                    ),
                  )
                : SizedBox(),
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
      ),
    );
  }
}
