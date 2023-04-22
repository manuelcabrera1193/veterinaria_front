import 'dart:convert';

class Profile {
  String uid;
  bool isLogged;
  bool isAdmin;
  String name;
  String email;
  String photo;
  String phoneNumber;
  String address;

  Profile({
    required this.uid,
    required this.isLogged,
    required this.isAdmin,
    required this.name,
    required this.email,
    required this.photo,
    required this.phoneNumber,
    required this.address,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "isLogged": isLogged,
        "isAdmin": isAdmin,
        "name": name,
        "email": email,
        "photo": photo,
        "phoneNumber": phoneNumber,
        "address": address,
      };

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        uid: json["uid"],
        isLogged: json["isLogged"],
        isAdmin: json["isAdmin"],
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
      );
}
