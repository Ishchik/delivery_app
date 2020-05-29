import 'package:delivery_app/widgets/common_widgets/big_button.dart';
import 'package:delivery_app/services/user_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

        final newUser = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        if (newUser != null) {
          FirebaseUser _user = await _auth.currentUser();
          _user.sendEmailVerification();

          await Provider.of<UserDataService>(context, listen: false)
              .initNewUser(_email);

          Fluttertoast.showToast(
              msg: 'Verification link has been sent to $_email');

          _stopProcessing();
          Navigator.pop(context);
        }
      } catch (e) {
        _stopProcessing();
        print(e);
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
                  text: 'Register',
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
