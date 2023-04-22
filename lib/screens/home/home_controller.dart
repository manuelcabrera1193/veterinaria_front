import 'package:accesorios_para_mascotas/models/body_enum.dart';
import 'package:accesorios_para_mascotas/models/facebook_profile.dart';
import 'package:accesorios_para_mascotas/models/google_profile.dart';
import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class HomeController extends SuperController<dynamic> {
  var bodyEnumState = BodyEnum.home.obs;

  var profile = Profile(
          isLogged: false,
          // isAdmin: false,
          isAdmin: true,
          name: "",
          email: "",
          address: '',
          phoneNumber: '',
          photo: '',
          uid: '')
      .obs;

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
        uid: ''));
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

    print("image $image");

    profile(
      Profile(
        uid: userCredential.user?.uid ?? "",
        isLogged: true,
        isAdmin: userCredential.user?.email?.startsWith("admin@") ?? false,
        name: userCredential.user?.displayName ?? "",
        email: userCredential.user?.email ?? "",
        photo: image ?? userCredential.user?.photoURL ?? "",
        phoneNumber: userCredential.user?.phoneNumber ?? "",
        address: "",
      ),
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user?.uid)
        .set(profile.value.toMap());
  }
}
