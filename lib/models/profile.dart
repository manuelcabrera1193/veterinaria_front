import 'dart:convert';

import 'package:accesorios_para_mascotas/models/sale.dart';

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

  Profile copy({
    String? uid,
    bool? isLogged,
    bool? isAdmin,
    String? name,
    String? email,
    String? photo,
    String? phoneNumber,
    String? address,
    List<Sale>? sales,
  }) {
    return Profile(
      uid: uid ?? this.uid,
      isLogged: isLogged ?? this.isLogged,
      isAdmin: isAdmin ?? this.isAdmin,
      name: name ?? this.name,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }
}
