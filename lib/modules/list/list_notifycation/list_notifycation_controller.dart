import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/request_return.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/models/warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/request_return_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/sales_order_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';
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
        RequestReturnMixin,
        UserMixin {
  List<SalesOrder>? listSalesOrder = [];
  List<WarehouseReceipt>? listWarehouseReceipt = [];
  List<RequestReturn>? listRequestReturn = [];
  User? user;
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    user = getUserInBox();
    await getListOderByFilter();
    await getListWarehouseFilter();
    await getListRequestReturnFilter();
    changeUI();
  }

  getListOderByFilter() async {
    loadingUI();
    listSalesOrder?.clear();
    var l1 = await getListOderByFilterMixin(
      month: null,
      year: null,
      deliveryStatus: ShareFuntion()
              .checkPermissionUserLogin(permission: ['QL', 'AD', 'BH'])
          ? '96c4b4fd-2e35-471e-9ef2-35f82cd52129'
          // 'f22caa04-b799-4921-aa6b-6ab0becf1df6'
          // đã hủy, trả hàng
          : 'cf7cc1ab-3685-4788-8174-7961925bcdb6',
      // 'd1a66226-aaa9-4914-9b47-5a31d233cb6d'
      // đã xác nhận, đợi giao lại
    );
    var l2 = await getListOderByFilterMixin(
        month: null,
        year: null,
        deliveryStatus: ShareFuntion()
                .checkPermissionUserLogin(permission: ['QL', 'AD', 'BH'])
            ?
            // '96c4b4fd-2e35-471e-9ef2-35f82cd52129'
            'f22caa04-b799-4921-aa6b-6ab0becf1df6'
            // đã hủy, trả hàng
            :
            // 'cf7cc1ab-3685-4788-8174-7961925bcdb6',
            'd1a66226-aaa9-4914-9b47-5a31d233cb6d'
        // đã xác nhận, đợi giao lại
        );
    listSalesOrder?.addAll(l1 ?? []);
    listSalesOrder?.addAll(l2 ?? []);
    // loại bỏ phần tử trùng
    final ids = listSalesOrder?.map((e) => e.uid).toSet();
    listSalesOrder?.retainWhere((x) => ids?.remove(x.uid) ?? false);
    listSalesOrder = listSalesOrder?.toSet().toList();

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
