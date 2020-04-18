import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'models/new_order_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewOrderData>(
      create: (context) => NewOrderData(),
      child: MaterialApp(
        title: 'Delivery App',
        home: WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
