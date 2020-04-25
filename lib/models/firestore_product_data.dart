import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'firestore_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProductData extends ChangeNotifier {
  List<FirestoreProduct> _soupList = [];
  List<FirestoreProduct> _dishList = [];
  List<FirestoreProduct> _drinkList = [];

  Future<void> initProductList() async {
    Firestore _store = Firestore.instance;
    var _snapshots = await _store
        .collection('product_info')
        .document('soups_info')
        .collection('soups')
        .getDocuments();
    for (var document in _snapshots.documents) {
      _soupList.add(FirestoreProduct(document.data));
    }

    _snapshots = await _store
        .collection('product_info')
        .document('dishes_info')
        .collection('dishes')
        .getDocuments();
    for (var document in _snapshots.documents) {
      _dishList.add(FirestoreProduct(document.data));
    }

    _snapshots = await _store
        .collection('product_info')
        .document('drinks_info')
        .collection('drinks')
        .getDocuments();
    for (var document in _snapshots.documents) {
      _drinkList.add(FirestoreProduct(document.data));
    }
  }

  UnmodifiableListView<FirestoreProduct> getList(String type) {
    switch (type) {
      case 'soups':
        return UnmodifiableListView(_soupList);
        break;
      case 'dishes':
        return UnmodifiableListView(_dishList);
        break;
      case 'drinks':
        return UnmodifiableListView(_drinkList);
        break;
    }
  }

  int listLength(String type) {
    switch (type) {
      case 'soups':
        return _soupList.length;
        break;
      case 'dishes':
        return _dishList.length;
        break;
      case 'drinks':
        return _drinkList.length;
        break;
    }
  }

  void clearProducts() {
    _soupList.clear();
    _dishList.clear();
    _drinkList.clear();
  }
}
