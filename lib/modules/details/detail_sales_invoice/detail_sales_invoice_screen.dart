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
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/box_detail.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_2line.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/icon_title_icon_title.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/status_status.dart';
import 'package:quan_ly_ban_hang/widgets/list_item/list_item_product.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/s_show_chose.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/theme_textinput.dart';
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
        isEdit = true;
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
                offset: (showFab && !isEdit) ? Offset.zero : const Offset(0, 2),
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
                      // await NetworkPrinter().printTicket(await mainESCPOS());
                      await NativePrinter().nativePrint(
                        customer: detailSalesInvoiceController.customer,
                        detailSalesOrderCustom: detailSalesInvoiceController
                            .listDetailSalesOrderCustom,
                        salesOrder: detailSalesInvoiceController.salesOrder,
                      );
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
                        child: isCreate
                            ? const SizedBox()
                            : Container(
                                color: Get.theme.primaryColor,
                                height: 120,
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(left: 4 * 8),
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
                                      margin:
                                          const EdgeInsets.only(left: 4 * 8),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textTitleMedium('Thông tin khách hàng'),
                              if (isEdit)
                                IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(detailSalesInvoiceController
                                        .obx((state) => showBottomListChose(
                                              options:
                                                  detailSalesInvoiceController
                                                      .listCustomer,
                                              value:
                                                  detailSalesInvoiceController
                                                      .customerItemSelect,
                                              onSelect: (p0) {
                                                detailSalesInvoiceController
                                                    .customerItemSelect = p0;
                                                detailSalesInvoiceController
                                                    .updateUI();
                                              },
                                              onSearch: (val) {
                                                ShareFuntion.searchList(
                                                    list:
                                                        detailSalesInvoiceController
                                                            .listCustomer,
                                                    value: val,
                                                    update: () {
                                                      detailSalesInvoiceController
                                                          .updateUI();
                                                    });
                                              },
                                              buildOption: (p0) =>
                                                  textBodyMedium(p0.key ?? ''),
                                            )));
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.lightPenToSquare,
                                    size: 18,
                                  ),
                                  color: Get.theme.primaryColor,
                                ),
                            ],
                          ),
                          cHeight(12),
                          iconTitleIconTitle(
                            title1: isEdit
                                ? detailSalesInvoiceController
                                        .customerItemSelect?.key ??
                                    ''
                                : detailSalesInvoiceController
                                        .salesOrder?.customerName ??
                                    '',
                            title2: isEdit
                                ? detailSalesInvoiceController
                                        .customerItemSelect?.data.phone ??
                                    ''
                                : detailSalesInvoiceController
                                        .customer?.phone ??
                                    'Trống',
                            icon1: FontAwesomeIcons.user,
                            icon2: FontAwesomeIcons.phone,
                          ),
                          cHeight(12),
                          iconTitle2Line(
                            title: isEdit
                                ? detailSalesInvoiceController
                                        .customerItemSelect?.data.address ??
                                    ''
                                : detailSalesInvoiceController
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textTitleMedium('Danh sách sản phẩm'),
                              if (isEdit)
                                IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                        detailSalesInvoiceController.obx(
                                            (state) => showBottomListMutilChose(
                                                  options:
                                                      detailSalesInvoiceController
                                                          .listProduct,
                                                  value:
                                                      detailSalesInvoiceController
                                                          .listProductSelect,
                                                  onSelect: (p0) {
                                                    if (p0.data.quantity == 0) {
                                                      buildToast(
                                                          message:
                                                              'Sản phẩm đã hết hàng',
                                                          status: TypeToast
                                                              .toastError);
                                                      return;
                                                    }
                                                    if (detailSalesInvoiceController
                                                            .listProductSelect
                                                            ?.contains(p0) ??
                                                        false) {
                                                      detailSalesInvoiceController
                                                          .listProductSelect
                                                          ?.remove(p0);
                                                    } else {
                                                      detailSalesInvoiceController
                                                          .listProductSelect
                                                          ?.add(p0);
                                                    }
                                                    detailSalesInvoiceController
                                                        .fillDataProduct();
                                                    detailSalesInvoiceController
                                                        .updateUI();
                                                  },
                                                  onSearch: (val) {
                                                    ShareFuntion.searchList(
                                                        list:
                                                            detailSalesInvoiceController
                                                                .listProduct,
                                                        value: val,
                                                        update: () {
                                                          detailSalesInvoiceController
                                                              .updateUI();
                                                        });
                                                  },
                                                  buildOption: (p0) => Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                p0.data.image),
                                                      ),
                                                      cWidth(8),
                                                      Expanded(
                                                          child: textBodyMedium(
                                                              p0.key ?? '')),
                                                      textBodySmall(p0
                                                          .data.quantity
                                                          .toString())
                                                    ],
                                                  ),
                                                )));
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.lightPenToSquare,
                                    size: 18,
                                  ),
                                  color: Get.theme.primaryColor,
                                ),
                            ],
                          ),
                          // cHeight(12),
                          Container(
                            // margin: alignment_20_0(),
                            constraints: const BoxConstraints(maxHeight: 360),
                            child: ListView.builder(
                                itemCount: isEdit
                                    ? (detailSalesInvoiceController
                                        .listDetailSalesOrderCustomEdit?.length)
                                    : detailSalesInvoiceController
                                        .listDetailSalesOrderCustom?.length,
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 12),
                                itemBuilder: (context, indext) {
                                  return itemProduct(
                                      product: isEdit
                                          ? (detailSalesInvoiceController
                                              .listDetailSalesOrderCustomEdit?[
                                                  indext]
                                              .product
                                              ?.copyWith(
                                              importPrice:
                                                  detailSalesInvoiceController
                                                      .listDetailSalesOrderCustomEdit?[
                                                          indext]
                                                      .detailSalesOrder
                                                      ?.importPrice,
                                              price: detailSalesInvoiceController
                                                  .listDetailSalesOrderCustomEdit?[
                                                      indext]
                                                  .detailSalesOrder
                                                  ?.price,
                                              discount: detailSalesInvoiceController
                                                  .listDetailSalesOrderCustomEdit?[
                                                      indext]
                                                  .detailSalesOrder
                                                  ?.discount,
                                            ))
                                          : detailSalesInvoiceController
                                              .listDetailSalesOrderCustom?[
                                                  indext]
                                              .product
                                              ?.copyWith(
                                              importPrice:
                                                  detailSalesInvoiceController
                                                      .listDetailSalesOrderCustom?[
                                                          indext]
                                                      .detailSalesOrder
                                                      ?.importPrice,
                                              price: detailSalesInvoiceController
                                                  .listDetailSalesOrderCustom?[
                                                      indext]
                                                  .detailSalesOrder
                                                  ?.price,
                                              discount:
                                                  detailSalesInvoiceController
                                                      .listDetailSalesOrderCustom?[
                                                          indext]
                                                      .detailSalesOrder
                                                      ?.discount,
                                            ),
                                      listUnit:
                                          detailSalesInvoiceController.listUnit,
                                      margin: const EdgeInsets.only(
                                          bottom: 12,
                                          top: 8,
                                          left: 8,
                                          right: 8),
                                      quantity: double.tryParse(isEdit
                                          ? (detailSalesInvoiceController
                                                  .listDetailSalesOrderCustomEdit?[
                                                      indext]
                                                  .detailSalesOrder
                                                  ?.quantity
                                                  .toString() ??
                                              '0')
                                          : detailSalesInvoiceController
                                                  .listDetailSalesOrderCustom?[
                                                      indext]
                                                  .detailSalesOrder
                                                  ?.quantity
                                                  .toString() ??
                                              '0'),
                                      onTap: isEdit
                                          ? () {
                                              if (isEdit) {
                                                showBottomSheetAddProduct(
                                                    detailSalesOrderCustom: isEdit
                                                        ? (detailSalesInvoiceController
                                                                .listDetailSalesOrderCustomEdit?[
                                                            indext])
                                                        : (detailSalesInvoiceController
                                                                .listDetailSalesOrderCustom?[
                                                            indext]));
                                              }
                                            }
                                          : null,
                                      onHoverDelete: () {
                                        isEdit
                                            ? ShareFuntion.onPopDialog(
                                                context: context,
                                                onCancel: () {
                                                  Get.back();
                                                },
                                                onSubmit: () {
                                                  detailSalesInvoiceController
                                                      .listDetailSalesOrderCustomEdit
                                                      ?.removeAt(indext);
                                                  detailSalesInvoiceController
                                                      .updateUI();
                                                  Get.back();
                                                },
                                                title:
                                                    'Xoá sản phẩm ra khỏi danh sách')
                                            : null;
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
                              value: ShareFuntion.formatCurrency(isEdit
                                  ? detailSalesInvoiceController
                                      .calculateTotalMoneyProduct()
                                  : detailSalesInvoiceController
                                          .salesOrder?.totalMoney ??
                                      0),
                              showEdit: false),
                          titleEditTitle(
                              title: 'Chiết khấu (%)',
                              value: isEdit
                                  ? detailSalesInvoiceController
                                          .discountTE?.text ??
                                      ''
                                  : detailSalesInvoiceController
                                          .salesOrder?.discount
                                          ?.toString() ??
                                      '',
                              onTap: (() {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailSalesInvoiceController.discountTE,
                                      keyboardType: TextInputType.number,
                                      onCancel: () {
                                    detailSalesInvoiceController.discountTE
                                        ?.text = detailSalesInvoiceController
                                            .salesOrder?.discount
                                            .toString() ??
                                        '0';
                                  }, onSubmitted: () {
                                    detailSalesInvoiceController.updateUI();
                                  }),
                                );
                              }),
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Phụ phí',
                              value: ShareFuntion.formatCurrency(isEdit
                                  ? num.parse(detailSalesInvoiceController
                                          .surchargeTE?.text ??
                                      '0')
                                  : detailSalesInvoiceController
                                          .salesOrder?.surcharge ??
                                      0),
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailSalesInvoiceController.surchargeTE,
                                      keyboardType: TextInputType.number,
                                      onCancel: () {
                                    detailSalesInvoiceController.surchargeTE
                                        ?.text = detailSalesInvoiceController
                                            .salesOrder?.surcharge
                                            .toString() ??
                                        '0';
                                  }, onSubmitted: () {
                                    detailSalesInvoiceController.updateUI();
                                  }),
                                );
                              },
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Thuế (%)',
                              value: isEdit
                                  ? detailSalesInvoiceController.vatTE?.text ??
                                      ''
                                  : detailSalesInvoiceController.salesOrder?.vat
                                          ?.toString() ??
                                      '',
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailSalesInvoiceController.vatTE,
                                      keyboardType: TextInputType.number,
                                      onCancel: () {
                                    detailSalesInvoiceController.vatTE?.text =
                                        detailSalesInvoiceController
                                                .salesOrder?.vat
                                                .toString() ??
                                            '0';
                                  }, onSubmitted: () {
                                    detailSalesInvoiceController.updateUI();
                                  }),
                                );
                              },
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Thanh toán 1 phần',
                              value: ShareFuntion.formatCurrency(isEdit
                                  ? num.parse(detailSalesInvoiceController
                                          .partlyPaidTE?.text ??
                                      '0')
                                  : detailSalesInvoiceController
                                          .salesOrder?.partlyPaid ??
                                      0),
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailSalesInvoiceController.partlyPaidTE,
                                      keyboardType: TextInputType.number,
                                      onCancel: () {
                                    detailSalesInvoiceController.partlyPaidTE
                                        ?.text = detailSalesInvoiceController
                                            .salesOrder?.partlyPaid
                                            .toString() ??
                                        '0';
                                  }, onSubmitted: () {
                                    detailSalesInvoiceController.updateUI();
                                  }),
                                );
                              },
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'Thành tiền',
                              value: ShareFuntion.formatCurrency(
                                isEdit
                                    ? detailSalesInvoiceController
                                        .calculateTotalMoney()
                                    : detailSalesInvoiceController
                                            .salesOrder?.totalMoney ??
                                        0,
                              ),
                              showEdit: false,
                              colorValue: a500),
                          titleEditTitle(
                            title: 'Tiền khách đưa',
                            value: ShareFuntion.formatCurrency(
                              isEdit
                                  ? num.parse(detailSalesInvoiceController
                                          .moneyGuestsTE?.text ??
                                      '0')
                                  : detailSalesInvoiceController
                                          .salesOrder?.moneyGuests ??
                                      0,
                            ),
                            showEdit: isEdit,
                            onTap: () {
                              Get.bottomSheet(
                                showBottomTextInput(
                                    detailSalesInvoiceController.moneyGuestsTE,
                                    onCancel: () {
                                  detailSalesInvoiceController.moneyGuestsTE
                                      ?.text = detailSalesInvoiceController
                                          .salesOrder?.moneyGuests
                                          .toString() ??
                                      '0';
                                }, onSubmitted: () {
                                  detailSalesInvoiceController.updateUI();
                                }),
                              );
                            },
                          ),
                          titleEditTitle(
                              title: 'Trả lại',
                              value: ShareFuntion.formatCurrency(
                                isEdit
                                    ? detailSalesInvoiceController
                                        .calculateChangeMoney()
                                    : detailSalesInvoiceController
                                            .salesOrder?.changeMoney ??
                                        0,
                              ),
                              showEdit: false),
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
                              value: isCreate
                                  ? detailSalesInvoiceController.uidCreate ?? ''
                                  : detailSalesInvoiceController
                                          .salesOrder?.uid ??
                                      '',
                              showEdit: false),
                          titleEditTitle(
                              title: 'Tg đặt hàng',
                              value: ShareFuntion.formatDate(
                                  dateTime: isCreate
                                      ? DateTime.now()
                                      : detailSalesInvoiceController
                                          .salesOrder?.timeOrder,
                                  type: TypeDate.ddMMyyyyhhmm),
                              showEdit: false),
                          titleEditTitle(
                              title: 'Tg thanh toán',
                              value: ShareFuntion.formatDate(
                                  dateTime: detailSalesInvoiceController
                                      .salesOrder?.paymentTime,
                                  type: TypeDate.ddMMyyyyhhmm),
                              showEdit: false),
                          titleEditTitle(
                              title: 'Tg giao hàng',
                              value: ShareFuntion.formatDate(
                                  dateTime: detailSalesInvoiceController
                                      .salesOrder?.deliveryTime,
                                  type: TypeDate.ddMMyyyyhhmm),
                              showEdit: false),
                          titleEditTitle(
                              title: 'T.Thái thanh toán',
                              valueWidget: statusWidget(
                                  ShareFuntion.getStatusWithIDFunc(
                                              isEdit
                                                  ? detailSalesInvoiceController
                                                      .statusPayItemSelect
                                                      ?.value
                                                  : detailSalesInvoiceController
                                                      .salesOrder
                                                      ?.paymentStatus,
                                              listStatus:
                                                  detailSalesInvoiceController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(isEdit ? detailSalesInvoiceController.statusPayItemSelect?.value : detailSalesInvoiceController.salesOrder?.paymentStatus, listStatus: detailSalesInvoiceController.listStatus)?.color}'))),
                              value: '',
                              onTap: () {
                                Get.bottomSheet(detailSalesInvoiceController
                                    .obx((state) => showBottomListChose(
                                          options: detailSalesInvoiceController
                                              .listStatusOption
                                              ?.where((element) =>
                                                  element.data.group ==
                                                  'Trạng thái thanh toán')
                                              .toList(),
                                          value: detailSalesInvoiceController
                                              .statusPayItemSelect,
                                          onSelect: (p0) {
                                            detailSalesInvoiceController
                                                .statusPayItemSelect = p0;

                                            detailSalesInvoiceController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailSalesInvoiceController
                                                        .listStatusOption,
                                                value: val,
                                                update: () {
                                                  detailSalesInvoiceController
                                                      .updateUI();
                                                });
                                          },
                                          buildOption: (p0) => Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Color(int.parse(
                                                    '0xff${p0.data.color}')),
                                              ),
                                              cWidth(8),
                                              Expanded(
                                                  child: textBodyMedium(
                                                      p0.key ?? ''))
                                            ],
                                          ),
                                        )));
                              },
                              showEdit: isEdit),
                          titleEditTitle(
                              title: 'T.Thái giao hàng',
                              valueWidget: statusWidget(
                                  ShareFuntion.getStatusWithIDFunc(
                                              isEdit
                                                  ? detailSalesInvoiceController
                                                      .statusDeliverItemSelect
                                                      ?.value
                                                  : detailSalesInvoiceController
                                                      .salesOrder
                                                      ?.deliveryStatus,
                                              listStatus:
                                                  detailSalesInvoiceController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(isEdit ? detailSalesInvoiceController.statusDeliverItemSelect?.value : detailSalesInvoiceController.salesOrder?.deliveryStatus, listStatus: detailSalesInvoiceController.listStatus)?.color}'))),
                              value: '',
                              onTap: () {
                                Get.bottomSheet(detailSalesInvoiceController
                                    .obx((state) => showBottomListChose(
                                          options: detailSalesInvoiceController
                                              .listStatusOption
                                              ?.where((element) =>
                                                  element.data.group ==
                                                  'trạng thái giao hàng')
                                              .toList(),
                                          value: detailSalesInvoiceController
                                              .statusDeliverItemSelect,
                                          onSelect: (p0) {
                                            detailSalesInvoiceController
                                                .statusDeliverItemSelect = p0;

                                            detailSalesInvoiceController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailSalesInvoiceController
                                                        .listStatusOption,
                                                value: val,
                                                update: () {
                                                  detailSalesInvoiceController
                                                      .updateUI();
                                                });
                                          },
                                          buildOption: (p0) => Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Color(int.parse(
                                                    '0xff${p0.data.color}')),
                                              ),
                                              cWidth(8),
                                              Expanded(
                                                  child: textBodyMedium(
                                                      p0.key ?? ''))
                                            ],
                                          ),
                                        )));
                              },
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
                              title: 'Nhân viên bán',
                              value: isEdit
                                  ? detailSalesInvoiceController
                                          .personnelSaleItemSelect?.key ??
                                      ''
                                  : detailSalesInvoiceController.salesOrder
                                          ?.personnelSalespersonName ??
                                      '',
                              showEdit: isEdit,
                              onTap: () {
                                Get.bottomSheet(detailSalesInvoiceController
                                    .obx((state) => showBottomListChose(
                                          options: detailSalesInvoiceController
                                              .listPersonnel,
                                          value: detailSalesInvoiceController
                                              .personnelSaleItemSelect,
                                          onSelect: (p0) {
                                            detailSalesInvoiceController
                                                .personnelSaleItemSelect = p0;

                                            detailSalesInvoiceController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailSalesInvoiceController
                                                        .listPersonnel,
                                                value: val,
                                                update: () {
                                                  detailSalesInvoiceController
                                                      .updateUI();
                                                });
                                          },
                                          buildOption: (p0) => Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(p0
                                                        .data.avatar ??
                                                    'https://i.imgur.com/BdzfHg0.png'),
                                              ),
                                              cWidth(8),
                                              Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  textBodyMedium(p0.key ?? ''),
                                                  textBodySmall(
                                                      p0.data.department ?? ''),
                                                ],
                                              ))
                                            ],
                                          ),
                                        )));
                              }),
                          titleEditTitle(
                              title: 'Nhân viên giao',
                              value: isEdit
                                  ? detailSalesInvoiceController
                                          .personnelShipperItemSelect?.key ??
                                      ''
                                  : detailSalesInvoiceController
                                          .salesOrder?.personnelShipperName ??
                                      '',
                              showEdit: isEdit,
                              onTap: () {
                                Get.bottomSheet(detailSalesInvoiceController
                                    .obx((state) => showBottomListChose(
                                          options: detailSalesInvoiceController
                                              .listPersonnel,
                                          value: detailSalesInvoiceController
                                              .personnelShipperItemSelect,
                                          onSelect: (p0) {
                                            detailSalesInvoiceController
                                                .personnelShipperItemSelect = p0;

                                            detailSalesInvoiceController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailSalesInvoiceController
                                                        .listPersonnel,
                                                value: val,
                                                update: () {
                                                  detailSalesInvoiceController
                                                      .updateUI();
                                                });
                                          },
                                          buildOption: (p0) => Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(p0
                                                        .data.avatar ??
                                                    'https://i.imgur.com/BdzfHg0.png'),
                                              ),
                                              cWidth(8),
                                              Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  textBodyMedium(p0.key ?? ''),
                                                  textBodySmall(
                                                      p0.data.department ?? ''),
                                                ],
                                              ))
                                            ],
                                          ),
                                        )));
                              }),
                          titleEditTitle(
                              title: 'Ghi chú',
                              value: '',
                              boldTitle: FontWeight.bold,
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailSalesInvoiceController.noteTE,
                                      onCancel: () {
                                    detailSalesInvoiceController.noteTE?.text =
                                        detailSalesInvoiceController
                                                .salesOrder?.note
                                                .toString() ??
                                            '';
                                  }, onSubmitted: () {
                                    detailSalesInvoiceController.updateUI();
                                  }),
                                );
                              },
                              showEdit: isEdit),
                          ExpandableText(
                            isEdit
                                ? detailSalesInvoiceController.noteTE?.text ??
                                    'Trống'
                                : detailSalesInvoiceController
                                        .salesOrder?.note ??
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
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailSalesInvoiceController
                                          .cancellationNotesTE, onCancel: () {
                                    detailSalesInvoiceController
                                        .cancellationNotesTE
                                        ?.text = detailSalesInvoiceController
                                            .salesOrder?.cancellationNotes
                                            .toString() ??
                                        '';
                                  }, onSubmitted: () {
                                    detailSalesInvoiceController.updateUI();
                                  }),
                                );
                              },
                              showEdit: isEdit),
                          ExpandableText(
                            isEdit
                                ? detailSalesInvoiceController
                                        .cancellationNotesTE?.text ??
                                    'Trống'
                                : detailSalesInvoiceController
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
                title: textTitleLarge('Thông tin đơn hàng'),
                centerTitle: false,
                surfaceTintColor: bg500,
                backgroundColor: bg500,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: FxButton.medium(
                      borderRadiusAll: 100,
                      onPressed: () async {
                        if (ShareFuntion().checkPermissionUserLogin(
                            permission: [
                              'QL',
                              'BH',
                              'GH',
                              'C_HD',
                              'E_HD',
                              'AD'
                            ])) {
                        } else {
                          buildToast(
                              message: 'Không có quyền xem thông tin',
                              status: TypeToast.toastError);
                          return;
                        }

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
                          await detailSalesInvoiceController.updateSaleOder();

                          return;
                        }
                        if (isCreate) {
                          await detailSalesInvoiceController.createSaleOder();
                        }
                      },
                      shadowColor: Colors.transparent,
                      child: isCreate
                          ? textTitleMedium('Tạo', color: Colors.white)
                          : textTitleMedium('Sửa', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        onLoading: const LoadingCustom());
  }

// thêm số lượng sản phẩm
  showBottomSheetAddProduct({DetailSalesOrderCustom? detailSalesOrderCustom}) {
    TextEditingController quantityTE = TextEditingController(
        text: detailSalesOrderCustom?.detailSalesOrder?.quantity.toString() ??
            '1');
    TextEditingController discountTE = TextEditingController(
        text: detailSalesOrderCustom?.detailSalesOrder?.discount.toString() ??
            '0');
    TextEditingController noteTE = TextEditingController(
        text: detailSalesOrderCustom?.detailSalesOrder?.note ?? '');
    final formKey = GlobalKey<FormState>();
    Get.bottomSheet(
        Container(
          height: Get.height * 0.75,
          decoration: BoxDecoration(
              color: bg500,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100), topRight: Radius.circular(0))),
          child: Form(
            key: formKey,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                child: Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                margin: alignment_20_0(),
                child: Column(
                  children: [
                    cHeight(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // FxButton.medium(
                        //   onPressed: () {},
                        //   borderRadiusAll: 100,
                        //   shadowColor: Colors.transparent,
                        //   backgroundColor: const Color.fromARGB(255, 255, 17, 0)
                        //       .withOpacity(0.1),
                        //   child: textTitleMedium('Xoá',
                        //       color: const Color.fromARGB(255, 255, 17, 0)),
                        // ),
                        // cWidth(20),
                        FxButton.medium(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              detailSalesInvoiceController
                                  .updateProductInSalesOrderEdit(
                                      discount: discountTE.text,
                                      note: noteTE.text,
                                      product: detailSalesOrderCustom?.product,
                                      quantity: quantityTE.text);
                              Get.back();
                            }
                          },
                          borderRadiusAll: 100,
                          shadowColor: Colors.transparent,
                          backgroundColor:
                              const Color.fromARGB(255, 20, 255, 27)
                                  .withOpacity(0.1),
                          child: textTitleMedium('Thêm',
                              color: const Color.fromARGB(255, 12, 173, 17)),
                        ),
                      ],
                    ),
                    cHeight(20),
                    itemProduct(
                      margin: EdgeInsets.zero,
                      product: detailSalesOrderCustom?.product,
                      listUnit: detailSalesInvoiceController.listUnit,
                    ),
                    cHeight(32),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap: () {},
                            style: textStyleCustom(fontSize: 16),
                            controller: quantityTE,
                            validator: (val) {
                              if (val == null) {
                                return 'Không để trống';
                              }
                              if (num.parse(val) >
                                  (detailSalesOrderCustom?.product?.quantity ??
                                      0)) {
                                return 'Vượt quá giới hạn kho';
                              }
                              if (num.parse(val) < 1) {
                                return 'Số lượng không nhỏ hơn 1';
                              }
                              return null;
                            },
                            readOnly: (isView || isCreate) ? false : true,
                            decoration: textFieldInputStyle(label: 'Số lượng'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        cWidth(12),
                        Expanded(
                          child: TextFormField(
                            onTap: () {},
                            style: textStyleCustom(fontSize: 16),
                            controller: discountTE,
                            textAlign: TextAlign.center,
                            // validator:
                            //     accountDetailController.validateString,
                            readOnly: (isView || isCreate) ? false : true,
                            decoration:
                                textFieldInputStyle(label: 'Giảm giá (%)'),
                          ),
                        ),
                      ],
                    ),
                    cHeight(28),
                    TextFormField(
                      onTap: () {},
                      style: textStyleCustom(fontSize: 16),
                      controller: noteTE,
                      // validator:
                      //     accountDetailController.validateString,
                      readOnly: (isView || isCreate) ? false : true,
                      maxLines: 7,
                      decoration: textFieldInputStyle(label: 'Ghi chú'),
                    ),
                  ],
                ),
              )),
            ]),
          ),
        ),
        isScrollControlled: true,
        isDismissible: true,
        elevation: 0,
        backgroundColor: Colors.grey.withOpacity(0));
  }
}
