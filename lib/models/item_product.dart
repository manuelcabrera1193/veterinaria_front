import 'dart:convert';

import 'package:accesorios_para_mascotas/models/categories.dart';

class ItemProduct {
  String uid;
  String name;
  double price;
  Categories category;
  int stock;

  ItemProduct({
    required this.uid,
    required this.name,
    required this.price,
    required this.category,
    required this.stock,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "price": price,
        "category": category.toMap(),
        "stock": stock,
      };

  factory ItemProduct.fromMap(Map<String, dynamic> json) => ItemProduct(
        uid: json['uid'],
        name: json['name'],
        price: json['price'],
        category: Categories.fromMap(json['category']),
        stock: json['stock'],
      );

  ItemProduct copy({
    String? uid,
    String? name,
    double? price,
    Categories? category,
    int? stock,
  }) {
    return ItemProduct(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      stock: stock ?? this.stock,
    );
  }
}
