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
import 'package:quan_ly_ban_hang/modules/details/detail_warehouse_receipt/detail_warehouse_receipt_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_warehouse_receipt/list_warehouse_receipt_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/widgets/empty.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/s_show_chose.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loadding_refreshindicator.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_search.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class ListWarehouseReceiptSreen extends StatefulWidget {
  const ListWarehouseReceiptSreen({super.key});
  static const String routeName = '/list_warehouse_receipt';

  @override
  State<ListWarehouseReceiptSreen> createState() =>
      _ListWarehouseReceiptState();
}

class _ListWarehouseReceiptState extends State<ListWarehouseReceiptSreen> {
  ListWarehouseReceiptController listWarehouseReceiptController = Get.find();
  @override
  Widget build(BuildContext context) {
    return listWarehouseReceiptController.obx(
        (state) => buildBody(
            context: context,
            body: SafeArea(
              // margin: alignment_20_0(),
              // constraints: const BoxConstraints(maxHeight: 750),
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2), () {});
                  await listWarehouseReceiptController
                      .getListWarehouseReceipt();
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
                  child:
                  listWarehouseReceiptController.listWarehouseReceiptResult != null &&
                            listWarehouseReceiptController.listWarehouseReceiptResult!.isEmpty
                        ? emptyWidget(
                            onTap: () async {
                              await listWarehouseReceiptController.getListWarehouseReceipt();
                            },
                          )
                        : ListView.builder(
                    itemCount: listWarehouseReceiptController
                        .listWarehouseReceiptResult?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: itemWarehouseReceipt(
                                warehouseReceipt: listWarehouseReceiptController
                                    .listWarehouseReceiptResult![index],
                                listStatus:
                                    listWarehouseReceiptController.listStatus),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              title: textTitleLarge('Danh sách đơn nhập kho'),
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
                      permission: ['QL', 'NK', 'C_NK', 'AD'])) {
                    Get.toNamed(DetailWarehouseReceiptScreen.routeName,
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
        listWarehouseReceiptController.obx(
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
                        textController:
                            listWarehouseReceiptController.textSearchTE),
                    cHeight(20),
                    InkWell(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textTitleMedium('Khách hàng'),
                            IconButton(
                                onPressed: () {
                                  Get.bottomSheet(listWarehouseReceiptController
                                      .obx((state) => showBottomListChose(
                                            options:
                                                listWarehouseReceiptController
                                                    .listSupplier,
                                            value:
                                                listWarehouseReceiptController
                                                    .supplierItemSelectFilter,
                                            onSelect: (p0) {
                                              if (listWarehouseReceiptController
                                                      .supplierItemSelectFilter ==
                                                  p0) {
                                                listWarehouseReceiptController
                                                        .supplierItemSelectFilter =
                                                    null;
                                              } else {
                                                listWarehouseReceiptController
                                                    .supplierItemSelectFilter = p0;
                                              }
                                              listWarehouseReceiptController
                                                  .updateUI();
                                            },
                                            onSearch: (val) {
                                              ShareFuntion.searchList(
                                                  list:
                                                      listWarehouseReceiptController
                                                          .listSupplier,
                                                  value: val,
                                                  update: () {
                                                    listWarehouseReceiptController
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
                    textBodyMedium(listWarehouseReceiptController
                            .supplierItemSelectFilter?.key ??
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
                        for (Status item in listWarehouseReceiptController
                                .listStatus
                                ?.where((element) =>
                                    element.group == 'trạng thái giao hàng')
                                .toList() ??
                            [])
                          FlexiChip(
                            label: textBodyMedium(item.name ?? '',
                                color: listWarehouseReceiptController
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
                            selected: listWarehouseReceiptController
                                    .listStatusSelectFilter
                                    ?.contains(item) ??
                                false,
                            onSelected: (value) {
                              if (value) {
                                listWarehouseReceiptController
                                    .listStatusSelectFilter
                                    ?.add(item);
                              } else {
                                listWarehouseReceiptController
                                    .listStatusSelectFilter
                                    ?.remove(item);
                              }
                              listWarehouseReceiptController.changeUI();
                            },
                            onDeleted: () {},
                          ),
                      ],
                    ),
                    cHeight(20),
                    textTitleMedium('Trạng thái duyệt'),
                    cHeight(12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (Status item in listWarehouseReceiptController
                                .listStatus
                                ?.where((element) =>
                                    element.group == 'Trạng thái duyệt')
                                .toList() ??
                            [])
                          FlexiChip(
                            label: textBodyMedium(item.name ?? '',
                                color: listWarehouseReceiptController
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
                            selected: listWarehouseReceiptController
                                    .listStatusSelectFilter
                                    ?.contains(item) ??
                                false,
                            onSelected: (value) {
                              if (value) {
                                listWarehouseReceiptController
                                    .listStatusSelectFilter
                                    ?.add(item);
                              } else {
                                listWarehouseReceiptController
                                    .listStatusSelectFilter
                                    ?.remove(item);
                              }
                              listWarehouseReceiptController.changeUI();
                            },
                            onDeleted: () {},
                          ),
                      ],
                    ),
                    cHeight(20),
                  ],
                ),
              )),
              Container(
                margin: alignment_20_8(),
                child: SizedBox(
                  width: double.infinity,
                  child: FxButton.large(
                    onPressed: () async {
                      await listWarehouseReceiptController.searchAndSortList();
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
