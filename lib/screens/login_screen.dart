import 'package:delivery_app/screens/admin_panel_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/big_rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/models/user_data.dart';
import 'package:delivery_app/models/firestore_product_data.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email;
    String password;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              email = value;
            },
            decoration: kTextFieldDecoration.copyWith(hintText: 'Enter email'),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value) {
              password = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter password'),
          ),
          SizedBox(
            height: 24.0,
          ),
          RoundedButton(
            //TODO: add progress indicator
            color: Colors.lightBlueAccent,
            onPressed: () async {
              try {
                final user =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                if (user != null) {
                  await Provider.of<UserData>(context, listen: false)
                      .initUser();
                  await Provider.of<FirestoreProductData>(context,
                          listen: false)
                      .initProductList();
                  Provider.of<UserData>(context, listen: false).isAdmin
                      ? Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminPanelScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        )
                      : Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                } //TODO: add alert dialog about incorrect input
              } catch (e) {
                print(e);
              }
            },
            text: 'Log In',
          ),
        ],
      ),
    );
  }
}
