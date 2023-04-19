import 'package:accesorios_para_mascotas/pages/home_page.dart';
import 'package:accesorios_para_mascotas/screens/login/login_screen.dart';
import 'package:accesorios_para_mascotas/utils/auth.dart';
import 'package:accesorios_para_mascotas/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = '/Home';

  const HomeScreen({Key? key}) : super(key: key);

  // Future<bool> isLooged() async {
  //   final looged = await Auth.flutterSecureStorage.read(key: kUsername);
  //   return looged?.isNotEmpty ?? false;
  // }

  @override
  Widget build(BuildContext context) {
    return HomePage();
    // return Scaffold(
    //   appBar: AppBar(),
    //   drawer: Drawer(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         FutureBuilder(
    //             future: isLooged(),
    //             builder: (_, AsyncSnapshot<bool> logged) {
    //               return (logged.data ?? true)
    //                   ? MaterialButton(
    //                       onPressed: () {
    //                         Auth.signOut();
    //                         Get.offAll(HomeScreen.routerName);
    //                       },
    //                       child: const Text("Cerrar Sesión"),
    //                     )
    //                   : MaterialButton(
    //                       onPressed: () {
    //                         Get.toNamed(LoginScreen.routerName);
    //                       },
    //                       child: const Text("Ingresar"),
    //                     );
    //             }),
    //         MaterialButton(
    //           onPressed: () {},
    //           child: const Text("Ingresar"),
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: const Center(
    //     child: Text('HomeScreen'),
    //   ),
    // );
  }
}
