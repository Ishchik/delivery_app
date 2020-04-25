import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/big_rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class RegistrationScreen extends StatelessWidget {
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
                final newUser = await _auth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                if (newUser != null) {
                  FirebaseUser _user = await _auth.currentUser();
                  _user.sendEmailVerification();
                  print('verification link has been sent to your email');
                  await Provider.of<UserData>(context, listen: false)
                      .initNewUser(email);
                  Navigator.pop(context);
                }
              } catch (e) {
                print(e);
              }
            },
            text: 'Register',
          ),
        ],
      ),
    );
  }
}
