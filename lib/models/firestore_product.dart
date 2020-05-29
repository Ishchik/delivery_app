class FirestoreProduct {
  String productName;
  List<dynamic> ingredientsList;
  String productImageUrl;
  int productPrice;

  FirestoreProduct(Map<String, dynamic> map)
      : productName = map['name'],
        ingredientsList = map['ingredients'],
        productImageUrl = map['image_url'],
        productPrice = map['price'];

  String ingredientsListToString() {
    return ingredientsList.join(', ');
  }
}
