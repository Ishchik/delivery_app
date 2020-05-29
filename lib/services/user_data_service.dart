import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataService extends ChangeNotifier {
  String userName;
  String userEmail;
  String userDefaultAddress;
  bool isAdmin;

  Future<void> initUser() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    userEmail = _user.email;

    Firestore _store = Firestore.instance;
    var userSnap =
        await _store.collection('user_info').document(userEmail).get();
    isAdmin = userSnap.data['isAdmin'];
    if (isAdmin == false) {
      userName = userSnap.data['name'];
      userDefaultAddress = userSnap.data['address'];
    }
//    notifyListeners();
  }

  Future<void> initNewUser(String email) async {
    await Firestore.instance
        .collection('user_info')
        .document(email)
        .setData({'isAdmin': false, 'name': email, 'address': ''});
  }

  Future<void> changeName(String newName) async {
    userName = newName;

    await Firestore.instance
        .collection('user_info')
        .document(userEmail)
        .updateData({
      'name': userName,
    });
    notifyListeners();
  }

  Future<void> changeAddress(String newAddress) async {
    userDefaultAddress = newAddress;

    await Firestore.instance
        .collection('user_info')
        .document(userEmail)
        .updateData({
      'address': userDefaultAddress,
    });
    notifyListeners();
  }

  Future<void> resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);
    print('link to reset your password has been sent to your email');
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    userName = null;
    userEmail = null;
    isAdmin = null;
    userDefaultAddress = null;
  }
}
