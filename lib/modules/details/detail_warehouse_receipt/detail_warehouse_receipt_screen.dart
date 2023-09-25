import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_warehouse_receipt/detail_warehouse_receipt_controller.dart';
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
/// [warehouseReceiptID]: id của salesOder, nếu type là chế độ view thì gọi api lấy tt

class DetailWarehouseReceiptScreen extends StatefulWidget {
  const DetailWarehouseReceiptScreen({super.key});
  static const String routeName = '/detail_warehouse_receipt';

  @override
  State<DetailWarehouseReceiptScreen> createState() =>
      _DetailWarehouseReceiptState();
}

class _DetailWarehouseReceiptState extends State<DetailWarehouseReceiptScreen> {
  DetailWarehouseReceiptController detailWarehouseReceiptController =
      Get.find();
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
    return detailWarehouseReceiptController.obx(
        (state) => buildBody(
              context: context,
              backgroundColor: bg500,
              // createFloatingActionButton:
              //  AnimatedSlide(
              //   duration: const Duration(milliseconds: 300),
              //   offset: (showFab && !isEdit) ? Offset.zero : const Offset(0, 2),
              //   child: AnimatedOpacity(
              //     duration: const Duration(milliseconds: 300),
              //     opacity: showFab ? 1 : 0,
              //     child: FloatingActionButton.extended(
              //       label: Wrap(
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           spacing: 8,
              //           children: [
              //             const Icon(
              //               FontAwesomeIcons.print,
              //               color: Colors.white,
              //             ),
              //             textLableMedium('In hoá đơn', color: Colors.white)
              //           ]),
              //       onPressed: () async {
              //         // await NetworkPrinter().printTicket(await mainESCPOS());
              //         await NativePrinter().nativePrint(
              //           customer: detailWarehouseReceiptController.customer,
              //           detailWarehouseReceiptCustom: detailWarehouseReceiptController
              //               .listDetailWarehouseReceiptCustom,
              //           warehouseReceipt: detailWarehouseReceiptController.warehouseReceipt,
              //         );
              //       },
              //     ),
              //   ),
              // ),

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
                      boxDetail(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textTitleMedium('Thông tin nhà cung cấp'),
                              if (isEdit)
                                IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                        detailWarehouseReceiptController
                                            .obx((state) => showBottomListChose(
                                                  options:
                                                      detailWarehouseReceiptController
                                                          .listSupplier,
                                                  value:
                                                      detailWarehouseReceiptController
                                                          .supplierItemSelect,
                                                  onSelect: (p0) {
                                                    detailWarehouseReceiptController
                                                        .supplierItemSelect = p0;
                                                    detailWarehouseReceiptController
                                                        .updateUI();
                                                  },
                                                  onSearch: (val) {
                                                    ShareFuntion.searchList(
                                                        list:
                                                            detailWarehouseReceiptController
                                                                .listSupplier,
                                                        value: val,
                                                        update: () {
                                                          detailWarehouseReceiptController
                                                              .updateUI();
                                                        });
                                                  },
                                                  buildOption: (p0) =>
                                                      textBodyMedium(
                                                          p0.key ?? ''),
                                                )));
                                  },
                                  icon: const Icon(
                                      FontAwesomeIcons.lightPenToSquare, size: 18,),
                                  color: Get.theme.primaryColor,
                                ),
                            ],
                          ),
                          cHeight(12),
                          iconTitleIconTitle(
                            title1: isEdit
                                ? detailWarehouseReceiptController
                                        .supplierItemSelect?.key ??
                                    ''
                                : detailWarehouseReceiptController
                                        .warehouseReceipt?.supplierName ??
                                    '',
                            title2: isEdit
                                ? detailWarehouseReceiptController
                                        .supplierItemSelect?.data.phone ??
                                    ''
                                : detailWarehouseReceiptController
                                        .supplier?.phone ??
                                    'Trống',
                            icon1: FontAwesomeIcons.user,
                            icon2: FontAwesomeIcons.phone,
                          ),
                          cHeight(12),
                          iconTitle2Line(
                            title: isEdit
                                ? detailWarehouseReceiptController
                                        .supplierItemSelect?.data.address ??
                                    ''
                                : detailWarehouseReceiptController
                                        .supplier?.address ??
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
                                        detailWarehouseReceiptController.obx(
                                            (state) => showBottomListMutilChose(
                                                  options:
                                                      detailWarehouseReceiptController
                                                          .listProduct,
                                                  value:
                                                      detailWarehouseReceiptController
                                                          .listProductSelect,
                                                  onSelect: (p0) {
                                                    if (detailWarehouseReceiptController
                                                            .listProductSelect
                                                            ?.contains(p0) ??
                                                        false) {
                                                      detailWarehouseReceiptController
                                                          .listProductSelect
                                                          ?.remove(p0);
                                                    } else {
                                                      detailWarehouseReceiptController
                                                          .listProductSelect
                                                          ?.add(p0);
                                                    }
                                                    detailWarehouseReceiptController
                                                        .fillDataProduct();
                                                    detailWarehouseReceiptController
                                                        .updateUI();
                                                  },
                                                  onSearch: (val) {
                                                    ShareFuntion.searchList(
                                                        list:
                                                            detailWarehouseReceiptController
                                                                .listProduct,
                                                        value: val,
                                                        update: () {
                                                          detailWarehouseReceiptController
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
                                                              p0.key ?? ''))
                                                    ],
                                                  ),
                                                )));
                                  },
                                  icon: const Icon(
                                      FontAwesomeIcons.lightPenToSquare, size: 18,),
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
                                    ? (detailWarehouseReceiptController
                                        .listDetailWarehouseReceiptCustomEdit
                                        ?.length)
                                    : detailWarehouseReceiptController
                                        .listDetailWarehouseReceiptCustom
                                        ?.length,
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 12),
                                itemBuilder: (context, indext) {
                                  return itemProduct(
                                    product: isEdit
                                        ? (detailWarehouseReceiptController
                                            .listDetailWarehouseReceiptCustomEdit?[
                                                indext]
                                            .product
                                            ?.copyWith(
                                            importPrice:
                                                detailWarehouseReceiptController
                                                    .listDetailWarehouseReceiptCustomEdit?[
                                                        indext]
                                                    .detailWarehouseReceipt
                                                    ?.importPrice,
                                          ))
                                        : detailWarehouseReceiptController
                                            .listDetailWarehouseReceiptCustom?[
                                                indext]
                                            .product
                                            ?.copyWith(
                                            importPrice:
                                                detailWarehouseReceiptController
                                                    .listDetailWarehouseReceiptCustom?[
                                                        indext]
                                                    .detailWarehouseReceipt
                                                    ?.importPrice,
                                          ),
                                    listUnit: detailWarehouseReceiptController
                                        .listUnit,
                                    isImportPrice: true,
                                    margin: const EdgeInsets.only(
                                        bottom: 12, top: 8, left: 8, right: 8),
                                    quantity: double.tryParse(isEdit
                                        ? (detailWarehouseReceiptController
                                                .listDetailWarehouseReceiptCustomEdit?[
                                                    indext]
                                                .detailWarehouseReceipt
                                                ?.quantity
                                                .toString() ??
                                            '0')
                                        : detailWarehouseReceiptController
                                                .listDetailWarehouseReceiptCustom?[
                                                    indext]
                                                .detailWarehouseReceipt
                                                ?.quantity
                                                .toString() ??
                                            '0'),
                                    onTap: isEdit
                                        ? () {
                                            if (isEdit) {
                                              showBottomSheetAddProduct(
                                                  detailWarehouseReceiptCustom: isEdit
                                                      ? (detailWarehouseReceiptController
                                                              .listDetailWarehouseReceiptCustomEdit?[
                                                          indext])
                                                      : (detailWarehouseReceiptController
                                                              .listDetailWarehouseReceiptCustom?[
                                                          indext]));
                                            }
                                          }
                                        : null,
                                    // onHoverDelete: () {
                                    //   ShareFuntion.onPopDialog(
                                    //       context: context,
                                    //       onCancel: () {
                                    //         Get.back();
                                    //       },
                                    //       onSubmit: () {
                                    //         Get.back();
                                    //       },
                                    //       title:
                                    //           'Xoá sản phẩm ra khỏi danh sách');
                                    // }
                                  );
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
                                  ? detailWarehouseReceiptController
                                      .calculateTotalMoney()
                                  : detailWarehouseReceiptController
                                          .warehouseReceipt?.totalMoney ??
                                      0),
                              showEdit: false),

                          titleEditTitle(
                              title: 'Thành tiền',
                              value: ShareFuntion.formatCurrency(
                                isEdit
                                    ? detailWarehouseReceiptController
                                        .calculateTotalMoney()
                                    : detailWarehouseReceiptController
                                            .warehouseReceipt?.totalMoney ??
                                        0,
                              ),
                              showEdit: false,
                              colorValue: a500),
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
                              title: 'Mã đơn nhập',
                              value: isCreate
                                  ? detailWarehouseReceiptController
                                          .uidCreate ??
                                      ''
                                  : detailWarehouseReceiptController
                                          .warehouseReceipt?.uid ??
                                      '',
                              showEdit: false),
                          titleEditTitle(
                              title: 'Tg tạo đơn',
                              value: ShareFuntion.formatDate(
                                  dateTime: detailWarehouseReceiptController
                                      .warehouseReceipt?.timeWarehouse,
                                  type: TypeDate.ddMMyyyyhhmm),
                              showEdit: false),
                          titleEditTitle(
                              title: 'T.Thái thanh toán',
                              valueWidget: statusWidget(
                                  ShareFuntion.getStatusWithIDFunc(
                                              isEdit
                                                  ? detailWarehouseReceiptController
                                                      .statusPayItemSelect
                                                      ?.value
                                                  : detailWarehouseReceiptController
                                                      .warehouseReceipt
                                                      ?.paymentStatus,
                                              listStatus:
                                                  detailWarehouseReceiptController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(isEdit ? detailWarehouseReceiptController.statusPayItemSelect?.value : detailWarehouseReceiptController.warehouseReceipt?.paymentStatus, listStatus: detailWarehouseReceiptController.listStatus)?.color}'))),
                              value: '',
                              onTap: () {
                                Get.bottomSheet(detailWarehouseReceiptController
                                    .obx((state) => showBottomListChose(
                                          options:
                                              detailWarehouseReceiptController
                                                  .listStatusOption
                                                  ?.where((element) =>
                                                      element.data.group ==
                                                      'Trạng thái thanh toán')
                                                  .toList(),
                                          value:
                                              detailWarehouseReceiptController
                                                  .statusPayItemSelect,
                                          onSelect: (p0) {
                                            detailWarehouseReceiptController
                                                .statusPayItemSelect = p0;

                                            detailWarehouseReceiptController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailWarehouseReceiptController
                                                        .listStatusOption,
                                                value: val,
                                                update: () {
                                                  detailWarehouseReceiptController
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
                                                  ? detailWarehouseReceiptController
                                                      .statusDeliverItemSelect
                                                      ?.value
                                                  : detailWarehouseReceiptController
                                                      .warehouseReceipt
                                                      ?.deliveryStatus,
                                              listStatus:
                                                  detailWarehouseReceiptController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(isEdit ? detailWarehouseReceiptController.statusDeliverItemSelect?.value : detailWarehouseReceiptController.warehouseReceipt?.deliveryStatus, listStatus: detailWarehouseReceiptController.listStatus)?.color}'))),
                              value: '',
                              onTap: () {
                                Get.bottomSheet(detailWarehouseReceiptController
                                    .obx((state) => showBottomListChose(
                                          options:
                                              detailWarehouseReceiptController
                                                  .listStatusOption
                                                  ?.where((element) =>
                                                      element.data.group ==
                                                      'trạng thái giao hàng')
                                                  .toList(),
                                          value:
                                              detailWarehouseReceiptController
                                                  .statusDeliverItemSelect,
                                          onSelect: (p0) {
                                            detailWarehouseReceiptController
                                                .statusDeliverItemSelect = p0;

                                            detailWarehouseReceiptController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailWarehouseReceiptController
                                                        .listStatusOption,
                                                value: val,
                                                update: () {
                                                  detailWarehouseReceiptController
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
                              title: 'T.Thái duyệt',
                              valueWidget: statusWidget(
                                  ShareFuntion.getStatusWithIDFunc(
                                              isEdit
                                                  ? detailWarehouseReceiptController
                                                      .statusBrowsingItemSelect
                                                      ?.value
                                                  : detailWarehouseReceiptController
                                                      .warehouseReceipt
                                                      ?.browsingStatus,
                                              listStatus:
                                                  detailWarehouseReceiptController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(isEdit ? detailWarehouseReceiptController.statusBrowsingItemSelect?.value : detailWarehouseReceiptController.warehouseReceipt?.browsingStatus, listStatus: detailWarehouseReceiptController.listStatus)?.color}'))),
                              value: '',
                              onTap: () {
                                if (ShareFuntion().checkPermissionUserLogin(
                                    permission: ['QL', 'AD'])) {
                                } else {
                                  buildToast(
                                      message:
                                          'Không có quyền xem thông tin',
                                      status: TypeToast.toastError);
                                  return;
                                }
                                Get.bottomSheet(detailWarehouseReceiptController
                                    .obx((state) => showBottomListChose(
                                          options:
                                              detailWarehouseReceiptController
                                                  .listStatusOption
                                                  ?.where((element) =>
                                                      element.data.group ==
                                                      'Trạng thái duyệt')
                                                  .toList(),
                                          value:
                                              detailWarehouseReceiptController
                                                  .statusBrowsingItemSelect,
                                          onSelect: (p0) {
                                            detailWarehouseReceiptController
                                                .statusBrowsingItemSelect = p0;

                                            detailWarehouseReceiptController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailWarehouseReceiptController
                                                        .listStatusOption,
                                                value: val,
                                                update: () {
                                                  detailWarehouseReceiptController
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
                              title: 'Nhân viên nhập kho',
                              value: isEdit
                                  ? detailWarehouseReceiptController
                                          .personnelWarehouseItemSelect?.key ??
                                      ''
                                  : detailWarehouseReceiptController
                                          .warehouseReceipt
                                          ?.personnelWarehouseStaffName ??
                                      '',
                              showEdit: isEdit,
                              onTap: () {
                                Get.bottomSheet(detailWarehouseReceiptController
                                    .obx((state) => showBottomListChose(
                                          options:
                                              detailWarehouseReceiptController
                                                  .listPersonnel,
                                          value:
                                              detailWarehouseReceiptController
                                                  .personnelWarehouseItemSelect,
                                          onSelect: (p0) {
                                            detailWarehouseReceiptController
                                                .personnelWarehouseItemSelect = p0;

                                            detailWarehouseReceiptController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailWarehouseReceiptController
                                                        .listPersonnel,
                                                value: val,
                                                update: () {
                                                  detailWarehouseReceiptController
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
                                                  child: textBodyMedium(
                                                      p0.key ?? ''))
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
                                      detailWarehouseReceiptController.noteTE,
                                      onCancel: () {
                                    detailWarehouseReceiptController
                                            .noteTE?.text =
                                        detailWarehouseReceiptController
                                                .warehouseReceipt?.note
                                                .toString() ??
                                            '';
                                  }, onSubmitted: () {
                                    detailWarehouseReceiptController.updateUI();
                                  }),
                                );
                              },
                              showEdit: isEdit),
                          ExpandableText(
                            isEdit
                                ? detailWarehouseReceiptController
                                        .noteTE?.text ??
                                    'Trống'
                                : detailWarehouseReceiptController
                                        .warehouseReceipt?.note ??
                                    'Trống',
                            expandText: 'xem thêm',
                            collapseText: 'thu gọn',
                            maxLines: 4,
                            linkColor: Get.theme.primaryColor,
                            style: textStyleCustom(
                              fontSize: 15.5,
                            ),
                          ),
                        ],
                      )),
                      cHeight(50),
                    ],
                  ),
                ),
              )),
              appBar: AppBar(
                title: textTitleLarge('Thông tin đơn nhập kho'),
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
                            permission: ['QL', 'NK', 'C_NK', 'E_NK', 'AD'])) {
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
                          await detailWarehouseReceiptController
                              .updateSaleOder();

                          return;
                        }
                        if (isCreate) {
                          await detailWarehouseReceiptController
                              .createSaleOder();
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
  showBottomSheetAddProduct(
      {DetailWarehouseReceiptCustom? detailWarehouseReceiptCustom}) {
    TextEditingController quantityTE = TextEditingController(
        text: detailWarehouseReceiptCustom?.detailWarehouseReceipt?.quantity
                .toString() ??
            '1');
    TextEditingController noteTE = TextEditingController(
        text: detailWarehouseReceiptCustom?.detailWarehouseReceipt?.note ?? '');
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
                              detailWarehouseReceiptController
                                  .updateProductInWarehouseReceiptEdit(
                                      note: noteTE.text,
                                      product:
                                          detailWarehouseReceiptCustom?.product,
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
                      product: detailWarehouseReceiptCustom?.product,
                      listUnit: detailWarehouseReceiptController.listUnit,
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
                                  (detailWarehouseReceiptCustom
                                          ?.product?.quantity ??
                                      0)) {
                                return 'Vượt quá giới hạn kho';
                              }
                              return null;
                            },
                            readOnly: (isView || isCreate) ? false : true,
                            decoration: textFieldInputStyle(label: 'Số lượng'),
                            textAlign: TextAlign.center,
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
