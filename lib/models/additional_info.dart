import 'dart:convert';

class AdditionalInfo {
  String uid;
  String name;

  AdditionalInfo({
    required this.uid,
    required this.name,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
      };

  factory AdditionalInfo.fromMap(Map<String, dynamic> json) => AdditionalInfo(
        uid: json["uid"],
        name: json["name"],
      );

  AdditionalInfo copy({String? uid, String? name, String? description}) {
    return AdditionalInfo(
      uid: uid ?? this.uid,
      name: name ?? this.name,
    );
  }
}
