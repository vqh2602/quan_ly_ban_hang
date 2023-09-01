import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';

void showBlockDetail({required Widget widget}) {
  Get.bottomSheet(
      Container(
        height: Get.height * 0.9,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12), bottom: Radius.circular(0)),
          color: Get.theme.scaffoldBackgroundColor,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: widget,
      ),
      isScrollControlled: true);
}

showBottomSheetFilter(
    {BorderRadiusGeometry? borderRadius,
    required Widget child,
    Widget? widgetBottom}) {
  Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
            color: bg500,
            borderRadius: borderRadius ??
                const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(0))),
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
          Expanded(child: child),
          if (widgetBottom != null) widgetBottom
         
        ]),
      ),
      isScrollControlled: true,
      isDismissible: true,
      elevation: 0,
      backgroundColor: Colors.grey.withOpacity(0));
}
