import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/models/sale_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Sale {
  String? uid = "";
  String correlativo;
  Profile usuario;
  DateTime fecha;
  double total;
  bool completed;
  List<SaleDetail> saleDetails;

  Sale(
      {this.uid,
      required this.correlativo,
      required this.usuario,
      required this.fecha,
      required this.total,
      required this.completed,
      required this.saleDetails});

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "correlativo": correlativo,
        "usuario": usuario.toMap(),
        "fecha": fecha,
        "total": total,
        "completed": completed,
        "saleDetails": List<dynamic>.from(saleDetails.map((x) => x.toMap())),
      };

  Sale copy(
      {String? uid,
      String? correlativo,
      Profile? usuario,
      DateTime? fecha,
      double? total,
      bool? completed,
      List<SaleDetail>? saleDetails}) {
    return Sale(
      uid: uid ?? this.uid,
      correlativo: correlativo ?? this.correlativo,
      usuario: usuario ?? this.usuario,
      fecha: fecha ?? this.fecha,
      total: total ?? this.total,
      completed: completed ?? this.completed,
      saleDetails: saleDetails ?? this.saleDetails,
    );
  }

  String getCorrelativo() {
    return UniqueKey().toString();
  }

  factory Sale.fromMap(Map<String, dynamic> json) => Sale(
        uid: json["uid"],
        correlativo: json["correlativo"],
        usuario: Profile.fromMap(json["usuario"]),
        fecha: (json["fecha"] as Timestamp).toDate(),
        total: json["total"],
        completed: json["completed"],
        saleDetails: List<SaleDetail>.from(
            json["saleDetails"].map((x) => SaleDetail.fromMap(x))),
      );
}

Sale getEmptySale() {
  return Sale(
    uid: '',
    correlativo: '',
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
    completed: false,
    saleDetails: [],
  );
}
