import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_title.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/status_status.dart';
import 'package:quan_ly_ban_hang/widgets/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget itemBillOfSale() {
  return 
        Container(
          margin:
              const EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
          padding:
              const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(1, 2),
                )
              ]),
          child: Column(
            children: [
              SizedBox(
                width: Get.width - 40,
                child: textTitleMedium(
                    text: 'HD.200823.238958l',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              cHeight(4),
              iconTitleTitle(
                  title1: '20/08/2023',
                  title2: 'Nguyễn Anh Trang',
                  icon: FontAwesomeIcons.calendar),
              cHeight(8),
              statusStatus(),
              cHeight(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textTitleMedium(text: formatCurrency(150000), color: b500),
                  textTitleMedium(text: formatCurrency(550000), color: a500)
                ],
              )
            ],
          ),
        );
    
}
