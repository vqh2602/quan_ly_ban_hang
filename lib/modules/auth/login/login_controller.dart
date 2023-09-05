
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';

class LoginController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, AppWriteMixin, UserMixin {
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
    loadingUI();
    // User? user;
    await loginMixin(phone: phoneTE.text, password: passWTE.text);
    // Future.delayed(const Duration(seconds: 2),(){
    //     user != null ? Get.offAndToNamed(SplashScreen.routeName) : null;
    // });
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
