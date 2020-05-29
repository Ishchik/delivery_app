import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/firestore_product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  FirestoreProduct getProductData(FirestoreProduct product) => product;

  Future<void> changeProductImage(
      FirestoreProduct product, String tabName) async {
    await ImagePicker.pickImage(source: ImageSource.gallery)
        .then((image) async {
      if (image != null) {
        var _storageRef = FirebaseStorage.instance
            .ref()
            .child('images/$tabName/${product.productName}');
        await _storageRef.putFile(image).onComplete.then((snapshot) async {
          await _storageRef.getDownloadURL().then((url) async {
            await Firestore.instance
                .collection('product_info')
                .document('${tabName}_info')
                .collection(tabName)
                .document(product.productName)
                .updateData({'image_url': url});
            product.productImageUrl = url.toString();
          });
        });
      }
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
          .document(product.productName);
      await transaction.update(docRef, {'price': newPrice});
      product.productPrice = newPrice;
    });
    notifyListeners();
  }

  Future<void> editProductIngredientName(FirestoreProduct product, int index,
      String tabName, String newName) async {
    product.ingredientsList[index] = newName;
    await _editProductIngredients(product, tabName);
  }

  Future<void> addProductIngredient(
      FirestoreProduct product, String tabName, String newIngredient) async {
    product.ingredientsList.add(newIngredient);
    await _editProductIngredients(product, tabName);
  }

  Future<void> deleteProductIngredient(
      FirestoreProduct product, String tabName, int index) async {
    product.ingredientsList.removeAt(index);
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
          .document(product.productName);
      await transaction
          .update(docRef, {'ingredients': product.ingredientsList});
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
          .document(product.productName);
      await transaction.set(docRef, map);
    });

//    notifyListeners();
    return product;
  }

  Future<void> deleteProduct(FirestoreProduct product, String tabName) async {
    var _store = Firestore.instance;
    await _store.runTransaction((transaction) async {
      var docRef = _store
          .collection('product_info')
          .document('${tabName}_info')
          .collection(tabName)
          .document(product.productName);
      await transaction.delete(docRef);

      if (product.productImageUrl.isNotEmpty) {
        var _storageRef = FirebaseStorage.instance
            .ref()
            .child('images/$tabName/${product.productName}');

        await _storageRef.delete();
      }

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
    });

    notifyListeners();
  }

  void clearProducts() {
    _soupList.clear();
    _dishList.clear();
    _drinkList.clear();
  }
}
