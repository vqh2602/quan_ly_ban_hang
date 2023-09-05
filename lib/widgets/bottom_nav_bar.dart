// import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_screen.dart';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/modules/qr_scan/qr_screen.dart';
import 'package:quan_ly_ban_hang/widgets/library/flashy_tab_bar2.dart';

// Widget bottomNavigationBar(
//     {int selectedIndex = 0,
//     required Function(int) onSelect,
//     required PageController pageController}) {
//   return BottomBarLabelSlide(
//       selectedIndex: selectedIndex,
//       color: Get.theme.primaryColor,
//       items: [
//         BottomBarItem(iconData: LucideIcons.home, label: 'Trang chủ'),
//         BottomBarItem(iconData: LucideIcons.scanLine, label: 'Kiểm kê'),
//         BottomBarItem(iconData: LucideIcons.pieChart, label: 'Thống kê'),
//         BottomBarItem(iconData: LucideIcons.settings, label: 'Thiết đặt'),
//       ],
//       onSelect: onSelect);
// }

// List<Widget> widgetOptions = <Widget>[
//   const DashBroadScreen(),
//   const QrScan(),
//   Container(
//     color: Colors.red,
//   ),
//  const AccountDetailScreen()

// ];

Widget bottomNavigationBar(
    {int selectedIndex = 0, required Function(int) onSelect}) {
  return FlashyTabBar(
    selectedIndex: selectedIndex,
    showElevation: true,
    animationCurve: Curves.elasticInOut,
    animationDuration: const Duration(milliseconds: 700),
    iconSize: 24,
    backgroundColor: Get.theme.colorScheme.background,
    onItemSelected: onSelect,
    items: items,
  );
}

List<FlashyTabBarItem> items = [
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.home),
    title: const Text('Trang chủ'),
    inactiveColor: Colors.grey,
    activeColor: a500,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.scanLine),
    title: const Text('Kiểm kê'),
    inactiveColor: Colors.grey,
    activeColor: a500,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.barChart2),
    title: const Text('Thống kê'),
    inactiveColor: Colors.grey,
    activeColor: a500,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.settings),
    title: const Text('Thiết đặt'),
    inactiveColor: Colors.grey,
    activeColor: a500,
  ),
];

List<Widget> widgetOptions = <Widget>[
  const DashBroadScreen(),
  const QrScan(),
  Container(
    color: Colors.red,
  ),
  const AccountDetailScreen()
];
