import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/modules/dashbroad/dashbroad_screen.dart';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/modules/qr_scan/qr_screen.dart';

Widget bottomNavigationBar(
    {int selectedIndex = 0,
    required Function(int) onSelect,
    required PageController pageController}) {
  return BottomBarLabelSlide(
      selectedIndex: selectedIndex,
      color: Get.theme.primaryColor,
      items: [
        BottomBarItem(iconData: LucideIcons.home, label: 'Trang chủ'),
        BottomBarItem(iconData: LucideIcons.scanLine, label: 'Kiểm kê'),
        BottomBarItem(iconData: LucideIcons.pieChart, label: 'Thống kê'),
        BottomBarItem(iconData: LucideIcons.settings, label: 'Thiết đặt'),
      ],
      onSelect: onSelect);
}

List<Widget> widgetOptions = <Widget>[
  const DashBroadScreen(),
  const QrScan(),
  Container(
    color: Colors.red,
  ),
  Container(
    color: Colors.green,
  ),
  Container(
    color: Colors.blue,
  ),
];
