// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quan_ly_ban_hang/data/models/supplier.dart';
import 'package:quan_ly_ban_hang/data/models/detail_warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/data/models/personnel.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/models/warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/supplier_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/personnel_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/product_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/warehouse_receipt_mixin.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:uuid/uuid.dart';

class DetailWarehouseReceiptController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        WarehouseReceiptMixin,
        AppWriteMixin,
        SupplierMixin,
        PersonnelMixin,
        UserMixin,
        ProductMixin {
  var arguments = Get.arguments;

  WarehouseReceipt? warehouseReceipt;
  List<Unit>? listUnit = []; // ds đơn vị
  List<SelectOptionItem>? listSupplier = []; // ds nhà cung cấp
  List<SelectOptionItem>? listProduct = []; // ds sản phẩm
  List<Status>? listStatus = []; // ds trạng thái
  List<SelectOptionItem>? listStatusOption =
      []; // ds trạng thái chuyển list option
  List<SelectOptionItem>? listPersonnel = []; // ds nhân viên

  SelectOptionItem? statusPayItemSelect; // tt thanh toán
  SelectOptionItem? statusDeliverItemSelect; // trạng thái giao
  SelectOptionItem? statusBrowsingItemSelect; // trạng thái duyệt
  SelectOptionItem? supplierItemSelect; // nhà cung cấp
  List<SelectOptionItem>? listProductSelect = []; // ds sản phẩm đc chọn
  SelectOptionItem? personnelWarehouseItemSelect; // nhân viên nhập đc chọn

  List<DetailWarehouseReceipt>? listDetailWarehouseReceipt =
      []; // danh sách chi tieets ddn hang co sản phẩm mua api trả về
  List<DetailWarehouseReceiptCustom>? listDetailWarehouseReceiptCustom =
      []; // danh sách sản phẩm của đơn hàng, nhưng có thêm thông tin sản phaamr gốc
  List<DetailWarehouseReceiptCustom>? listDetailWarehouseReceiptCustomEdit =
      []; // ds sản phẩm đơn hàng, áp dụng cho sửa và tạo mới
  Supplier? supplier; // nhà cung cấp

  TextEditingController? noteTE = TextEditingController() // ghi chú
      ;

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
      await getDetailWarehouseReceipt(arguments['warehouseReceiptID']);
    }
    if (arguments['type'] == 'create') {
      await initDataCreate();
    }
    changeUI();
  }

  initTE({WarehouseReceipt? warehouseReceipt}) {
    noteTE?.text = warehouseReceipt?.note ?? '';
    update();
  }

  initDataCreate() async {
    uidCreate = uuid.v4();

    supplierItemSelect = null;
    listDetailWarehouseReceiptCustomEdit = [];

    //fill dữ liệu vào các trường select
    // supplierItemSelect = listSupplier
    //     ?.where((element) => element.value == supplier?.uid)
    //     .firstOrNull;
    statusPayItemSelect = listStatusOption
        ?.where((element) =>
            element.value == 'cc9a9396-f062-4969-af52-45501eb9fda3')
        .firstOrNull;
    statusDeliverItemSelect = listStatusOption
        ?.where((element) =>
            element.value == 'cf7cc1ab-3685-4788-8174-7961925bcdb6')
        .firstOrNull;
    statusBrowsingItemSelect = listStatusOption
        ?.where((element) =>
            element.value == '90a489bf-764a-4f13-99ad-cb9ab681b673')
        .firstOrNull;
    personnelWarehouseItemSelect = listPersonnel
        ?.where((element) => element.value == userLogin?.uId)
        .firstOrNull;
    // personnelShipperItemSelect = listPersonnel
    //     ?.where((element) => element.value == warehouseReceipt?.personnelShipperId)
    //     .firstOrNull;
    initTE(warehouseReceipt: null);
    update();
  }

// lấy dl don hang qua id
  getDetailWarehouseReceipt(String? id) async {
    loadingUI();

    warehouseReceipt = await getDetailWarehouseReceiptMixin(id: id);
    supplier =
        await getDetailSupplierWithUidMixin(uid: warehouseReceipt?.supplierID);
    await getListDetailProductOrder(idWarehouseReceipt: warehouseReceipt?.uid);

//fill dữ liệu vào các trường select
    supplierItemSelect = listSupplier
        ?.where((element) => element.value == supplier?.uid)
        .firstOrNull;
    statusPayItemSelect = listStatusOption
        ?.where((element) => element.value == warehouseReceipt?.paymentStatus)
        .firstOrNull;
    statusDeliverItemSelect = listStatusOption
        ?.where((element) => element.value == warehouseReceipt?.deliveryStatus)
        .firstOrNull;
    statusBrowsingItemSelect = listStatusOption
        ?.where((element) => element.value == warehouseReceipt?.browsingStatus)
        .firstOrNull;
    personnelWarehouseItemSelect = listPersonnel
        ?.where((element) =>
            element.value == warehouseReceipt?.personnelWarehouseStaffId)
        .firstOrNull;
    initTE(warehouseReceipt: warehouseReceipt);
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
  getListDetailProductOrder({String? idWarehouseReceipt}) async {
    listDetailWarehouseReceipt =
        await getListDetailProductInWarehouseReceiptMixin(
            idWarehouseReceipt: idWarehouseReceipt);
    listDetailWarehouseReceiptCustom?.clear();
    for (DetailWarehouseReceipt item in listDetailWarehouseReceipt ?? []) {
      Product? product =
          await getListProductWithIdMixin(idProduct: item.productId);
      listDetailWarehouseReceiptCustom?.add(DetailWarehouseReceiptCustom(
        detailWarehouseReceipt: item,
        product: product,
      ));
    }
    // fill ds sản phẩm đc chọn
    listProductSelect = listProduct
        ?.where((element1) =>
            (listDetailWarehouseReceipt
                    ?.where((element2) => element1.value == element2.productId)
                    .length ??
                0) >
            0)
        .toList();
    listDetailWarehouseReceiptCustomEdit = [];
    // gắn list tạo mới đối tượng để tránh tình trạng trùng ô nhớ
    listDetailWarehouseReceiptCustom?.forEach((element) {
      listDetailWarehouseReceiptCustomEdit?.add(DetailWarehouseReceiptCustom(
        detailWarehouseReceipt: element.detailWarehouseReceipt,
        product: element.product,
      ));
    });

    update();
  }

// cập nhật hóa đơn nhập
  updateSaleOder() async {
    loadingUI();
    // KIỂM tra trạng thái duyệt => đã duyệt và hoàn tất k cho sửa trừa admin
    if ((
        // warehouseReceipt?.deliveryStatus ==
        //       '7dafedc3-edd3-453a-8724-b2c4d75b3912' &&
        warehouseReceipt?.browsingStatus ==
            '6616adbe-cec8-4477-94a8-4175d7d2cabe')) {
      // if (!ShareFuntion().checkPermissionUserLogin(permission: ['QL', 'AD'])) {
      buildToast(
          message: 'Không được phép sửa sau khi đã gắn trạng thái hoàn thành',
          status: TypeToast.getError);
      changeUI();
      return;
      // }
    } else {}

    // cập nhật ds sản phâm trong hoá đơn
    await updateDetailProductInWarehouseReceipt();

    warehouseReceipt = await updateDetailWarehouseReceiptMixin(
        warehouseReceipt: warehouseReceipt?.copyWith(
      note: noteTE?.text,
      paymentStatus: statusPayItemSelect?.value,
      deliveryStatus: statusDeliverItemSelect?.value,
      browsingStatus: statusBrowsingItemSelect?.value,
      supplierName: supplierItemSelect?.key,
      supplierID: supplierItemSelect?.value,
      personnelWarehouseStaffId: personnelWarehouseItemSelect?.value,
      personnelWarehouseStaffName: personnelWarehouseItemSelect?.key,
      totalMoney: calculateTotalMoney(),
    ));
    if (warehouseReceipt?.browsingStatus ==
        '6616adbe-cec8-4477-94a8-4175d7d2cabe') {
      await updateProduct();
    }
    await getListDetailProductOrder(idWarehouseReceipt: warehouseReceipt?.uid);

    changeUI();
  }

  // tạo hóa đơn nhập
  createSaleOder() async {
    loadingUI();
    if (supplierItemSelect?.value != null &&
        personnelWarehouseItemSelect?.value != null &&
        listDetailWarehouseReceiptCustomEdit != null &&
        (listDetailWarehouseReceiptCustomEdit?.length ?? 0) > 0) {
      warehouseReceipt = await createDetailWarehouseReceiptMixin(
          warehouseReceipt: WarehouseReceipt(
        note: noteTE?.text,
        paymentStatus: statusPayItemSelect?.value,
        deliveryStatus: statusDeliverItemSelect?.value,
        supplierID: supplierItemSelect?.value,
        supplierName: supplierItemSelect?.key,
        totalMoney: calculateTotalMoney(),
        browsingStatus: statusBrowsingItemSelect?.value,
        timeWarehouse: DateTime.now().toString(),
        personnelWarehouseStaffId: personnelWarehouseItemSelect?.value,
        personnelWarehouseStaffName: personnelWarehouseItemSelect?.key,
        uid: uidCreate,
      ));
      // cập nhật ds sản phâm trong hoá đơn
      await updateDetailProductInWarehouseReceipt();
      // nếu gắn trạng thái hoàn thành thì cập nhật giá nhập sp và số lượng
      if (warehouseReceipt?.browsingStatus ==
          '6616adbe-cec8-4477-94a8-4175d7d2cabe') {
        await updateProduct();
      }
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
  updateDetailProductInWarehouseReceipt() async {
    // lặp tìm sản phẩm cập nhật
    if (listDetailWarehouseReceiptCustom != null &&
        listDetailWarehouseReceiptCustom!.isNotEmpty) {
      List<DetailWarehouseReceiptCustom>? update = [];
      listDetailWarehouseReceiptCustomEdit?.forEach((element1) async {
        listDetailWarehouseReceiptCustom?.forEach((element2) async {
          if (element1.detailWarehouseReceipt?.productId ==
              element2.detailWarehouseReceipt?.productId) {
            update.add(element1);
          }
        });
      });
      // lặp tìm sản phẩm tạo mới có trong list edit nhưng k có trong list custom

      List<DetailWarehouseReceiptCustom?>? create = [];
      List<DetailWarehouseReceiptCustom?>? data1 = [];
      data1.addAll(listDetailWarehouseReceiptCustomEdit ?? []);
      data1.removeWhere((element) => update
          .where((element2) =>
              element?.detailWarehouseReceipt?.productId ==
              element2.detailWarehouseReceipt?.productId)
          .isNotEmpty);
      create = data1;

      // lặp tìm sản phẩm đẻ xoá
      List<DetailWarehouseReceiptCustom?>? delete = [];
      List<DetailWarehouseReceiptCustom?>? data2 = [];
      data2.addAll(listDetailWarehouseReceiptCustom ?? []);
      data2.removeWhere((element) => update
          .where((element2) =>
              element?.detailWarehouseReceipt?.productId ==
              element2.detailWarehouseReceipt?.productId)
          .isNotEmpty);
      delete = data2;

      for (var element1 in update) {
        // await updateQuantityProduct(
        //     product: element1.product,
        //     quantityNew: element1.detailWarehouseReceipt?.quantity ?? 0,
        //     quantityHistory: listDetailWarehouseReceiptCustom
        //             ?.where((element) =>
        //                 element.detailWarehouseReceipt?.productId ==
        //                 element1.detailWarehouseReceipt?.productId)
        //             .firstOrNull
        //             ?.detailWarehouseReceipt
        //             ?.quantity ??
        //         0);
        await updateDetailProductInWarehouseReceiptMixin(
            detailWarehouseReceipt: element1.detailWarehouseReceipt);
      }
      for (var element1 in create) {
        // await updateQuantityProduct(
        //     product: element1?.product,
        //     isNumberSalse: true,
        //     quantityNew: element1?.detailWarehouseReceipt?.quantity ?? 0,
        //     quantityHistory: listDetailWarehouseReceiptCustom
        //             ?.where((element) =>
        //                 element.detailWarehouseReceipt?.productId ==
        //                 element1?.detailWarehouseReceipt?.productId)
        //             .firstOrNull
        //             ?.detailWarehouseReceipt
        //             ?.quantity ??
        //         0);
        await createDetailProductInWarehouseReceiptMixin(
            detailWarehouseReceipt: element1?.detailWarehouseReceipt);
      }
      for (var element1 in delete) {
        // await updateQuantityProduct(
        //     product: element1?.product,
        //     quantityNew: 0,
        //     quantityHistory: listDetailWarehouseReceiptCustom
        //             ?.where((element) =>
        //                 element.detailWarehouseReceipt?.productId ==
        //                 element1?.detailWarehouseReceipt?.productId)
        //             .firstOrNull
        //             ?.detailWarehouseReceipt
        //             ?.quantity ??
        //         0);
        await deleteDetailProductInWarehouseReceiptMixin(
            detailWarehouseReceipt: element1?.detailWarehouseReceipt);
      }
    } else {
      // List<DetailWarehouseReceipt>? create1 = [];
      listDetailWarehouseReceiptCustomEdit?.forEach((element1) async {
        await createDetailProductInWarehouseReceiptMixin(
            detailWarehouseReceipt: element1.detailWarehouseReceipt);
        // await updateQuantityProduct(
        //     product: element1.product,
        //     isNumberSalse: true,
        //     quantityNew: element1.detailWarehouseReceipt?.quantity ?? 0,
        //     quantityHistory: 0);
      });
      // print(create1);
    }

    await getListProduct(isCache: false);
    update();
  }

// gắn trạng thái đã duyệt thì cập nhật giá nhập và số lượng
  updateProduct() {
    listDetailWarehouseReceiptCustom?.forEach((element) async {
      await updateQuantityProduct(
          product: element.product,
          quantityNew: element.detailWarehouseReceipt?.quantity ?? 0,
          importPrice: element.detailWarehouseReceipt?.importPrice);
    });
  }

  //hàm cập nhật và tính lại số lượng sản phẩm
  updateQuantityProduct(
      {Product? product, num? quantityNew, num? importPrice}) async {
    if (quantityNew != null && quantityNew > 0) {
      await updateDetailProductMixin(
          product: product?.copyWith(
              quantity: ((product.quantity ?? 0) + quantityNew),
              importPrice: importPrice));
      return;
    }
  }

// áp dụng khi tạo mới, sửa hoá đơn -
//chọn dánh ách sản phẩm convert sang kiểu dữ liệu detailWarehouseReceiptCustom
  fillDataProduct() async {
    listDetailWarehouseReceiptCustomEdit?.clear();
    List<SelectOptionItem>? listProductSelectData = [];
    List<SelectOptionItem>? listResultEqual =
        []; // dánh ách sản phẩm khi tìm trùng
    listProductSelectData.addAll(listProductSelect ?? []);
    if (listDetailWarehouseReceipt != null &&
        listDetailWarehouseReceipt!.isNotEmpty &&
        arguments['type'] == 'view') {
      for (var element in listProductSelectData) {
        Product? product = element.data;
        // nếu sản phẩm đã tồn tại,ghi đè lên
        listDetailWarehouseReceipt?.forEach((element2) {
          if (element.value == element2.productId) {
            listDetailWarehouseReceiptCustomEdit
                ?.add(DetailWarehouseReceiptCustom(
              detailWarehouseReceipt: DetailWarehouseReceipt(
                wareHouseId: warehouseReceipt?.uid,
                productId: product?.uid,
                id: element2.id,
                quantity: element2.quantity,
                importPrice: element2.importPrice ?? product?.importPrice,
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
        listDetailWarehouseReceiptCustomEdit?.add(DetailWarehouseReceiptCustom(
          detailWarehouseReceipt: DetailWarehouseReceipt(
            uid: uuid.v4(),
            wareHouseId: warehouseReceipt?.uid,
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
        listDetailWarehouseReceiptCustomEdit?.add(DetailWarehouseReceiptCustom(
          detailWarehouseReceipt: DetailWarehouseReceipt(
            uid: uuid.v4(),
            wareHouseId:
                arguments['type'] == 'view' ? warehouseReceipt?.uid : uidCreate,
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
  updateProductInWarehouseReceiptEdit(
      {Product? product,
      String? quantity,
      String? importPriceP,
      String? note}) {
    for (int i = 0;
        i < (listDetailWarehouseReceiptCustomEdit?.length ?? 0);
        i++) {
      if (listDetailWarehouseReceiptCustomEdit?[i].product?.uid ==
          product?.uid) {
        listDetailWarehouseReceiptCustomEdit?[i].detailWarehouseReceipt =
            listDetailWarehouseReceiptCustomEdit?[i]
                .detailWarehouseReceipt
                ?.copyWith(
                  importPrice: (importPriceP != null && importPriceP != '')
                      ? num.parse(importPriceP)
                      : product?.importPrice,
                  note: note,
                  productId: product?.uid,
                  quantity: num.parse(quantity ?? '0'),
                  wareHouseId: warehouseReceipt?.uid,
                );
      }
    }
    update();
  }

  // tính tổng tiền -> thành tiền
  num calculateTotalMoney() {
    num? totalMoneyData = 0;
    listDetailWarehouseReceiptCustomEdit?.forEach((element) {
      totalMoneyData = (totalMoneyData ?? 0) +
          ((element.detailWarehouseReceipt?.quantity ?? 0) *
              (element.detailWarehouseReceipt?.importPrice ?? 1));
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

  // khi tạo mới sp bằng cách tạo nhanh -> cpạ nhật list kh sẽ khiên sthay đổi địa chỉ ô nhớ
// => xóa và convert lại ds cho đúng địa chỉ
  resetDataProduct() {
    List<SelectOptionItem>? lstProductBackup = listProductSelect;
    listProductSelect = listProduct
        ?.where((element) =>
            (lstProductBackup
                    ?.where((element2) => element.value == element2.value)
                    .length ??
                0) >
            0)
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
class DetailWarehouseReceiptCustom {
  DetailWarehouseReceipt? detailWarehouseReceipt;
  Product? product;
  DetailWarehouseReceiptCustom({
    this.detailWarehouseReceipt,
    this.product,
  });

  // @override
  // bool operator ==(covariant DetailWarehouseReceiptCustom other) {
  //   if (identical(this, other)) return true;

  //   return other.detailWarehouseReceipt == detailWarehouseReceipt &&
  //       other.product == product;
  // }

  // @override
  // int get hashCode => detailWarehouseReceipt.hashCode ^ product.hashCode;

  // DetailWarehouseReceiptCustom copyWith({
  //   DetailWarehouseReceipt? detailWarehouseReceipt,
  //   Product? product,
  // }) {
  //   return DetailWarehouseReceiptCustom(
  //     detailWarehouseReceipt: detailWarehouseReceipt ?? this.detailWarehouseReceipt,
  //     product: product ?? this.product,
  //   );
  // }
}
