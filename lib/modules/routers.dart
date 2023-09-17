import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_binding.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/auth/login/login_binding.dart';
import 'package:quan_ly_ban_hang/modules/auth/login/login_screen.dart';
import 'package:quan_ly_ban_hang/modules/auth/signup/signup_binding.dart';
import 'package:quan_ly_ban_hang/modules/auth/signup/signup_screen.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_binding.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_customer/customer_detail_binding.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_customer/customer_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_binding.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_request_return/detail_request_return_binding.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_request_return/detail_request_return_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_binding.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_supplier/supplier_detail_binding.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_supplier/supplier_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_warehouse_receipt/detail_warehouse_receipt_binding.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_warehouse_receipt/detail_warehouse_receipt_screen.dart';

import 'package:quan_ly_ban_hang/modules/home/home_binding.dart';
import 'package:quan_ly_ban_hang/modules/home/home_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_customer/list_customer_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_customer/list_customer_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_request_return/list_request_return_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_request_return/list_request_return_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_supplier/list_supplier_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_supplier/list_supplier_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/list_tools_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/list_tools_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_warehouse_receipt/list_warehouse_receipt_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_warehouse_receipt/list_warehouse_receipt_screen.dart';
import 'package:quan_ly_ban_hang/modules/splash/splash_binding.dart';
import 'package:quan_ly_ban_hang/modules/splash/splash_screen.dart';

import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/statistical/statistical_binding.dart';
import 'package:quan_ly_ban_hang/modules/statistical/statistical_screen.dart';

List<GetPage> routes = [
  GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      binding: SplashBinding()),
  GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fade),
  GetPage(
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
      binding: LoginBinding()),
  GetPage(
      name: SignupScreen.routeName,
      page: () => const SignupScreen(),
      binding: SignupBinding()),
  GetPage(
      name: DashBroadScreen.routeName,
      page: () => const DashBroadScreen(),
      binding: DashBroadBinding(),
      transition: Transition.downToUp),
  GetPage(
      name: ListProductSreen.routeName,
      page: () => const ListProductSreen(),
      binding: ListProductBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ListSalesOrderSreen.routeName,
      page: () => const ListSalesOrderSreen(),
      binding: ListSalesOrderBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: DetailProductSreen.routeName,
      page: () => const DetailProductSreen(),
      binding: DetailProductBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: DetailSalesInvoiceSreen.routeName,
      page: () => const DetailSalesInvoiceSreen(),
      binding: DetailSalesInvoiceBinding(),
      transition: Transition.rightToLeft),
  GetPage(
    name: AccountDetailScreen.routeName,
    page: () => const AccountDetailScreen(),
    binding: AccountDetailBinding(),
  ),
  GetPage(
      name: ListToolsSreen.routeName,
      page: () => const ListToolsSreen(),
      binding: ListToolsBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ListPersonnelSreen.routeName,
      page: () => const ListPersonnelSreen(),
      binding: ListPersonnelBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ListCustomerSreen.routeName,
      page: () => const ListCustomerSreen(),
      binding: ListCustomerBinding(),
      transition: Transition.rightToLeft),
  GetPage(
    name: CustomerDetailScreen.routeName,
    page: () => const CustomerDetailScreen(),
    binding: CustomerDetailBinding(),
  ),
  GetPage(
    name: ListSupplierSreen.routeName,
    page: () => const ListSupplierSreen(),
    binding: ListSupplierBinding(),
  ),
  GetPage(
    name: SupplierDetailScreen.routeName,
    page: () => const SupplierDetailScreen(),
    binding: SupplierDetailBinding(),
  ),
  GetPage(
    name: ListWarehouseReceiptSreen.routeName,
    page: () => const ListWarehouseReceiptSreen(),
    binding: ListWarehouseReceiptBinding(),
  ),
  GetPage(
    name: DetailWarehouseReceiptScreen.routeName,
    page: () => const DetailWarehouseReceiptScreen(),
    binding: DetailWarehouseReceiptBinding(),
  ),
  GetPage(
    name: ListRequestReturnSreen.routeName,
    page: () => const ListRequestReturnSreen(),
    binding: ListRequestReturnBinding(),
  ),
  GetPage(
    name: DetailRequestReturnScreen.routeName,
    page: () => const DetailRequestReturnScreen(),
    binding: DetailRequestReturnBinding(),
  ),
  GetPage(
    name: StatisticalScreen.routeName,
    page: () => const StatisticalScreen(),
    binding: StatisticalBinding(),
  ),
];
