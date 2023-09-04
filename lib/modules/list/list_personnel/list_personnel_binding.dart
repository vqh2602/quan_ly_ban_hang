import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_controller.dart';
import 'package:get/get.dart';

class ListPersonnelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPersonnelController>(() => ListPersonnelController());
  }
}
