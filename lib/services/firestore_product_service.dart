import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/firestore_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreProductService extends ChangeNotifier {
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

    return null;
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

    return null;
  }

  FirestoreProduct getProductData(FirestoreProduct product) {
    return product;
  }

  Future<void> changeProductImage(
      FirestoreProduct product, String tabName) async {
    await ImagePicker.pickImage(source: ImageSource.gallery)
        .then((image) async {
      print(image);
      var _storageRef = FirebaseStorage.instance
          .ref()
          .child('images/$tabName/${product.name}');
      await _storageRef.putFile(image).onComplete.then((snapshot) async {
        print('uploaded');
        await _storageRef.getDownloadURL().then((url) async {
          await Firestore.instance
              .collection('product_info')
              .document('${tabName}_info')
              .collection(tabName)
              .document(product.name)
              .updateData({'image_url': url});
          product.imageUrl = url.toString();
        });
      });
    });

    notifyListeners();
  }

  Future<void> editProductPrice(
      FirestoreProduct product, String tabName, int newPrice) async {
    var _store = Firestore.instance;
    await _store.runTransaction((transaction) async {
      var docRef = _store
          .collection('product_info')
          .document('${tabName}_info')
          .collection(tabName)
          .document(product.name);
      await transaction.update(docRef, {'price': newPrice});
      product.price = newPrice;
    });
    notifyListeners();
  }

  void editProductIngredientName(FirestoreProduct product, int index,
      String tabName, String newName) async {
    product.list[index] = newName;
    await _editProductIngredients(product, tabName);
  }

  void addProductIngredient(
      FirestoreProduct product, String tabName, String newIngredient) async {
    product.list.add(newIngredient);
    await _editProductIngredients(product, tabName);
  }

  void deleteProductIngredient(
      FirestoreProduct product, String tabName, int index) async {
    product.list.removeAt(index);
    await _editProductIngredients(product, tabName);
  }

  Future<void> _editProductIngredients(
      FirestoreProduct product, String tabName) async {
    var _store = Firestore.instance;
    await _store.runTransaction((transaction) async {
      var docRef = _store
          .collection('product_info')
          .document('${tabName}_info')
          .collection(tabName)
          .document(product.name);
      await transaction.update(docRef, {'ingredients': product.list});
    });
    notifyListeners();
  }

  Future<FirestoreProduct> createProduct(String name, String group) async {
    Map<String, dynamic> map = {
      'name': name,
      'ingredients': [],
      'image_url': '',
      'price': 0
    };
    FirestoreProduct product = FirestoreProduct(map);
    switch (group) {
      case 'soups':
        _soupList.add(product);
        break;
      case 'dishes':
        _dishList.add(product);
        break;
      case 'drinks':
        _drinkList.add(product);
        break;
    }

    var _store = Firestore.instance;
    await _store.runTransaction((transaction) async {
      var docRef = _store
          .collection('product_info')
          .document('${group}_info')
          .collection(group)
          .document(product.name);
      await transaction.set(docRef, map);
    });

    return product;
  }

  Future<void> deleteProduct(FirestoreProduct product, String tabName) async {
    var _store = Firestore.instance;
    await _store.runTransaction((transaction) async {
      var docRef = _store
          .collection('product_info')
          .document('${tabName}_info')
          .collection(tabName)
          .document(product.name);
      await transaction.delete(docRef);

      var _storageRef = FirebaseStorage.instance
          .ref()
          .child('images/$tabName/${product.name}');

      await _storageRef.delete();

      switch (tabName) {
        case 'soups':
          _soupList.remove(product);
          break;
        case 'dishes':
          _dishList.remove(product);
          break;
        case 'drinks':
          _drinkList.remove(product);
          break;
      }

      print('deleted');
    });

    notifyListeners();
  }

  void clearProducts() {
    _soupList.clear();
    _dishList.clear();
    _drinkList.clear();
  }
}
