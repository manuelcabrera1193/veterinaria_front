import 'package:accesorios_para_mascotas/models/categories.dart';
import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:accesorios_para_mascotas/widgets/components/carousel.dart';
import 'package:accesorios_para_mascotas/widgets/mobile_components/menu_tap.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/body/section_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
    required this.autoScrollController,
  });

  final AutoScrollController autoScrollController;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Categories> _categories = [];
  List<ItemProduct> _products = [];

  Future<List<Categories>> getCategories() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    List<Categories> list = [];
    for (var doc in snapshot.docs) {
      Categories object = Categories.fromMap(doc.data());
      list.add(object);
    }
    return list;
  }

  Future<List<ItemProduct>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("products").get();
    List<ItemProduct> list = [];
    for (var doc in snapshot.docs) {
      ItemProduct object = ItemProduct.fromMap(doc.data());
      list.add(object);
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    _categories = [];
    final categories = await getCategories();
    final products = await getProducts();
    if (mounted) {
      _categories = categories;
      _products = products;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24.0,
        ),
        const Carousel(),
        isMobileAndTablet(context)
            ? MenuTap(
                categories: _categories,
                products: _products,
                size: _categories.length,
              )
            : SectionListView(
                products: _products,
                categories: _categories,
                autoScrollController: widget.autoScrollController,
              ),
      ],
    );
  }
}
