import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';

Widget boxDetail({required Widget child}) {
  return Container(
    padding: alignment_20_8(),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 3), // di chuyển đổ bóng theo trục x và y
        ),
      ],
    ),
    child: child,
  );
}

Widget titleEditTitle(
    {required String title,
    required String value,
    Function()? onTap,
    bool showEdit = true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          textBodyMedium(text: title),
          if (showEdit)
            IconButton(
              onPressed: () {
                if (onTap != null) onTap();
              },
              icon: const Icon(FontAwesomeIcons.lightPenToSquare),
              color: Get.theme.primaryColor,
            ),
        ],
      ),
      Expanded(
        child: textTitleMedium(text: value, textAlign: TextAlign.right),
      )
    ],
  );
}