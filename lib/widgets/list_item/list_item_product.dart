import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_screen.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_title.dart';
import 'package:quan_ly_ban_hang/widgets/image_custom.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget itemProduct({
  Product? product,
  List<Unit>? listUnit,
  EdgeInsets? margin,
  double? quantity,
  Function?
      onHoverDelete, // ấn giữ xoá sp ra khỏi list - dùng cho các màn hoá đơn
}) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(DetailProductSreen.routeName,
          arguments: {'type': 'view', 'productID': product?.id});
    },
    onLongPress: () {
      if (onHoverDelete != null) onHoverDelete();
    },
    child: Container(
      margin: margin ??
          const EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
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
                child:
                    imageNetwork(url: product?.image ?? '', fit: BoxFit.cover)),
          ),
          cWidth(8),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: Get.width - 40,
                  child: textTitleMedium(
                       product?.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                iconTitleTitle(
                    title1: product?.bardcode ?? 'Trống',
                    title2: 'Lượt bán: ',
                    subTitleBold: true,
                    subTitle2: ShareFuntion.formatNumber(
                        number: product?.numberSales.toString() ?? '0'),
                    icon: FontAwesomeIcons.barcodeRead),
                iconTitleTitle(
                    title1: 'Số lượng: ',
                    title2: 'Đơn vị:',
                    subTitleBold: true,
                    subTitle1: product?.quantity.toString() ?? '0',
                    subTitle2: ShareFuntion.getUnitWithIDFunc(product?.unit,
                                listUnit: listUnit)
                            ?.name ??
                        'Trống',
                    icon: null),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (quantity != null)
                        textTitleMedium( 'x$quantity', color: b500),
                      Expanded(
                        child: textTitleMedium(
                             ShareFuntion.formatCurrency(
                                product?.price ?? 0),
                            color: a500,
                            textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
