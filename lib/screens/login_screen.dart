import 'package:delivery_app/screens/admin_panel_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/big_rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'package:delivery_app/constants.dart';

class LoginScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String email;
  String password;
  bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
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
                  final user = await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  if (user != null) {
                    final data = await _firestore
                        .collection('user_info')
                        .document(email)
                        .get();
                    isAdmin = data.data['isAdmin'];

                    isAdmin == true
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPanelScreen()),
                            (Route<dynamic> route) => false,
                          )
                        : Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false,
                          );
                  }
                } catch (e) {
                  print(e);
                }
              },
              text: 'Log In',
            ),
          ],
        ),
      ),
    );
  }
}
