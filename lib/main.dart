import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/new_order_data.dart';
import 'models/user_data.dart';
import 'screens/root_page.dart';

void main() => runApp(DeliveryApp());

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewOrderData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserData(),
        ),
      ],
      child: MaterialApp(
        title: 'Delivery App',
        home: RootPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
