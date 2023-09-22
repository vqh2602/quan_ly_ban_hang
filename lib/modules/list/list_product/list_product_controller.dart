import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/category.dart';
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
  List<Product>? listProductResult = [];
  List<Unit>? listUnit = [];
  List<Category>? listCategory = [];
  List<Category>? listCategorySelectFilter = [];
  TextEditingController textSearchTE = TextEditingController();
  bool sortQuantity = false;
  bool sortPrice = false;
  bool sortSalse = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await initProductMixin();
    await getListProducts();
    await getListUnit();
    await getListCategory();
    changeUI();
  }

  getListProducts() async {
    listProduct?.clear();
    loadingUI();
    listProduct = await getListProductMixin();
    listProduct
        ?.sort((a, b) => (b.numberSales ?? 0).compareTo(a.numberSales ?? 0));
    listProductResult = [...listProduct ?? []];

    sortPrice = false;
    sortSalse = false;
    sortQuantity = false;
    listCategorySelectFilter?.clear();
    changeUI();
  }

  getListUnit() async {
    listUnit = await getListUnitMixin();
  }

  getListCategory() async {
    listCategory = await getListCategoryMixin();
  }

  searchAndSortList() {
    if (textSearchTE.text == '') {
      listProductResult = [...listProduct ?? []];
    } else {
      listProductResult = listProduct
          ?.where((element) =>
              element.name
                  ?.toLowerCase()
                  .contains(textSearchTE.text.toLowerCase()) ??
              false)
          .toList();
    }
    if (listCategorySelectFilter != null &&
        listCategorySelectFilter!.isNotEmpty) {
      listProductResult = listProductResult
          ?.where((element) =>
              (listCategorySelectFilter
                      ?.where((element2) =>
                          element.category?.contains(element2.uid) ?? false)
                      .length ??
                  0) >
              0)
          .toList();
    }

    if (sortPrice) {
      listProductResult?.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
    }
    if (sortSalse) {
      listProductResult
          ?.sort((a, b) => (b.numberSales ?? 0).compareTo(a.numberSales ?? 0));
    }
    if (sortQuantity) {
      listProductResult
          ?.sort((a, b) => (b.quantity ?? 0).compareTo(a.quantity ?? 0));
    }
    Get.back();
    updateUI();
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
