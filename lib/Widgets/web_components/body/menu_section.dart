import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/body/container/menu_container.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/models/menu.dart';
import 'package:accesorios_para_mascotas/values/string_app.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'container/section_container.dart';

class MenuSection extends StatefulWidget {
  final AutoScrollController scrollController;

  const MenuSection({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);

    return Column(
      children: [
        SectionContainer(
          title: sectionMenuTitleStr,
          subTitle: sectionMenuSubTitleStr,
        ),
        Padding(
            padding: responsiveApp.edgeInsetsApp?.onlyExLargeTopEdgeInsets ??
                const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  menu.length,
                  (index) => MenuContainer(
                      index: index, onPress: () => scrollIndex(index + 1))),
            ))
      ],
    );
  }

  scrollIndex(index) {
    widget.scrollController.scrollToIndex(index);
  }
}
