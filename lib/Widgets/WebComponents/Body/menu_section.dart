import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Modelo/Menu.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';
import 'package:accesorios_para_mascotas/Values/StringApp.dart';
import 'package:accesorios_para_mascotas/Widgets/WebComponents/Body/Container/menu_container.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'Container/section_container.dart';

class MenuSection extends StatelessWidget {
  AutoScrollController scrollController;

  MenuSection({Key? key, required this.scrollController}): super(key: key);

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
            padding: responsiveApp.edgeInsetsApp?.onlyExLargeTopEdgeInsets ?? const EdgeInsets.all(0),
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
    scrollController.scrollToIndex(index);
  }
}
