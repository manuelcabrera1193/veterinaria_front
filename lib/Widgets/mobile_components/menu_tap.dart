import 'package:accesorios_para_mascotas/models/categories.dart';
import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:accesorios_para_mascotas/utils/images.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/widgets/Components/product_list_view.dart';

class MenuTap extends StatefulWidget {
  final List<Categories> categories;
  final List<ItemProduct> products;
  final int size;

  const MenuTap({
    super.key,
    required this.categories,
    required this.products,
    required this.size,
  });

  @override
  State<StatefulWidget> createState() => MenuTapState();
}

class MenuTapState extends State<MenuTap> {
  ResponsiveApp? responsiveApp;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final names = widget.categories.map((e) => e.name).toList();
    responsiveApp = ResponsiveApp(context);
    return names.isEmpty
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : DefaultTabController(
            length: widget.size,
            child: SizedBox(
              height: responsiveApp?.menuTabContainerHeight,
              child: Padding(
                padding: responsiveApp?.edgeInsetsApp?.allLargeEdgeInsets ??
                    const EdgeInsets.all(0),
                child: Column(
                  children: <Widget>[
                    TabBar(
                      onTap: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      tabs: names
                          .map((ele) => createTab(
                                names.indexOf(ele),
                                getMenu(ele, names.indexOf(ele)).title,
                                getMenu(ele, names.indexOf(ele)).image,
                                context,
                              ))
                          .toList(),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: widget.categories
                            .map(
                              (e) => ProductListView(
                                list: widget.products
                                    .where((element) =>
                                        element.category.uid == e.uid)
                                    .toList(),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget createTab(int index, String text, String image, BuildContext context) {
    return Tab(
      text: text,
      icon: Image.asset(
        image,
        fit: BoxFit.fill,
        height: _selectedIndex == index
            ? (responsiveApp?.tabImageHeight * 1.2)
            : responsiveApp?.tabImageHeight,
      ),
    );
  }
}
