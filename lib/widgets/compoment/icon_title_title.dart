import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget iconTitleTitle(
    {required String title1,
    String? subTitle1,
    String? subTitle2,
    bool subTitleBold = false,
    required String title2,
    required IconData? icon}) {
  return SizedBox(
    width: Get.width - 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 12,
                color: Colors.grey,
              ),
            if (icon != null) cWidth(4),
            textBodySmall(
              text: title1,
            ),
            textBodySmall(
              text: subTitle1 ?? '',
              fontWeight: subTitleBold ? FontWeight.bold : FontWeight.normal,
            ),
          ],
        ),
        Row(
          children: [
            textBodySmall(
              text: title2,
            ),
            textBodySmall(
              text: subTitle2 ?? '',
              fontWeight: subTitleBold ? FontWeight.bold : FontWeight.normal,
            ),
          ],
        ),
      ],
    ),
  );
}