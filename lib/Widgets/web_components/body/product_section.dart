import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/models/section.dart';
import 'package:accesorios_para_mascotas/widgets/Components/product_list_view.dart';

import 'container/section_container.dart';

class ProductSection extends StatelessWidget {
  final Section section;
  final Function(ItemProduct, int, bool) event;
  const ProductSection({
    Key? key,
    required this.section,
    required this.event,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionContainer(
          title: section.title,
          subTitle: section.subtitle,
          color: section.color,
        ),
        ProductListView(list: section.list, event: event)
      ],
    );
  }
}
