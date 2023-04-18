import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Modelo/Menu.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';

class MenuContainer extends StatefulWidget {
  const MenuContainer({Key? key, required this.index, required this.onPress})
      : super(key: key);

  final int index;
  final Function() onPress;

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Padding(
        padding: responsiveApp.edgeInsetsApp?.hrzSmallEdgeInsets ??
            const EdgeInsets.all(0),
        child: InkWell(
          onTap: () => widget.onPress(),
          child: Container(
              width: responsiveApp.menuContainerWidth,
              height: responsiveApp.menuContainerHeight,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(responsiveApp.menuRadiusWidth))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      menu[widget.index].image,
                      width: responsiveApp.menuImageWidth,
                      height: responsiveApp.menuImageHeight,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      menu[widget.index].title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ])),
        ));
  }
}
