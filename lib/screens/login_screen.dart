import 'package:delivery_app/screens/admin_panel_screen.dart';
import 'package:delivery_app/services/firestore_product_service.dart';
import 'package:delivery_app/services/user_data_service.dart';
import 'package:delivery_app/widgets/common_widgets/big_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  bool _processing = false;

  void _startProcessing() {
    setState(() {
      _processing = true;
    });
  }

  void _stopProcessing() {
    setState(() {
      _processing = false;
    });
  }

  String _validateUsername(String email) {
    if (email.isEmpty) {
      return 'Email can\'t be empty';
    }

    if (!email.contains('@') && !email.contains('.')) {
      return 'Incorrect email input';
    }

    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    }

    if (password.length < 6) {
      return 'Password must contain atleast 6 characters';
    }

    if (password.contains('/')) {
      return 'Password can\'t contain characters ...';
    }

    return null;
  }

  void _submit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        _startProcessing();

        FocusScope.of(context).unfocus();

        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        if (user != null) {
          final userData = Provider.of<UserDataService>(context, listen: false);
          await userData.initUser();

          await Provider.of<FirestoreProductService>(context, listen: false)
              .initProductList();

          _stopProcessing();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  userData.isAdmin ? AdminPanelScreen() : HomeScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        _stopProcessing();

        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            Fluttertoast.showToast(msg: 'This user does not exist');
            break;
          case 'The password is invalid or the user does not have a password.':
            Fluttertoast.showToast(msg: 'Invalid password');
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            Fluttertoast.showToast(msg: 'Network error');
            break;
          default:
            Fluttertoast.showToast(msg: 'Unknown error');
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter email', labelText: 'Email'),
                  validator: _validateUsername,
                  onSaved: (value) => _email = value,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter password', labelText: 'Password'),
                  validator: _validatePassword,
                  onSaved: (value) => _password = value,
                ),
                BigButton(
                  textColor: Colors.white,
                  buttonColor: Color(0xFFFFC107),
                  onPressed: () => _submit(context),
                  text: 'Log in',
                )
              ],
            ),
          ),
        ),
        inAsyncCall: _processing,
      ),
    );
  }
}
