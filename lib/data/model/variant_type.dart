class VariantType {
  String? id;
  String? name;
  String? title;
  varianttypeenum? type;

  VariantType(this.id, this.name, this.title, this.type);
  factory VariantType.fromjson(Map<String, dynamic> jsonObject) {
    return VariantType(jsonObject["id"], jsonObject["name"],
        jsonObject["title"], _gettypeenum(jsonObject["type"]));
  }
}

varianttypeenum _gettypeenum(String type) {
  switch (type) {
    case "Color":
      return varianttypeenum.color;
    case "Storage":
      return varianttypeenum.storage;
    case "Voltage":
      return varianttypeenum.voltage;
    default:
      return varianttypeenum.color;
  }
}

enum varianttypeenum { color, storage, voltage }
