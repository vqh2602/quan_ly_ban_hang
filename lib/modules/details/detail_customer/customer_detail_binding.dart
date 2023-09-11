import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_customer/customer_detail_controller.dart';

class CustomerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerDetailController>(() => CustomerDetailController());
  }
}
