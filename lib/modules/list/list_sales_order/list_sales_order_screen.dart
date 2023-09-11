import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/block_bottomsheet.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_bill_of_sale.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
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
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: listSalesOrderController.listSalesOrder?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: itemBillOfSale(
                                salesOrder: listSalesOrderController
                                    .listSalesOrder![index],
                                listStatus:
                                    listSalesOrderController.listStatus),
                          ),
                        ),
                      );
                    },
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
                      Get.bottomSheet(
                          showBottomSheetFilter(
                              widgetBottom: _widgetBottom(),
                              child: _widgetChild()),
                          isScrollControlled: true,
                          isDismissible: true,
                          elevation: 0,
                          backgroundColor: Colors.grey.withOpacity(0));
                    },
                  )
                ],
              ),
            ),
        onLoading: const LoadingCustom());
  }

  _widgetBottom() {
    return Container(
      margin: alignment_20_8(),
      child: FxButton.block(
        onPressed: () {},
        borderRadiusAll: 20,
        child: textTitleMedium('Tìm kiếm', color: Colors.white),
      ),
    );
  }

  _widgetChild() {
    return Container(
      margin: alignment_20_0(),
      child: Column(
        children: [
          cHeight(20),
          textSearch(
              onTapSearch: () {}, textController: TextEditingController()),
        ],
      ),
    );
  }
}
