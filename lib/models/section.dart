import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/values/string_app.dart';

import 'product.dart';

class Section {
  String title;
  String subtitle;
  Color color;
  List<ItemProduct> list;

  Section(
      {required this.title,
      required this.subtitle,
      required this.color,
      required this.list});
}

// List<Section> sections = [
//   Section(
//     title: coffeesStr,
//     color: Colors.yellow,
//     subtitle: "Collares, correas y arneses",
//     list: coffeesList,
//   ),
//   Section(
//     title: drinksStr,
//     color: Colors.red,
//     subtitle: "Juguetes y entretenimiento",
//     list: drinksList,
//   ),
//   Section(
//     title: cakesStr,
//     color: Colors.blue,
//     subtitle: "Alimentación y cuidado",
//     list: cakesList,
//   ),
//   Section(
//     title: sandwichesStr,
//     color: Colors.purpleAccent,
//     subtitle: "Ropa y accesorios para el hogar",
//     list: sandwichesList,
//   )
// ];
