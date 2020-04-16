class FirestoreProduct {
  String name;
  List list;
  String imageUrl;
  int price;

  FirestoreProduct(Map<String, dynamic> json) {
    name = json['name'];
    list = json['ingredients'];
    imageUrl = json['image_url'];
    try {
      double priceData = json['price'];
      price = priceData.toInt();
    } catch (e) {
      price = json['price'];
    }
  }

  String listString() {
    String result = '';
    for (String item in list) {
      result += item + ', ';
    }
    return result.substring(0, result.length - 1);
  }
}
