import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget iconTitle2Line({required String title, required IconData icon}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(top: 2),
        child: Icon(
          icon,
          size: 16,
          color: Colors.grey,
        ),
      ),
      cWidth(8),
      Expanded(child: textBodyMedium( title))
    ],
  );
}
