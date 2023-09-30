// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/detail_request_return.dart';
import 'package:quan_ly_ban_hang/data/models/request_return.dart';

import 'package:quan_ly_ban_hang/data/models/supplier.dart';
import 'package:quan_ly_ban_hang/data/models/personnel.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/request_return_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/supplier_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/personnel_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/product_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:uuid/uuid.dart';

class DetailRequestReturnController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        RequestReturnMixin,
        AppWriteMixin,
        SupplierMixin,
        PersonnelMixin,
        UserMixin,
        ProductMixin {
  var arguments = Get.arguments;

  RequestReturn? requestReturn;
  List<Unit>? listUnit = []; // ds đơn vị
  List<SelectOptionItem>? listSupplier = []; // ds nhà cung cấp
  List<SelectOptionItem>? listProduct = []; // ds sản phẩm
  List<Status>? listStatus = []; // ds trạng thái
  List<SelectOptionItem>? listStatusOption =
      []; // ds trạng thái chuyển list option
  List<SelectOptionItem>? listPersonnel = []; // ds nhân viên

  SelectOptionItem? statusBrowsingItemSelect; // trạng thái duyệt
  SelectOptionItem? statusSupplierItemSelect; // trạng ncc
  SelectOptionItem? supplierItemSelect; // nhà cung cấp
  List<SelectOptionItem>? listProductSelect = []; // ds sản phẩm đc chọn
  SelectOptionItem? personnelWarehouseItemSelect; // nhân viên nhập đc chọn

  List<DetailRequestReturn>? listDetailRequestReturn =
      []; // danh sách chi tieets ddn hang co sản phẩm mua api trả về
  List<DetailRequestReturnCustom>? listDetailRequestReturnCustom =
      []; // danh sách sản phẩm của đơn hàng, nhưng có thêm thông tin sản phaamr gốc
  List<DetailRequestReturnCustom>? listDetailRequestReturnCustomEdit =
      []; // ds sản phẩm đơn hàng, áp dụng cho sửa và tạo mới
  Supplier? supplier; // nhà cung cấp

  TextEditingController? noteTE = TextEditingController(), // ghi chú
      totalAmountRefundedTE = TextEditingController(),
      nameTE = TextEditingController();

  Uuid uuid = const Uuid();
  String? uidCreate = '';
  User? userLogin;

  @override
  Future<void> onInit() async {
    super.onInit();
    userLogin = getUserInBox();
    uidCreate = uuid.v4();
    await getListStatus();
    await getListUnit();
    await getListSupplier();
    await getListProduct();
    await getListPersonnel();
    if (arguments['type'] == 'view') {
      await getDetailRequestReturn(arguments['requestReturnID']);
    }
    if (arguments['type'] == 'create') {
      await initDataCreate();
    }
    changeUI();
  }

  initTE({RequestReturn? requestReturn}) {
    noteTE?.text = requestReturn?.note ?? '';
    totalAmountRefundedTE?.text =
        requestReturn?.totalAmountRefunded.toString() ?? '0';
    nameTE?.text = requestReturn?.name ?? '';
    update();
  }

  initDataCreate() async {
    uidCreate = uuid.v4();

    supplierItemSelect = null;
    listDetailRequestReturnCustomEdit = [];

    //fill dữ liệu vào các trường select
    // supplierItemSelect = listSupplier
    //     ?.where((element) => element.value == supplier?.uid)
    //     .firstOrNull;
    // statusPayItemSelect = listStatusOption
    //     ?.where((element) =>
    //         element.value == 'cc9a9396-f062-4969-af52-45501eb9fda3')
    //     .firstOrNull;
    statusSupplierItemSelect = listStatusOption
        ?.where((element) =>
            element.value == 'f20df927-39e9-452f-aaf3-6571717da5c5')
        .firstOrNull;
    statusBrowsingItemSelect = listStatusOption
        ?.where((element) =>
            element.value == '90a489bf-764a-4f13-99ad-cb9ab681b673')
        .firstOrNull;
    personnelWarehouseItemSelect = listPersonnel
        ?.where((element) => element.value == userLogin?.uId)
        .firstOrNull;
    // personnelShipperItemSelect = listPersonnel
    //     ?.where((element) => element.value == requestReturn?.personnelShipperId)
    //     .firstOrNull;
    initTE(requestReturn: null);
    update();
  }

// lấy dl don hang qua id
  getDetailRequestReturn(String? id) async {
    loadingUI();

    requestReturn = await getDetailRequestReturnMixin(id: id);
    supplier =
        await getDetailSupplierWithUidMixin(uid: requestReturn?.supplierID);
    await getListDetailProductOrder(idRequestReturn: requestReturn?.uid);

//fill dữ liệu vào các trường select
    supplierItemSelect = listSupplier
        ?.where((element) => element.value == supplier?.uid)
        .firstOrNull;
    // statusPayItemSelect = listStatusOption
    //     ?.where((element) => element.value == requestReturn?.paymentStatus)
    //     .firstOrNull;
    statusSupplierItemSelect = listStatusOption
        ?.where((element) => element.value == requestReturn?.supplierStatus)
        .firstOrNull;
    statusBrowsingItemSelect = listStatusOption
        ?.where((element) => element.value == requestReturn?.browsingStatus)
        .firstOrNull;
    personnelWarehouseItemSelect = listPersonnel
        ?.where((element) =>
            element.value == requestReturn?.personnelWarehouseStaffId)
        .firstOrNull;
    initTE(requestReturn: requestReturn);
    changeUI();
  }

  getListStatus() async {
    listStatus = await getListStatusMixin();
    listStatusOption = listStatus
        ?.map((e) => SelectOptionItem(key: e.name, value: e.uid, data: e))
        .toList();
    update();
  }

// lấy ds chi tiết sản phẩm qua id đơn hàng
  getListDetailProductOrder({String? idRequestReturn}) async {
    listDetailRequestReturn = await getListDetailProductInRequestReturnMixin(
        idRequestReturn: idRequestReturn);
    listDetailRequestReturnCustom?.clear();
    for (DetailRequestReturn item in listDetailRequestReturn ?? []) {
      Product? product =
          await getListProductWithIdMixin(idProduct: item.productId);
      listDetailRequestReturnCustom?.add(DetailRequestReturnCustom(
        detailRequestReturn: item,
        product: product,
      ));
    }
    // fill ds sản phẩm đc chọn
    listProductSelect = listProduct
        ?.where((element1) =>
            (listDetailRequestReturn
                    ?.where((element2) => element1.value == element2.productId)
                    .length ??
                0) >
            0)
        .toList();
    listDetailRequestReturnCustomEdit = [];
    // gắn list tạo mới đối tượng để tránh tình trạng trùng ô nhớ
    listDetailRequestReturnCustom?.forEach((element) {
      listDetailRequestReturnCustomEdit?.add(DetailRequestReturnCustom(
        detailRequestReturn: element.detailRequestReturn,
        product: element.product,
      ));
    });

    update();
  }

// cập nhật hoá đơn bán
  updateSaleOder() async {
    loadingUI();
    // KIỂM tra trạng thái duyệt => đã duyệt và hoàn tất k cho sửa trừa admin
    if ((requestReturn?.supplierStatus ==
            '00f36339-cf48-4b84-8eef-c52081ee0013' &&
        requestReturn?.browsingStatus ==
            '6616adbe-cec8-4477-94a8-4175d7d2cabe')) {
      if (!ShareFuntion().checkPermissionUserLogin(permission: ['QL', 'AD'])) {
        buildToast(
            message: 'Không được phép sửa sau khi đã gắn trạng thái hoàn thành',
            status: TypeToast.getError);
        changeUI();
        return;
      }
    } else {}

    // cập nhật ds sản phâm trong hoá đơn
    await updateDetailProductInRequestReturn();

    requestReturn = await updateDetailRequestReturnMixin(
        requestReturn: requestReturn?.copyWith(
      note: noteTE?.text,
      browsingStatus: statusBrowsingItemSelect?.value,
      supplierName: supplierItemSelect?.key,
      supplierID: supplierItemSelect?.value,
      personnelWarehouseStaffId: personnelWarehouseItemSelect?.value,
      personnelWarehouseStaffName: personnelWarehouseItemSelect?.key,
      totalMoney: calculateTotalMoney(),
    ));

    await getListDetailProductOrder(idRequestReturn: requestReturn?.uid);

    changeUI();
  }

  // tạo hoá đơn bán
  createSaleOder() async {
    loadingUI();
    if (supplierItemSelect?.value != null &&
        personnelWarehouseItemSelect?.value != null &&
        listDetailRequestReturnCustomEdit != null &&
        (listDetailRequestReturnCustomEdit?.length ?? 0) > 0) {
      requestReturn = await createDetailRequestReturnMixin(
          requestReturn: RequestReturn(
        note: noteTE?.text,
        supplierID: supplierItemSelect?.value,
        supplierName: supplierItemSelect?.key,
        totalMoney: calculateTotalMoney(),
        browsingStatus: statusBrowsingItemSelect?.value,
        timeRequestReturn: DateTime.now().toString(),
        supplierStatus: statusSupplierItemSelect?.value,
        totalAmountRefunded: num.parse(totalAmountRefundedTE?.text ?? '0'),
        personnelWarehouseStaffId: personnelWarehouseItemSelect?.value,
        personnelWarehouseStaffName: personnelWarehouseItemSelect?.key,
        uid: uidCreate,
      ));
      // cập nhật ds sản phâm trong hoá đơn
      await updateDetailProductInRequestReturn();

      await initDataCreate();
    } else {
      buildToast(
          message:
              'Không để trống các trường thông tin: nhà cung cấp, nhân viên, sản phẩm...',
          status: TypeToast.toastError);
    }
    changeUI();
  }

  // cập nhật danh sách sản phẩm -api
  updateDetailProductInRequestReturn() async {
    // lặp tìm sản phẩm cập nhật
    if (listDetailRequestReturnCustom != null &&
        listDetailRequestReturnCustom!.isNotEmpty) {
      List<DetailRequestReturnCustom>? update = [];
      listDetailRequestReturnCustomEdit?.forEach((element1) async {
        listDetailRequestReturnCustom?.forEach((element2) async {
          if (element1.detailRequestReturn?.productId ==
              element2.detailRequestReturn?.productId) {
            update.add(element1);
          }
        });
      });
      // lặp tìm sản phẩm tạo mới có trong list edit nhưng k có trong list custom

      List<DetailRequestReturnCustom?>? create = [];
      List<DetailRequestReturnCustom?>? data1 = [];
      data1.addAll(listDetailRequestReturnCustomEdit ?? []);
      data1.removeWhere((element) => update
          .where((element2) =>
              element?.detailRequestReturn?.productId ==
              element2.detailRequestReturn?.productId)
          .isNotEmpty);
      create = data1;

      // lặp tìm sản phẩm đẻ xoá
      List<DetailRequestReturnCustom?>? delete = [];
      List<DetailRequestReturnCustom?>? data2 = [];
      data2.addAll(listDetailRequestReturnCustom ?? []);
      data2.removeWhere((element) => update
          .where((element2) =>
              element?.detailRequestReturn?.productId ==
              element2.detailRequestReturn?.productId)
          .isNotEmpty);
      delete = data2;

      for (var element1 in update) {
        await updateQuantityProduct(
            product: element1.product,
            quantityNew: element1.detailRequestReturn?.quantity ?? 0,
            quantityHistory: listDetailRequestReturnCustom
                    ?.where((element) =>
                        element.detailRequestReturn?.productId ==
                        element1.detailRequestReturn?.productId)
                    .firstOrNull
                    ?.detailRequestReturn
                    ?.quantity ??
                0);
        await updateDetailProductInRequestReturnMixin(
            detailRequestReturn: element1.detailRequestReturn);
      }
      for (var element1 in create) {
        await updateQuantityProduct(
            product: element1?.product,
            isNumberSalse: true,
            quantityNew: element1?.detailRequestReturn?.quantity ?? 0,
            quantityHistory: listDetailRequestReturnCustom
                    ?.where((element) =>
                        element.detailRequestReturn?.productId ==
                        element1?.detailRequestReturn?.productId)
                    .firstOrNull
                    ?.detailRequestReturn
                    ?.quantity ??
                0);
        await createDetailProductInRequestReturnMixin(
            detailRequestReturn: element1?.detailRequestReturn);
      }
      for (var element1 in delete) {
        await updateQuantityProduct(
            product: element1?.product,
            quantityNew: 0,
            quantityHistory: listDetailRequestReturnCustom
                    ?.where((element) =>
                        element.detailRequestReturn?.productId ==
                        element1?.detailRequestReturn?.productId)
                    .firstOrNull
                    ?.detailRequestReturn
                    ?.quantity ??
                0);
        await deleteDetailProductInRequestReturnMixin(
            detailRequestReturn: element1?.detailRequestReturn);
      }
    } else {
      // List<DetailRequestReturn>? create1 = [];
      listDetailRequestReturnCustomEdit?.forEach((element1) async {
        await createDetailProductInRequestReturnMixin(
            detailRequestReturn: element1.detailRequestReturn);
        await updateQuantityProduct(
            product: element1.product,
            isNumberSalse: true,
            quantityNew: element1.detailRequestReturn?.quantity ?? 0,
            quantityHistory: 0);
      });
      // print(create1);
    }

    await getListProduct(isCache: false);
    update();
  }

  //hàm cập nhật và tính lại số lượng sản phẩm
  updateQuantityProduct(
      {Product? product,
      num? quantityNew,
      num? quantityHistory,
      isNumberSalse = false}) async {
    if (quantityNew != null &&
        quantityHistory != null &&
        quantityNew < quantityHistory &&
        quantityNew > 0) {
      await updateDetailProductMixin(
          product: product?.copyWith(
              numberSales: isNumberSalse ? product.numberSales ?? 0 + 1 : null,
              quantity:
                  (product.quantity ?? 0) + (quantityHistory - quantityNew)));
      return;
    }

    if (quantityNew != null &&
        quantityHistory != null &&
        quantityNew > quantityHistory) {
      await updateDetailProductMixin(
          product: product?.copyWith(
              numberSales: isNumberSalse ? product.numberSales ?? 0 + 1 : null,
              quantity:
                  (product.quantity ?? 0) - (quantityNew - quantityHistory)));
      return;
    }
    if (quantityNew != null &&
        quantityHistory != null &&
        quantityNew < quantityHistory &&
        quantityNew == 0) {
      await updateDetailProductMixin(
          product: product?.copyWith(
              numberSales: isNumberSalse ? product.numberSales ?? 0 + 1 : null,
              quantity: (product.quantity ?? 0) + (quantityHistory)));
      return;
    }
  }

// áp dụng khi tạo mới, sửa hoá đơn -
//chọn dánh ách sản phẩm convert sang kiểu dữ liệu detailRequestReturnCustom
  fillDataProduct() async {
    listDetailRequestReturnCustomEdit?.clear();
    List<SelectOptionItem>? listProductSelectData = [];
    List<SelectOptionItem>? listResultEqual =
        []; // dánh ách sản phẩm khi tìm trùng
    listProductSelectData.addAll(listProductSelect ?? []);
    if (listDetailRequestReturn != null &&
        listDetailRequestReturn!.isNotEmpty &&
        arguments['type'] == 'view') {
      for (var element in listProductSelectData) {
        Product? product = element.data;
        // nếu sản phẩm đã tồn tại,ghi đè lên
        listDetailRequestReturn?.forEach((element2) {
          if (element.value == element2.productId) {
            listDetailRequestReturnCustomEdit?.add(DetailRequestReturnCustom(
              detailRequestReturn: DetailRequestReturn(
                requestReturnId: requestReturn?.uid,
                productId: product?.uid,
                id: element2.id,
                quantity: element2.quantity,
                importPrice: product?.importPrice,
                note: '',
                uid: element2.uid,
              ),
              product: product,
            ));
            listResultEqual.add(element);
          }
        });
      }
      // tạo mới phần tử
      listProductSelectData
          .removeWhere((element) => listResultEqual.contains(element));

      for (var element in listProductSelectData) {
        Product? product = element.data;
        listDetailRequestReturnCustomEdit?.add(DetailRequestReturnCustom(
          detailRequestReturn: DetailRequestReturn(
            uid: uuid.v4(),
            requestReturnId: requestReturn?.uid,
            productId: product?.uid,
            quantity: 1,
            importPrice: product?.importPrice,
            note: '',
          ),
          product: product,
        ));
      }
    } else {
      for (var element in listProductSelectData) {
        listDetailRequestReturnCustomEdit?.add(DetailRequestReturnCustom(
          detailRequestReturn: DetailRequestReturn(
            uid: uuid.v4(),
            requestReturnId:
                arguments['type'] == 'view' ? requestReturn?.uid : uidCreate,
            productId: element.data?.uid,
            quantity: 1,
            importPrice: element.data?.importPrice,
            note: '',
          ),
          product: element.data,
        ));
      }
    }
    update();
  }

  // set lại giá trị của sản phẩm - cập nhật, tạo mới khi hiển thị bottomsheet thay đổi số lượng
  updateProductInRequestReturnEdit(
      {Product? product, String? quantity, String? note}) {
    for (int i = 0; i < (listDetailRequestReturnCustomEdit?.length ?? 0); i++) {
      if (listDetailRequestReturnCustomEdit?[i].product?.uid == product?.uid) {
        listDetailRequestReturnCustomEdit?[i].detailRequestReturn =
            listDetailRequestReturnCustomEdit?[i].detailRequestReturn?.copyWith(
                  importPrice: product?.importPrice,
                  note: note,
                  productId: product?.uid,
                  quantity: num.parse(quantity ?? '0'),
                  requestReturnId: requestReturn?.uid,
                );
      }
    }
    update();
  }

  // tính tổng tiền -> thành tiền
  num calculateTotalMoney() {
    num? totalMoneyData = 0;
    listDetailRequestReturnCustomEdit?.forEach((element) {
      totalMoneyData = (totalMoneyData ?? 0) +
          ((element.detailRequestReturn?.quantity ?? 0) *
              (element.detailRequestReturn?.importPrice ?? 1));
    });
    // (tổng tiền
    return totalMoneyData ?? 0;
  }

  getListUnit() async {
    listUnit = await getListUnitMixin();
  }

  getListSupplier() async {
    List<Supplier>? result = await getListSupplierMixin(isCache: true);
    listSupplier = result
        ?.map((e) => SelectOptionItem(key: e.name ?? '', value: e.uid, data: e))
        .toList();
    update();
  }

  getListProduct({bool isCache = true}) async {
    List<Product>? result = await getListProductMixin(isCache: isCache);
    listProduct = result
        ?.map((e) => SelectOptionItem(key: e.name ?? '', value: e.uid, data: e))
        .toList();
    update();
  }

  getListPersonnel() async {
    List<Personnel>? result = await getListPersonnelMixin(isCache: true);
    listPersonnel = result
        ?.map((e) => SelectOptionItem(key: e.name ?? '', value: e.uId, data: e))
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

// chauw sthoong tin - sản phẩm của hoá đơn và sản phẩm gốc
class DetailRequestReturnCustom {
  DetailRequestReturn? detailRequestReturn;
  Product? product;
  DetailRequestReturnCustom({
    this.detailRequestReturn,
    this.product,
  });

  // @override
  // bool operator ==(covariant DetailRequestReturnCustom other) {
  //   if (identical(this, other)) return true;

  //   return other.detailRequestReturn == detailRequestReturn &&
  //       other.product == product;
  // }

  // @override
  // int get hashCode => detailRequestReturn.hashCode ^ product.hashCode;

  // DetailRequestReturnCustom copyWith({
  //   DetailRequestReturn? detailRequestReturn,
  //   Product? product,
  // }) {
  //   return DetailRequestReturnCustom(
  //     detailRequestReturn: detailRequestReturn ?? this.detailRequestReturn,
  //     product: product ?? this.product,
  //   );
  // }
}
