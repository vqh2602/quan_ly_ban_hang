import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';

Widget itemNotifycation({String? title, String? date, Function? onTap}) {
  return GestureDetector(
    onTap: () {
      if (onTap != null) {
        onTap();
        return;
      }
    },
    child: Container(
      margin: const EdgeInsets.only(top: 0, bottom: 12, left: 12, right: 12),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(100),
          boxShadow: const []),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitleMedium('Đơn hàng ${title?.replaceAll('-', ' ')}',
              maxLines: 1),
          textBodySmall(date ?? ''),
        ],
      ),
    ),
  );
}
