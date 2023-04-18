import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Modelo/section.dart';
import 'package:accesorios_para_mascotas/Widgets/Components/product_list_view.dart';

import 'Container/section_container.dart';

class ProductSection extends StatelessWidget {
  Section section;
  ProductSection({Key? key, required this.section}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionContainer(
          title: section.title,
          subTitle: section.subtitle,
          color: section.color,
        ),
        ProductListView(list: section.list)
      ],
    );
  }
}
