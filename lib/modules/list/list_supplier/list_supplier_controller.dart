import 'dart:async';
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
  List<Unit>? listUnit = [];
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
    loadingUI();
    listSupplier = await getListSupplierMixin();
    listSupplier?.sort((a, b) => (b.name ?? 'a').compareTo(a.name ?? 'a'));
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
