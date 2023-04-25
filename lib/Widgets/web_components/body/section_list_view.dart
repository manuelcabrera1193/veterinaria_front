import 'package:accesorios_para_mascotas/models/categories.dart';
import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:accesorios_para_mascotas/utils/scroll.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/models/section.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'menu_section.dart';
import 'product_section.dart';

class SectionListView extends StatefulWidget {
  final AutoScrollController autoScrollController;
  final List<Categories> categories;
  final List<ItemProduct> products;

  final Function(ItemProduct, int, bool) event;

  final int? position;

  const SectionListView({
    Key? key,
    required this.autoScrollController,
    required this.categories,
    required this.products,
    required this.event,
    required this.position,
  }) : super(key: key);

  @override
  State<SectionListView> createState() => _SectionListViewState();
}

class _SectionListViewState extends State<SectionListView> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    final list = widget.categories
        .map(
          (e) => Section(
            title: e.name,
            color: Colors.yellow,
            subtitle: e.description,
            list: widget.products
                .where((element) => element.category.uid == e.uid)
                .toList(),
          ),
        )
        .toList();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          list.length + 1,
          (index) {
            return (index == 0)
                ? Padding(
                    padding:
                        responsiveApp.edgeInsetsApp?.allExLargeEdgeInsets ??
                            const EdgeInsets.all(10),
                    child: addScroll(
                      MenuSection(
                        names: list.map((e) => e.title).toList(),
                        scrollController: widget.autoScrollController,
                      ),
                      widget.position ?? 0,
                      widget.autoScrollController,
                    ),
                  )
                : Padding(
                    padding:
                        responsiveApp.edgeInsetsApp?.allExLargeEdgeInsets ??
                            const EdgeInsets.all(10),
                    child: addScroll(
                      ProductSection(
                        section: list[index - 1],
                        event: widget.event,
                      ),
                      index,
                      widget.autoScrollController,
                    ),
                  );
          },
        ));
  }
}
