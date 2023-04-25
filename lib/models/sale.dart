import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/models/sale_detail.dart';

class Sale {
  int correlativo;
  Profile usuario;
  DateTime fecha;
  double total;
  List<SaleDetail> saleDetails;

  Sale(
      {required this.correlativo,
      required this.usuario,
      required this.fecha,
      required this.total,
      required this.saleDetails});

  Sale copy(
      {int? correlativo,
      Profile? usuario,
      DateTime? fecha,
      double? total,
      List<SaleDetail>? saleDetails}) {
    return Sale(
      correlativo: correlativo ?? this.correlativo,
      usuario: usuario ?? this.usuario,
      fecha: fecha ?? this.fecha,
      total: total ?? this.total,
      saleDetails: saleDetails ?? this.saleDetails,
    );
  }

  int getCorrelativo() {
    // Obtiene la fecha actual
    DateTime now = DateTime.now();
    // Convierte la fecha a un valor numérico
    int correlativo = int.parse(
        "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}");
    return correlativo;
  }
}

Sale getEmptySale() {
  return Sale(
    correlativo: 0,
    usuario: Profile(
      uid: '',
      isLogged: false,
      isAdmin: false,
      name: '',
      email: '',
      photo: '',
      phoneNumber: '',
      address: '',
    ),
    fecha: DateTime.now(),
    total: 0.0,
    saleDetails: [],
  );
}
