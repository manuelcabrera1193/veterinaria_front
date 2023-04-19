import 'package:accesorios_para_mascotas/models/item_product.dart';

class SaleDetail {
  ItemProduct item;
  int cantidad;
  double subtotal;

  SaleDetail({required this.item, required this.cantidad, required this.subtotal});
}