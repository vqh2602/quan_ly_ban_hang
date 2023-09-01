import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget iconTitleIconTitle(
    {required String title1,
    required String title2,
    required IconData icon1,
    required IconData icon2}) {
  return Row(
    children: [
      Expanded(
          child: Row(
        children: [
          Icon(
            icon1,
            size: 16,
            color: Colors.grey,
          ),
          cWidth(8),
          textBodyMedium(text: title1),
        ],
      )),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            icon2,
            size: 16,
            color: Colors.grey,
          ),
          cWidth(8),
          textBodyMedium(text: title2),
        ],
      ))
    ],
  );
}
