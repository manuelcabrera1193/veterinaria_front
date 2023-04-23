import 'package:accesorios_para_mascotas/models/body_enum.dart';

class PageModel {
  String? name;
  BodyEnum? bodyEnum;

  PageModel({required this.name, required this.bodyEnum});
}

final listRegisters = [
  PageModel(
    name: "Productos",
    bodyEnum: BodyEnum.products,
  ),
  PageModel(
    name: "Categorias",
    bodyEnum: BodyEnum.categories,
  ),
  PageModel(
    name: "Información Adicional",
    bodyEnum: BodyEnum.additionalInfo,
  ),
  PageModel(
    name: "Usuarios",
    bodyEnum: BodyEnum.users,
  ),
];
