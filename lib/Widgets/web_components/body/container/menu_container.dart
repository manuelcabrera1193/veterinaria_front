import 'package:accesorios_para_mascotas/utils/images.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';

class MenuContainer extends StatefulWidget {
  const MenuContainer({
    Key? key,
    required this.index,
    required this.onPress,
    required this.names,
  }) : super(key: key);

  final int index;
  final Function() onPress;
  final List<String> names;

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
                getMenu(widget.names[widget.index], widget.index).image,
                width: responsiveApp.menuImageWidth,
                height: responsiveApp.menuImageHeight,
                fit: BoxFit.fill,
              ),
              Text(
                getMenu(widget.names[widget.index], widget.index).title,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
