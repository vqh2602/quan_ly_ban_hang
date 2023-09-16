import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/statistical/statistical_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/widgets/chart/bar_chart_sample6.dart';
import 'package:quan_ly_ban_hang/widgets/chart/barchart1.dart';
import 'package:quan_ly_ban_hang/widgets/chart/line_chart_sample2.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/block_statistical.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({Key? key}) : super(key: key);
  static const String routeName = '/statistical';

  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen>
    with TickerProviderStateMixin {
  StatisticalController statisticalController = Get.find();
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return statisticalController.obx(
        (state) => buildBody(
              // backgroundColor: Colors.white,
              context: context,
              body: _buildBody(),
              appBar: AppBar(
                title: textTitleLarge('Thống kê'),
                centerTitle: false,
                surfaceTintColor: bg500,
                backgroundColor: bg500,
                actions: [
                  InkWell(
                    onTap: () {
                      ShareFuntion.dateTimePicker(
                        onchange: (date) {
                          statisticalController.date = date;
                          statisticalController.update();
                        },
                      );
                    },
                    child: textBodyMedium(
                      'T${statisticalController.date.month} ${statisticalController.date.year}',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.sparkles),
                    onPressed: () async {
                      await statisticalController.getListOderByFilter();
                      setState(() {
                        
                      });
                    },
                  )
                ],
              ),
            ),
        onLoading: const LoadingCustom());
  }

  Widget _buildBody() {
    return statisticalController.obx((state) => SafeArea(
          child: Container(
            color: bg500,
            margin: alignment_20_0(),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: bg700,
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            tabController.animateTo(0);
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: tabController.index == 0
                                    ? Colors.white
                                    : Colors.transparent),
                            child: textBodyMedium('Chi tiết',
                                color: tabController.index == 0
                                    ? Colors.black
                                    : Colors.grey,
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                      cWidth(20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            tabController.animateTo(1);
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: tabController.index == 1
                                    ? Colors.white
                                    : Colors.transparent),
                            child: textBodyMedium('Thống kê',
                                color: tabController.index == 1
                                    ? Colors.black
                                    : Colors.grey,
                                textAlign: TextAlign.center),
                          ),
                        ),
                      )
                    ]),
              ),
              cHeight(20),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [_tabDetail(), _tabChart()],
              ))
            ]),
          ),
        ));
  }

  Widget _tabDetail() {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          blockStatistical(
              title: 'Doanh số',
              date:
                  'tháng ${statisticalController.date.month}/${statisticalController.date.year}',
              value: statisticalController.calculateTotalRevenue().toString(),
              color: a500,
              margin: EdgeInsets.zero,
              padding:
                  const EdgeInsets.only(top: 8, right: 8, left: 20, bottom: 8),
              height: 90,
              icon: Icon(FontAwesomeIcons.sackDollar, color: a500),
              onTap: () {}),
          cHeight(20),
          blockStatistical(
              title: 'Lợi nhuận',
              date:
                  'tháng ${statisticalController.date.month}/${statisticalController.date.year}',
              value: statisticalController.calculateTotalProfit().toString(),
              color: b500,
              margin: EdgeInsets.zero,
              padding:
                  const EdgeInsets.only(top: 8, right: 8, left: 20, bottom: 8),
              height: 90,
              icon: Icon(FontAwesomeIcons.moneyBill, color: b500),
              onTap: () {}),
          cHeight(20),
          blockStatistical(
              title: 'Tổng số đơn hàng',
              date:
                  'tháng ${statisticalController.date.month}/${statisticalController.date.year}',
              value:
                  '${statisticalController.listSalesOrder?.length.toString() ?? '0'} đơn',
              color: a500,
              margin: EdgeInsets.zero,
              isFormatCurrency: false,
              padding:
                  const EdgeInsets.only(top: 8, right: 8, left: 20, bottom: 8),
              height: 90,
              icon: Icon(FontAwesomeIcons.receipt, color: a500),
              onTap: () {}),
          cHeight(20),
          blockStatistical(
              title: 'Số lượng sản phẩm đã bán',
              date: 'tháng 8/2023',
              value: '15000000',
              color: b500,
              margin: EdgeInsets.zero,
              padding:
                  const EdgeInsets.only(top: 8, right: 8, left: 20, bottom: 8),
              height: 90,
              icon: Icon(FontAwesomeIcons.boxOpen, color: b500),
              onTap: () {}),
          cHeight(20),
          blockStatistical(
              title: 'Tiền nhập hàng',
              date: 'tháng 8/2023',
              value: '15000000',
              color: a500,
              margin: EdgeInsets.zero,
              padding:
                  const EdgeInsets.only(top: 8, right: 8, left: 20, bottom: 8),
              height: 90,
              icon: Icon(FontAwesomeIcons.truckRampBox, color: a500),
              onTap: () {}),
          cHeight(20),
          blockStatistical(
              title: 'Tiền hoàn trả hàng',
              date: 'tháng 8/2023',
              value: '15000000',
              color: b500,
              margin: EdgeInsets.zero,
              padding:
                  const EdgeInsets.only(top: 8, right: 8, left: 20, bottom: 8),
              height: 90,
              icon: Icon(FontAwesomeIcons.handHoldingBox, color: b500),
              onTap: () {}),
          cHeight(20),
          blockStatistical(
              title: 'Tỷ lệ thành công',
              date: 'tháng 8/2023',
              value: '15000000',
              color: a500,
              margin: EdgeInsets.zero,
              padding:
                  const EdgeInsets.only(top: 8, right: 8, left: 20, bottom: 8),
              height: 90,
              icon: Icon(FontAwesomeIcons.boxCheck, color: a500),
              onTap: () {}),
          cHeight(50)
        ]),
      ),
    );
  }

  Widget _tabChart() {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textTitleMedium('Biểu đồ doanh thu, lợi nhuận'),
        BarChartSample2(data: [
          makeGroupData(
              0,
              statisticalController.calculateTotalRevenue(type: 1) / 1000000,
              statisticalController.calculateTotalProfit(type: 1) / 1000000),
          makeGroupData(
              1,
              statisticalController.calculateTotalRevenue(type: 2) / 1000000,
              statisticalController.calculateTotalProfit(type: 2) / 1000000),
          makeGroupData(
              2,
              statisticalController.calculateTotalRevenue(type: 3) / 1000000,
              statisticalController.calculateTotalProfit(type: 3) / 1000000),
          makeGroupData(
              3,
              statisticalController.calculateTotalRevenue(type: 4) / 1000000,
              statisticalController.calculateTotalProfit(type: 4) / 1000000),
        ]),
        textTitleMedium('Biểu đồ tăng trưởng đơn hàng'),
        const LineChartSample2(),
        textTitleMedium('Biểu đồ tỷ lệ thành công'),
        const BarChartSample3()
      ])),
    );
  }
}
