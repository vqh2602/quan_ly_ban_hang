import 'package:quan_ly_ban_hang/modules/list/list_customer/list_customer_controller.dart';
import 'package:get/get.dart';

class ListCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListCustomerController>(() => ListCustomerController());
  }
}
