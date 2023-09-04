import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/personnel.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/personnel_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListPersonnelController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        PersonnelMixin {
  List<Personnel>? listPersonnel = [];
  List<Unit>? listUnit = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await getListPersonnels();
    await getListUnit();
    changeUI();
  }

  getListPersonnels() async {
    listPersonnel?.clear();
    loadingUI();
    listPersonnel = await getListPersonnelMixin();
    listPersonnel?.sort((a, b) => (b.name ?? 'a').compareTo(a.name ?? 'a'));
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
