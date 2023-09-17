
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/list/list_request_return/list_request_return_controller.dart';

class ListRequestReturnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListRequestReturnController>(() => ListRequestReturnController());
  }
}
