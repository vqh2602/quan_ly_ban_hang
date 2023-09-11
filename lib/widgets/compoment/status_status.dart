import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';

Widget statusStatus({Status? status1, Status? status2}) {
  return SizedBox(
    width: Get.width - 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        statusWidget(status1?.name ?? 'Trống',
            Color(int.parse('0xff${status1?.color ?? 'ffff'}'))),
        statusWidget(status2?.name ?? 'Trống',
            Color(int.parse('0xff${status2?.color ?? 'ffff'}')))
      ],
    ),
  );
}

Widget statusWidget(String title, Color color) {
  return Container(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
    decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100)),
    child: textTitleSmall(title, color: color, textAlign: TextAlign.center),
  );
}
