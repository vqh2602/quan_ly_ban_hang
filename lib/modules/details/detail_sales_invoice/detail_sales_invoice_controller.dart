// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/customer.dart';
import 'package:quan_ly_ban_hang/data/models/detail_sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/customer_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/product_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/sales_order_mixin.dart';

class DetailSalesInvoiceController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        SalesOrderMixin,
        AppWriteMixin,
        CustomerMixin,
        ProductMixin {
  var arguments = Get.arguments;
  ImgurRepo imgurRepo = ImgurRepo();
  SalesOrder? salesOrder;
  List<Unit>? listUnit = [];

  List<DetailSalesOrder>? listDetailSalesOrder =
      []; // danh sách sản phẩm mua api trả về
  List<DetailSalesOrderCustom?>? listDetailSalesOrderCustom =
      []; // danh sách sản phẩm của đơn hàng, nhưng có thêm thông tin sản phaamr gốc

  List<Status>? listStatus = []; // ds trạng thái
  List<SelectOptionItem>? listStatusOption =
      []; // ds trạng thái chuyển list option
  SelectOptionItem? statusItemSelect;

  List<Customer> listCustomer = [];
  Customer? customer; // khách hàng mua hàng

  String? imageUrl;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getListStatus();
    await getListUnit();
    if (arguments['type'] == 'view') {
      await getDetailSalesOrder(arguments['salesOrderID']);
    }
    changeUI();
  }

// lấy dl sản phẩm qua id
  getDetailSalesOrder(String? id) async {
    loadingUI();

    salesOrder = await getDetailSalesOrderMixin(id: id);
    customer = await getDetailCustomerWithUIDMixin(id: salesOrder?.customerId);
    await getListDetailProductOrder(idSalesOrder: salesOrder?.uid);

    changeUI();
  }

  getListStatus() async {
    listStatus = await getListStatusMixin();
    listStatusOption = listStatus
        ?.map((e) => SelectOptionItem(key: e.name, value: e.id, data: e))
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
    update();
  }

  getListUnit() async {
    listUnit = await getListUnitMixin();
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

  @override
  bool operator ==(covariant DetailSalesOrderCustom other) {
    if (identical(this, other)) return true;

    return other.detailSalesOrder == detailSalesOrder &&
        other.product == product;
  }

  @override
  int get hashCode => detailSalesOrder.hashCode ^ product.hashCode;
}
