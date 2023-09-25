import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/widgets/empty.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_bill_of_sale.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/s_show_chose.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loadding_refreshindicator.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_search.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class ListSalesOrderSreen extends StatefulWidget {
  const ListSalesOrderSreen({super.key});
  static const String routeName = '/list_sales_order';

  @override
  State<ListSalesOrderSreen> createState() => _ListSalesOrderState();
}

class _ListSalesOrderState extends State<ListSalesOrderSreen> {
  ListSalesOrderController listSalesOrderController = Get.find();
  @override
  Widget build(BuildContext context) {
    return listSalesOrderController.obx(
        (state) => buildBody(
            context: context,
            body: SafeArea(
              // margin: alignment_20_0(),
              // constraints: const BoxConstraints(maxHeight: 750),
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2), () {});
                  await listSalesOrderController.getListSalesOrder();
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
                child: AnimationLimiter(
                  child:listSalesOrderController.listSalesOrderResult != null &&
                            listSalesOrderController.listSalesOrderResult!.isEmpty
                        ? emptyWidget(
                            onTap: () async {
                              await listSalesOrderController.getListSalesOrder();
                            },
                          )
                        : ListView.builder(
                    itemCount:
                        listSalesOrderController.listSalesOrderResult?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: itemBillOfSale(
                                salesOrder: listSalesOrderController
                                    .listSalesOrderResult![index],
                                listStatus:
                                    listSalesOrderController.listStatus),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              title: textTitleLarge('Danh sách đơn hàng'),
              centerTitle: false,
              surfaceTintColor: bg500,
              backgroundColor: bg500,
              actions: [
                IconButton(
                  icon: const Icon(LucideIcons.filter),
                  onPressed: () {
                    Get.bottomSheet(showBottomSheetFilter(),
                        isScrollControlled: true,
                        isDismissible: true,
                        elevation: 0,
                        backgroundColor: Colors.grey.withOpacity(0));
                  },
                )
              ],
            ),
            createFloatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  if (ShareFuntion().checkPermissionUserLogin(
                      permission: ['QL', 'BH', 'C_HD', 'AD'])) {
                    Get.toNamed(DetailSalesInvoiceSreen.routeName,
                        arguments: {'type': 'create'});
                  } else {
                    buildToast(
                        message: 'Không có quyền xem thông tin',
                        status: TypeToast.toastError);
                  }
                },
                label: const Icon(
                    FontAwesomeIcons.solidRectangleHistoryCirclePlus))),
        onLoading: const LoadingCustom());
  }

  showBottomSheetFilter() {
    Get.bottomSheet(
        listSalesOrderController.obx(
          (state) => Container(
            height: Get.height * 0.8,
            decoration: BoxDecoration(
                color: bg500,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                child: Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                margin: alignment_20_0(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cHeight(20),
                    textSearch(
                        onTapSearch: () {},
                        textController: listSalesOrderController.textSearchTE),
                    cHeight(20),
                    InkWell(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textTitleMedium('Khách hàng'),
                            IconButton(
                                onPressed: () {
                                  Get.bottomSheet(listSalesOrderController
                                      .obx((state) => showBottomListChose(
                                            options: listSalesOrderController
                                                .listCustomer,
                                            value: listSalesOrderController
                                                .customerItemSelectFilter,
                                            onSelect: (p0) {
                                              if (listSalesOrderController
                                                      .customerItemSelectFilter ==
                                                  p0) {
                                                listSalesOrderController
                                                        .customerItemSelectFilter =
                                                    null;
                                              } else {
                                                listSalesOrderController
                                                    .customerItemSelectFilter = p0;
                                              }
                                              listSalesOrderController
                                                  .updateUI();
                                            },
                                            onSearch: (val) {
                                              ShareFuntion.searchList(
                                                  list: listSalesOrderController
                                                      .listCustomer,
                                                  value: val,
                                                  update: () {
                                                    listSalesOrderController
                                                        .updateUI();
                                                  });
                                            },
                                            buildOption: (p0) =>
                                                textBodyMedium(p0.key ?? ''),
                                          )));
                                },
                                icon: const Icon(LucideIcons.chevronRight))
                          ]),
                    ),
                    textBodyMedium(listSalesOrderController
                            .customerItemSelectFilter?.key ??
                        'Trống'),
                    cHeight(20),
                    textTitleMedium('Trạng thái giao hàng'),
                    cHeight(12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (Status item in listSalesOrderController.listStatus
                                ?.where((element) =>
                                    element.group == 'trạng thái giao hàng')
                                .toList() ??
                            [])
                          FlexiChip(
                            label: textBodyMedium(item.name ?? '',
                                color: listSalesOrderController
                                            .listStatusSelectFilter
                                            ?.contains(item) ??
                                        false
                                    ? Colors.white
                                    : null),
                            style: FlexiChipStyle.outlined(
                                color: Colors.grey,
                                selectedStyle: FlexiChipStyle.filled(
                                    iconColor: Colors.white,
                                    checkmarkColor: Colors.white)),
                            deleteIcon: const SizedBox(),
                            checkmark: true,
                            selected: listSalesOrderController
                                    .listStatusSelectFilter
                                    ?.contains(item) ??
                                false,
                            onSelected: (value) {
                              if (value) {
                                listSalesOrderController.listStatusSelectFilter
                                    ?.add(item);
                              } else {
                                listSalesOrderController.listStatusSelectFilter
                                    ?.remove(item);
                              }
                              listSalesOrderController.changeUI();
                            },
                            onDeleted: () {},
                          ),
                      ],
                    ),
                    cHeight(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textTitleMedium('Sắp xếp theo doanh thu'),
                        Switch(
                          // This bool value toggles the switch.
                          value: listSalesOrderController.sortMoney,
                          // activeColor: Colors.red,
                          // overlayColor:
                          //     MaterialStateColor.resolveWith((states) {
                          //   return Colors.grey.withOpacity(0.2);
                          // }),
                          activeTrackColor: Get.theme.primaryColor,
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.withOpacity(0.2),
                          trackOutlineColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey.withOpacity(0.3)),
                          onChanged: (bool value) {
                            listSalesOrderController.sortMoney = value;
                            listSalesOrderController.sortProfit = false;
                            listSalesOrderController.changeUI();
                          },
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textTitleMedium('Sắp xếp theo lợi nhuận'),
                        Switch(
                          // This bool value toggles the switch.
                          value: listSalesOrderController.sortProfit,
                          // activeColor: Colors.red,
                          // overlayColor:
                          //     MaterialStateColor.resolveWith((states) {
                          //   return Colors.grey.withOpacity(0.2);
                          // }),
                          activeTrackColor: Get.theme.primaryColor,
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.withOpacity(0.2),
                          trackOutlineColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey.withOpacity(0.3)),
                          onChanged: (bool value) {
                            listSalesOrderController.sortProfit = value;
                            listSalesOrderController.sortMoney = false;
                            listSalesOrderController.changeUI();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )),
              Container(
                margin: alignment_20_8(),
                child: SizedBox(
                  width: double.infinity,
                  child: FxButton.large(
                    onPressed: () async {
                      await listSalesOrderController.searchAndSortList();
                    },

                    // borderRadiusAll: 20,
                    child: textTitleMedium('Tìm kiếm', color: Colors.white),
                  ),
                ),
              )
            ]),
          ),
        ),
        isScrollControlled: true,
        isDismissible: true,
        elevation: 0,
        backgroundColor: Colors.grey.withOpacity(0));
  }
}
