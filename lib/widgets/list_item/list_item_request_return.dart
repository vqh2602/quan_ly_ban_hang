import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/data/models/request_return.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_request_return/detail_request_return_screen.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_title.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/status_status.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

// item hoa đơn bán hàng
Widget itemRequestReturn(
    {RequestReturn? requestReturn, List<Status>? listStatus}) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(DetailRequestReturnScreen.routeName,
          arguments: {'requestReturnID': requestReturn?.id, 'type': 'view'});
    },
    child: Container(
      margin: const EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
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
      child: Column(
        children: [
          SizedBox(
            width: Get.width - 40,
            child: textTitleMedium(requestReturn?.name ?? '',
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          cHeight(4),
          iconTitleTitle(
              title1: ShareFuntion.formatDate(
                  type: TypeDate.ddMMyyyy,
                  dateTime: requestReturn?.timeRequestReturn),
              title2: requestReturn?.personnelWarehouseStaffName ?? '',
              icon: FontAwesomeIcons.calendar),
          cHeight(8),
          statusStatus(
            status1: ShareFuntion.getStatusWithIDFunc(
                requestReturn?.browsingStatus,
                listStatus: listStatus),
            status2: ShareFuntion.getStatusWithIDFunc(
                requestReturn?.supplierStatus,
                listStatus: listStatus),
          ),
          cHeight(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textTitleMedium(requestReturn?.supplierName ?? '', color: b500),
              textTitleMedium(
                  ShareFuntion.formatCurrency(requestReturn?.totalMoney ?? 0),
                  color: a500)
            ],
          )
        ],
      ),
    ),
  );
}
