
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_controller.dart';
import 'package:quan_ly_ban_hang/modules/home/home_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/bottom_nav_bar.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();
  AccountDetailController accountController = Get.find();

  @override
  void initState() {
    homeController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return homeController.obx(
        (state) => buildBody(
              context: context,
              body: _buildBody(),
              bottomNavigationBar: bottomNavigationBar(
                  onSelect: (index) => setState(() {
                        homeController.selectItemScreen = index;

                        /// control your animation using page controller
                        homeController.pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        if (index == 2) {
                          accountController.getDataUser();
                        }
                        homeController.updateUI();
                      }),
                  // pageController: homeController.pageController,
                  selectedIndex: homeController.selectItemScreen),
              appBar: null,
            ),
        onLoading: const LoadingCustom());
  }

  Widget _buildBody() {
    return PageView(
      controller: homeController.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children:
          List.generate(widgetOptions.length, (index) => widgetOptions[index]),
    );

    //widgetOptions.elementAt(homeController.selectItemScreen);
  }
}
