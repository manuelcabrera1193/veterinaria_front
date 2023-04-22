import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/models/sale_detail.dart';

class Sale {
  int correlativo;
  Profile usuario;
  DateTime fecha;
  double total;
  List<SaleDetail> saleDetails;

  Sale({required this.correlativo, required this.usuario, required this.fecha, required this.total, required this.saleDetails});
}