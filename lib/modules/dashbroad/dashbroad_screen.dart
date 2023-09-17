
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_controller.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/data_tools.dart';
import 'package:quan_ly_ban_hang/modules/list/list_tools/list_tools_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_warehouse_receipt/list_warehouse_receipt_controller.dart';
import 'package:quan_ly_ban_hang/modules/list/list_warehouse_receipt/list_warehouse_receipt_screen.dart';
import 'package:quan_ly_ban_hang/modules/statistical/statistical_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/block_bottomsheet.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/block_statistical.dart';
import 'package:quan_ly_ban_hang/widgets/hide_widget.dart';
import 'package:quan_ly_ban_hang/widgets/library/dragghome/draggable_home.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_bill_of_sale.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_product.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_tool.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class DashBroadScreen extends StatefulWidget {
  const DashBroadScreen({Key? key}) : super(key: key);
  static const String routeName = '/DashBroad';

  @override
  State<DashBroadScreen> createState() => _DashBroadScreenState();
}

class _DashBroadScreenState extends State<DashBroadScreen> {
  DashBroadController dashBroadController = Get.find();
  ListProductController listProductController = Get.find();
  ListSalesOrderController listSalesOrderController = Get.find();
  ListWarehouseReceiptController listWarehouseReceiptController = Get.find();
  AccountDetailController accountController = Get.find();
  StatisticalController statisticalController = Get.find();
  bool showHeader = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return dashBroadController.obx(
        (state) => RefreshIndicator(
              onRefresh: () async {},
              child: DraggableHome(
                // leading: const Icon(Icons.arrow_back_ios),
                centerTitle: true,
                title: Center(
                    child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Badge(
                                textColor: Colors.white,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.bell,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            textTitleMedium('Trang chủ', color: Colors.white),
                            IconButton(
                              onPressed: () async {
                                // Get.toNamed(AccountDetailScreen.routeName,
                                //     arguments: {'type': 'user'});
                                await accountController.getDataUser();
                                Get.bottomSheet(
                                    showBottomSheetFilter(
                                        child: const AccountDetailScreen(
                                          isEdit: false,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    elevation: 0,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0));
                              },
                              icon: const Icon(
                                LucideIcons.user,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ))),

                expandedHeight: 460,
                // actions: [
                //   IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
                // ],
                headerWidget: _headerWidget(context),
                // headerBottomBar: headerBottomBarWidget(),
                body: [
                  cHeight(8),
                  if (ShareFuntion().checkPermissionUserLogin(
                      permission: ['QL', 'BH', 'AD'])) ...[
                    Container(
                      margin: alignment_20_0(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textTitleLarge(
                            'Đơn hàng bán',
                            color: Colors.black,
                          ),
                          IconButton(
                              onPressed: () {
                                Get.toNamed(ListSalesOrderSreen.routeName);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.ellipsis,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ),
                    listSalesOrderController.obx(
                      (state) => Container(
                        // margin: alignment_20_0(),
                        constraints: const BoxConstraints(maxHeight: 460),
                        child: ListView.builder(
                            itemCount: (listSalesOrderController
                                            .listSalesOrder?.length ??
                                        0) >
                                    5
                                ? 5
                                : listSalesOrderController
                                    .listSalesOrder?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 12),
                            itemBuilder: (context, indext) {
                              return itemBillOfSale(
                                  listStatus:
                                      listSalesOrderController.listStatus,
                                  salesOrder: listSalesOrderController
                                      .listSalesOrder![indext]);
                            }),
                      ),
                    ),
                  ],
                  if (ShareFuntion().checkPermissionUserLogin(
                      permission: ['QL', 'NK', 'AD'])) ...[
                    Container(
                      margin: alignment_20_0(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textTitleLarge(
                            'Đơn nhập kho',
                            color: Colors.black,
                          ),
                          IconButton(
                              onPressed: () {
                                Get.toNamed(
                                    ListWarehouseReceiptSreen.routeName);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.ellipsis,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ),
                    listWarehouseReceiptController.obx(
                      (state) => Container(
                        // margin: alignment_20_0(),
                        constraints: const BoxConstraints(maxHeight: 460),
                        child: ListView.builder(
                            itemCount: (listWarehouseReceiptController
                                            .listWarehouseReceipt?.length ??
                                        0) >
                                    5
                                ? 5
                                : listWarehouseReceiptController
                                    .listWarehouseReceipt?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 12),
                            itemBuilder: (context, indext) {
                              return itemWarehouseReceipt(
                                  listStatus:
                                      listWarehouseReceiptController.listStatus,
                                  warehouseReceipt:
                                      listWarehouseReceiptController
                                          .listWarehouseReceipt![indext]);
                            }),
                      ),
                    ),
                  ],
                  Container(
                    margin: alignment_20_0(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textTitleLarge(
                          'Sản phẩm bán chạy',
                          color: Colors.black,
                        ),
                        IconButton(
                            onPressed: () {
                              Get.toNamed(ListProductSreen.routeName);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.ellipsis,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                  listProductController.obx(
                    (state) => Container(
                      // margin: alignment_20_0(),
                      constraints: const BoxConstraints(maxHeight: 760),
                      child: ListView.builder(
                          itemCount:
                              listProductController.listProduct?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 12),
                          itemBuilder: (context, indext) {
                            return itemProduct(
                                product:
                                    listProductController.listProduct?[indext],
                                listUnit: listProductController.listUnit);
                          }),
                    ),
                  ),
                  cHeight(100)
                ],
                // headerExpandedHeight: 0.3,
                fullyStretchable: false,
                // expandedBody: Container(color: Colors.amber),
                backgroundColor: bg500,
                appBarColor: Get.theme.primaryColor,
              ),
            ),
        onLoading: const LoadingCustom());
  }

  Widget _headerWidget(BuildContext context) {
    return Container(
        color: Get.theme.primaryColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cHeight(kTextTabBarHeight),
              Stack(
                children: [
                  statisticalController.obx(
                    (state) => Column(
                      children: [
                        blockStatistical(
                            title: 'Doanh số',
                            date:
                                'tháng ${statisticalController.date.month}/${statisticalController.date.year}',
                            value: statisticalController
                                .calculateTotalRevenue(
                                    listData: statisticalController
                                        .listSalesOrderHome)
                                .toString(),
                            color: a500,
                            onTap: () {}),
                        blockStatistical(
                            title: 'Lợi nhuận',
                            date:
                                'tháng ${statisticalController.date.month}/${statisticalController.date.year}',
                            value: statisticalController
                                .calculateTotalProfit(
                                    listData: statisticalController
                                        .listSalesOrderHome)
                                .toString(),
                            color: b500,
                            onTap: () {}),
                      ],
                    ),
                  ),
                  Padding(
                      padding: alignment_20_0(),
                      child:
                          hideWidget(permission: ['QL', 'ADMIN', 'TK', 'AD']))
                ],
              ),
              cHeight(12),
              Container(
                margin: alignment_20_0(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textTitleLarge(
                      'Tiện ích',
                      color: Colors.white,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.toNamed(ListToolsSreen.routeName);
                        },
                        icon: const Icon(
                          FontAwesomeIcons.lightEllipsisStroke,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              cHeight(12),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.start,
                children: [
                  for (int i = 0; i < 4; i++) ...[
                    itemTool(
                        dataTool: listDataTools[i],
                        clearBackgroundColor: Colors.white)
                  ]
                ],
              )
            ],
          ),
        ));
  }
}
