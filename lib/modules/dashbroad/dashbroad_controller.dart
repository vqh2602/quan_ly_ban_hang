import 'package:get/get.dart';

class DashBroadController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  @override
  void onInit() {
    changeUI();
    super.onInit();
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
