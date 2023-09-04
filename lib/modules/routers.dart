import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_binding.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/auth/login/login_binding.dart';
import 'package:quan_ly_ban_hang/modules/auth/login/login_screen.dart';
import 'package:quan_ly_ban_hang/modules/auth/signup/signup_binding.dart';
import 'package:quan_ly_ban_hang/modules/auth/signup/signup_screen.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_binding.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_binding.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_binding.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_screen.dart';

import 'package:quan_ly_ban_hang/modules/home/home_binding.dart';
import 'package:quan_ly_ban_hang/modules/home/home_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/list_tools_binding.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/list_tools_screen.dart';
import 'package:quan_ly_ban_hang/modules/splash/splash_binding.dart';
import 'package:quan_ly_ban_hang/modules/splash/splash_screen.dart';

import 'package:get/get.dart';

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
];
