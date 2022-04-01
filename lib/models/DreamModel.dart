class DreamModel {
  int? id;
  String name;
  String descriptions;

  DreamModel({this.id, required this.name, required this.descriptions});
  DreamModel.withId(
      {required this.id, required this.name, required this.descriptions});

  factory DreamModel.fromObject(dynamic o) => DreamModel.withId(
        id: int.tryParse(o["id"].toString()),
        name: o["name"],
        descriptions: o["descriptions"],
      );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["descriptions"] = descriptions;

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
