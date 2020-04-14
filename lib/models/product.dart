class Product {
  static const nameKey = 'name';
  static const listKey = 'ingredients';
  static const imageUrlKey = 'image_url';
  static const priceKey = 'price';

  String name;
  List list;
  String imageUrl;
  int price;

  Product(Map<String, dynamic> json) {
    name = json[nameKey];
    list = json[listKey];
    imageUrl = json[imageUrlKey];
    try {
      double priceData = json[priceKey];
      price = priceData.toInt();
    } catch (e) {
      price = json[priceKey];
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
