import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_controller.dart';
import 'package:get/get.dart';

class ListProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListProductController>(() => ListProductController());
  }
}
