
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/modules/splash/splash_screen.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/theme_textinput.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class LoginController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, AppWriteMixin, UserMixin {
  late TextEditingController phoneTE, passWTE;
  TextEditingController resetPassTE = TextEditingController();
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
    User? user;
    bool passwordVisible = true;
    bool isChangePass = false;
    GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormL2');
    user = await loginMixin(phone: phoneTE.text, password: passWTE.text);

    if (user?.resetPassword) {
      await Get.dialog(StatefulBuilder(
        builder: (context, setState) {
          return Material(
            child: Form(
              key: keyForm1,
              child: Container(
                padding: alignment_20_0(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: bg500),
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textTitleLarge('Yêu cầu đổi mật khẩu'),
                      cHeight(50),
                      TextFormField(
                        onTap: () {},
                        controller: resetPassTE,
                        obscureText: passwordVisible,
                        decoration: textFieldInputStyle(
                            label: 'Mật khẩu mới',
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              child: Ink(
                                child: Icon(passwordVisible
                                    ? LucideIcons.eye
                                    : LucideIcons.eyeOff),
                              ),
                            )),
                        validator: validatePass,
                      ),
                      cHeight(40),
                      Align(
                        alignment: Alignment.center,
                        child: FxButton.medium(
                            onPressed: () {
                              if (keyForm1.currentState?.validate() ?? false) {
                                isChangePass = true;
                                updateDetailUserMixin(
                                    user: user?.copyWith(
                                        resetPassword: false,
                                        password: resetPassTE.text));
                              }
                            },
                            child: textBodyLarge('Đổi mật khẩu',
                                color: Colors.white)),
                      )
                    ]),
              ),
            ),
          );
        },
      ), barrierDismissible: false, useSafeArea: false);

      if (isChangePass) {
        Future.delayed(const Duration(seconds: 2), () {
          user != null ? Get.offAndToNamed(SplashScreen.routeName) : null;
        });
      } else {}
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        user != null ? Get.offAndToNamed(SplashScreen.routeName) : null;
      });
    }

    changeUI();
  }

  String? validatePass(String? value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return (regExp.hasMatch(value ?? '') && ((value ?? '').length > 7))
        ? null
        : 'Mật khẩu không đủ mạnh';
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
