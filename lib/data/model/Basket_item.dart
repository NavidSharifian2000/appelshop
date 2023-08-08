import 'package:hive_flutter/hive_flutter.dart';

part 'Basket_item.g.dart';

@HiveType(typeId: 0)
class Basket_Item {
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  int discountPrice;
  @HiveField(4)
  int price;
  @HiveField(5)
  String name;
  @HiveField(6)
  String category;
  @HiveField(7)
  int? realprice;
  @HiveField(8)
  num? persent;

  Basket_Item(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.discountPrice,
    this.price,
    this.name,
    this.category,
  ) {
    this.realprice = price + discountPrice;
    this.persent = ((price - realprice!) / price) * 100;
    //'http://startflutter.ir/api/files/${jsonobject['collectionId']}/${jsonobject['id']}/${jsonobject['thumbnail']}',
  }
}
