import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Modelo/product.dart';

import 'product_container_screen.dart';

class ProductListView extends StatelessWidget {

  List<Product> list;
  ProductListView({Key? key, required this.list}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ProductContainerScreen(product: list[index], onPress: () {});
      },
    );
  }
}
