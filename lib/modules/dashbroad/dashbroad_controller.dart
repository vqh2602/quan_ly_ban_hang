import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';

class DashBroadController extends GetxController
    with GetTickerProviderStateMixin, StateMixin,AppWriteMixin {
  @override
  Future<void> onInit() async {
    changeUI();
    await initMixin();
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
