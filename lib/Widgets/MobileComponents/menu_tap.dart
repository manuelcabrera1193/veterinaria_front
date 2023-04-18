import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Modelo/Menu.dart';
import 'package:accesorios_para_mascotas/Modelo/product.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';
import 'package:accesorios_para_mascotas/Widgets/Components/product_list_view.dart';

class MenuTap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuTapState();
}

class MenuTapState extends State<MenuTap> with TickerProviderStateMixin {
  TabController? _controller;
  ResponsiveApp? responsiveApp;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: menu.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return SizedBox(
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
                controller: _controller,
                tabs: List.generate(
                    menu.length,
                    (index) => createTab(
                        index, menu[index].title, menu[index].image, context))),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  ProductListView(list: coffeesList),
                  ProductListView(list: drinksList),
                  ProductListView(list: cakesList),
                  ProductListView(list: sandwichesList),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  createTab(int index, String text, String image, BuildContext context) {
    return Tab(
      text: text,
      icon: Image.asset(
        image,
        // color: _selectedIndex == index
        //     ? Theme.of(context).iconTheme.color
        //     : Theme.of(context).unselectedWidgetColor,
        fit: BoxFit.fill,
        height: _selectedIndex == index
            ? (responsiveApp?.tabImageHeight * 1.2)
            : responsiveApp?.tabImageHeight,
      ),
    );
  }
}
