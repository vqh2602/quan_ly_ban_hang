import 'dart:async';
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
  List<Unit>? listUnit = [];
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
    loadingUI();
    listCustomer = await getListCustomerMixin();
    listCustomer?.sort((a, b) => (b.name ?? 'a').compareTo(a.name ?? 'a'));
    changeUI();
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
