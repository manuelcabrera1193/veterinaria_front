import 'package:accesorios_para_mascotas/Widgets/WebComponents/Header/header_button.dart';
import 'package:accesorios_para_mascotas/screens/home/body_enum.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';
import 'package:accesorios_para_mascotas/Values/StringApp.dart';

class HeaderWeb extends StatefulWidget implements PreferredSizeWidget {
  final double opacity;
  final Function(BodyEnum) redirect;

  const HeaderWeb({Key? key, required this.opacity, required this.redirect})
      : super(key: key);

  @override
  State<HeaderWeb> createState() => _HeaderWebState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderWebState extends State<HeaderWeb> {
  late ResponsiveApp responsiveApp;
  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(widget.opacity),
      child: Padding(
        padding: responsiveApp.edgeInsetsApp?.allMediumEdgeInsets ??
            const EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1,
              child: Text(
                shopStr,
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: responsiveApp.headline6 * 1.5,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: responsiveApp.letterSpacingHeaderWidth,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HeaderButton(
                    index: 0,
                    title: home,
                    redirect: () {
                      widget.redirect(BodyEnum.home);
                    },
                  ),
                  HeaderButton(
                    index: 1,
                    title: nosotros,
                    redirect: () {
                      widget.redirect(BodyEnum.nosotros);
                    },
                  ),
                  HeaderButton(
                    index: 2,
                    title: carrito,
                    redirect: () {
                      widget.redirect(BodyEnum.carrito);
                    },
                  ),
                  HeaderButton(
                    index: 3,
                    title: ventas,
                    redirect: () {
                      widget.redirect(BodyEnum.ventas);
                    },
                  ),
                  HeaderButton(
                    index: 4,
                    title: registros,
                    redirect: () {
                      widget.redirect(BodyEnum.registros);
                    },
                  ),
                  HeaderButton(
                    index: 5,
                    title: contactos,
                    redirect: () {
                      widget.redirect(BodyEnum.contacts);
                    },
                  ),
                  HeaderButton(
                    index: 6,
                    title: login,
                    lineIsVisible: false,
                    redirect: () {
                      widget.redirect(BodyEnum.login);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
