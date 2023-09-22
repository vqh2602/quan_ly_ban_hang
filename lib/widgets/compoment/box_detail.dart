import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget boxDetail({required Widget child}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
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
    FontWeight? boldTitle,
    Color? colorValue,
    Widget? valueWidget,
    Function()? onTap,
    bool showEdit = true}) {
  return Container(
    margin: const EdgeInsets.only(top: 4, bottom: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textBodyMedium(title, fontWeight: boldTitle ?? FontWeight.normal),
            if (showEdit)
              InkWell(
                onTap: () {
                  if (onTap != null) onTap();
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Icon(
                      FontAwesomeIcons.lightPenToSquare,
                      color: Get.theme.primaryColor,
                      size: 16,
                    )),
                // color: Get.theme.primaryColor,
              ),
          ],
        ),
        cWidth(12),
        valueWidget ??
            Expanded(
              child: textTitleMedium(value,
                  textAlign: TextAlign.right, color: colorValue),
            )
      ],
    ),
  );
}
