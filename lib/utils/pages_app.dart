
import 'package:accesorios_para_mascotas/screens/home/home_binding.dart';
import 'package:accesorios_para_mascotas/screens/home/home_screen.dart';
import 'package:get/get.dart';

class PagesApp {
  static List<GetPage> screens = [
    GetPage(
      name: HomeScreen.routerName,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];
}
