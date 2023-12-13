// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quan_ly_ban_hang/data/models/customer.dart';
import 'package:quan_ly_ban_hang/data/models/detail_sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/personnel.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/customer_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/personnel_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/product_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/sales_order_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:uuid/uuid.dart';

class DetailSalesInvoiceController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        SalesOrderMixin,
        AppWriteMixin,
        CustomerMixin,
        PersonnelMixin,
        UserMixin,
        ProductMixin {
  var arguments = Get.arguments;
  ImgurRepo imgurRepo = ImgurRepo();
  SalesOrder? salesOrder;
  List<Unit>? listUnit = []; // ds đơn vị
  List<SelectOptionItem>? listCustomer = []; // ds khách hàng
  List<SelectOptionItem>? listProduct = []; // ds sản phẩm
  List<Status>? listStatus = []; // ds trạng thái
  List<SelectOptionItem>? listStatusOption =
      []; // ds trạng thái chuyển list option
  List<SelectOptionItem>? listPersonnel = []; // ds nhân viên

  SelectOptionItem? statusPayItemSelect; // tt thanh toán
  SelectOptionItem? statusDeliverItemSelect; // trạng thái giao
  SelectOptionItem? statuspaymentsIDSelect; // tt phương thưc sthanh toán

  SelectOptionItem? customerItemSelect;
  List<SelectOptionItem>? listProductSelect = []; // ds sản phẩm đc chọn
  SelectOptionItem? personnelSaleItemSelect; // nhân viên bán hàng đc chọn
  SelectOptionItem? personnelShipperItemSelect; // nhân viên giao hàng đc chọn

  List<DetailSalesOrder>? listDetailSalesOrder =
      []; // danh sách chi tieets ddn hang co sản phẩm mua api trả về
  List<DetailSalesOrderCustom>? listDetailSalesOrderCustom =
      []; // danh sách sản phẩm của đơn hàng, nhưng có thêm thông tin sản phaamr gốc
  List<DetailSalesOrderCustom>? listDetailSalesOrderCustomEdit =
      []; // ds sản phẩm đơn hàng, áp dụng cho sửa và tạo mới
  Customer? customer; // khách hàng mua hàng

  TextEditingController? discountTE = TextEditingController(), //chiết khấu
      surchargeTE = TextEditingController(), // phụ phí
      vatTE = TextEditingController(), // thuế
      noteTE = TextEditingController(), // ghi chú
      partlyPaidTE = TextEditingController(), //thanh toán 1 phần
      moneyGuestsTE = TextEditingController(), // tiền khách đưa
      cancellationNotesTE = TextEditingController(); // ghi chú huỷ

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
    await getListCustomer();
    await getListProduct();
    await getListPersonnel();
    if (arguments['type'] == 'view') {
      await getDetailSalesOrder(arguments['salesOrderID']);
    }
    if (arguments['type'] == 'create') {
      await initDataCreate();
    }
    changeUI();
  }

  initTE({SalesOrder? salesOrder}) {
    discountTE?.text = salesOrder?.discount?.toString() ?? '0';
    surchargeTE?.text = salesOrder?.surcharge?.toString() ?? '0';
    vatTE?.text = salesOrder?.vat?.toString() ?? '0';
    noteTE?.text = salesOrder?.note ?? '';
    partlyPaidTE?.text = salesOrder?.partlyPaid?.toString() ?? '0';
    cancellationNotesTE?.text = salesOrder?.cancellationNotes ?? '';
    moneyGuestsTE?.text = salesOrder?.moneyGuests?.toString() ?? '0';
    update();
  }

  initDataCreate() async {
    uidCreate = uuid.v4();

    customerItemSelect = null;
    listProductSelect = [];
    listDetailSalesOrderCustomEdit = [];
    personnelShipperItemSelect = null;
    //fill dữ liệu vào các trường select
    // customerItemSelect = listCustomer
    //     ?.where((element) => element.value == customer?.uid)
    //     .firstOrNull;
    statusPayItemSelect = listStatusOption
        ?.where((element) =>
            element.value == 'cc9a9396-f062-4969-af52-45501eb9fda3')
        .firstOrNull;
    statusDeliverItemSelect = listStatusOption
        ?.where((element) =>
            element.value == 'cf7cc1ab-3685-4788-8174-7961925bcdb6')
        .firstOrNull;
    personnelSaleItemSelect = listPersonnel
        ?.where((element) => element.value == userLogin?.uId)
        .firstOrNull;
    statuspaymentsIDSelect = listStatusOption
        ?.where((element) =>
            element.value == '90601b31-a59c-4ce9-9a31-7d621286b6f2')
        .firstOrNull;
    // personnelShipperItemSelect = listPersonnel
    //     ?.where((element) => element.value == salesOrder?.personnelShipperId)
    //     .firstOrNull;
    initTE(salesOrder: null);
    update();
  }

// lấy dl don hang qua id
  getDetailSalesOrder(String? id) async {
    loadingUI();

    salesOrder = await getDetailSalesOrderMixin(id: id);
    customer = await getDetailCustomerWithUIDMixin(id: salesOrder?.customerId);
    await getListDetailProductOrder(idSalesOrder: salesOrder?.uid);
//fill dữ liệu vào các trường select
    customerItemSelect = listCustomer
        ?.where((element) => element.value == customer?.uid)
        .firstOrNull;
    statusPayItemSelect = listStatusOption
        ?.where((element) => element.value == salesOrder?.paymentStatus)
        .firstOrNull;
    statusDeliverItemSelect = listStatusOption
        ?.where((element) => element.value == salesOrder?.deliveryStatus)
        .firstOrNull;
    personnelSaleItemSelect = listPersonnel
        ?.where(
            (element) => element.value == salesOrder?.personnelSalespersonId)
        .firstOrNull;
    personnelShipperItemSelect = listPersonnel
        ?.where((element) => element.value == salesOrder?.personnelShipperId)
        .firstOrNull;

    statuspaymentsIDSelect = listStatusOption
        ?.where((element) => element.value == salesOrder?.paymentsId)
        .firstOrNull;
    initTE(salesOrder: salesOrder);
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
  getListDetailProductOrder({String? idSalesOrder}) async {
    listDetailSalesOrder =
        await getListDetailProductInSalesOrderMixin(idSalesOrder: idSalesOrder);
    listDetailSalesOrderCustom?.clear();
    for (DetailSalesOrder item in listDetailSalesOrder ?? []) {
      Product? product =
          await getListProductWithIdMixin(idProduct: item.productId);
      listDetailSalesOrderCustom?.add(DetailSalesOrderCustom(
        detailSalesOrder: item,
        product: product,
      ));
    }
    // fill ds sản phẩm đc chọn
    listProductSelect = listProduct
        ?.where((element1) =>
            (listDetailSalesOrder
                    ?.where((element2) => element1.value == element2.productId)
                    .length ??
                0) >
            0)
        .toList();
    listDetailSalesOrderCustomEdit = [];
    // gắn list tạo mới đối tượng để tránh tình trạng trùng ô nhớ
    listDetailSalesOrderCustom?.forEach((element) {
      listDetailSalesOrderCustomEdit?.add(DetailSalesOrderCustom(
        detailSalesOrder: element.detailSalesOrder,
        product: element.product,
      ));
    });

    update();
  }

// cập nhật hoá đơn bán
  updateSaleOder() async {
    loadingUI();
    // cập nhật ds sản phâm trong hoá đơn
    // KIỂM tra trạng thái giao và thanh toán => k cho sửa trừa admin
    if ((salesOrder?.deliveryStatus == '7dafedc3-edd3-453a-8724-b2c4d75b3912' &&
        salesOrder?.paymentStatus == 'adc1e2af-fa93-4f5b-b985-dbbedb53ba89')) {
      if (!ShareFuntion().checkPermissionUserLogin(permission: ['QL', 'AD'])) {
        buildToast(
            message: 'Không được phép sửa sau khi đã gắn trạng thái hoàn thành',
            status: TypeToast.getError);
        changeUI();
        return;
      }
    } else {}

    await updateDetailProductInSalesOrder();

    salesOrder = await updateDetailSalesOrderMixin(
        salesOrder: salesOrder?.copyWith(
      discount: double.parse(discountTE?.text ?? '0'),
      surcharge: double.parse(surchargeTE?.text ?? '0'),
      vat: double.parse(vatTE?.text ?? '0'),
      note: noteTE?.text,
      partlyPaid: double.parse(partlyPaidTE?.text ?? '0'),
      cancellationNotes: cancellationNotesTE?.text,
      moneyGuests: double.parse(moneyGuestsTE?.text ?? '0'),
      paymentStatus: statusPayItemSelect?.value,
      deliveryStatus: statusDeliverItemSelect?.value,
      personnelSalespersonName: personnelSaleItemSelect?.key,
      personnelShipperName: personnelShipperItemSelect?.key,
      personnelSalespersonId: personnelSaleItemSelect?.value,
      personnelShipperId: personnelShipperItemSelect?.value,
      paymentsId: statuspaymentsIDSelect?.value,
      customerId: customerItemSelect?.value,
      customerName: customerItemSelect?.key,
      totalMoney: calculateTotalMoney(),
      profit: calculateProfitMoneyProduct(),
      changeMoney: calculateChangeMoney(),
      paymentTime: (statusPayItemSelect?.value ==
                  'adc1e2af-fa93-4f5b-b985-dbbedb53ba89' &&
              salesOrder?.paymentTime != 'adc1e2af-fa93-4f5b-b985-dbbedb53ba89')
          ? DateTime.now().toString()
          : null,
      deliveryTime: (statusDeliverItemSelect?.value ==
                  '7dafedc3-edd3-453a-8724-b2c4d75b3912' &&
              salesOrder?.deliveryTime !=
                  'adc1e2af-fa93-4f5b-b985-dbbedb53ba89')
          ? DateTime.now().toString()
          : null,
    ));

    await getListDetailProductOrder(idSalesOrder: salesOrder?.uid);

    changeUI();
  }

  // tạo hoá đơn bán
  createSaleOder() async {
    loadingUI();
    if (customerItemSelect?.value != null &&
        personnelSaleItemSelect?.value != null &&
        personnelShipperItemSelect?.value != null &&
        // double.parse(partlyPaidTE?.text ?? '0') <= calculateTotalMoney() &&
        //  double.parse(moneyGuestsTE?.text ?? '0') >= calculateTotalMoney() &&
        listDetailSalesOrderCustomEdit != null &&
        (listDetailSalesOrderCustomEdit?.length ?? 0) > 0) {
      salesOrder = await createDetailSalesOrderMixin(
          salesOrder: SalesOrder(
              discount: double.parse(discountTE?.text ?? '0'),
              surcharge: double.parse(surchargeTE?.text ?? '0'),
              vat: double.parse(vatTE?.text ?? '0'),
              note: noteTE?.text,
              partlyPaid: double.parse(partlyPaidTE?.text ?? '0'),
              cancellationNotes: cancellationNotesTE?.text,
              moneyGuests: double.parse(moneyGuestsTE?.text ?? '0'),
              paymentStatus: statusPayItemSelect?.value,
              deliveryStatus: statusDeliverItemSelect?.value,
              paymentsId: statuspaymentsIDSelect?.value,
              personnelSalespersonName: personnelSaleItemSelect?.key,
              personnelShipperName: personnelShipperItemSelect?.key,
              personnelSalespersonId: personnelSaleItemSelect?.value,
              personnelShipperId: personnelShipperItemSelect?.value,
              customerId: customerItemSelect?.value,
              customerName: customerItemSelect?.key,
              totalMoney: calculateTotalMoney(),
              changeMoney: calculateChangeMoney(),
              paymentTime: (statusPayItemSelect?.value ==
                          'adc1e2af-fa93-4f5b-b985-dbbedb53ba89' &&
                      salesOrder?.paymentTime !=
                          'adc1e2af-fa93-4f5b-b985-dbbedb53ba89')
                  ? DateTime.now().toString()
                  : null,
              deliveryTime: (statusDeliverItemSelect?.value ==
                          '7dafedc3-edd3-453a-8724-b2c4d75b3912' &&
                      salesOrder?.deliveryTime !=
                          'adc1e2af-fa93-4f5b-b985-dbbedb53ba89')
                  ? DateTime.now().toString()
                  : null,
              uid: uidCreate,
              timeOrder: DateTime.now().toString(),
              profit: calculateProfitMoneyProduct()));
      // cập nhật ds sản phâm trong hoá đơn
      await updateDetailProductInSalesOrder();

      await initDataCreate();
    } else {
      buildToast(
          message:
              'Không để trống các trường thông tin: khách hàng, nhân viên, sản phẩm...\nHoặc thanh toán một phần & tiền khách đưa sai giá trị',
          status: TypeToast.toastError);
      // buildToast(
      //     message: 'Hoặc thanh toán một phần & tiền khách đưa sai giá trị',
      //     status: TypeToast.toastError);
    }
    changeUI();
  }

  // cập nhật danh sách sản phẩm -api
  updateDetailProductInSalesOrder() async {
    // lặp tìm sản phẩm cập nhật
    if (listDetailSalesOrderCustom != null &&
        listDetailSalesOrderCustom!.isNotEmpty) {
      List<DetailSalesOrderCustom>? update = [];
      listDetailSalesOrderCustomEdit?.forEach((element1) async {
        listDetailSalesOrderCustom?.forEach((element2) async {
          if (element1.detailSalesOrder?.productId ==
              element2.detailSalesOrder?.productId) {
            update.add(element1);
          }
        });
      });
      // lặp tìm sản phẩm tạo mới có trong list edit nhưng k có trong list custom

      List<DetailSalesOrderCustom?>? create = [];
      List<DetailSalesOrderCustom?>? data1 = [];
      data1.addAll(listDetailSalesOrderCustomEdit ?? []);
      data1.removeWhere((element) => update
          .where((element2) =>
              element?.detailSalesOrder?.productId ==
              element2.detailSalesOrder?.productId)
          .isNotEmpty);
      create = data1;

      // lặp tìm sản phẩm đẻ xoá
      List<DetailSalesOrderCustom?>? delete = [];
      List<DetailSalesOrderCustom?>? data2 = [];
      data2.addAll(listDetailSalesOrderCustom ?? []);
      data2.removeWhere((element) => update
          .where((element2) =>
              element?.detailSalesOrder?.productId ==
              element2.detailSalesOrder?.productId)
          .isNotEmpty);
      delete = data2;

      for (var element1 in update) {
        await updateQuantityProduct(
            product: element1.product,
            quantityNew: element1.detailSalesOrder?.quantity ?? 0,
            quantityHistory: listDetailSalesOrderCustom
                    ?.where((element) =>
                        element.detailSalesOrder?.productId ==
                        element1.detailSalesOrder?.productId)
                    .firstOrNull
                    ?.detailSalesOrder
                    ?.quantity ??
                0);
        await updateDetailProductInSalesOrderMixin(
            detailSalesOrder: element1.detailSalesOrder);
      }
      for (var element1 in create) {
        await updateQuantityProduct(
            product: element1?.product,
            isNumberSalse: true,
            quantityNew: element1?.detailSalesOrder?.quantity ?? 0,
            quantityHistory: listDetailSalesOrderCustom
                    ?.where((element) =>
                        element.detailSalesOrder?.productId ==
                        element1?.detailSalesOrder?.productId)
                    .firstOrNull
                    ?.detailSalesOrder
                    ?.quantity ??
                0);
        await createDetailProductInSalesOrderMixin(
            detailSalesOrder: element1?.detailSalesOrder);
      }
      for (var element1 in delete) {
        await updateQuantityProduct(
            product: element1?.product,
            quantityNew: 0,
            quantityHistory: listDetailSalesOrderCustom
                    ?.where((element) =>
                        element.detailSalesOrder?.productId ==
                        element1?.detailSalesOrder?.productId)
                    .firstOrNull
                    ?.detailSalesOrder
                    ?.quantity ??
                0);
        await deleteDetailProductInSalesOrderMixin(
            detailSalesOrder: element1?.detailSalesOrder);
      }
    } else {
      // List<DetailSalesOrder>? create1 = [];
      listDetailSalesOrderCustomEdit?.forEach((element1) async {
        await createDetailProductInSalesOrderMixin(
            detailSalesOrder: element1.detailSalesOrder);
        await updateQuantityProduct(
            product: element1.product,
            isNumberSalse: true,
            quantityNew: element1.detailSalesOrder?.quantity ?? 0,
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
//chọn dánh ách sản phẩm convert sang kiểu dữ liệu detailSalesOrderCustom
  fillDataProduct() async {
    listDetailSalesOrderCustomEdit?.clear();
    List<SelectOptionItem>? listProductSelectData = [];
    List<SelectOptionItem>? listResultEqual =
        []; // dánh ách sản phẩm khi tìm trùng
    listProductSelectData.addAll(listProductSelect ?? []);
    if (listDetailSalesOrder != null &&
        listDetailSalesOrder!.isNotEmpty &&
        arguments['type'] == 'view') {
      for (var element in listProductSelectData) {
        Product? product = element.data;
        // nếu sản phẩm đã tồn tại,ghi đè lên
        listDetailSalesOrder?.forEach((element2) {
          if (element.value == element2.productId) {
            listDetailSalesOrderCustomEdit?.add(DetailSalesOrderCustom(
              detailSalesOrder: DetailSalesOrder(
                salesOrderId: salesOrder?.uid,
                productId: product?.uid,
                id: element2.id,
                quantity: element2.quantity,
                importPrice: product?.importPrice,
                price: product?.price,
                discount: product?.discount,
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
        listDetailSalesOrderCustomEdit?.add(DetailSalesOrderCustom(
          detailSalesOrder: DetailSalesOrder(
            uid: uuid.v4(),
            salesOrderId: salesOrder?.uid,
            productId: product?.uid,
            quantity: 1,
            importPrice: product?.importPrice,
            price: product?.price,
            discount: product?.discount,
            note: '',
          ),
          product: product,
        ));
      }
    } else {
      for (var element in listProductSelectData) {
        listDetailSalesOrderCustomEdit?.add(DetailSalesOrderCustom(
          detailSalesOrder: DetailSalesOrder(
            uid: uuid.v4(),
            salesOrderId:
                arguments['type'] == 'view' ? salesOrder?.uid : uidCreate,
            productId: element.data?.uid,
            quantity: 1,
            importPrice: element.data?.importPrice,
            price: element.data?.price,
            discount: element.data?.discount,
            note: '',
          ),
          product: element.data,
        ));
      }
    }
    update();
  }

  // set lại giá trị của sản phẩm - cập nhật, tạo mới khi hiển thị bottomsheet thay đổi số lượng
  updateProductInSalesOrderEdit(
      {Product? product, String? quantity, String? discount, String? note}) {
    for (int i = 0; i < (listDetailSalesOrderCustomEdit?.length ?? 0); i++) {
      if (listDetailSalesOrderCustomEdit?[i].product?.uid == product?.uid) {
        listDetailSalesOrderCustomEdit?[i].detailSalesOrder =
            listDetailSalesOrderCustomEdit?[i].detailSalesOrder?.copyWith(
                  importPrice: product?.importPrice,
                  note: note,
                  discount: num.parse(discount ?? '0'),
                  price: product?.price,
                  productId: product?.uid,
                  quantity: num.parse(quantity ?? '0'),
                  salesOrderId: salesOrder?.uid,
                );
      }
    }
    update();
  }

  // tính tổng tiền của sản phẩm (sản phẩm - giảm giá) * sl
  num calculateTotalMoneyProduct() {
    num? totalMoneyData = 0;
    listDetailSalesOrderCustomEdit?.forEach((element) {
      num soluong = element.detailSalesOrder?.quantity ?? 0;
      num sanpham = element.detailSalesOrder?.price ?? 0;
      num giamgia = ((element.detailSalesOrder?.discount ?? 100) / 100);
      totalMoneyData =
          (totalMoneyData ?? 0) + (soluong * (sanpham - (sanpham * giamgia)));
    });
    return totalMoneyData ?? 0;
  }

  // tính lợi nhuận (giá sản phẩm bán  - giá sản phẩm nhập)
  num calculateProfitMoneyProduct() {
    num? totalMoneyData = 0;
    listDetailSalesOrderCustomEdit?.forEach((element) {
      totalMoneyData = (totalMoneyData ?? 0) +
          ((element.detailSalesOrder?.quantity ?? 0) *
              (element.detailSalesOrder?.importPrice ?? 0));
    });
    return calculateTotalMoneyProduct() - (totalMoneyData ?? 0);
  }

  // tính tổng tiền -> thành tiền
  num calculateTotalMoney() {
    num? totalMoneyData = calculateTotalMoneyProduct();
    // (tổng tiền + tiền thuế ) - (thanh toán 1 phần + giảm giá) + phụ phí
    num vat = double.parse(vatTE?.text ?? '0') / 100;
    num partlyPaid = double.parse(partlyPaidTE?.text ?? '0');
    num discount = double.parse(discountTE?.text ?? '0') / 100;
    num surcharge = double.parse(surchargeTE?.text ?? '0');
    return ((totalMoneyData) + ((totalMoneyData) * vat)) -
        (partlyPaid + ((totalMoneyData) * discount)) +
        surcharge;
  }

  // tính tiền trả lại
  num calculateChangeMoney() {
    num? changeMoneyData = 0;
    if (moneyGuestsTE?.text != null &&
        moneyGuestsTE?.text != '' &&
        num.parse(moneyGuestsTE?.text ?? '0') > 0) {
      changeMoneyData =
          double.parse(moneyGuestsTE?.text ?? '0') - (calculateTotalMoney());
    }
    return changeMoneyData;
  }

  getListUnit() async {
    listUnit = await getListUnitMixin();
  }

  getListCustomer() async {
    List<Customer>? result = await getListCustomerMixin(isCache: false);
    listCustomer = result
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

// khi tạo mới kh bằng cách tạo nhanh -> cpạ nhật list kh sẽ khiên sthay đổi địa chỉ ô nhớ
// => xóa và convert lại ds cho đúng địa chỉ
  resetDataCustomer() {
    SelectOptionItem? customerBackup = customerItemSelect;
    customerItemSelect = listCustomer
        ?.where((element) => element.value == customerBackup?.value)
        .firstOrNull;
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
class DetailSalesOrderCustom {
  DetailSalesOrder? detailSalesOrder;
  Product? product;
  DetailSalesOrderCustom({
    this.detailSalesOrder,
    this.product,
  });

  // @override
  // bool operator ==(covariant DetailSalesOrderCustom other) {
  //   if (identical(this, other)) return true;

  //   return other.detailSalesOrder == detailSalesOrder &&
  //       other.product == product;
  // }

  // @override
  // int get hashCode => detailSalesOrder.hashCode ^ product.hashCode;

  // DetailSalesOrderCustom copyWith({
  //   DetailSalesOrder? detailSalesOrder,
  //   Product? product,
  // }) {
  //   return DetailSalesOrderCustom(
  //     detailSalesOrder: detailSalesOrder ?? this.detailSalesOrder,
  //     product: product ?? this.product,
  //   );
  // }
}
