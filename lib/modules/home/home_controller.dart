import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';


class HomeController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin {
  int selectItemScreen = 0;
  PageController pageController = PageController(
    viewportFraction: 1.0,
  );


  @override
  Future<void> onInit() async {
    changeUI();
    // await _downloadAssets();
    initData();
    super.onInit();
  }


  Future init() async {
  }

 

  Future initData() async {
    // loadingUI();
    // user = getUserInBox();
    
    changeUI();
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
