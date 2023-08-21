import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/qr_scan/qr_controller.dart';

class QrScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrController>(() => QrController(),
);
  }
}
