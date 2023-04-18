import 'package:accesorios_para_mascotas/screens/home/body_enum.dart';
import 'package:accesorios_para_mascotas/Util/keys.dart';
import 'package:accesorios_para_mascotas/Util/sizing_info.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';
import 'package:accesorios_para_mascotas/Widgets/Components/carousel.dart';
import 'package:accesorios_para_mascotas/Widgets/MobileComponents/menu_tap.dart';
import 'package:accesorios_para_mascotas/Widgets/MobileComponents/shop_app_bar.dart';
import 'package:accesorios_para_mascotas/Widgets/MobileComponents/shop_drawer.dart';
import 'package:accesorios_para_mascotas/Widgets/WebComponents/Body/section_list_view.dart';
import 'package:accesorios_para_mascotas/Widgets/WebComponents/Footer/footer.dart';
import 'package:accesorios_para_mascotas/Widgets/WebComponents/Header/header_web.dart';
import 'package:accesorios_para_mascotas/screens/home/home_controller.dart';
import 'package:accesorios_para_mascotas/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _scrollPosition = 0;
  double _opacity = 0;

  late AutoScrollController autoScrollController;
  bool _isVisible = false;
  ResponsiveApp? responsiveApp;

  final homeController = Get.find<HomeController>();

  _scrollListener() {
    setState(() {
      _scrollPosition = autoScrollController.position.pixels;
    });
  }

  @override
  void initState() {
    autoScrollController = AutoScrollController(
        //add this for advanced viewport boundary. e.g. SafeArea
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    autoScrollController!.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);

    _opacity = _scrollPosition < responsiveApp?.opacityHeight
        ? _scrollPosition / responsiveApp?.opacityHeight
        : 1;

    _isVisible = _scrollPosition >= responsiveApp!.menuHeight;
    return Scaffold(
      key: homeScaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          onPressed: () => {autoScrollController.scrollToIndex(0)},
          child: const Icon(Icons.arrow_upward),
        ),
      ),
      drawer: isMobileAndTablet(context)
          ? ShopDrawer(
              redirect: (body) {
                homeController.redirectScreen(body);
                homeScaffoldKey.currentState!.openEndDrawer();
                setState(() {});
              },
            )
          : Container(),
      body: ListView(
        controller: autoScrollController,
        children: [
          isMobileAndTablet(context)
              ? AppBar(
                  title: ShopAppBar(
                  opacity: _opacity,
                  redirect: (body) {
                    homeController.redirectScreen(body);
                    homeScaffoldKey.currentState!.openEndDrawer();
                    setState(() {});
                  },
                ))
              : HeaderWeb(
                  opacity: 1,
                  redirect: (body) {
                    homeController.redirectScreen(body);
                    setState(() {});
                  }),
          /**
           * Start Body
           */
          BodyContainer(
            autoScrollController: autoScrollController,
            body: homeController.bodyEnumState.value,
          ),
          /**
           * End Body
           */

          isMobileAndTablet(context) ? const SizedBox.shrink() : Footer()
        ],
      ),
    );
  }
}

class BodyContainer extends StatelessWidget {
  final AutoScrollController autoScrollController;
  final BodyEnum body;

  const BodyContainer({
    super.key,
    required this.autoScrollController,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    switch (body) {
      case BodyEnum.home:
        return Column(
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Carousel(),
            isMobileAndTablet(context)
                ? MenuTap()
                : SectionListView(
                    autoScrollController: autoScrollController,
                  ),
          ],
        );
      case BodyEnum.contacts:
        return const BodyItem(name: "contacts");
      case BodyEnum.carrito:
        return const BodyItem(name: "carrito");
      case BodyEnum.nosotros:
        return const BodyItem(name: "nosotros");
      case BodyEnum.login:
        return const LoginScreen();
      case BodyEnum.contactamos:
        return const BodyItem(name: "contactamos");
      case BodyEnum.registros:
        return const BodyItem(name: "registros");
      case BodyEnum.ventas:
        return const BodyItem(name: "ventas");
      default:
        return Container();
    }
  }
}

class BodyItem extends StatelessWidget {
  final String name;
  const BodyItem({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text("Titulo $name");
  }
}
