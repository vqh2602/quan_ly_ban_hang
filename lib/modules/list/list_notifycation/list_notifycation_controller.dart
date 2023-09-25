import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/request_return.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/request_return_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/sales_order_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/warehouse_receipt_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListNotifycationController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        SalesOrderMixin,
        WarehouseReceiptMixin,
        RequestReturnMixin {
  List<SalesOrder>? listSalesOrder = [];
  List<WarehouseReceipt>? listWarehouseReceipt = [];
  List<RequestReturn>? listRequestReturn = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await getListOderByFilter();
    await getListWarehouseFilter();
    await getListRequestReturnFilter();
    changeUI();
  }

  getListOderByFilter() async {
    loadingUI();
    listSalesOrder?.clear();
    listSalesOrder = await getListOderByFilterMixin(
        month: null,
        year: null,
        deliveryStatus: ShareFuntion()
                .checkPermissionUserLogin(permission: ['QL', 'AD', 'BH'])
            ? '96c4b4fd-2e35-471e-9ef2-35f82cd52129' // đã hủy
            : 'cf7cc1ab-3685-4788-8174-7961925bcdb6' // đã xác nhận
            );

    changeUI();
  }

  getListWarehouseFilter() async {
    loadingUI();
    listWarehouseReceipt?.clear();
    listWarehouseReceipt = await getListWarehouseReceiptByFilterMixin(
        month: null,
        year: null,
        statusBrowsing:
            ShareFuntion().checkPermissionUserLogin(permission: ['QL', 'AD'])
                ? '90a489bf-764a-4f13-99ad-cb9ab681b673' //đợi duytwj
                : '6616adbe-cec8-4477-94a8-4175d7d2cabe' // da duyet
        );

    changeUI();
  }

  getListRequestReturnFilter() async {
    loadingUI();
    listRequestReturn?.clear();
    listRequestReturn = await getListRequestReturnByFilterMixin(
        month: null,
        year: null,
        statusBrowsing:
            ShareFuntion().checkPermissionUserLogin(permission: ['QL', 'AD'])
                ? '90a489bf-764a-4f13-99ad-cb9ab681b673' //đợi duytwj
                : '6616adbe-cec8-4477-94a8-4175d7d2cabe' // da duyet
        );

    changeUI();
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
