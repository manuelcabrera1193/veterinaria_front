import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';

class ProductContainerScreen extends StatefulWidget {
  final ItemProduct product;

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
              widget.product.name.toUpperCase(),
            ),
            Text(widget.product.price.toString()),
          ],
        ),
      ),
    );
  }
}
