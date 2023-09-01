import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/modules/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';

class LoginController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, AppWriteMixin {
  late TextEditingController phoneTE, passWTE;
  @override
  Future<void> onInit() async {
    super.onInit();
    initData();
    changeUI();
  }

  initData() {
    phoneTE = TextEditingController();
    passWTE = TextEditingController();
  }

  Future<void> login() async {
    User? user;
    await loginMixin(phone: phoneTE.text, password: passWTE.text);
    user != null ? Get.offAllNamed(SplashScreen.routeName) : null;
    changeUI();
  }

  String? validateEmail(String? value) {
    // bool phoneValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '');
    // return phoneValid ? null : "Không đúng định dạng phone";
    return '';
  }

  String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
