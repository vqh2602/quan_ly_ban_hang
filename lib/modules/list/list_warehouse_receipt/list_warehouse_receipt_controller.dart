import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/data/models/supplier.dart';
import 'package:quan_ly_ban_hang/data/models/warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/supplier_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/warehouse_receipt_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListWarehouseReceiptController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        SupplierMixin,
        WarehouseReceiptMixin {
  List<WarehouseReceipt>? listWarehouseReceipt = [];
  List<WarehouseReceipt>? listWarehouseReceiptResult = [];
  List<Status>? listStatus = [];
  List<Status>? listStatusSelectFilter = [];
  List<SelectOptionItem>? listSupplier = [];
  SelectOptionItem? supplierItemSelectFilter;
  TextEditingController textSearchTE = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await initWarehouseReceiptMixin();
    await getListWarehouseReceipt();
    await getListStatus();
    await getListSupplier();
    changeUI();
  }

  getListWarehouseReceipt() async {
    listWarehouseReceipt?.clear();
    listWarehouseReceiptResult?.clear();
    loadingUI();
    listWarehouseReceipt = await getListWarehouseReceiptMixin();
    listWarehouseReceipt
        ?.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
    listWarehouseReceiptResult = [...listWarehouseReceipt ?? []];
    changeUI();
  }

  getListStatus() async {
    listStatus = await getListStatusMixin();
  }

  getListSupplier() async {
    List<Supplier>? result = await getListSupplierMixin(isCache: true);
    listSupplier = result
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
      listWarehouseReceiptResult = [...listWarehouseReceipt ?? []];
    } else {
      listWarehouseReceiptResult = listWarehouseReceipt
          ?.where((element) =>
              element.uid
                  ?.toLowerCase()
                  .contains(textSearchTE.text.toLowerCase()) ??
              false)
          .toList();
    }
    if (supplierItemSelectFilter != null) {
      listWarehouseReceiptResult = listWarehouseReceiptResult
          ?.where((element) =>
              element.supplierID == supplierItemSelectFilter?.value)
          .toList();
    }

    if (listStatusSelectFilter != null && listStatusSelectFilter!.isNotEmpty) {
      listWarehouseReceiptResult = listWarehouseReceiptResult
          ?.where((element) =>
              (listStatusSelectFilter
                      ?.where((element2) =>
                          element.deliveryStatus!
                              .contains(element2.uid ?? '') ||
                          element.browsingStatus!.contains(element2.uid ?? ''))
                      .length ??
                  0) >
              0)
          .toList();
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
