import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/widgets/empty.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_iteam_personnel.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loadding_refreshindicator.dart';
import 'package:quan_ly_ban_hang/widgets/shimmer/loading/loding_list.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_search.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class ListPersonnelSreen extends StatefulWidget {
  const ListPersonnelSreen({super.key});
  static const String routeName = '/list_personnel';

  @override
  State<ListPersonnelSreen> createState() => _ListPersonnelState();
}

class _ListPersonnelState extends State<ListPersonnelSreen> {
  ListPersonnelController listPersonnelController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
        context: context,
        body: listPersonnelController.obx(
            (state) => CustomRefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2), () {});
                    await listPersonnelController.getListPersonnels();
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
                    child: listPersonnelController.listPersonnelResult !=
                                null &&
                            listPersonnelController.listPersonnelResult!.isEmpty
                        ? emptyWidget(
                            onTap: () async {
                              await listPersonnelController.getListPersonnels();
                            },
                          )
                        : ListView.builder(
                            itemCount: listPersonnelController
                                    .listPersonnelResult?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: itemPersonnel(
                                      personnel: listPersonnelController
                                          .listPersonnelResult?[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
            onLoading: const LoadingList()),
        appBar: AppBar(
          title: textTitleLarge('Danh sách nhân viên'),
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
              if (ShareFuntion()
                  .checkPermissionUserLogin(permission: ['QL', 'C_NV', 'AD'])) {
                Get.toNamed(AccountDetailScreen.routeName,
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
        listPersonnelController.obx(
          (state) => Container(
            height: Get.height * 0.5,
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
                        textController: listPersonnelController.textSearchTE),
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
                      await listPersonnelController.searchAndSortList();
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
