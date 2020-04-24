import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/new_order_data.dart';
import 'models/user_data.dart';
import 'screens/root_page.dart';
import 'models/firestore_product_data.dart';

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
        ChangeNotifierProvider(
          create: (context) => FirestoreProductData(),
        )
      ],
      child: MaterialApp(
        title: 'Delivery App',
        home: RootPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
