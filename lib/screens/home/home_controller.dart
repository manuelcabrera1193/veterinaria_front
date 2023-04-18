import 'package:accesorios_para_mascotas/screens/home/body_enum.dart';
import 'package:get/get.dart';

class HomeController extends SuperController<dynamic> {
  var bodyEnumState = BodyEnum.home.obs;

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void redirectScreen(BodyEnum body) {
    bodyEnumState(body);
  }
}
