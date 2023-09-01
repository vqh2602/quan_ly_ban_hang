import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';

Widget buttonCustom({
  Function? onTap,
  required String title,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Get.theme.colorScheme.background,
      borderRadius: BorderRadius.circular(40.0),
    ),
    padding: const EdgeInsets.only(top: 4 * 5, bottom: 4 * 5),
    child: InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4 * 5,
            children: [
              textBodyMedium(
                 title,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
