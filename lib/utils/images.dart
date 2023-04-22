import 'package:accesorios_para_mascotas/models/menu.dart';

Menu getMenu(String name, int position) {
  String imageCustom = "";
  switch (position) {
    case 0:
      imageCustom = "assets/images/menu1.png";
      break;
    case 1:
      imageCustom = "assets/images/menu2.png";
      break;
    case 2:
      imageCustom = "assets/images/menu3.png";
      break;
    case 3:
      imageCustom = "assets/images/menu4.png";
      break;
    default:
      imageCustom = "assets/images/menu1.png";
  }

  return Menu(
    title: name,
    image: imageCustom,
  );
}
