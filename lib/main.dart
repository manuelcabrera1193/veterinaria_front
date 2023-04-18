import 'package:accesorios_para_mascotas/firebase_options.dart';
import 'package:accesorios_para_mascotas/screens/home/home_screen.dart';
import 'package:accesorios_para_mascotas/utils/main_bindings.dart';
import 'package:accesorios_para_mascotas/utils/pages_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Accesorios para mascotas',
      initialRoute: HomeScreen.routerName,
      getPages: PagesApp.screens,
      initialBinding: MainBindings(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
