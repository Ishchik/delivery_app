import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:delivery_app/widgets/common_widgets/big_rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
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
                  final newUser = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  if (newUser != null) {
                    await Provider.of<UserData>(context, listen: false)
                        .initNewUser(email);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
