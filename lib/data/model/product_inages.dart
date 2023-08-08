class MainproductImage {
  String? imageurl;
  String? productid;
  MainproductImage(this.imageurl, this.productid);

  factory MainproductImage.fromjson(Map<String, dynamic> jsonObject) {
    return MainproductImage(
        'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
        jsonObject['product_id']);
  }
}
