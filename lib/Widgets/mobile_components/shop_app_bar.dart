import 'package:accesorios_para_mascotas/models/body_enum.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:accesorios_para_mascotas/values/string_app.dart';

class ShopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double opacity;
  final Function(BodyEnum) redirect;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const ShopAppBar({Key? key, required this.opacity, required this.redirect})
      : super(key: key);

  @override
  State<ShopAppBar> createState() => _ShopAppBarState();
}

class _ShopAppBarState extends State<ShopAppBar> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Column(
      children: [
        Card(
          color: Theme.of(context).primaryColor.withOpacity(widget.opacity),
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                shopStr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: responsiveApp.headline6 * 1.5,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: responsiveApp.letterSpacingHeaderWidth,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.local_grocery_store_outlined),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  widget.redirect(BodyEnum.carrito);
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
