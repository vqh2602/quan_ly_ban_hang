 import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quan_ly_ban_hang/widgets/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget blockStatistical(
      {required String title,
      required String date,
      required String value,
      required Color color,
      required Function onTap}) {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textTitleMedium(text: '18', fontWeight: FontWeight.w900),
                    textTitleSmall(text: 'N', fontWeight: FontWeight.w900),
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
                    textTitleSmall(text: title),
                    textBodySmall(text: date, color: Colors.grey),
                  ],
                ),
                textTitleMedium(text: formatCurrency(num.parse(value)))
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
