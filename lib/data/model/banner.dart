class MainBanner {
  String? id;
  String? collectionid;
  String? thumbnail;
  String? categoryid;
  MainBanner(this.id, this.collectionid, this.thumbnail, this.categoryid);
  factory MainBanner.fromMapJson(Map<String, dynamic> jsonObject) {
    return MainBanner(
        jsonObject['id'],
        jsonObject["collectionId"],
        "http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}",
        jsonObject["categoryid"]);
  }
}
