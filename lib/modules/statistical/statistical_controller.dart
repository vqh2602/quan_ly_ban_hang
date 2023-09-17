import 'dart:async';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/sales_order_mixin.dart';

class StatisticalController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, SalesOrderMixin {
  List<SalesOrder>? listSalesOrder = [];
  List<SalesOrder>? listSalesOrderHome = [];
  var arguments = Get.arguments;
  DateTime date = DateTime.now();
  @override
  Future<void> onInit() async {
    super.onInit();
    await getListOderByFilter();
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

// TÔNG DOANH THU
  num calculateTotalRevenue({int? type = 0, List<SalesOrder>? listData}) {
    num total = 0.0;
    switch (type) {
      case 0:
        // tổng
        (listData ?? listSalesOrder)?.forEach((element) {
          total += element.totalMoney ?? 0;
        });
        return total;
      case 1:
        // tuần 1
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .isAfter(DateTime(date.year, date.month, 1)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .isBefore(DateTime(date.year, date.month, 8))) {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 2:
        // tuan 2
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .isAfter(DateTime(date.year, date.month, 8)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .isBefore(DateTime(date.year, date.month, 16))) {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 3:
        // tuan 3
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .isAfter(DateTime(date.year, date.month, 16)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .isBefore(DateTime(date.year, date.month, 24))) {
            total += element.totalMoney ?? 0;
          }
        });
        return total;
      case 4:
        // tuan 4
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .isAfter(DateTime(date.year, date.month, 24)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .isBefore(DateTime(date.year, date.month, 31))) {
            total += element.totalMoney ?? 0;
          }
        });
        return total;

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
          total += element.profit ?? 0;
        });
        return total;
      case 1:
        // tuần 1
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .isAfter(DateTime(date.year, date.month, 1)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .isBefore(DateTime(date.year, date.month, 8))) {
            total += element.profit ?? 0;
          }
        });
        return total;
      case 2:
        // tuan 2
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .isAfter(DateTime(date.year, date.month, 8)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .isBefore(DateTime(date.year, date.month, 16))) {
            total += element.profit ?? 0;
          }
        });
        return total;
      case 3:
        // tuan 3
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .isAfter(DateTime(date.year, date.month, 16)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .isBefore(DateTime(date.year, date.month, 24))) {
            total += element.profit ?? 0;
          }
        });
        return total;
      case 4:
        // tuan 4
        listSalesOrder?.forEach((element) {
          if (DateTime.parse(element.timeOrder ?? '')
                  .isAfter(DateTime(date.year, date.month, 24)) &&
              DateTime.parse(element.timeOrder ?? '')
                  .isBefore(DateTime(date.year, date.month, 31))) {
            total += element.profit ?? 0;
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
