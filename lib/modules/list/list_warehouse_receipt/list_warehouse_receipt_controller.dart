import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/data/models/warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/warehouse_receipt_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListWarehouseReceiptController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        WarehouseReceiptMixin {
  List<WarehouseReceipt>? listWarehouseReceipt = [];
  List<Status>? listStatus = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await initWarehouseReceiptMixin();
    await getListWarehouseReceipt();
    await getListStatus();
    changeUI();
  }

  getListWarehouseReceipt() async {
    listWarehouseReceipt?.clear();
    loadingUI();
    listWarehouseReceipt = await getListWarehouseReceiptMixin();
    listWarehouseReceipt
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
