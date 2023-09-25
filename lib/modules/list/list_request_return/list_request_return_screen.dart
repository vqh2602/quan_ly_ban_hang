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
import 'package:quan_ly_ban_hang/modules/details/detail_request_return/detail_request_return_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_request_return/list_request_return_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/widgets/empty.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_request_return.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/s_show_chose.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loadding_refreshindicator.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_search.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class ListRequestReturnSreen extends StatefulWidget {
  const ListRequestReturnSreen({super.key});
  static const String routeName = '/list_request_return';

  @override
  State<ListRequestReturnSreen> createState() => _ListRequestReturnState();
}

class _ListRequestReturnState extends State<ListRequestReturnSreen> {
  ListRequestReturnController listRequestReturnController = Get.find();
  @override
  Widget build(BuildContext context) {
    return listRequestReturnController.obx(
        (state) => buildBody(
            context: context,
            body: SafeArea(
              // margin: alignment_20_0(),
              // constraints: const BoxConstraints(maxHeight: 750),
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2), () {});
                  await listRequestReturnController.getListRequestReturn();
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
                  child: listRequestReturnController.listRequestReturnResult !=
                              null &&
                          listRequestReturnController
                              .listRequestReturnResult!.isEmpty
                      ? emptyWidget(
                          onTap: () async {
                            await listRequestReturnController
                                .getListRequestReturn();
                          },
                        )
                      : ListView.builder(
                          itemCount: listRequestReturnController
                              .listRequestReturnResult?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: itemRequestReturn(
                                      requestReturn: listRequestReturnController
                                          .listRequestReturnResult![index],
                                      listStatus: listRequestReturnController
                                          .listStatus),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
            appBar: AppBar(
              title: textTitleLarge('Danh sách yêu cầu dổi trả'),
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
                      permission: ['QL', 'NK', 'C_YC', 'AD'])) {
                    Get.toNamed(DetailRequestReturnScreen.routeName,
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
        listRequestReturnController.obx(
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
                            listRequestReturnController.textSearchTE),
                    cHeight(20),
                    InkWell(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textTitleMedium('Nhà cung cấp'),
                            IconButton(
                                onPressed: () {
                                  Get.bottomSheet(listRequestReturnController
                                      .obx((state) => showBottomListChose(
                                            options: listRequestReturnController
                                                .listSupplier,
                                            value: listRequestReturnController
                                                .supplierItemSelectFilter,
                                            onSelect: (p0) {
                                              if (listRequestReturnController
                                                      .supplierItemSelectFilter ==
                                                  p0) {
                                                listRequestReturnController
                                                        .supplierItemSelectFilter =
                                                    null;
                                              } else {
                                                listRequestReturnController
                                                    .supplierItemSelectFilter = p0;
                                              }
                                              listRequestReturnController
                                                  .updateUI();
                                            },
                                            onSearch: (val) {
                                              ShareFuntion.searchList(
                                                  list:
                                                      listRequestReturnController
                                                          .listSupplier,
                                                  value: val,
                                                  update: () {
                                                    listRequestReturnController
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
                    textBodyMedium(listRequestReturnController
                            .supplierItemSelectFilter?.key ??
                        'Trống'),
                    cHeight(20),
                    textTitleMedium('Trạng thái nhà cung cấp'),
                    cHeight(12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (Status item in listRequestReturnController
                                .listStatus
                                ?.where((element) =>
                                    element.group == 'Trạng thái ncc')
                                .toList() ??
                            [])
                          FlexiChip(
                            label: textBodyMedium(item.name ?? '',
                                color: listRequestReturnController
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
                            selected: listRequestReturnController
                                    .listStatusSelectFilter
                                    ?.contains(item) ??
                                false,
                            onSelected: (value) {
                              if (value) {
                                listRequestReturnController
                                    .listStatusSelectFilter
                                    ?.add(item);
                              } else {
                                listRequestReturnController
                                    .listStatusSelectFilter
                                    ?.remove(item);
                              }
                              listRequestReturnController.changeUI();
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
                        for (Status item in listRequestReturnController
                                .listStatus
                                ?.where((element) =>
                                    element.group == 'Trạng thái duyệt')
                                .toList() ??
                            [])
                          FlexiChip(
                            label: textBodyMedium(item.name ?? '',
                                color: listRequestReturnController
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
                            selected: listRequestReturnController
                                    .listStatusSelectFilter
                                    ?.contains(item) ??
                                false,
                            onSelected: (value) {
                              if (value) {
                                listRequestReturnController
                                    .listStatusSelectFilter
                                    ?.add(item);
                              } else {
                                listRequestReturnController
                                    .listStatusSelectFilter
                                    ?.remove(item);
                              }
                              listRequestReturnController.changeUI();
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
                      await listRequestReturnController.searchAndSortList();
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
