import 'dart:async';
import 'package:convert_vietnamese/convert_vietnamese.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/supplier.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/supplier_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListSupplierController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        SupplierMixin {
  List<Supplier>? listSupplier = [];
  List<Supplier>? listSupplierResult = [];
  List<Unit>? listUnit = [];
  TextEditingController textSearchTE = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await getListSuppliers();
    await getListUnit();
    changeUI();
  }

  getListSuppliers() async {
    listSupplier?.clear();
    listSupplierResult?.clear();
    loadingUI();
    listSupplier = await getListSupplierMixin();
    listSupplier?.sort((a, b) => (b.name ?? 'a').compareTo(a.name ?? 'a'));
    listSupplierResult = [...listSupplier ?? []];
    changeUI();
  }

  searchAndSortList() {
    if (textSearchTE.text == '') {
      listSupplierResult = [...listSupplier ?? []];
    } else {
      listSupplierResult = listSupplier
          ?.where((element) =>
              removeDiacritics(element.name ?? '').toLowerCase().contains(
                  removeDiacritics(textSearchTE.text).toLowerCase()) ||
              removeDiacritics(element.phone ?? '')
                  .toLowerCase()
                  .contains(removeDiacritics(textSearchTE.text).toLowerCase()))
          .toList();
    }

    Get.back();
    updateUI();
  }

  getListUnit() async {
    listUnit = await getListUnitMixin();
  }

  Unit? getUnitWithID(String? id) {
    if (id == null) return null;
    return ShareFuntion.getUnitWithIDFunc(id, listUnit: listUnit);
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
