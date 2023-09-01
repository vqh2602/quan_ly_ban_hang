import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_tool.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_search.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class ListToolsSreen extends StatefulWidget {
  const ListToolsSreen({super.key});
  static const String routeName = '/list_tools';

  @override
  State<ListToolsSreen> createState() => _ListToolsState();
}

class _ListToolsState extends State<ListToolsSreen> {
  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: SafeArea(
        // margin: alignment_20_0(),
        // constraints: const BoxConstraints(maxHeight: 750),
        child: LiveGrid(
          padding: const EdgeInsets.all(16),
          showItemInterval: const Duration(milliseconds: 50),
          showItemDuration: const Duration(milliseconds: 150),
          visibleFraction: 0.001,
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: itemTool(
                      textColor: Colors.black,
                      isTextSmall: false,
                      // iconColor: Colors.white,
                      )),
            );
          },
        ),
      ),
      appBar: AppBar(
        title: textTitleLarge( 'Danh sách tính năng'),
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
    );
  }

  showBottomSheetFilter() {
    Get.bottomSheet(
        Container(
          height: Get.height * 0.8,
          decoration: BoxDecoration(
              color: bg500,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100), topRight: Radius.circular(0))),
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
                children: [
                  cHeight(20),
                  textSearch(
                      onTapSearch: () {},
                      textController: TextEditingController()),
                ],
              ),
            )),
            Container(
              margin: alignment_20_8(),
              child: FxButton.block(
                onPressed: () {},
                borderRadiusAll: 20,
                child: textTitleMedium( 'Tìm kiếm', color: Colors.white),
              ),
            )
          ]),
        ),
        isScrollControlled: true,
        isDismissible: true,
        elevation: 0,
        backgroundColor: Colors.grey.withOpacity(0));
  }
}