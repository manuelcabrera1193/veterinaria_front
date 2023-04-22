import 'dart:convert';

class Categories {
  String uid;
  String name;
  String description;

  Categories({
    required this.uid,
    required this.name,
    required this.description,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "description": description,
      };

  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        uid: json["uid"],
        name: json["name"],
        description: json["description"],
      );

  Categories copy({String? uid, String? name, String? description}) {
    return Categories(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
