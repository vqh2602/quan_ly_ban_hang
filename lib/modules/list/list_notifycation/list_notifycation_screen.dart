import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_request_return/detail_request_return_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_warehouse_receipt/detail_warehouse_receipt_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_notifycation/list_notifycation_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/library/tabtoexpand.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_notifycation.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loadding_refreshindicator.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loding_list.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class ListNotifycationSreen extends StatefulWidget {
  const ListNotifycationSreen({super.key});
  static const String routeName = '/list_notifycation';

  @override
  State<ListNotifycationSreen> createState() => _ListNotifycationState();
}

class _ListNotifycationState extends State<ListNotifycationSreen> {
  ListNotifycationController listNotifycationController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: listNotifycationController.obx(
          (state) => CustomRefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2), () {});
                  // await listNotifycationController.getListNotifycations();
                },
                builder: (context, child, controller) {
                  return AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, _) {
                      return loaddingRefreshIndicator(
                          child: child,
                          context: context,
                          controller: controller);
                    },
                  );
                },
                child: SafeArea(
                  child: Column(
                    children: [
                      TapToExpand(
                        content: _saleOderNoti(isPreview: false),
                        title: SizedBox(
                          height: 50,
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: a500,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Icon(
                                LucideIcons.receipt,
                                color: Colors.white,
                              ),
                            ),
                            cWidth(20),
                            textBodyLarge(
                                'Đơn hàng  ${ShareFuntion().checkPermissionUserLogin(permission: [
                                      'QL',
                                      'AD',
                                      'BH'
                                    ]) ? 'đã hủy' //đợi duytwj
                                    : 'đợi giao' // da duyet
                                } (${listNotifycationController.listSalesOrder?.length ?? 0})',
                                fontWeight: FontWeight.w500),
                          ]),
                        ),
                        onTapPadding: 10,
                        color: Colors.transparent,
                        closedHeight: 50,
                        scrollable: true,
                        borderRadius: 10,
                        openedHeight: 250,
                        boxShadow: const [],
                      ),
                      if (ShareFuntion().checkPermissionUserLogin(
                          permission: ['QL', 'AD', 'NK']))
                        TapToExpand(
                          content: _wareHouseNoti(isPreview: false),
                          title: SizedBox(
                            height: 50,
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: b500,
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Icon(
                                  LucideIcons.boxes,
                                  color: Colors.white,
                                ),
                              ),
                              cWidth(20),
                              textBodyLarge(
                                  'Đơn hàng nhập ${ShareFuntion().checkPermissionUserLogin(permission: [
                                        'QL',
                                        'AD'
                                      ]) ? 'đợi duyệt' //đợi duytwj
                                      : 'đã duyệt' // da duyet
                                  } (${listNotifycationController.listWarehouseReceipt?.length ?? 0})',
                                  fontWeight: FontWeight.w500),
                            ]),
                          ),
                          onTapPadding: 10,
                          color: Colors.transparent,
                          closedHeight: 50,
                          scrollable: true,
                          borderRadius: 10,
                          openedHeight: 250,
                          boxShadow: const [],
                        ),
                      if (ShareFuntion().checkPermissionUserLogin(
                          permission: ['QL', 'AD', 'NK']))
                        TapToExpand(
                          content: _requestReturnNoti(isPreview: false),
                          title: SizedBox(
                            height: 50,
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Icon(
                                  LucideIcons.boxes,
                                  color: Colors.white,
                                ),
                              ),
                              cWidth(20),
                              textBodyLarge(
                                  'Yêu cầu đổi trả ${ShareFuntion().checkPermissionUserLogin(permission: [
                                        'QL',
                                        'AD'
                                      ]) ? 'đợi duyệt' //đợi duytwj
                                      : 'đã duyệt' // da duyet
                                  } (${listNotifycationController.listRequestReturn?.length ?? 0})',
                                  fontWeight: FontWeight.w500),
                            ]),
                          ),
                          onTapPadding: 10,
                          color: Colors.transparent,
                          closedHeight: 50,
                          scrollable: true,
                          borderRadius: 10,
                          openedHeight: 250,
                          boxShadow: const [],
                        ),
                    ],
                  ),
                ),
              ),
          onLoading: const LoadingList()),
      appBar: AppBar(
        title: textTitleLarge('Thông báo'),
        centerTitle: false,
        surfaceTintColor: bg500,
        backgroundColor: bg500,
        actions: const [],
      ),
    );
  }

  _saleOderNoti({bool isPreview = false}) {
    return SizedBox(
      height: 200,
      child: AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: isPreview
              ? (listNotifycationController.listSalesOrder?.length ?? 0) > 3
                  ? 3
                  : listNotifycationController.listSalesOrder?.length ?? 0
              : listNotifycationController.listSalesOrder?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: itemNotifycation(
                      title:
                          listNotifycationController.listSalesOrder?[index].uid,
                      onTap: () {
                        Get.toNamed(DetailSalesInvoiceSreen.routeName,
                            arguments: {
                              'salesOrderID': listNotifycationController
                                  .listSalesOrder?[index].id,
                              'type': 'view'
                            });
                      },
                      date: ShareFuntion.formatDate(
                          dateTime: listNotifycationController
                              .listSalesOrder?[index].timeOrder,
                          type: TypeDate.ddMMyyyyhhmm)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _wareHouseNoti({bool isPreview = false}) {
    return SizedBox(
      height: 200,
      child: AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: isPreview
              ? (listNotifycationController.listWarehouseReceipt?.length ?? 0) > 3
                  ? 3
                  : listNotifycationController.listWarehouseReceipt?.length ?? 0
              : listNotifycationController.listWarehouseReceipt?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: itemNotifycation(
                      title: listNotifycationController
                          .listWarehouseReceipt?[index].uid,
                      onTap: () {
                        Get.toNamed(DetailWarehouseReceiptScreen.routeName,
                            arguments: {
                              'warehouseReceiptID': listNotifycationController
                                  .listWarehouseReceipt?[index].id,
                              'type': 'view'
                            });
                      },
                      date: ShareFuntion.formatDate(
                          dateTime: listNotifycationController
                              .listWarehouseReceipt?[index].timeWarehouse,
                          type: TypeDate.ddMMyyyyhhmm)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _requestReturnNoti({bool isPreview = false}) {
    return SizedBox(
      height: 200,
      child: AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: isPreview
              ? (listNotifycationController.listRequestReturn?.length ?? 0) > 3
                  ? 3
                  : listNotifycationController.listRequestReturn?.length ?? 0
              : listNotifycationController.listRequestReturn?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: itemNotifycation(
                      title: listNotifycationController
                          .listRequestReturn?[index].uid,
                      onTap: () {
                        Get.toNamed(DetailRequestReturnScreen.routeName,
                            arguments: {
                              'requestReturnID': listNotifycationController
                                  .listRequestReturn?[index].id,
                              'type': 'view'
                            });
                      },
                      date: ShareFuntion.formatDate(
                          dateTime: listNotifycationController
                              .listRequestReturn?[index].timeRequestReturn,
                          type: TypeDate.ddMMyyyyhhmm)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
