import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData extends ChangeNotifier {
  String _userName;
  String _userEmail;
  String _userDefaultAddress;
  bool _isAdmin;

  Future<void> initUser() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    _userEmail = _user.email;

    Firestore _store = Firestore.instance;
    var userSnap =
        await _store.collection('user_info').document(_userEmail).get();
    _isAdmin = userSnap.data['isAdmin'];
    if (_isAdmin == false) {
      _userName = userSnap.data['name'];
      _userDefaultAddress = userSnap.data['address'];
    }
//    notifyListeners();
  }

  Future<void> initNewUser(String email) async {
    _userName = email;
    _userEmail = email;
    _isAdmin = false;
    _userDefaultAddress = null;

    await Firestore.instance.collection('user_info').document(email).setData({
      'isAdmin': _isAdmin,
      'name': _userEmail,
      'address': _userDefaultAddress
    });
  }

  Future<void> changeName(String newName) async {
    _userName = newName;

    await Firestore.instance
        .collection('user_info')
        .document(_userEmail)
        .updateData({
      'name': _userName,
    });
    notifyListeners();
  }

  Future<void> changeAddress(String newAddress) async {
    _userDefaultAddress = newAddress;

    await Firestore.instance
        .collection('user_info')
        .document(_userEmail)
        .updateData({
      'address': _userDefaultAddress,
    });
    notifyListeners();
  }

  Future<void> resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _userEmail);
    print('link to reset your password has been sent to your email');
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _userName = null;
    _userEmail = null;
    _isAdmin = null;
    _userDefaultAddress = null;
  }

  String get userName {
    return _userName;
  }

  String get userEmail {
    return _userEmail;
  }

  bool get isAdmin {
    return _isAdmin;
  }

  String get userDefaultAddress {
    return _userDefaultAddress;
  }
}
