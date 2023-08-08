class MainCategory {
  String? collectionId;
  String? id;
  String? thumbnail;
  String? title;
  String? color;
  String? icon;
  MainCategory(this.collectionId, this.id, this.thumbnail, this.title,
      this.color, this.icon);

  factory MainCategory.fromMapJson(Map<String, dynamic> jsonObject) {
    return MainCategory(
      jsonObject['collectionId'],
      jsonObject['id'],
      "http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}",
      jsonObject['title'],
      jsonObject['color'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['icon']}',
    );
  }
}
