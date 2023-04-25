import 'package:accesorios_para_mascotas/models/page.dart';
import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:accesorios_para_mascotas/models/body_enum.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/header/header_button.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/header/header_list_button.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/values/string_app.dart';

class HeaderWeb extends StatefulWidget implements PreferredSizeWidget {
  final Profile? user;
  final double opacity;
  final Function(BodyEnum) redirect;

  const HeaderWeb(
      {Key? key,
      required this.opacity,
      required this.redirect,
      required this.user})
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
                "   $shopStr",
                style: TextStyle(
                  color: Colors.white,
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
                  // HeaderButton(
                  //   index: 3,
                  //   title: ventas,
                  //   redirect: () {
                  //     widget.redirect(BodyEnum.ventas);
                  //   },
                  // ),
                  widget.user?.isAdmin ?? false
                      ? HeaderListButton(
                          views: listRegisters,
                          index: 4,
                          title: registros,
                          redirect: (bodyEnum) {
                            widget.redirect(bodyEnum);
                          },
                        )
                      : const SizedBox.shrink(),
                  HeaderButton(
                    index: 6,
                    title: (widget.user?.isLogged ?? false) ? profile : login,
                    lineIsVisible: false,
                    redirect: () {
                      if (widget.user?.isLogged ?? false) {
                        widget.redirect(BodyEnum.profile);
                      } else {
                        widget.redirect(BodyEnum.login);
                      }
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
