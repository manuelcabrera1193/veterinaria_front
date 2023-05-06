import 'package:accesorios_para_mascotas/models/item_product.dart';

class SaleDetail {
  ItemProduct item;
  int cantidad;
  double subtotal;

  SaleDetail(
      {required this.item, required this.cantidad, required this.subtotal});

  Map<String, dynamic> toMap() => {
        "item": item.toMap(),
        "cantidad": cantidad,
        "subtotal": subtotal,
      };

  factory SaleDetail.fromMap(Map<String, dynamic> json) => SaleDetail(
        item: ItemProduct.fromMap(json["item"]),
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
      );
}
