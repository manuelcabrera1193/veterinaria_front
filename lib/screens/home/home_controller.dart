import 'package:accesorios_para_mascotas/models/body_enum.dart';
import 'package:accesorios_para_mascotas/models/facebook_profile.dart';
import 'package:accesorios_para_mascotas/models/google_profile.dart';
import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/models/sale.dart';
import 'package:accesorios_para_mascotas/models/sale_detail.dart';
import 'package:accesorios_para_mascotas/screens/register/firestore_service.dart';
import 'package:accesorios_para_mascotas/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:paypal_sdk/core.dart' as core;
import 'package:paypal_sdk/catalog_products.dart';

const _clientId = 'clientId';
const _clientSecret = 'clientSecret';

class HomeController extends SuperController<dynamic> {
  var bodyEnumState = BodyEnum.home.obs;

  var sale = getEmptySale().obs;

  var position = (-1).obs;

  var profile = Profile(
    isLogged: false,
    isAdmin: false,
    // isAdmin: true,
    name: "",
    email: "",
    address: '',
    phoneNumber: '',
    photo: '',
    uid: '',
  ).obs;

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

  Profile getUser() {
    return profile.value;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    print('Sesión cerrada');
    profile(Profile(
      isLogged: false,
      isAdmin: false,
      name: "",
      email: "",
      address: '',
      phoneNumber: '',
      photo: '',
      uid: '',
    ));
    sale(getEmptySale());
    bodyEnumState(BodyEnum.home);
  }

  Future<String> executeLoginGoogle() async {
    try {
      var googleProvider = GoogleAuthProvider();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      print("credential $userCredential");
      redirectScreen(BodyEnum.home);
      saveUser(userCredential);
      return "";
    } catch (e) {
      print("error:  $e");
      return "$e";
    }
  }

  Future<String> executeLoginFacebook() async {
    try {
      final loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? "");

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      print("credential $userCredential");
      redirectScreen(BodyEnum.home);
      saveUser(userCredential);
      return "";
    } catch (e) {
      print("error:  $e");
      return "$e";
    }
  }

  Future<String> executeLogin(value1, value2) async {
    try {
      UserCredential userCredential =
          await Auth.signInWithEmailAndPassword(value1, value2);
      print("credential $userCredential");
      redirectScreen(BodyEnum.home);
      saveUser(userCredential);
      return "";
    } catch (e) {
      print("error:  $e");
      return "$e";
    }
  }

  Future<void> saveUser(UserCredential userCredential) async {
    String? image;
    final Map<String, dynamic>? profileData =
        userCredential.additionalUserInfo?.profile;
    if (userCredential.user?.providerData[0].providerId == "google.com" &&
        profileData != null) {
      GoogleProfile googleProfile = GoogleProfile.fromMap(profileData);
      print("googleProfile $googleProfile");
      image = googleProfile.picture;
    }
    if (userCredential.user?.providerData[0].providerId == "facebook.com" &&
        profileData != null) {
      FacebookProfile facebookProfile = FacebookProfile.fromMap(profileData);
      print("facebookProfile $facebookProfile");

      image = facebookProfile.picture.data.url;
    }

    final newProfile = Profile(
      uid: userCredential.user?.uid ?? "",
      isLogged: true,
      isAdmin: userCredential.user?.email?.startsWith("admin@") ?? false,
      name: userCredential.user?.displayName ?? "",
      email: userCredential.user?.email ?? "",
      photo: image ?? userCredential.user?.photoURL ?? "",
      phoneNumber: userCredential.user?.phoneNumber ?? "",
      address: "",
    );
    profile(newProfile);

    //Verificar si tiene alguna venda sin concluir y
    //hacer merge con lo que se tiene o consultar al usuario si desea unir sus pedidos
    sale(sale.value.copy(usuario: newProfile));

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user?.uid)
        .set(profile.value.toMap());
  }

  void addProductCard(ItemProduct product, int cant, bool redirect) {
    print("lista::: ${sale.value.saleDetails.length}");

    var details = sale.value.saleDetails;
    if (details.firstWhereOrNull((e) => e.item.uid == product.uid) == null) {
      details.add(
        SaleDetail(
          item: product,
          cantidad: cant,
          subtotal: cant * product.price,
        ),
      );
    } else {
      details = details
          .map(
            (e) => SaleDetail(
              item: e.item,
              cantidad: (e.cantidad + cant),
              subtotal: (e.item.price * (e.cantidad + cant)),
            ),
          )
          .toList();
    }
    double total = sale.value.saleDetails.fold(
        0, (previousValue, producto) => previousValue + producto.subtotal);

    sale(sale.value.copy(
      saleDetails: details,
      total: total,
    ));

    if (redirect) {
      bodyEnumState(BodyEnum.carrito);
    }

    print("lista::: ${sale.value.saleDetails.length}");
  }

  void positionedHome() {
    position(0);
  }

  void resetPosition() {
    position(-1);
  }

  Future<String> saveSale() async {
    try {
      final result = await FirestoreService().addDocument(
          "sales",
          sale.value
              .copy(uid: profile.value.uid, usuario: profile.value)
              .toMap());
      print("idSale: ${result.id}");
      return result.id;
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  void onReady() {
    //validateLogin();
    super.onReady();
  }

  Future<void> validateLogin() async {
    try {
      final userId =
          Get.routing.current.split("?")[1].split("&")[0].split("=")[1];
      if (userId.isNotEmpty) {
        final docRef =
            FirebaseFirestore.instance.collection("users").doc(userId);
        final doc = await docRef.get();
        final data = doc.data() as Map<String, dynamic>;
        final profilei = Profile.fromMap(data);

        profile(profilei.copy(
          isLogged: true,
          isAdmin: profilei.email.startsWith("admin@"),
        ));
      }

      final idSaleLabel =
          Get.routing.current.split("?")[1].split("&")[1].split("=")[0];
      final idSale =
          Get.routing.current.split("?")[1].split("&")[1].split("=")[1];
      print(idSale);
      if (idSale.isNotEmpty) {
        final docRef =
            FirebaseFirestore.instance.collection("sales").doc(idSale);
        final doc = await docRef.get();
        print(doc.data());
        final data = doc.data() as Map<String, dynamic>;
        final salei = Sale.fromMap(data);
        print(salei);
        FirebaseFirestore.instance
            .collection("sales")
            .doc(idSale)
            .set(salei.copy(completed: true).toMap());
      }
    } catch (e) {
      print(e);
    }
  }
}
