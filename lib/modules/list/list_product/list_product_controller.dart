import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/filterdata_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/product_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';

class ListProductController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        AppWriteMixin,
        FilterDataMixin,
        ProductMixin {
  List<Product>? listProduct = [];
  List<Unit>? listUnit = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await getListProducts();
    await getListUnit();
    changeUI();
  }

  getListProducts() async {
    listProduct?.clear();
    loadingUI();
    listProduct = await getListProductMixin();
    listProduct
        ?.sort((a, b) => (b.numberSales ?? 0).compareTo(a.numberSales ?? 0));
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
