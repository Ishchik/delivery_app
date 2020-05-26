import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/new_order_service.dart';
import 'services/user_data_service.dart';
import 'screens/root_page.dart';
import 'services/firestore_product_service.dart';

void main() => runApp(DeliveryApp());

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewOrderService(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDataService(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirestoreProductService(),
        )
      ],
      child: MaterialApp(
        title: 'Delivery App',
        home: RootPage(),
        theme: ThemeData(
          accentColor: Colors.yellow,
          canvasColor: Colors.amber,
          scaffoldBackgroundColor: Colors.grey[200],
          primaryColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
