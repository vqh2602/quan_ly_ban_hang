import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/library/dragghome/draggable_home.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/share_function/share_funciton.dart';
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
        (state) => DraggableHome(
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
                            icon: const Icon(
                              FontAwesomeIcons.lightBars,
                              color: Colors.white,
                            ),
                          ),
                          textTitleMedium(
                              text: 'Trang chủ', color: Colors.white),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              LucideIcons.user,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))),

              expandedHeight: Get.height * 0.58,
              // actions: [
              //   IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
              // ],
              headerWidget: _headerWidget(context),
              // headerBottomBar: headerBottomBarWidget(),
              body: [
                cHeight(8),
                Container(
                  margin: alignment_20_0(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textTitleLarge(
                        text: 'Đơn hàng bán',
                        color: Colors.black,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.ellipsis,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, indext) {
                        return Container(
                          decoration: BoxDecoration(),
                        );
                      }),
                ),
                cHeight(800),
                textBodyLarge(text: 'dsjfh ')
              ],
              // headerExpandedHeight: 0.3,
              fullyStretchable: false,
              // expandedBody: Container(color: Colors.amber),
              backgroundColor: Get.theme.colorScheme.background,
              appBarColor: Get.theme.primaryColor,
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
              blockStatistical(
                  title: 'Doanh số',
                  date: 'tháng 8/2023',
                  value: '180000000',
                  color: a500,
                  onTap: () {}),
              blockStatistical(
                  title: 'Lợi nhuận',
                  date: 'tháng 8/2023',
                  value: '15000000',
                  color: b500,
                  onTap: () {}),
              cHeight(12),
              Container(
                margin: alignment_20_0(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textTitleLarge(
                      text: 'Tiện ích',
                      color: Colors.white,
                    ),
                    IconButton(
                        onPressed: () {},
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
                    InkWell(
                      child: SizedBox(
                        width: 70,
                        child: Column(children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Icon(
                              FontAwesomeIcons.ballotCheck,
                              color: b500,
                            ),
                          ),
                          cHeight(4),
                          textBodySmall(
                            text: 'tạo hoá đơn bán',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                          )
                        ]),
                      ),
                    )
                  ]
                ],
              )
            ],
          ),
        ));
  }

  Widget blockStatistical(
      {required String title,
      required String date,
      required String value,
      required Color color,
      required Function onTap}) {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 5, color: color),
                borderRadius: BorderRadius.circular(100)),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textTitleMedium(text: '18', fontWeight: FontWeight.w900),
                    textTitleSmall(text: 'N', fontWeight: FontWeight.w900),
                  ],
                ),
              ),
            ),
          ),
          cWidth(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textTitleSmall(text: title),
                    textBodySmall(text: date, color: Colors.grey),
                  ],
                ),
                textTitleMedium(text: formatCurrency(num.parse(value)))
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                onTap();
              },
              icon: const Icon(LucideIcons.moreHorizontal, color: Colors.black))
        ],
      ),
    );
  }
}
