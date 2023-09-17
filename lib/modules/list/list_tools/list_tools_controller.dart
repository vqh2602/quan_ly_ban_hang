import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/data_tools.dart';

class ListToolsController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  TextEditingController textSearchTE = TextEditingController();
  List<DataTool> listDataToolResult = listDataTools;
  @override
  Future<void> onInit() async {
    super.onInit();

    changeUI();
  }

  onSearch(String val) {
    if (val == '') {
      listDataToolResult = listDataTools;
      update();
      return;
    }
    listDataToolResult = listDataTools
        .where((element) => element.name?.contains(val) ?? false)
        .toList();
    update();
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
