class MainProduct {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discountPrice;
  int price;
  String popularity;
  String name;
  int quantity;
  String category;
  int? realprice;
  num? persent;

  MainProduct(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.description,
    this.discountPrice,
    this.price,
    this.popularity,
    this.name,
    this.quantity,
    this.category,
  ) {
    this.realprice = price + discountPrice;
    this.persent = ((price - realprice!) / price) * 100;
  }
  factory MainProduct.fromjson(Map<String, dynamic> jsonobject) {
    return MainProduct(
        jsonobject['id'],
        jsonobject['collectionId'],
        'http://startflutter.ir/api/files/${jsonobject['collectionId']}/${jsonobject['id']}/${jsonobject['thumbnail']}',
        jsonobject['description'],
        jsonobject['discount_price'],
        jsonobject['price'],
        jsonobject['popularity'],
        jsonobject['name'],
        jsonobject['quantity'],
        jsonobject['category']);
  }
}
