import 'package:delivery_app/constants.dart';
import 'package:delivery_app/widgets/common_widgets/big_button.dart';
import 'package:delivery_app/widgets/common_widgets/small_bottom_sheet_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  void _showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => child,
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => destination,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'DELIVERY APP',
              style: kParagraph1TextStyle,
            ),
            SizedBox(
              height: 48.0,
            ),
            BigButton(
              buttonColor: Color(0xFFFFD659),
              textColor: Colors.black,
              onPressed: () => _navigateTo(context, LoginScreen()),
              text: 'Log in',
            ),
            BigButton(
              buttonColor: Color(0xFFFFC107),
              textColor: Colors.white,
              onPressed: () => _navigateTo(context, RegistrationScreen()),
              text: 'Register',
            ),
            FlatButton(
              child: Text('Forgot password?'),
              onPressed: () =>
                  _showBottomSheet(context, ResetLinkBottomSheetBuilder()),
            )
          ],
        ),
      ),
    );
  }
}

class ResetLinkBottomSheetBuilder extends StatelessWidget {
  void _sendResetLink(String email) async {
    if (email != null) {
      Fluttertoast.showToast(
        msg: 'Reset link has been sent to your email',
      );
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SmallBottomSheetContainer(
          hintText: 'Enter email',
          onPressed: (value) => _sendResetLink(value),
        ),
      ),
    );
  }
}
