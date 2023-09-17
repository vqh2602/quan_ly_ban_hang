import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/request_return.dart';
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
  List<Status>? listStatus = [];
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
    loadingUI();
    listRequestReturn = await getListRequestReturnMixin();
    listRequestReturn
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
