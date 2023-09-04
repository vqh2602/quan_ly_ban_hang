import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/supplier.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/supplier_mixin.dart';

import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:uuid/uuid.dart';

class SupplierDetailController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        UserMixin,
        AppWriteMixin,
        SupplierMixin {
  ImgurRepo imgurRepo = ImgurRepo();
  late TextEditingController? phoneTE, addressTE, genderTE, noteTE, nameTE;
  Supplier? supplier;
  User? userLogin;
  String? avatar;
  DateTime? birthday;
  bool isResetPassword = false;
  var uuid = const Uuid();


  @override
  Future<void> onInit() async {
    super.onInit();
    userLogin = getUserInBox();
    loadingUI();
    initTE();
    if (Get.arguments != null) {
      if (Get.arguments?['type'] == 'view') {}
      if (Get.arguments?['type'] == 'create') {
        initData();
      }
    } else {}

    // await initData();
    // await getDataSupplier();
    changeUI();
  }

  getDataSupplier({String? id}) async {
    loadingUI();
    if (id != null) {
      supplier = await getDetailSupplierMixin(id: id);
      await initData(supplier: supplier);
    }

    // updateUI();
    changeUI();
  }

  initTE() {
    phoneTE = TextEditingController();
    addressTE = TextEditingController();
    nameTE = TextEditingController();
    genderTE = TextEditingController();
    noteTE = TextEditingController();
  }

  initData({Supplier? supplier}) {
    phoneTE?.text = supplier?.phone ?? '';
    addressTE?.text = supplier?.address ?? '';
    nameTE?.text = supplier?.name ?? '';
    noteTE?.text = supplier?.note ?? '';
    update();
  }

// cập nhật
  Future<void> updateSupplier() async {
    loadingUI();
    supplier = await updateDetailSupplierMixin(
        supplier: supplier?.copyWith(
            name: nameTE?.text,
            phone: phoneTE?.text,
            address: addressTE?.text,
            note: noteTE?.text),
        id: supplier?.id);
    changeUI();
  }

// tạo ng dùng
  createSupplier() async {
    loadingUI();
    if (nameTE?.text == null ||
        nameTE?.text == '' ||
        phoneTE?.text == null ||
        phoneTE?.text == '' ||
        genderTE?.text == null ||
        genderTE?.text == '' ||
        addressTE?.text == null ||
        addressTE?.text == '') {
      buildToast(
          message: 'Không để trống dữ liệu: tên, sdt, chức vụ,...',
          status: TypeToast.toastError);
      changeUI();
      return;
    } else {
      var result = await createDetailSupplierMixin(
          supplier: Supplier(
        uid: uuid.v4(),
        name: nameTE?.text,
        phone: phoneTE?.text,
        note: noteTE?.text,
        address: addressTE?.text,
      ));
      changeUI();
      if (result != null) {
        initData();
      }
    }
    changeUI();
  }

  String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value == '') {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '$value không phải kiểu số';
    }
    return null;
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
