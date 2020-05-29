import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/services/user_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_panel_screen.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN_USER,
  LOGGED_IN_ADMIN,
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Widget buildWaitingScreen() {
    return Scaffold();
  }

  void checkUser() async {
    var _user = await _auth.currentUser();
    if (_user != null) {
      await Provider.of<FirestoreProductService>(context, listen: false)
          .initProductList();

      final userData = Provider.of<UserDataService>(context, listen: false);
      await userData.initUser();

      setState(() {
        authStatus = userData.isAdmin == true
            ? AuthStatus.LOGGED_IN_ADMIN
            : AuthStatus.LOGGED_IN_USER;
      });
    } else {
      setState(() {
        authStatus = AuthStatus.NOT_LOGGED_IN;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(authStatus);
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return WelcomeScreen();
        break;
      case AuthStatus.LOGGED_IN_USER:
        return HomeScreen();
        break;
      case AuthStatus.LOGGED_IN_ADMIN:
        return AdminPanelScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
