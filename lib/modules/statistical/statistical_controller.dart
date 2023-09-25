import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/request_return.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/request_return_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/sales_order_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/warehouse_receipt_mixin.dart';

class StatisticalController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        SalesOrderMixin,
        WarehouseReceiptMixin,
        RequestReturnMixin {
  List<SalesOrder>? listSalesOrder = [];
  List<SalesOrder>? listSalesOrderHome = [];
  List<WarehouseReceipt>? listWarehouseReceipt = [];
  List<RequestReturn>? listRequestReturn = [];

  var arguments = Get.arguments;
  DateTime date = DateTime.now();
  @override
  Future<void> onInit() async {
    super.onInit();
    await getListOderByFilter();
    await getListWarehouseFilter();
    await getListRequestReturnFilter();
    listSalesOrderHome = [...listSalesOrder!];
    update();
  }

  getListOderByFilter() async {
    loadingUI();
    listSalesOrder?.clear();
    listSalesOrder =
        await getListOderByFilterMixin(month: date.month, year: date.year);

    changeUI();
  }

  getListWarehouseFilter() async {
    loadingUI();
    listWarehouseReceipt?.clear();
    listWarehouseReceipt = await getListWarehouseReceiptByFilterMixin(
        month: date.month, year: date.year);

    changeUI();
  }

  getListRequestReturnFilter() async {
    loadingUI();
    listRequestReturn?.clear();
    listRequestReturn = await getListRequestReturnByFilterMixin(
        month: date.month, year: date.year);

    changeUI();
  }

// TÔNG DOANH THU
  num calculateTotalRevenue(
      {int? type = 0, List<SalesOrder>? listData, bool isNumberSalse = false}) {
    num total = 0.0;
    num numberSales = 0;
    switch (type) {
      case 0:
        // tổng
        (listData ?? listSalesOrder)?.forEach((element) {
          if (element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.totalMoney ?? 0;
            numberSales++;
          }
        });
        return isNumberSalse ? numberSales : total;
      case 1:
        // tuần 1
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 1)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 8)) &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.totalMoney ?? 0;
            numberSales++;
          }
        });
        return isNumberSalse ? numberSales : total;
      case 2:
        // tuan 2
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 8)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 16)) &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.totalMoney ?? 0;
            numberSales++;
          }
        });
        return isNumberSalse ? numberSales : total;
      case 3:
        // tuan 3
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 16)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 24)) &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.totalMoney ?? 0;
            numberSales++;
          }
        });
        return isNumberSalse ? numberSales : total;
      case 4:
        // tuan 4
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 24)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 31)) &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.totalMoney ?? 0;
            numberSales++;
          }
        });
        return isNumberSalse ? numberSales : total;

      default:
        return 0.0;
    }
  }

  // TÔNG lợi nhuận
  num calculateTotalProfit({int? type = 0, List<SalesOrder>? listData}) {
    num total = 0.0;
    switch (type) {
      case 0:
        // tổng
        (listData ?? listSalesOrder)?.forEach((element) {
          if (element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.profit ?? 0;
          }
        });
        return total;
      case 1:
        // tuần 1
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 1)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 8)) &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.profit ?? 0;
          }
        });
        return total;
      case 2:
        // tuan 2
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 8)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 16)) &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.profit ?? 0;
          }
        });
        return total;
      case 3:
        // tuan 3
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 16)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 24)) &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.profit ?? 0;
          }
        });
        return total;
      case 4:
        // tuan 4
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 24)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 31)) &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            total += element.profit ?? 0;
          }
        });
        return total;

      default:
        return 0.0;
    }
  }

// Tìm và tỷ lệ thành công
  num calculateTotalSuccessRate({int? type = 0, List<SalesOrder>? listData}) {
    num total = 0.0;
    num totalsalse = 0.0;
    switch (type) {
      case 0:
        // thành công
        (listData ?? listSalesOrder)?.forEach((element) {
          total++;
          if (element.paymentStatus == 'adc1e2af-fa93-4f5b-b985-dbbedb53ba89' &&
              element.deliveryStatus ==
                  '7dafedc3-edd3-453a-8724-b2c4d75b3912') {
            totalsalse++;
          }
        });
        return (totalsalse / total) * 100;

      case 1:
        // hủy
        (listData ?? listSalesOrder)?.forEach((element) {
          total++;
          if (element.deliveryStatus ==
              '96c4b4fd-2e35-471e-9ef2-35f82cd52129') {
            totalsalse++;
          }
        });
        return (totalsalse / total) * 100;
      case 2:
        // khác
        (listData ?? listSalesOrder)?.forEach((element) {
          total++;
          if (element.deliveryStatus !=
              '7dafedc3-edd3-453a-8724-b2c4d75b3912') {
            totalsalse++;
          }
        });
        return (totalsalse / total) * 100;

      default:
        return 0.0;
    }
  }

  // TÔNG giá trị nhập kho
  num calculateTotalWarehouse(
      {int? type = 0, List<WarehouseReceipt>? listData}) {
    num total = 0.0;
    switch (type) {
      case 0:
        // tổng
        (listData ?? listWarehouseReceipt)?.forEach((element) {
          if (element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129' &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 1:
        // tuần 1
        listWarehouseReceipt?.forEach((element) {
          if (DateTime.parse(element.timeWarehouse ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 1)) &&
              DateTime.parse(element.timeWarehouse ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 8)) &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129' &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 2:
        // tuan 2
        listWarehouseReceipt?.forEach((element) {
          if (DateTime.parse(element.timeWarehouse ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 8)) &&
              DateTime.parse(element.timeWarehouse ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 16)) &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129' &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 3:
        // tuan 3
        listWarehouseReceipt?.forEach((element) {
          if (DateTime.parse(element.timeWarehouse ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 16)) &&
              DateTime.parse(element.timeWarehouse ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 24)) &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129' &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 4:
        // tuan 4
        listWarehouseReceipt?.forEach((element) {
          if (DateTime.parse(element.timeWarehouse ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 24)) &&
              DateTime.parse(element.timeWarehouse ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 31)) &&
              element.deliveryStatus !=
                  '96c4b4fd-2e35-471e-9ef2-35f82cd52129' &&
              element.paymentStatus != '2973e0de-8402-4c20-b0d8-137088d29dbd' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;

      default:
        return 0.0;
    }
  }

// Tổng giá trị tiền hoàn
  num calculateTotalRequestReturn(
      {int? type = 0, List<RequestReturn>? listData}) {
    num total = 0.0;
    switch (type) {
      case 0:
        // tổng
        (listData ?? listRequestReturn)?.forEach((element) {
          if (element.supplierStatus !=
                  'bc1022ca-a49d-4626-a751-11811f7d0abf' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 1:
        // tuần 1
        listRequestReturn?.forEach((element) {
          if (DateTime.parse(element.timeRequestReturn ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 1)) &&
              DateTime.parse(element.timeRequestReturn ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 8)) &&
              element.supplierStatus !=
                  'bc1022ca-a49d-4626-a751-11811f7d0abf' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 2:
        // tuan 2
        listRequestReturn?.forEach((element) {
          if (DateTime.parse(element.timeRequestReturn ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 8)) &&
              DateTime.parse(element.timeRequestReturn ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 16)) &&
              element.supplierStatus !=
                  'bc1022ca-a49d-4626-a751-11811f7d0abf' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 3:
        // tuan 3
        listRequestReturn?.forEach((element) {
          if (DateTime.parse(element.timeRequestReturn ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 16)) &&
              DateTime.parse(element.timeRequestReturn ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 24)) &&
              element.supplierStatus !=
                  'bc1022ca-a49d-4626-a751-11811f7d0abf' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 4:
        // tuan 4
        listRequestReturn?.forEach((element) {
          if (DateTime.parse(element.timeRequestReturn ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isAfter(DateTime(date.year, date.month, 24)) &&
              DateTime.parse(element.timeRequestReturn ?? '')
                  .subtract(DateTime.now().timeZoneOffset)
                  .isBefore(DateTime(date.year, date.month, 31)) &&
              element.supplierStatus !=
                  'bc1022ca-a49d-4626-a751-11811f7d0abf' &&
              element.browsingStatus !=
                  '694ead01-5fb2-472b-b9fd-3f05dda8be17') {
            total += element.totalMoney ?? 0;
          }
        });
        return total;

      default:
        return 0.0;
    }
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
