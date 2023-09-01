import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_controller.dart';

class DetailSalesInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSalesInvoiceController>(() => DetailSalesInvoiceController());
  }
}
