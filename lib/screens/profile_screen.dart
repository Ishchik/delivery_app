import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'package:delivery_app/widgets/common_widgets/card_button.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/models/user_data.dart';
import 'package:delivery_app/widgets/user/change_password_card.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Provider.of<UserData>(context).userName,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              subtitle: Text('Tap to change the name'),
              onTap: () async {
                //TODO: implement "change name"

                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: ChangePasswordCard(),
                      ),
                    );
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CardButton(
                  onPressed: () {
                    //TODO: implement "reset password"
                  },
                  text: 'Reset password',
                ),
                CardButton(
                  onPressed: () async {
                    await Provider.of<UserData>(context, listen: false)
                        .signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  text: 'Sign out',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
