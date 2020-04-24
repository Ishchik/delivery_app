import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';
import 'admin_panel_screen.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';
import 'package:delivery_app/models/firestore_product_data.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN_USER,
  LOGGED_IN_ADMIN,
}

FirebaseAuth _auth = FirebaseAuth.instance;

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;

  @override
  void initState() {
    super.initState();

    _auth.currentUser().then((user) {
      setState(() {
        if (user != null) {
          Provider.of<UserData>(context, listen: false).initUser();
          Provider.of<FirestoreProductData>(context, listen: false)
              .initProductList();
          authStatus =
              Provider.of<UserData>(context, listen: false).isAdmin == true
                  ? AuthStatus.LOGGED_IN_ADMIN
                  : AuthStatus.LOGGED_IN_USER;
        } else {
          authStatus = AuthStatus.NOT_LOGGED_IN;
        }
      });
    });
  }

  //TODO: rework with LogoScreen;
  Widget buildWaitingScreen() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
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
