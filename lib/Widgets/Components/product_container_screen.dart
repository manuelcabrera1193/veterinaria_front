import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Modelo/product.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';

class ProductContainerScreen extends StatefulWidget {
  static const String routerName = '/Product';
  final Product product;

  final Function() onPress;

  const ProductContainerScreen(
      {Key? key, required this.product, required this.onPress})
      : super(key: key);

  @override
  State<ProductContainerScreen> createState() => _ProductContainerScreenState();
}

class _ProductContainerScreenState extends State<ProductContainerScreen> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return InkWell(
      onTap: widget.onPress,
      child: SizedBox(
        height: responsiveApp.productContainerWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.title.toUpperCase(),
            ),
            Text(widget.product.price),
          ],
        ),
      ),
    );
  }
}
