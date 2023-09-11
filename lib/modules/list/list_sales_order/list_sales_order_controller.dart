import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/sales_order_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListSalesOrderController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        SalesOrderMixin {
  List<SalesOrder>? listSalesOrder = [];
  List<Status>? listStatus = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await getListSalesOrder();
    await getListStatus();
    changeUI();
  }

  getListSalesOrder() async {
    listSalesOrder?.clear();
    loadingUI();
    listSalesOrder = await getListSalesOrderMixin();
    listSalesOrder
        ?.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
    changeUI();
  }

  getListStatus() async {
    listStatus = await getListStatusMixin();
  }

  Status? getUnitWithID(String? id) {
    if (id == null) return null;
    return ShareFuntion.getStatusWithIDFunc(id, listStatus: listStatus);
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
