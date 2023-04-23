import 'dart:convert';

import 'package:accesorios_para_mascotas/models/additional_info.dart';
import 'package:accesorios_para_mascotas/models/categories.dart';

class ItemProduct {
  String uid;
  String name;
  String image;
  double price;
  Categories category;
  int stock;
  List<AdditionalInfo> additional;

  ItemProduct({
    required this.uid,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.stock,
    required this.additional,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "image": image,
        "price": price,
        "category": category.toMap(),
        "stock": stock,
        "additional": List<dynamic>.from(additional.map((x) => x.toMap())),
      };

  factory ItemProduct.fromMap(Map<String, dynamic> json) => ItemProduct(
        uid: json['uid'],
        name: json['name'],
        image: json['image'],
        price: json['price'],
        category: Categories.fromMap(json['category']),
        stock: json['stock'],
        additional: List<AdditionalInfo>.from(
            json["additional"].map((x) => AdditionalInfo.fromMap(x))),
      );

  ItemProduct copy({
    String? uid,
    String? name,
    String? image,
    double? price,
    Categories? category,
    int? stock,
    List<AdditionalInfo>? additional,
  }) {
    return ItemProduct(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      additional: additional ?? this.additional,
    );
  }
}
