import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/box_detail.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_2line.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_icon_title.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/status_status.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_product.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class DetailSalesInvoiceSreen extends StatefulWidget {
  const DetailSalesInvoiceSreen({super.key});
  static const String routeName = '/detail_sales_invoice';

  @override
  State<DetailSalesInvoiceSreen> createState() => _DetailSalesInvoiceState();
}

class _DetailSalesInvoiceState extends State<DetailSalesInvoiceSreen> {
  DetailSalesInvoiceController detailProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      backgroundColor: bg500,
      body: detailProductController.obx(
        (state) => SafeArea(
            // margin: alignment_20_0(),
            // constraints: const BoxConstraints(maxHeight: 750),
            child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  color: Get.theme.primaryColor,
                  height: 120,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 4 * 8),
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.lightTruckClock,
                              color: Colors.white,
                            ),
                            cWidth(4 * 5),
                            Expanded(
                              child: textTitleLarge(
                                   'Đã Giao Hàng',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4 * 8),
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.lightCashRegister,
                              color: Colors.white,
                            ),
                            cWidth(4 * 5),
                            textTitleLarge(
                                 'Đơn Hàng Đã Thanh Toán',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              boxDetail(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textTitleMedium( 'Thông tin khách hàng'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.lightPenToSquare),
                        color: Get.theme.primaryColor,
                      ),
                    ],
                  ),
                  cHeight(12),
                  iconTitleIconTitle(
                    title1: 'Nguyễn Minh Hưng',
                    title2: '0965674033',
                    icon1: FontAwesomeIcons.user,
                    icon2: FontAwesomeIcons.phone,
                  ),
                  cHeight(12),
                  iconTitle2Line(
                    title:
                        'Nhà 10A, Ngách 141/256 Giáp nhị, Thịnh Liệt, Hoàng Mai, Hà Nội',
                    icon: FontAwesomeIcons.lightMapLocationDot,
                  ),
                  cHeight(8),
                ],
              )),
              cHeight(16),
              boxDetail(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textTitleMedium( 'Danh sách sản phẩm'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.lightPenToSquare),
                        color: Get.theme.primaryColor,
                      ),
                    ],
                  ),
                  // cHeight(12),

                  Container(
                    // margin: alignment_20_0(),
                    constraints: const BoxConstraints(maxHeight: 360),
                    child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 12),
                        itemBuilder: (context, indext) {
                          return itemProduct(
                              margin: const EdgeInsets.only(
                                  bottom: 12, top: 8, left: 8, right: 8),
                              quantity: 8,
                              onHoverDelete: () {
                                ShareFuntion.onPopDialog(
                                    context: context,
                                    onCancel: () {},
                                    onSubmit: () {},
                                    title: 'Xoá sản phẩm ra khỏi danh sách');
                              });
                        }),
                  ),
                  cHeight(8),
                ],
              )),
              cHeight(16),
              boxDetail(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // textTitleMedium( 'Thông tin'),
                  cHeight(4),
                  titleEditTitle(
                      title: 'Tổng tiền',
                      value: ShareFuntion.formatCurrency(59000008)),
                  titleEditTitle(
                      title: 'Chiết khấu (giảm giá)',
                      value: ShareFuntion.formatCurrency(0)),
                  titleEditTitle(
                      title: 'Phụ phí', value: ShareFuntion.formatCurrency(0)),
                  titleEditTitle(
                      title: 'Thuế', value: ShareFuntion.formatCurrency(20000)),
                  titleEditTitle(
                      title: 'Thành tiền',
                      value: ShareFuntion.formatCurrency(1588858850),
                      colorValue: a500),
                  titleEditTitle(
                      title: 'Tiền khách đưa',
                      value: ShareFuntion.formatCurrency(20000)),
                  titleEditTitle(
                      title: 'Trả lại',
                      value: ShareFuntion.formatCurrency(20000)),
                ],
              )),
              cHeight(16),
              boxDetail(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textTitleMedium( 'Thông tin'),
                  cHeight(4),
                  titleEditTitle(
                      title: 'Mã hoá đơn', value: 'HD.20282023.UUIFV4'),
                  titleEditTitle(
                      title: 'Tg đặt hàng',
                      value: ShareFuntion.formatDate(
                          dateTime: DateTime.now(),
                          type: TypeDate.ddMMyyyyhhmm)),
                  titleEditTitle(
                      title: 'Tg thanh toán',
                      value: ShareFuntion.formatDate(
                          dateTime: DateTime.now(),
                          type: TypeDate.ddMMyyyyhhmm)),
                  titleEditTitle(
                      title: 'Tg giao hàng',
                      value: ShareFuntion.formatDate(
                          dateTime: DateTime.now(),
                          type: TypeDate.ddMMyyyyhhmm)),
                  titleEditTitle(
                      title: 'Trạng thái thanh toán',
                      valueWidget:
                          statusWidget('Đã thanh toán', Colors.green.shade700),
                      value: ''),
                  titleEditTitle(
                      title: 'Trạng thái giao hàng',
                      valueWidget:
                          statusWidget('Đang giao', Colors.orange.shade600),
                      value: ''),
                ],
              )),
              cHeight(16),
              boxDetail(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textTitleMedium( 'Ghi chú'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.lightPenToSquare),
                        color: Get.theme.primaryColor,
                      ),
                    ],
                  ),
                  titleEditTitle(
                      title: 'Thanh toán 1 phần',
                      value: ShareFuntion.formatCurrency(20000)),
                  titleEditTitle(
                      title: 'Nhân viên bán', value: 'Nguyễn Thị Quỳnh Như'),
                  titleEditTitle(
                      title: 'Nhân viên giao', value: 'Nguyễn Tiến Dũng'),
                  titleEditTitle(
                      title: 'Ghi chú', value: '', boldTitle: FontWeight.bold),
                  ExpandableText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    expandText: 'xem thêm',
                    collapseText: 'thu gọn',
                    maxLines: 4,
                    linkColor: Get.theme.primaryColor,
                    style: textStyleCustom(
                      fontSize: 15.5,
                    ),
                  ),
                  titleEditTitle(
                      title: 'Ghi chú huỷ',
                      value: '',
                      boldTitle: FontWeight.bold),
                  ExpandableText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    expandText: 'xem thêm',
                    collapseText: 'thu gọn',
                    maxLines: 4,
                    linkColor: Get.theme.primaryColor,
                    style: textStyleCustom(
                      fontSize: 15.5,
                    ),
                  )
                ],
              )),
              cHeight(50),
            ],
          ),
        )),
      ),
      appBar: AppBar(
        title: textTitleLarge( 'SP.12082023.YYSB'),
        centerTitle: false,
        surfaceTintColor: bg500,
        backgroundColor: bg500,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: FxButton.medium(
              onPressed: () {},
              shadowColor: Colors.transparent,
              child: textTitleMedium( 'Sửa', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
