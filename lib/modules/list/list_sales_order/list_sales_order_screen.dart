import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/block_bottomsheet.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_bill_of_sale.dart';
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
  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: SafeArea(
          // margin: alignment_20_0(),
          // constraints: const BoxConstraints(maxHeight: 750),
          child: LiveList(
        // delay: Duration(milliseconds: 100),
        // showItemInterval: Duration(milliseconds: 500),
        showItemDuration: const Duration(milliseconds: 300),
        shrinkWrap: true,
        itemCount: 20,
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
                child: itemBillOfSale()),
          );
        },
        // ... and all other arguments from `LiveOptions` (see above)
      )

          // child: ListView.builder(
          //     itemCount: 20,
          //     shrinkWrap: true,
          //     // physics: const NeverScrollableScrollPhysics(),
          //     padding: const EdgeInsets.only(top: 12),
          //     itemBuilder: (context, indext) {
          //       return itemBillOfSale();
          //     }),
          ),
      appBar: AppBar(
        title: textTitleLarge( 'Danh sách đơn hàng'),
        surfaceTintColor: bg500,
        backgroundColor: bg500,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.filter),
            onPressed: () {
              Get.bottomSheet(
                  showBottomSheetFilter(
                      widgetBottom: _widgetBottom(), child: _widgetChild()),
                  isScrollControlled: true,
                  isDismissible: true,
                  elevation: 0,
                  backgroundColor: Colors.grey.withOpacity(0));
            },
          )
        ],
      ),
    );
  }

  _widgetBottom() {
    return Container(
      margin: alignment_20_8(),
      child: FxButton.block(
        onPressed: () {},
        borderRadiusAll: 20,
        child: textTitleMedium( 'Tìm kiếm', color: Colors.white),
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
