import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/customer.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/customer_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/sales_order_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListSalesOrderController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        SalesOrderMixin,
        CustomerMixin {
  List<SalesOrder>? listSalesOrder = [];
  List<SalesOrder>? listSalesOrderResult = [];
  List<Status>? listStatus = [];
  List<Status>? listStatusSelectFilter = [];
  List<SelectOptionItem>? listCustomer = [];
  SelectOptionItem? customerItemSelectFilter;
  TextEditingController textSearchTE = TextEditingController();
  bool sortMoney = false;
  bool sortProfit = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await initSalesOrderMixin();
    await getListSalesOrder();
    await getListStatus();
    await getListCustomer();
    changeUI();
  }

  getListSalesOrder() async {
    listSalesOrder?.clear();
    listSalesOrderResult?.clear();
    loadingUI();
    listSalesOrder = await getListSalesOrderMixin();
    listSalesOrder
        ?.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
    listSalesOrderResult = [...listSalesOrder ?? []];
    changeUI();
  }

  getListStatus() async {
    listStatus = await getListStatusMixin();
  }

  getListCustomer() async {
    List<Customer>? result = await getListCustomerMixin(isCache: true);
    listCustomer = result
        ?.map((e) => SelectOptionItem(key: e.name ?? '', value: e.uid, data: e))
        .toList();
    update();
  }

  Status? getUnitWithID(String? id) {
    if (id == null) return null;
    return ShareFuntion.getStatusWithIDFunc(id, listStatus: listStatus);
  }

  searchAndSortList() {
    if (textSearchTE.text == '') {
      listSalesOrderResult = [...listSalesOrder ?? []];
    } else {
      listSalesOrderResult = listSalesOrder
          ?.where((element) =>
              element.uid
                  ?.toLowerCase()
                  .contains(textSearchTE.text.toLowerCase()) ??
              false)
          .toList();
    }
    if (customerItemSelectFilter != null) {
      listSalesOrderResult = listSalesOrderResult
          ?.where((element) =>
              element.customerId == customerItemSelectFilter?.value)
          .toList();
    }

    if (listStatusSelectFilter != null && listStatusSelectFilter!.isNotEmpty) {
      listSalesOrderResult = listSalesOrderResult
          ?.where((element) =>
              (listStatusSelectFilter
                      ?.where((element2) =>
                          element.deliveryStatus
                              ?.contains(element2.uid ?? '') ??
                          false)
                      .length ??
                  0) >
              0)
          .toList();
    }

    if (sortMoney) {
      listSalesOrderResult
          ?.sort((a, b) => (b.totalMoney ?? 0).compareTo(a.totalMoney ?? 0));
    }
    if (sortProfit) {
      listSalesOrderResult
          ?.sort((a, b) => (b.profit ?? 0).compareTo(a.profit ?? 0));
    }

    Get.back();
    updateUI();
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
