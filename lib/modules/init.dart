import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_controller.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_controller.dart';
import 'package:quan_ly_ban_hang/modules/home/home_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_controller.dart';
import 'package:quan_ly_ban_hang/modules/qr_scan/qr_controller.dart';

Future<void> initialize() async {
//hinh anh

  //controller
  Get.lazyPut<HomeController>(
    () => HomeController(),
  );
  Get.lazyPut<DashBroadController>(
    () => DashBroadController(),
  );
  Get.lazyPut<QrController>(
    () => QrController(),
  );
  Get.lazyPut<AccountDetailController>(
    () => AccountDetailController(),
  );
  Get.lazyPut<ListProductController>(
    () => ListProductController(),
  );
  Get.lazyPut<ListSalesOrderController>(
    () => ListSalesOrderController(),
  );
}
