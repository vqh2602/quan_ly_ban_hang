import 'dart:async';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:quan_ly_ban_hang/data/models/customer.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';

import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/customer_mixin.dart';

import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:uuid/uuid.dart';

class CustomerDetailController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        UserMixin,
        AppWriteMixin,
        CustomerMixin {
  ImgurRepo imgurRepo = ImgurRepo();
  late TextEditingController? phoneTE, addressTE, genderTE, noteTE, nameTE;
  Customer? customer;
  User? userLogin;
  String? avatar;
  DateTime? birthday;
  bool isResetPassword = false;
  var uuid = const Uuid();
  String? idCreate = '';

  List<SelectOptionItem> listGender = [
    SelectOptionItem(key: 'Nam', value: 'Nam', data: null),
    SelectOptionItem(key: 'Nữ', value: 'Nữ', data: null),
  ];
  SelectOptionItem? genderItemSelect;

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
    // await getDataCustomer();
    changeUI();
  }

  getDataCustomer({String? id}) async {
    loadingUI();
    if (id != null) {
      customer = await getDetailCustomerMixin(id: id);
      await initData(customer: customer);
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

  initData({Customer? customer}) {
    phoneTE?.text = customer?.phone ?? '';
    addressTE?.text = customer?.address ?? '';
    nameTE?.text = customer?.name ?? '';
    genderTE?.text = customer?.gender ?? '';
    noteTE?.text = customer?.note ?? '';
    genderItemSelect = listGender
        .where(
          (element) => element.value == customer?.gender,
        )
        .firstOrNull;
    update();
  }

  updateDataTextEditing() {
    genderTE?.text = genderItemSelect?.value ?? 'Trống';
    update();
  }

// cập nhật
  Future<void> updateCustomer() async {
    loadingUI();
    List<Customer>? listCheck =
        await checkUniqueCustomerMixin(phone: phoneTE?.text);

    // kiểm tra sdt đã tồn tại hay chưa, nếu tồn tại phải 2 id bằng nhau mới cho sửa
    if ((listCheck == null || listCheck.length <= 1) &&
        ((listCheck?.length ?? 0) < 1
            ? listCheck?.firstOrNull?.uid != customer?.uid
            : listCheck?.firstOrNull?.uid == customer?.uid)) {
      customer = await updateDetailCustomerMixin(
          customer: customer?.copyWith(
              name: nameTE?.text,
              phone: phoneTE?.text,
              address: addressTE?.text,
              gender: genderItemSelect?.value,
              note: noteTE?.text),
          id: customer?.id);
    } else {
      buildToast(
          message: 'CCCD hoặc số điện thoại đã tồn tại trong hệ thống',
          status: TypeToast.getError);
    }
    changeUI();
  }

// tạo ng dùng
  createCustomer() async {
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
      List<Customer>? listCheck =
          await checkUniqueCustomerMixin(phone: phoneTE?.text);
      if ((listCheck == null || listCheck.isEmpty)) {
        var result = await createDetailCustomerMixin(
            customer: Customer(
          uid: uuid.v4(),
          name: nameTE?.text,
          phone: phoneTE?.text,
          gender: genderTE?.text,
          note: noteTE?.text,
          address: addressTE?.text,
        ));

        changeUI();
        if (result != null) {
          idCreate = result.uid;
          initData();
        }
      } else {
        buildToast(
            message: 'Số điện thoại đã tồn tại trong hệ thống',
            status: TypeToast.getError);
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
