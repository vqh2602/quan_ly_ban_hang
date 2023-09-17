import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_warehouse_receipt/detail_warehouse_receipt_controller.dart';

class DetailWarehouseReceiptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWarehouseReceiptController>(() => DetailWarehouseReceiptController());
  }
}
