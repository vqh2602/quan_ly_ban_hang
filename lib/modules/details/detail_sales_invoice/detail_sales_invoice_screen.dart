import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_controller.dart';
import 'package:quan_ly_ban_hang/modules/print_pos/print_pos.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/box_detail.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_2line.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_icon_title.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/status_status.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_product.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

// tham số truyền vào
/// [type]: **view** - xem, và sửa; **create** - tạo
/// [salesOrderID]: id của salesOder, nếu type là chế độ view thì gọi api lấy tt

class DetailSalesInvoiceSreen extends StatefulWidget {
  const DetailSalesInvoiceSreen({super.key});
  static const String routeName = '/detail_sales_invoice';

  @override
  State<DetailSalesInvoiceSreen> createState() => _DetailSalesInvoiceState();
}

class _DetailSalesInvoiceState extends State<DetailSalesInvoiceSreen> {
  DetailSalesInvoiceController detailSalesInvoiceController = Get.find();
  bool showFab = true;
  bool isEdit = false; // hiển thị icon edit
  bool isCreate = false; // tạo hoá đơn
  bool isView = false; // xem hoá đơn

  var agrument = Get.arguments;
  @override
  void initState() {
    if (Get.arguments['type'] == 'view') {
      setState(() {
        isView = true;
        isCreate = false;
      });
    } else {
      setState(() {
        isCreate = true;
        isView = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return detailSalesInvoiceController.obx(
        (state) => buildBody(
              context: context,
              backgroundColor: bg500,
              createFloatingActionButton: AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: showFab ? Offset.zero : const Offset(0, 2),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: showFab ? 1 : 0,
                  child: FloatingActionButton.extended(
                    label: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          const Icon(
                            FontAwesomeIcons.print,
                            color: Colors.white,
                          ),
                          textLableMedium('In hoá đơn', color: Colors.white)
                        ]),
                    onPressed: () async {
                      await NetworkPrinter().printTicket(await mainESCPOS());
                    },
                  ),
                ),
              ),
              body: SafeArea(
                  // margin: alignment_20_0(),
                  // constraints: const BoxConstraints(maxHeight: 750),
                  child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  setState(() {
                    if (direction == ScrollDirection.reverse) {
                      showFab = false;
                    } else if (direction == ScrollDirection.forward) {
                      showFab = true;
                    }
                  });
                  return true;
                },
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
                                          ShareFuntion.getStatusWithIDFunc(
                                                      detailSalesInvoiceController
                                                          .salesOrder
                                                          ?.deliveryStatus,
                                                      listStatus:
                                                          detailSalesInvoiceController
                                                              .listStatus)
                                                  ?.name ??
                                              'Trống',
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
                                        ShareFuntion.getStatusWithIDFunc(
                                                    detailSalesInvoiceController
                                                        .salesOrder
                                                        ?.paymentStatus,
                                                    listStatus:
                                                        detailSalesInvoiceController
                                                            .listStatus)
                                                ?.name ??
                                            'Trống',
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
                              textTitleMedium('Thông tin khách hàng'),
                              if (isEdit)
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                      FontAwesomeIcons.lightPenToSquare),
                                  color: Get.theme.primaryColor,
                                ),
                            ],
                          ),
                          cHeight(12),
                          iconTitleIconTitle(
                            title1: detailSalesInvoiceController
                                    .salesOrder?.customerName ??
                                '',
                            title2:
                                detailSalesInvoiceController.customer?.phone ??
                                    'Trống',
                            icon1: FontAwesomeIcons.user,
                            icon2: FontAwesomeIcons.phone,
                          ),
                          cHeight(12),
                          iconTitle2Line(
                            title: detailSalesInvoiceController
                                    .customer?.address ??
                                'Trống',
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
                              textTitleMedium('Danh sách sản phẩm'),
                              if (isEdit)
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                      FontAwesomeIcons.lightPenToSquare),
                                  color: Get.theme.primaryColor,
                                ),
                            ],
                          ),
                          // cHeight(12),
                          Container(
                            // margin: alignment_20_0(),
                            constraints: const BoxConstraints(maxHeight: 360),
                            child: ListView.builder(
                                itemCount: detailSalesInvoiceController
                                    .listDetailSalesOrderCustom?.length,
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 12),
                                itemBuilder: (context, indext) {
                                  return itemProduct(
                                      product: detailSalesInvoiceController
                                          .listDetailSalesOrderCustom?[indext]
                                          ?.product
                                          ?.copyWith(
                                        importPrice:
                                            detailSalesInvoiceController
                                                .listDetailSalesOrderCustom?[
                                                    indext]
                                                ?.detailSalesOrder
                                                ?.importPrice,
                                        price: detailSalesInvoiceController
                                            .listDetailSalesOrderCustom?[indext]
                                            ?.detailSalesOrder
                                            ?.price,
                                        discount: detailSalesInvoiceController
                                            .listDetailSalesOrderCustom?[indext]
                                            ?.detailSalesOrder
                                            ?.discount,
                                      ),
                                      listUnit:
                                          detailSalesInvoiceController.listUnit,
                                      margin: const EdgeInsets.only(
                                          bottom: 12,
                                          top: 8,
                                          left: 8,
                                          right: 8),
                                      quantity: double.tryParse(
                                          detailSalesInvoiceController
                                                  .listDetailSalesOrderCustom?[
                                                      indext]
                                                  ?.detailSalesOrder
                                                  ?.quantity
                                                  .toString() ??
                                              '0'),
                                      onHoverDelete: () {
                                        ShareFuntion.onPopDialog(
                                            context: context,
                                            onCancel: () {
                                              Get.back();
                                            },
                                            onSubmit: () {
                                              Get.back();
                                            },
                                            title:
                                                'Xoá sản phẩm ra khỏi danh sách');
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
                              value: ShareFuntion.formatCurrency(
                                  detailSalesInvoiceController
                                          .salesOrder?.totalMoney ??
                                      0),
                              showEdit: false),
                          titleEditTitle(
                              title: 'Chiết khấu (%)',
                              value: detailSalesInvoiceController
                                      .salesOrder?.discount
                                      ?.toString() ??
                                  '',
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Phụ phí',
                              value: ShareFuntion.formatCurrency(
                                  detailSalesInvoiceController
                                          .salesOrder?.surcharge ??
                                      0),
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Thuế (%)',
                              value: detailSalesInvoiceController
                                      .salesOrder?.vat
                                      ?.toString() ??
                                  '',
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Thành tiền',
                              value: ShareFuntion.formatCurrency(
                                detailSalesInvoiceController
                                        .salesOrder?.totalMoney ??
                                    0,
                              ),
                              showEdit: false,
                              colorValue: a500),
                          // titleEditTitle(
                          //     title: 'Tiền khách đưa',
                          //     value: ShareFuntion.formatCurrency(20000)),
                          // titleEditTitle(
                          //     title: 'Trả lại',
                          //     value: ShareFuntion.formatCurrency(20000)),
                        ],
                      )),
                      cHeight(16),
                      boxDetail(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textTitleMedium('Thông tin'),
                          cHeight(4),
                          titleEditTitle(
                              title: 'Mã hoá đơn',
                              value: detailSalesInvoiceController
                                      .salesOrder?.uid ??
                                  '',
                              showEdit: false),
                          titleEditTitle(
                              title: 'Tg đặt hàng',
                              value: ShareFuntion.formatDate(
                                  dateTime: detailSalesInvoiceController
                                      .salesOrder?.timeOrder,
                                  type: TypeDate.ddMMyyyyhhmm),
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Tg thanh toán',
                              value: ShareFuntion.formatDate(
                                  dateTime: detailSalesInvoiceController
                                      .salesOrder?.paymentTime,
                                  type: TypeDate.ddMMyyyyhhmm),
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Tg giao hàng',
                              value: ShareFuntion.formatDate(
                                  dateTime: detailSalesInvoiceController
                                      .salesOrder?.deliveryTime,
                                  type: TypeDate.ddMMyyyyhhmm),
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'T.Thái thanh toán',
                              valueWidget: statusWidget(
                                  ShareFuntion.getStatusWithIDFunc(
                                              detailSalesInvoiceController
                                                  .salesOrder?.paymentStatus,
                                              listStatus:
                                                  detailSalesInvoiceController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(detailSalesInvoiceController.salesOrder?.paymentStatus, listStatus: detailSalesInvoiceController.listStatus)?.color}'))),
                              value: '',
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'T.Thái giao hàng',
                              valueWidget: statusWidget(
                                  ShareFuntion.getStatusWithIDFunc(
                                              detailSalesInvoiceController
                                                  .salesOrder?.deliveryStatus,
                                              listStatus:
                                                  detailSalesInvoiceController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(detailSalesInvoiceController.salesOrder?.deliveryStatus, listStatus: detailSalesInvoiceController.listStatus)?.color}'))),
                              value: '',
                              showEdit: isEdit),
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
                              textTitleMedium('Ghi chú'),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: const Icon(
                              //       FontAwesomeIcons.lightPenToSquare),
                              //   color: Get.theme.primaryColor,
                              // ),
                            ],
                          ),
                          titleEditTitle(
                              title: 'Thanh toán 1 phần',
                              value: ShareFuntion.formatCurrency(
                                  detailSalesInvoiceController
                                          .salesOrder?.partlyPaid ??
                                      0),
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Nhân viên bán',
                              value: detailSalesInvoiceController
                                      .salesOrder?.personnelSalespersonName ??
                                  '',
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Nhân viên giao',
                              value: detailSalesInvoiceController
                                      .salesOrder?.personnelShipperName ??
                                  '',
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Ghi chú',
                              value: '',
                              boldTitle: FontWeight.bold,
                              showEdit: isEdit),
                          ExpandableText(
                            detailSalesInvoiceController.salesOrder?.note ??
                                'Trống',
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
                              boldTitle: FontWeight.bold,
                              showEdit: isEdit),
                          ExpandableText(
                            detailSalesInvoiceController
                                    .salesOrder?.cancellationNotes ??
                                'Trống',
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
                ),
              )),
              appBar: AppBar(
                title: textTitleLarge('SP.12082023.YYSB'),
                centerTitle: false,
                surfaceTintColor: bg500,
                backgroundColor: bg500,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: FxButton.medium(
                      borderRadiusAll: 100,
                      onPressed: () {
                        if (isView && !isEdit) {
                          setState(() {
                            isView = true;
                            isEdit = true;
                          });
                          return;
                        }
                        if (isView && isEdit) {
                          setState(() {
                            isView = true;
                            isEdit = false;
                          });
                          return;
                        }
                        if (isCreate) {}
                      },
                      shadowColor: Colors.transparent,
                      child: textTitleMedium('Sửa', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        onLoading: const LoadingCustom());
  }
}
