import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/request_return.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/request_return_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListRequestReturnController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        RequestReturnMixin {
  List<RequestReturn>? listRequestReturn = [];
  List<RequestReturn>? listRequestReturnResult = [];
  List<Status>? listStatus = [];
  List<Status>? listStatusSelectFilter = [];
  List<SelectOptionItem>? listSupplier = [];
  SelectOptionItem? supplierItemSelectFilter;
  TextEditingController textSearchTE = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await initRequestReturnMixin();
    await getListRequestReturn();
    await getListStatus();
    changeUI();
  }

  getListRequestReturn() async {
    listRequestReturn?.clear();
    listRequestReturnResult?.clear();
    loadingUI();
    listRequestReturn = await getListRequestReturnMixin();
    listRequestReturn
        ?.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
    listRequestReturnResult = [...listRequestReturn ?? []];
    changeUI();
  }

  getListStatus() async {
    listStatus = await getListStatusMixin();
  }

  searchAndSortList() {
    if (textSearchTE.text == '') {
      listRequestReturnResult = [...listRequestReturn ?? []];
    } else {
      listRequestReturnResult = listRequestReturn
          ?.where((element) =>
              element.uid
                  ?.toLowerCase()
                  .contains(textSearchTE.text.toLowerCase()) ??
              false)
          .toList();
    }
    if (supplierItemSelectFilter != null) {
      listRequestReturnResult = listRequestReturnResult
          ?.where((element) =>
              element.supplierID == supplierItemSelectFilter?.value)
          .toList();
    }

    if (listStatusSelectFilter != null && listStatusSelectFilter!.isNotEmpty) {
      listRequestReturnResult = listRequestReturnResult
          ?.where((element) =>
              (listStatusSelectFilter
                      ?.where((element2) =>
                          element.supplierStatus!
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
