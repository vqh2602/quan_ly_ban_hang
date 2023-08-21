
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
          Container(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
            decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(100)),
            child:
                textTitleSmall(text: 'Đã giao', color: Colors.green.shade700),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
            decoration: BoxDecoration(
                color: Colors.yellow.shade50,
                borderRadius: BorderRadius.circular(100)),
            child:
                textTitleSmall(text: 'Đã giao', color: Colors.yellow.shade700),
          )
        ],
      ),
    );
  }
