import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/data_tools.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/list_tools_controller.dart';
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
  ListToolsController listToolsController = Get.find();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: SafeArea(
        // margin: alignment_20_0(),
        // constraints: const BoxConstraints(maxHeight: 750),
        child: Column(
          children: [
            Container(
              margin: alignment_20_0(),
              padding: const EdgeInsets.only(bottom: 12),
              child: textSearch(
                  focusNode: _focus,
                  onChange: (value){
                     listToolsController
                        .onSearch(listToolsController.textSearchTE.text);
                  },
                  onTapSearch: () {
                    listToolsController
                        .onSearch(listToolsController.textSearchTE.text);
                  },
                  textController: listToolsController.textSearchTE),
            ),
            Expanded(
                child: listToolsController.obx(
              (state) => Container(
                padding: alignment_20_0(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (listToolsController.textSearchTE.text != "" ) ...[
                        textBodyMedium(
                            'Kết quả tìm kiếm: ${listToolsController.textSearchTE.text}',
                            color: Colors.grey),
                        _listData(
                            listDataToolResult:
                                listToolsController.listDataToolResultSearch),
                        cHeight(20),
                      ],
                      textBodyMedium('Bán hàng', color: Colors.grey),
                      _listData(
                          listDataToolResult:
                              listToolsController.listDataToolResult1),
                      cHeight(20),
                      textBodyMedium('Nhập kho', color: Colors.grey),
                      _listData(
                          listDataToolResult:
                              listToolsController.listDataToolResult2),
                      cHeight(20),
                      textBodyMedium('Người dùng', color: Colors.grey),
                      _listData(
                          listDataToolResult:
                              listToolsController.listDataToolResult3),
                      cHeight(20),
                      textBodyMedium('Sản phẩm', color: Colors.grey),
                      _listData(
                          listDataToolResult:
                              listToolsController.listDataToolResult4),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
      appBar: AppBar(
        title: textTitleLarge('Danh sách tính năng'),
        surfaceTintColor: bg500,
        backgroundColor: bg500,
        actions: const [
          // IconButton(
          //   icon: const Icon(LucideIcons.filter),
          //   onPressed: () {
          //     showBottomSheetFilter();
          //   },
          // )
        ],
      ),
    );
  }

  _listData({List<DataTool>? listDataToolResult}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 20),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: AnimationLimiter(
        child: GridView.builder(
          itemCount: listDataToolResult?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: itemTool(
                    dataTool: listDataToolResult?[index],
                    textColor: Colors.black,
                    isTextSmall: false,
                    // iconColor: Colors.white,
                  ),
                ),
              ),
            );
          },
          padding: const EdgeInsets.only(top: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
        ),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    cHeight(20),
                    textSearch(
                        onTapSearch: () {},
                        textController: TextEditingController()),
                  ],
                ),
              ),
            )),
            Container(
              margin: alignment_20_8(),
              child: FxButton.block(
                onPressed: () {},
                borderRadiusAll: 20,
                child: textTitleMedium('Tìm kiếm', color: Colors.white),
              ),
            )
          ]),
        ),
        isScrollControlled: true,
        isDismissible: true,
        ignoreSafeArea: true,
        elevation: 0,
        backgroundColor: Colors.grey.withOpacity(0));
  }
}
