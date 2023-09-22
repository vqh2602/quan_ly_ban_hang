import 'package:quan_ly_ban_hang/modules/list/list_notifycation/list_notifycation_controller.dart';
import 'package:get/get.dart';

class ListNotifycationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListNotifycationController>(() => ListNotifycationController());
  }
}
