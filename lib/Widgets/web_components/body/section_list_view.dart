import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/models/section.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'menu_section.dart';
import 'product_section.dart';

class SectionListView extends StatefulWidget {
  final AutoScrollController autoScrollController;

  const SectionListView({Key? key, required this.autoScrollController})
      : super(key: key);

  @override
  State<SectionListView> createState() => _SectionListViewState();
}

class _SectionListViewState extends State<SectionListView> {
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
                        MenuSection(
                            scrollController: widget.autoScrollController),
                        0))
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
      controller: widget.autoScrollController,
      index: index,
      child: child,
    );
  }
}
