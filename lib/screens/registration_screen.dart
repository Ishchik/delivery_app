import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/big_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            BigButton(
              buttonColor: Color(0xFFFFC107),
              textColor: Colors.white,
              onPressed: () async {
                try {
                  startLoading();

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
                    stopLoading();

                    Navigator.pop(context);
                  }
                } catch (e) {
                  stopLoading();

                  print(e);
                }
              },
              text: 'Register',
            ),
          ],
        ),
        inAsyncCall: _loading,
      ),
    );
  }
}
