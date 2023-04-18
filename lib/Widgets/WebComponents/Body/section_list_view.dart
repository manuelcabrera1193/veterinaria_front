import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Modelo/section.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'menu_section.dart';
import 'product_section.dart';

class SectionListView extends StatelessWidget {
  AutoScrollController autoScrollController;

  SectionListView({Key? key, required this.autoScrollController})
      : super(key: key);

  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          sections.length + 1,
          (index) {
            return (index == 0)
                ? Padding(
                    padding:
                        responsiveApp.edgeInsetsApp?.allExLargeEdgeInsets ??
                            const EdgeInsets.all(10),
                    child: addScroll(
                        MenuSection(scrollController: autoScrollController), 0))
                : Padding(
                    padding:
                        responsiveApp.edgeInsetsApp?.allExLargeEdgeInsets ??
                            const EdgeInsets.all(10),
                    child: addScroll(
                        ProductSection(section: sections[index - 1]), index));
          },
        ));
  }

  addScroll(Widget child, index) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: autoScrollController,
      index: index,
      child: child,
    );
  }
}
