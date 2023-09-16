import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget blockStatistical(
    {required String title,
    required String date,
    required String value,
    required Color color,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    bool isBoxShadow = false,
    double? height,
    Widget? icon,
    bool isFormatCurrency = true,
    required Function onTap}) {
  return Container(
    margin: margin ?? const EdgeInsets.only(top: 12, left: 20, right: 20),
    padding: padding ?? const EdgeInsets.all(8),
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 3), // Di chuyển đổ bóng theo trục x và y
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 5, color: color),
              borderRadius: BorderRadius.circular(100)),
          child: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.white,
            child: Center(
              child: icon ??
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: textTitleSmall(
                              ShareFuntion.formatNumber(number: value),
                              fontWeight: FontWeight.w900,textAlign: TextAlign.center)),
                    ],
                  ),
            ),
          ),
        ),
        cWidth(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textTitleSmall(title),
                  textBodySmall(date, color: Colors.grey),
                ],
              ),
              textTitleMedium(isFormatCurrency
                  ? ShareFuntion.formatCurrency(num.parse(value))
                  : value)
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              onTap();
            },
            icon: const Icon(LucideIcons.moreHorizontal, color: Colors.black))
      ],
    ),
  );
}
