class Property {
  String title;
  String value;
  Property(this.title, this.value);
  factory Property.fromjson(Map<String, dynamic> json) {
    return Property(json['title'], json['value']);
  }
}
