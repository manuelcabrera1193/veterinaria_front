import 'package:accesorios_para_mascotas/models/body_enum.dart';
import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/models/sale.dart';
import 'package:accesorios_para_mascotas/screens/card/card_screen.dart';
import 'package:accesorios_para_mascotas/screens/home/home_body.dart';
import 'package:accesorios_para_mascotas/screens/home/home_controller.dart';
import 'package:accesorios_para_mascotas/screens/login/login_screen.dart';
import 'package:accesorios_para_mascotas/screens/nosotros/nosotros_screen.dart';
import 'package:accesorios_para_mascotas/screens/profile/profile_screen.dart';
import 'package:accesorios_para_mascotas/screens/register/additional_info_screen.dart';
import 'package:accesorios_para_mascotas/screens/register/categories_screen.dart';
import 'package:accesorios_para_mascotas/screens/register/products_screen.dart';
import 'package:accesorios_para_mascotas/screens/register/users_screen.dart';
import 'package:accesorios_para_mascotas/screens/sales/sale_screen.dart';
import 'package:accesorios_para_mascotas/utils/keys.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:accesorios_para_mascotas/values/string_app.dart';
import 'package:accesorios_para_mascotas/widgets/mobile_components/shop_app_bar.dart';
import 'package:accesorios_para_mascotas/widgets/mobile_components/shop_drawer.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/footer/footer.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/header/header_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = '/Home';

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("page: ${Get.routing.current}");
    print("arg: ${Get.routing.route?.settings.arguments}");

    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    autoScrollController.addListener(_scrollListener);
    validateLogin();
    super.initState();
  }

  Future<void> validateLogin() async {
    final result = await homeController.validateLogin();
    setState(() {});
    return result;
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
          heroTag: UniqueKey(),
          onPressed: () => {autoScrollController.scrollToIndex(0)},
          child: const Icon(Icons.arrow_upward),
        ),
      ),
      drawer: isMobileAndTablet(context)
          ? ShopDrawer(
              user: homeController.getUser(),
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
                  user: homeController.getUser(),
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
            user: homeController.getUser(),
            login: executeLogin,
            loginGoogle: executeLoginGoogle,
            loginFacebook: executeLoginFacebook,
            logout: logout,
            event: (product, cant, redirect) {
              homeController.addProductCard(product, cant, redirect);
              setState(() {});
            },
            sale: homeController.sale.value,
            saveSale: homeController.saveSale,
            redirectHome: () {
              homeController.positionedHome();
              homeController.redirectScreen(BodyEnum.home);
              setState(() {});
              homeController.resetPosition();
            },
            redirectLogin: () {
              homeController.redirectScreen(BodyEnum.login);
              setState(() {});
            },
            position: homeController.position.value == -1
                ? null
                : homeController.position.value,
            isLoggued: homeController.getUser().isLogged,
          ),

          /**
           * End Body
           */

          isMobileAndTablet(context) ? const SizedBox.shrink() : const Footer()
        ],
      ),
    );
  }

  Future<void> logout() async {
    await homeController.logout();
    setState(() {});
    Get.offAllNamed(HomeScreen.routerName);
  }

  Future<String> executeLoginGoogle() async {
    final result = await homeController.executeLoginGoogle();
    setState(() {});
    return result;
  }

  Future<String> executeLoginFacebook() async {
    final result = await homeController.executeLoginFacebook();
    setState(() {});
    return result;
  }

  Future<String> executeLogin(value1, value2) async {
    final result = await homeController.executeLogin(value1, value2);
    setState(() {});
    return result;
  }
}

class BodyContainer extends StatelessWidget {
  final AutoScrollController autoScrollController;
  final BodyEnum body;
  final Profile? user;
  final Future<String> Function(String, String) login;
  final Future<String> Function() loginGoogle;
  final Future<String> Function() loginFacebook;
  final Future<void> Function() logout;

  final Function(ItemProduct, int, bool) event;
  final Sale sale;
  final Future<String> Function() saveSale;
  final Function() redirectHome;
  final Function() redirectLogin;

  final bool isLoggued;

  final int? position;

  const BodyContainer({
    super.key,
    required this.autoScrollController,
    required this.body,
    required this.user,
    required this.login,
    required this.loginGoogle,
    required this.loginFacebook,
    required this.logout,
    required this.event,
    required this.sale,
    required this.saveSale,
    required this.redirectHome,
    required this.redirectLogin,
    required this.position,
    required this.isLoggued,
  });

  @override
  Widget build(BuildContext context) {
    switch (body) {
      case BodyEnum.ventas:
        return const SalesScreen();
      case BodyEnum.home:
        return HomeBody(
          autoScrollController: autoScrollController,
          event: event,
          position: position,
        );
      case BodyEnum.contacts:
        return const BodyItem(name: "contacts");
      case BodyEnum.users:
        return const ListUsersScreen();
      case BodyEnum.products:
        return const ProductsScreen();
      case BodyEnum.categories:
        return const CategoriesScreen();
      case BodyEnum.additionalInfo:
        return const AdditionalInfoScreen();
      case BodyEnum.carrito:
        return CardScreen(
          sale: sale,
          saveSale: saveSale,
          redirectHome: redirectHome,
          redirectLogin: redirectLogin,
          isLoggued: isLoggued,
          userId: user?.uid ?? "",
        );
      case BodyEnum.nosotros:
        return NosotrosWidget(autoScrollController: autoScrollController);
      case BodyEnum.login:
        return LoginScreen(
          login: login,
          loginGoogle: loginGoogle,
          loginFacebook: loginFacebook,
        );
      case BodyEnum.profile:
        return ProfileScreen(
          autoScrollController: autoScrollController,
          user: user,
          logout: logout,
        );
      // case BodyEnum.contactamos:
      //   return const BodyItem(name: "contactamos");
      case BodyEnum.registros:
        return const ListUsersScreen();
      // case BodyEnum.ventas:
      //   return const BodyItem(name: "ventas");
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
