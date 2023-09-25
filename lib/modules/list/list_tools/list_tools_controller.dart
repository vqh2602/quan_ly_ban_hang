import 'dart:async';
import 'package:convert_vietnamese/convert_vietnamese.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/data_tools.dart';

class ListToolsController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  TextEditingController textSearchTE = TextEditingController();
  List<DataTool> listDataToolResult = listDataTools;
  List<DataTool> listDataToolResult1 = [];
  List<DataTool> listDataToolResult2 = [];
  List<DataTool> listDataToolResult3 = [];
  List<DataTool> listDataToolResult4 = [];
  List<DataTool> listDataToolResultSearch = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    listDataToolResult1 = listDataToolResult
        .where((element) =>
            element.group == 'hoadon' || element.group == 'khachhang')
        .toList();
    listDataToolResult2 = listDataToolResult
        .where(
            (element) => element.group == 'nhapkho' || element.group == 'ncc')
        .toList();
    listDataToolResult3 = listDataToolResult
        .where((element) => element.group == 'nhanvien')
        .toList();
    listDataToolResult4 = listDataToolResult
        .where((element) => element.group == 'sanpham')
        .toList();
    changeUI();
  }

  onSearch(String val) {
    if (val == '') {
      listDataToolResultSearch = listDataTools;
      update();
      return;
    }

    listDataToolResultSearch = listDataTools
        .where((element) => removeDiacritics(element.name ?? '')
            .toLowerCase()
            .contains(removeDiacritics(val).toLowerCase()))
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
