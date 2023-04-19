import 'package:accesorios_para_mascotas/utils/keys.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:accesorios_para_mascotas/widgets/mobile_components/menu_tap.dart';
import 'package:accesorios_para_mascotas/widgets/mobile_components/shop_app_bar.dart';
import 'package:accesorios_para_mascotas/widgets/mobile_components/shop_drawer.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:accesorios_para_mascotas/screens/home/body_enum.dart';
import 'package:accesorios_para_mascotas/widgets/Components/carousel.dart';
import 'package:accesorios_para_mascotas/screens/home/home_controller.dart';
import 'package:accesorios_para_mascotas/screens/login/login_screen.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/body/section_list_view.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/footer/footer.dart';
import 'package:accesorios_para_mascotas/widgets/web_components/header/header_web.dart';
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
          ? FutureBuilder(
              future: homeController.isLooged(),
              builder: (context, AsyncSnapshot<bool> info) {
                return ShopDrawer(
                  isLogged: info.data ?? false,
                  redirect: (body) {
                    homeController.redirectScreen(body);
                    homeScaffoldKey.currentState!.openEndDrawer();
                    setState(() {});
                  },
                );
              })
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
                ? const MenuTap()
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
        return const NosotrosWidget();
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

class NosotrosWidget extends StatelessWidget {
  const NosotrosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 50,
            runSpacing: 50,
            //crossAxisCount: isMobileAndTablet(context) ? 4 : 2,
            children: const [
              CardNosotros(
                title: "Implante Microchip",
                description:
                    "Un microchip para perros siempre se mantendrá seguro en su lugar. Si sucede lo peor y tu perro se pierde, un microchip puede ayudar a garantizar ...",
              ),
              CardNosotros(
                title: "Ultrasonido",
                description:
                    "Consiste en echar un vistazo a los órganos que se encuentran en el abdomen y el tórax de su perro o su gato; estos órganos incluyen ...",
              ),
              CardNosotros(
                title: "Servicio de Transporte",
                description:
                    "Encontrar el servicio de transporte adecuado que pueda cuidar adecuadamente a su mascota, mantener el costo de la entrega a un precio bajo ...",
              ),
              CardNosotros(
                title: "Vacunas",
                description:
                    "Las vacunas más comunes son la trivalente, la tetravalente o bien la polivalente ...",
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Divider(
              height: 10,
            ),
          ),
          const Card2Nosotros(
            title: "ACERCA DE NUESTRA CLINICA:",
            description:
                "Nuestro Equipo te garantiza una atencion A1. \nEn nuestra clínica encontrarás todo lo que tu mascota necesita en un solo lugar. Convivir con perros y gatos en el embarazo tiene beneficios para la salud ...",
          ),
        ],
      ),
    );
  }
}

class Card2Nosotros extends StatelessWidget {
  const Card2Nosotros({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.orangeAccent,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardNosotros extends StatelessWidget {
  const CardNosotros({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.orangeAccent,
      child: SizedBox(
        width: 200,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
