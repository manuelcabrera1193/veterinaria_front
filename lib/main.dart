import 'package:accesorios_para_mascotas/firebase_options.dart';
import 'package:accesorios_para_mascotas/screens/home/home_screen.dart';
import 'package:accesorios_para_mascotas/utils/main_bindings.dart';
import 'package:accesorios_para_mascotas/utils/pages_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FacebookAuth.instance.webAndDesktopInitialize(
    appId: "118249261241040",
    cookie: true,
    xfbml: true,
    version: "v15.0",
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
