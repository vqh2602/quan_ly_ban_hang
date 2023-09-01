import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';

Widget statusStatus() {
  return SizedBox(
    width: Get.width - 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        statusWidget('Đã thanh toán', Colors.green.shade700),
        statusWidget('Đang giao', Colors.yellow.shade600)
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
    child:
        textTitleSmall( title, color: color, textAlign: TextAlign.center),
  );
}
