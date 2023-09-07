import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget iconTitleTitle(
    {required String title1,
    String? subTitle1,
    String? subTitle2,
    bool subTitleBold = false,
    String? title2,
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
            if (icon != null) cWidth(6),
            subTitle1 == null && subTitle2 == null
                ? SizedBox(
                    width: Get.width * 0.40,
                    child: textBodySmall(title1, textAlign: TextAlign.left),
                  )
                : textBodySmall(
                    title1,
                  ),
            textBodySmall(
              subTitle1 ?? '',
              fontWeight: subTitleBold ? FontWeight.bold : FontWeight.normal,
            ),
          ],
        ),
        if (title2 != null)
          Row(
            children: [
              textBodySmall(
                title2,
              ),
              textBodySmall(
                subTitle2 ?? '',
                fontWeight: subTitleBold ? FontWeight.bold : FontWeight.normal,
              ),
            ],
          ),
      ],
    ),
  );
}
