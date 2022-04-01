class Calendar {
  int? id;
  String name;
  String? date;
  String descriptions;

  Calendar({
    this.id,
    required this.name,
    required this.descriptions,
     this.date,
  });

  Calendar.withId(
      {required this.id,
      required this.name,
      required this.date,
      required this.descriptions});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["descriptions"] = descriptions;

    if(date!=null){
      map["date"] = date;
    }
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  factory Calendar.fromObject(dynamic o) => Calendar(
      id: int.tryParse(o["id"].toString()),
      name: o["name"],
      descriptions: o["descriptions"],
      date: o["date"]);
}
