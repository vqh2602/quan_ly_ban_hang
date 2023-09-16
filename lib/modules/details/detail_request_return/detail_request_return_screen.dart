import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_request_return/detail_request_return_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
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
/// [requestReturnID]: id của salesOder, nếu type là chế độ view thì gọi api lấy tt

class DetailRequestReturnScreen extends StatefulWidget {
  const DetailRequestReturnScreen({super.key});
  static const String routeName = '/detail_request_return';

  @override
  State<DetailRequestReturnScreen> createState() => _DetailRequestReturnState();
}

class _DetailRequestReturnState extends State<DetailRequestReturnScreen> {
  DetailRequestReturnController detailRequestReturnController = Get.find();
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
    return detailRequestReturnController.obx(
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
              //           customer: detailRequestReturnController.customer,
              //           detailRequestReturnCustom: detailRequestReturnController
              //               .listDetailRequestReturnCustom,
              //           requestReturn: detailRequestReturnController.requestReturn,
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
                            children: [
                              textTitleMedium('Thông tin nhà cung cấp'),
                              if (isEdit)
                                IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                        detailRequestReturnController
                                            .obx((state) => showBottomListChose(
                                                  options:
                                                      detailRequestReturnController
                                                          .listSupplier,
                                                  value:
                                                      detailRequestReturnController
                                                          .supplierItemSelect,
                                                  onSelect: (p0) {
                                                    detailRequestReturnController
                                                        .supplierItemSelect = p0;
                                                    detailRequestReturnController
                                                        .updateUI();
                                                  },
                                                  onSearch: (val) {
                                                    ShareFuntion.searchList(
                                                        list:
                                                            detailRequestReturnController
                                                                .listSupplier,
                                                        value: val,
                                                        update: () {
                                                          detailRequestReturnController
                                                              .updateUI();
                                                        });
                                                  },
                                                  buildOption: (p0) =>
                                                      textBodyMedium(
                                                          p0.key ?? ''),
                                                )));
                                  },
                                  icon: const Icon(
                                      FontAwesomeIcons.lightPenToSquare),
                                  color: Get.theme.primaryColor,
                                ),
                            ],
                          ),
                          cHeight(12),
                          iconTitleIconTitle(
                            title1: isEdit
                                ? detailRequestReturnController
                                        .supplierItemSelect?.key ??
                                    ''
                                : detailRequestReturnController
                                        .requestReturn?.supplierName ??
                                    '',
                            title2: isEdit
                                ? detailRequestReturnController
                                        .supplierItemSelect?.data.phone ??
                                    ''
                                : detailRequestReturnController
                                        .supplier?.phone ??
                                    'Trống',
                            icon1: FontAwesomeIcons.user,
                            icon2: FontAwesomeIcons.phone,
                          ),
                          cHeight(12),
                          iconTitle2Line(
                            title: isEdit
                                ? detailRequestReturnController
                                        .supplierItemSelect?.data.address ??
                                    ''
                                : detailRequestReturnController
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
                            children: [
                              textTitleMedium('Danh sách sản phẩm'),
                              if (isEdit)
                                IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                        detailRequestReturnController.obx(
                                            (state) => showBottomListMutilChose(
                                                  options:
                                                      detailRequestReturnController
                                                          .listProduct,
                                                  value:
                                                      detailRequestReturnController
                                                          .listProductSelect,
                                                  onSelect: (p0) {
                                                    if (detailRequestReturnController
                                                            .listProductSelect
                                                            ?.contains(p0) ??
                                                        false) {
                                                      detailRequestReturnController
                                                          .listProductSelect
                                                          ?.remove(p0);
                                                    } else {
                                                      detailRequestReturnController
                                                          .listProductSelect
                                                          ?.add(p0);
                                                    }
                                                    detailRequestReturnController
                                                        .fillDataProduct();
                                                    detailRequestReturnController
                                                        .updateUI();
                                                  },
                                                  onSearch: (val) {
                                                    ShareFuntion.searchList(
                                                        list:
                                                            detailRequestReturnController
                                                                .listProduct,
                                                        value: val,
                                                        update: () {
                                                          detailRequestReturnController
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
                                itemCount: isEdit
                                    ? (detailRequestReturnController
                                        .listDetailRequestReturnCustomEdit
                                        ?.length)
                                    : detailRequestReturnController
                                        .listDetailRequestReturnCustom?.length,
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 12),
                                itemBuilder: (context, indext) {
                                  return itemProduct(
                                    product: isEdit
                                        ? (detailRequestReturnController
                                            .listDetailRequestReturnCustomEdit?[
                                                indext]
                                            .product
                                            ?.copyWith(
                                            importPrice:
                                                detailRequestReturnController
                                                    .listDetailRequestReturnCustomEdit?[
                                                        indext]
                                                    .detailRequestReturn
                                                    ?.importPrice,
                                          ))
                                        : detailRequestReturnController
                                            .listDetailRequestReturnCustom?[
                                                indext]
                                            .product
                                            ?.copyWith(
                                            importPrice:
                                                detailRequestReturnController
                                                    .listDetailRequestReturnCustom?[
                                                        indext]
                                                    .detailRequestReturn
                                                    ?.importPrice,
                                          ),
                                    listUnit:
                                        detailRequestReturnController.listUnit,
                                    isImportPrice: true,
                                    margin: const EdgeInsets.only(
                                        bottom: 12, top: 8, left: 8, right: 8),
                                    quantity: double.tryParse(isEdit
                                        ? (detailRequestReturnController
                                                .listDetailRequestReturnCustomEdit?[
                                                    indext]
                                                .detailRequestReturn
                                                ?.quantity
                                                .toString() ??
                                            '0')
                                        : detailRequestReturnController
                                                .listDetailRequestReturnCustom?[
                                                    indext]
                                                .detailRequestReturn
                                                ?.quantity
                                                .toString() ??
                                            '0'),
                                    onTap: isEdit
                                        ? () {
                                            if (isEdit) {
                                              showBottomSheetAddProduct(
                                                  detailRequestReturnCustom: isEdit
                                                      ? (detailRequestReturnController
                                                              .listDetailRequestReturnCustomEdit?[
                                                          indext])
                                                      : (detailRequestReturnController
                                                              .listDetailRequestReturnCustom?[
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
                                  ? detailRequestReturnController
                                      .calculateTotalMoney()
                                  : detailRequestReturnController
                                          .requestReturn?.totalMoney ??
                                      0),
                              showEdit: false),

                          titleEditTitle(
                            title: 'Tiền được hoàn',
                            value: ShareFuntion.formatCurrency(
                              isEdit
                                  ? num.parse(detailRequestReturnController
                                          .totalAmountRefundedTE?.text ??
                                      '0')
                                  : detailRequestReturnController
                                          .requestReturn?.totalAmountRefunded ??
                                      0,
                            ),
                            showEdit: false,
                            colorValue: a500,
                            onTap: () {
                              Get.bottomSheet(
                                showBottomTextInput(
                                    detailRequestReturnController
                                        .totalAmountRefundedTE,
                                    keyboardType: TextInputType.number,
                                    onCancel: () {
                                  detailRequestReturnController
                                      .totalAmountRefundedTE
                                      ?.text = detailRequestReturnController
                                          .requestReturn?.totalAmountRefunded
                                          .toString() ??
                                      '0';
                                }, onSubmitted: () {
                                  detailRequestReturnController.updateUI();
                                }),
                              );
                            },
                          ),
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
                              title: 'Tên yêu cầu',
                              value: isCreate
                                  ? detailRequestReturnController
                                          .nameTE?.text ??
                                      ''
                                  : detailRequestReturnController
                                          .requestReturn?.name ??
                                      '',
                              showEdit: isEdit,
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailRequestReturnController.nameTE,
                                      // keyboardType: TextInputType.number,
                                      onCancel: () {
                                    detailRequestReturnController.nameTE?.text =
                                        detailRequestReturnController
                                                .requestReturn?.name
                                                .toString() ??
                                            '0';
                                  }, onSubmitted: () {
                                    detailRequestReturnController.updateUI();
                                  }),
                                );
                              }),
                          titleEditTitle(
                              title: 'Tg tạo đơn',
                              value: ShareFuntion.formatDate(
                                  dateTime: detailRequestReturnController
                                      .requestReturn?.timeRequestReturn,
                                  type: TypeDate.ddMMyyyyhhmm),
                              showEdit: false),
                          titleEditTitle(
                              title: 'T.Thái NCC',
                              valueWidget: statusWidget(
                                  ShareFuntion.getStatusWithIDFunc(
                                              isEdit
                                                  ? detailRequestReturnController
                                                      .statusSupplierItemSelect
                                                      ?.value
                                                  : detailRequestReturnController
                                                      .requestReturn
                                                      ?.supplierStatus,
                                              listStatus:
                                                  detailRequestReturnController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(isEdit ? detailRequestReturnController.statusSupplierItemSelect?.value : detailRequestReturnController.requestReturn?.supplierStatus, listStatus: detailRequestReturnController.listStatus)?.color}'))),
                              value: '',
                              onTap: () {
                                Get.bottomSheet(detailRequestReturnController
                                    .obx((state) => showBottomListChose(
                                          options: detailRequestReturnController
                                              .listStatusOption
                                              ?.where((element) =>
                                                  element.data.group ==
                                                  'Trạng thái ncc')
                                              .toList(),
                                          value: detailRequestReturnController
                                              .statusSupplierItemSelect,
                                          onSelect: (p0) {
                                            detailRequestReturnController
                                                .statusSupplierItemSelect = p0;

                                            detailRequestReturnController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailRequestReturnController
                                                        .listStatusOption,
                                                value: val,
                                                update: () {
                                                  detailRequestReturnController
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
                                                  ? detailRequestReturnController
                                                      .statusBrowsingItemSelect
                                                      ?.value
                                                  : detailRequestReturnController
                                                      .requestReturn
                                                      ?.browsingStatus,
                                              listStatus:
                                                  detailRequestReturnController
                                                      .listStatus)
                                          ?.name ??
                                      '',
                                  Color(int.parse(
                                      '0xff${ShareFuntion.getStatusWithIDFunc(isEdit ? detailRequestReturnController.statusBrowsingItemSelect?.value : detailRequestReturnController.requestReturn?.browsingStatus, listStatus: detailRequestReturnController.listStatus)?.color}'))),
                              value: '',
                              onTap: () {
                                Get.bottomSheet(detailRequestReturnController
                                    .obx((state) => showBottomListChose(
                                          options: detailRequestReturnController
                                              .listStatusOption
                                              ?.where((element) =>
                                                  element.data.group ==
                                                  'Trạng thái duyệt')
                                              .toList(),
                                          value: detailRequestReturnController
                                              .statusBrowsingItemSelect,
                                          onSelect: (p0) {
                                            detailRequestReturnController
                                                .statusBrowsingItemSelect = p0;

                                            detailRequestReturnController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailRequestReturnController
                                                        .listStatusOption,
                                                value: val,
                                                update: () {
                                                  detailRequestReturnController
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
                                  ? detailRequestReturnController
                                          .personnelWarehouseItemSelect?.key ??
                                      ''
                                  : detailRequestReturnController.requestReturn
                                          ?.personnelWarehouseStaffName ??
                                      '',
                              showEdit: isEdit,
                              onTap: () {
                                Get.bottomSheet(detailRequestReturnController
                                    .obx((state) => showBottomListChose(
                                          options: detailRequestReturnController
                                              .listPersonnel,
                                          value: detailRequestReturnController
                                              .personnelWarehouseItemSelect,
                                          onSelect: (p0) {
                                            detailRequestReturnController
                                                .personnelWarehouseItemSelect = p0;

                                            detailRequestReturnController
                                                .updateUI();
                                          },
                                          onSearch: (val) {
                                            ShareFuntion.searchList(
                                                list:
                                                    detailRequestReturnController
                                                        .listPersonnel,
                                                value: val,
                                                update: () {
                                                  detailRequestReturnController
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
                                      detailRequestReturnController.noteTE,
                                      onCancel: () {
                                    detailRequestReturnController.noteTE?.text =
                                        detailRequestReturnController
                                                .requestReturn?.note
                                                .toString() ??
                                            '';
                                  }, onSubmitted: () {
                                    detailRequestReturnController.updateUI();
                                  }),
                                );
                              },
                              showEdit: isEdit),
                          ExpandableText(
                            isEdit
                                ? detailRequestReturnController.noteTE?.text ??
                                    'Trống'
                                : detailRequestReturnController
                                        .requestReturn?.note ??
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
                          await detailRequestReturnController.updateSaleOder();

                          return;
                        }
                        if (isCreate) {
                          await detailRequestReturnController.createSaleOder();
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
      {DetailRequestReturnCustom? detailRequestReturnCustom}) {
    TextEditingController quantityTE = TextEditingController(
        text: detailRequestReturnCustom?.detailRequestReturn?.quantity
                .toString() ??
            '1');
    TextEditingController noteTE = TextEditingController(
        text: detailRequestReturnCustom?.detailRequestReturn?.note ?? '');
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
                              detailRequestReturnController
                                  .updateProductInRequestReturnEdit(
                                      note: noteTE.text,
                                      product:
                                          detailRequestReturnCustom?.product,
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
                      product: detailRequestReturnCustom?.product,
                      listUnit: detailRequestReturnController.listUnit,
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
                                  (detailRequestReturnCustom
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
