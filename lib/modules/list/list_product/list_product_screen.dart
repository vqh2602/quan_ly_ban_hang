import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flexi_chip/flexi_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/data/models/category.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/widgets/empty.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_product.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loadding_refreshindicator.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loding_list.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_search.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class ListProductSreen extends StatefulWidget {
  const ListProductSreen({super.key});
  static const String routeName = '/list_product';

  @override
  State<ListProductSreen> createState() => _ListProductState();
}

class _ListProductState extends State<ListProductSreen> {
  ListProductController listProductController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
        context: context,
        body: listProductController.obx(
            (state) => CustomRefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2), () {});
                    await listProductController.getListProducts();
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
                    child: listProductController.listProductResult != null &&
                            listProductController.listProductResult!.isEmpty
                        ? emptyWidget(
                            onTap: () async {
                              await listProductController.getListProducts();
                            },
                          )
                        : ListView.builder(
                            itemCount: listProductController
                                    .listProductResult?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: itemProduct(
                                        product: listProductController
                                            .listProductResult?[index],
                                        listUnit:
                                            listProductController.listUnit),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
            onLoading: const LoadingList()),
        appBar: AppBar(
          title: textTitleLarge('Danh sách sản phẩm'),
          centerTitle: false,
          surfaceTintColor: bg500,
          backgroundColor: bg500,
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.filter),
              onPressed: () {
                showBottomSheetFilter();
              },
            )
          ],
        ),
        createFloatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (ShareFuntion().checkPermissionUserLogin(
                  permission: ['QL', 'NK', 'C_SP', 'AD'])) {
                Get.toNamed(DetailProductSreen.routeName,
                    arguments: {'type': 'create'});
              } else {
                buildToast(
                    message: 'Không có quyền xem thông tin',
                    status: TypeToast.toastError);
              }
            },
            label:
                const Icon(FontAwesomeIcons.solidRectangleHistoryCirclePlus)));
  }

  showBottomSheetFilter() {
    Get.bottomSheet(
        listProductController.obx(
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
                        textController: listProductController.textSearchTE),
                    cHeight(20),
                    textTitleMedium('Danh mục'),
                    cHeight(12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (Category item
                            in listProductController.listCategory ?? [])
                          FlexiChip(
                            label: textBodyMedium(item.name ?? '',
                                color: listProductController
                                            .listCategorySelectFilter
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
                            selected: listProductController
                                    .listCategorySelectFilter
                                    ?.contains(item) ??
                                false,
                            onSelected: (value) {
                              if (value) {
                                listProductController.listCategorySelectFilter
                                    ?.add(item);
                              } else {
                                listProductController.listCategorySelectFilter
                                    ?.remove(item);
                              }
                              listProductController.changeUI();
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
                        textTitleMedium('Sắp xếp theo số lượng'),
                        Switch(
                          // This bool value toggles the switch.
                          value: listProductController.sortQuantity,
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
                            listProductController.sortQuantity = value;
                            listProductController.sortSalse = false;
                            listProductController.sortPrice = false;
                            listProductController.changeUI();
                          },
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textTitleMedium('Sắp xếp theo giá'),
                        Switch(
                          // This bool value toggles the switch.
                          value: listProductController.sortPrice,
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
                            listProductController.sortPrice = value;
                            listProductController.sortSalse = false;
                            listProductController.sortQuantity = false;
                            listProductController.changeUI();
                          },
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textTitleMedium('Sắp xếp theo lượt bán'),
                        Switch(
                          // This bool value toggles the switch.
                          value: listProductController.sortSalse,
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
                            listProductController.sortSalse = value;
                            listProductController.sortPrice = false;
                            listProductController.sortQuantity = false;
                            listProductController.changeUI();
                          },
                        )
                      ],
                    )
                  ],
                ),
              )),
              Container(
                margin: alignment_20_8(),
                child: SizedBox(
                  width: double.infinity,
                  child: FxButton.large(
                    onPressed: () async {
                      await listProductController.searchAndSortList();
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
