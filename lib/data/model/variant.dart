class variant {
  String? id;
  String? name;
  String? typeId;
  String? value;
  int? pricechange;

  variant(this.id, this.name, this.typeId, this.value, this.pricechange);
  factory variant.fromjson(Map<String, dynamic> jsonobject) {
    return variant(jsonobject["id"], jsonobject["name"], jsonobject["type_id"],
        jsonobject["value"], jsonobject["price_change"]);
  }
}
