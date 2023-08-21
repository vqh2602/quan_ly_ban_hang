import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListProductController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
  
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
