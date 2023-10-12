import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_controller.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_controller.dart';
import 'package:quan_ly_ban_hang/modules/home/home_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_customer/list_customer_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_request_return/list_request_return_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_supplier/list_supplier_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_warehouse_receipt/list_warehouse_receipt_controller.dart';
import 'package:quan_ly_ban_hang/modules/qr_scan/qr_controller.dart';
import 'package:quan_ly_ban_hang/modules/statistical/statistical_controller.dart';

Future<void> initialize() async {
//hinh anh

  //controller
  Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  Get.lazyPut<DashBroadController>(() => DashBroadController(), fenix: true);
  Get.lazyPut<QrController>(() => QrController(), fenix: true);
  Get.lazyPut<AccountDetailController>(() => AccountDetailController(),
      fenix: true);
  Get.lazyPut<ListProductController>(() => ListProductController(),
      fenix: true);
  Get.lazyPut<ListSalesOrderController>(() => ListSalesOrderController(),
      fenix: true);
  Get.lazyPut<ListWarehouseReceiptController>(
      () => ListWarehouseReceiptController(),
      fenix: true);
  Get.lazyPut<ListRequestReturnController>(() => ListRequestReturnController(),
      fenix: true);
  Get.lazyPut<StatisticalController>(() => StatisticalController(),
      fenix: true);
  Get.lazyPut<ListCustomerController>(() => ListCustomerController(),
      fenix: true);
  Get.lazyPut<ListPersonnelController>(() => ListPersonnelController(),
      fenix: true);
  Get.lazyPut<ListSupplierController>(() => ListSupplierController(),
      fenix: true);
}
