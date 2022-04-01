
class MemoryItemModel {
   int? id;
  String name;
  String mostRecentText;
  String date;

  MemoryItemModel({
    required this.name,
    required this.mostRecentText,
    required this.date,
  });

  MemoryItemModel.withId({
    required this.id,
    required this.name,
    required this.mostRecentText,
    required this.date,
  });

  factory MemoryItemModel.fromObject( dynamic o) =>
      MemoryItemModel.withId(
          id: int.tryParse(o["id"].toString()),
          name: o["name"],
          mostRecentText: o["mostRecentText"],
          date: o["date"]);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["mostRecentText"] = mostRecentText;
    map["date"] = date;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
