class FirestoreProduct {
  String name;
  List list;
  String imageUrl;
  int price;

  FirestoreProduct(Map<String, dynamic> map) {
    name = map['name'];
    list = map['ingredients'];
    imageUrl = map['image_url'];
    price = map['price'];
  }

  String listString() {
    String result = '';
    if (list.length < 1) {
      return result;
    }
    for (String item in list) {
      result += item + ', ';
    }
    return result.substring(0, result.length - 2);
  }
}
