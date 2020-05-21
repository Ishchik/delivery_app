import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/common_widgets/big_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:delivery_app/widgets/common_widgets/small_bottom_sheet_container.dart';
import 'package:delivery_app/constants.dart';

class WelcomeScreen extends StatelessWidget {
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              text: 'Log in',
            ),
            BigButton(
              buttonColor: Color(0xFFFFC107),
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
              text: 'Register',
            ),
            FlatButton(
              child: Text('Forgot password?'),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: SmallBottomSheetContainer(
                          hintText: 'Enter email',
                          onPressed: (value) async {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: value);
                            print(
                                'link to reset your password has been sent to your email');
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
