import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_controller.dart';
import 'package:quan_ly_ban_hang/modules/home/home_controller.dart';

Future<void> initialize() async {
//hinh anh

  //controller
  Get.lazyPut<HomeController>(
    () => HomeController(),
  );
  Get.lazyPut<DashBroadController>(
    () => DashBroadController(),
  );
}
