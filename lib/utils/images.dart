import 'package:accesorios_para_mascotas/models/menu.dart';
import 'package:flutter/material.dart';

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

ImageProvider addImage(String url) {
  try {
    if (url.isEmpty || url.toLowerCase() == "null") {
      return const AssetImage("assets/images/placeholder2.jpg");
    } else {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset("assets/images/placeholder2.jpg"),
      ).image;
    }
  } catch (e) {
    return const AssetImage("assets/images/placeholder2.jpg");
  }
}
