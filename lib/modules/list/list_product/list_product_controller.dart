import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';

class ListProductController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, AppWriteMixin {
  List<Product>? listProduct = [];

  @override
  Future<void> onInit() async {
    super.onInit();

    changeUI();
  }

  getListProducts() async {
    loadingUI();
    listProduct = await getListProductMixin();
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
