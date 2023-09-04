import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_supplier/supplier_detail_controller.dart';

class SupplierDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierDetailController>(() => SupplierDetailController());
  }
}
