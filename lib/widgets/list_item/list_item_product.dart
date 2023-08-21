import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_screen.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_title.dart';
import 'package:quan_ly_ban_hang/widgets/image_custom.dart';
import 'package:quan_ly_ban_hang/widgets/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget itemProduct() {
  return GestureDetector(
    onTap: (){
      Get.toNamed(DetailProductSreen.routeName);
    },
    child: Container(
      margin: const EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
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
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageNetwork(
                    url: 'https://i.imgur.com/UYT3Gnu.jpeg', fit: BoxFit.cover)),
          ),
          cWidth(8),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: Get.width - 40,
                  child: textTitleMedium(
                      text: 'Điều hoà Pấnonic 12000PU 2023',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                iconTitleTitle(
                    title1: '1352775365',
                    title2: 'Lượt bán: ',
                    subTitleBold: true,
                    subTitle2: '18 N',
                    icon: FontAwesomeIcons.barcodeRead),
                iconTitleTitle(
                    title1: 'Số lượng: ',
                    title2: 'Đơn vị:',
                    subTitleBold: true,
                    subTitle1: '2000',
                    subTitle2: 'cái',
                    icon: null),
                Align(
                  alignment: Alignment.centerRight,
                  child:
                      textTitleMedium(text: formatCurrency(550000), color: a500),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
