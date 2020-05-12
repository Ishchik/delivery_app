import 'package:delivery_app/screens/admin_panel_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/big_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/models/user_data.dart';
import 'package:delivery_app/models/firestore_product_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool _loading = false;

  void startLoading() {
    setState(() {
      _loading = true;
    });
  }

  void stopLoading() {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textInputAction: TextInputAction.done,
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
            BigButton(
              textColor: Colors.white,
              buttonColor: Color(0xFFFFC107),
              onPressed: () async {
                try {
                  startLoading();
                  FocusScope.of(context).unfocus();
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
                    stopLoading();
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
                  }
                } catch (e) {
                  stopLoading();
                  print(e);
                }
              },
              text: 'Log In',
            ),
          ],
        ),
        inAsyncCall: _loading,
      ),
    );
  }
}
