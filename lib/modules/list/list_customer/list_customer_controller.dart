import 'dart:async';
import 'package:convert_vietnamese/convert_vietnamese.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/customer.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/customer_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListCustomerController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        CustomerMixin {
  List<Customer>? listCustomer = [];
  List<Customer>? listCustomerResult = [];
  List<Unit>? listUnit = [];
  TextEditingController textSearchTE = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await getListCustomers();
    await getListUnit();
    changeUI();
  }

  getListCustomers() async {
    listCustomer?.clear();
    listCustomerResult?.clear();
    loadingUI();
    listCustomer = await getListCustomerMixin();
    listCustomer?.sort((a, b) => (b.name ?? 'a').compareTo(a.name ?? 'a'));
    listCustomerResult = [...listCustomer ?? []];
    changeUI();
  }

  searchAndSortList() {
    if (textSearchTE.text == '') {
      listCustomerResult = [...listCustomer ?? []];
    } else {
      listCustomerResult = listCustomer
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
