import 'dart:io';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/box_detail.dart';
import 'package:quan_ly_ban_hang/widgets/image_custom.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/s_show_chose.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

/// tham số truyền vào
/// [type]: **view** - xem, và sửa; **create** - tạo
/// [productID]: id của product, nếu type là chế độ view thì gọi api lấy tt sản phẩm
class DetailProductSreen extends StatefulWidget {
  const DetailProductSreen({super.key});
  static const String routeName = '/detail_product';

  @override
  State<DetailProductSreen> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProductSreen> {
  DetailProductController detailProductController = Get.find();
  final ImagePicker picker = ImagePicker();
  var arguments = Get.arguments;
  bool isView = false; // XEM HAY LÀ TẠO MỚI
  bool isIconEdit = false; // hiển thị icon edit
  @override
  void initState() {
    if (arguments['type'] == 'view') {
      setState(() {
        isView = true;
      });
    }
    if (arguments['type'] == 'create') {
      setState(() {
        isIconEdit = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return detailProductController.obx(
        (state) => buildBody(
              context: context,
              backgroundColor: bg500,
              body: Form(
                key: detailProductController.formKey,
                child: SafeArea(
                    // margin: alignment_20_0(),
                    // constraints: const BoxConstraints(maxHeight: 750),
                    child: RefreshIndicator(
                  onRefresh: () async {},
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
                                textTitleMedium('Ảnh sản phẩm'),
                                isIconEdit
                                    ? IconButton(
                                        onPressed: () async {
                                          // Pick an image.
                                          final XFile? image =
                                              await picker.pickImage(
                                            source: ImageSource.gallery,
                                          );
                                          if (image != null) {
                                            File file = File(image.path);
                                            detailProductController
                                                .uploadImageWithImgur(file);
                                          }
                                        },
                                        icon: const Icon(
                                            FontAwesomeIcons.lightPenToSquare),
                                        color: Get.theme.primaryColor,
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            cHeight(4),
                            Hero(
                              tag: 'hero_show_image-1',
                              child: GestureDetector(
                                onTap: () async {
                                  if (isView) {
                                    Get.to(ViewImageWithZoom(
                                        url: detailProductController
                                                .product?.image ??
                                            'Trống',
                                        index: -1));
                                  } else {
                                    // Pick an image.
                                    final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (image != null) {
                                      File file = File(image.path);
                                      detailProductController
                                          .uploadImageWithImgur(file);
                                    }
                                  }
                                },
                                child: SizedBox(
                                    width: Get.width,
                                    height: Get.width * 0.5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: imageNetwork(
                                          url: isView
                                              ? detailProductController
                                                      .product?.image ??
                                                  'Trống'
                                              : detailProductController
                                                      .imageUrl ??
                                                  'Trống',
                                          fit: BoxFit.cover),
                                    )),
                              ),
                            )
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
                              title: 'Mã sản phẩm',
                              showEdit: isIconEdit,
                              value: isView
                                  ? detailProductController.product?.code ??
                                      'Trống'
                                  : detailProductController.codeTE?.text ??
                                      'Trống',
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailProductController.codeTE,
                                      onCancel: () {
                                    detailProductController.codeTE?.text =
                                        detailProductController.product?.code ??
                                            '';
                                  }, onSubmitted: () {
                                    detailProductController.updateUI();
                                  }),
                                );
                              },
                            ),
                            //  cHeight(2),
                            titleEditTitle(
                              title: 'Tên sản phẩm',
                              showEdit: isIconEdit,
                              value: isView
                                  ? detailProductController.product?.name ??
                                      'Trống'
                                  : detailProductController.nameTE?.text ??
                                      'Trống',
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailProductController.nameTE,
                                      onCancel: () {
                                    detailProductController.nameTE?.text =
                                        detailProductController.product?.name ??
                                            '';
                                  }, onSubmitted: () {
                                    detailProductController.updateUI();
                                  }),
                                );
                              },
                            ),
                            titleEditTitle(
                              title: 'Mã vạch',
                              showEdit: isIconEdit,
                              value: isView
                                  ? detailProductController.product?.bardcode ??
                                      'Trống'
                                  : detailProductController.barcodeTE?.text ??
                                      'Trống',
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailProductController.barcodeTE,
                                      onCancel: () {
                                    detailProductController.barcodeTE?.text =
                                        detailProductController
                                                .product?.bardcode ??
                                            '';
                                  }, onSubmitted: () {
                                    detailProductController.updateUI();
                                  }),
                                );
                              },
                            ),
                            titleEditTitle(
                              title: 'Giá bán',
                              showEdit: isIconEdit,
                              value: ShareFuntion.formatCurrency(isView
                                  ? detailProductController.product?.price ?? 0
                                  : double.parse(
                                      detailProductController.priceTE?.text ??
                                          '0')),
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailProductController.priceTE,
                                      keyboardType: TextInputType.number,
                                      onCancel: () {
                                    detailProductController.priceTE?.text =
                                        detailProductController.product?.price
                                                .toString() ??
                                            '0';
                                  }, onSubmitted: () {
                                    detailProductController.updateUI();
                                  }),
                                );
                              },
                            ),
                            titleEditTitle(
                                title: 'Giá nhập',
                                value: ShareFuntion.formatCurrency(isView
                                    ? detailProductController
                                            .product?.importPrice ??
                                        0
                                    : double.parse(detailProductController
                                            .importPriceTE?.text ??
                                        '0')),
                                onTap: () {
                                  Get.bottomSheet(
                                    showBottomTextInput(
                                        detailProductController.importPriceTE,
                                        keyboardType: TextInputType.number,
                                        onCancel: () {
                                      detailProductController.importPriceTE
                                          ?.text = detailProductController
                                              .product?.importPrice
                                              .toString() ??
                                          '0';
                                    }, onSubmitted: () {
                                      detailProductController.updateUI();
                                    }),
                                  );
                                },
                                showEdit: isIconEdit),
                            titleEditTitle(
                                title: 'Đơn vị',
                                showEdit: isIconEdit,
                                value: isView
                                    ? ShareFuntion.getUnitWithIDFunc(
                                                detailProductController
                                                    .product?.unit,
                                                listUnit:
                                                    detailProductController
                                                        .listUnit
                                                        ?.map((e) =>
                                                            e.data as Unit)
                                                        .toList())
                                            ?.name ??
                                        'Trống'
                                    : detailProductController
                                            .selectedUnit?.key ??
                                        'Trống',
                                onTap: () {
                                  Get.bottomSheet(detailProductController
                                      .obx((state) => showBottomListChose(
                                            options: detailProductController
                                                .listUnit,
                                            value: detailProductController
                                                .selectedUnit,
                                            onSelect: (p0) {
                                              detailProductController
                                                  .selectedUnit = p0;
                                              detailProductController
                                                  .updateUI();
                                            },
                                            buildOption: (p0) =>
                                                textBodyMedium(p0.key ?? ''),
                                          )));
                                }),
                            titleEditTitle(
                              title: 'Số lượng',
                              showEdit: isIconEdit,
                              value: isView
                                  ? detailProductController.product?.quantity
                                          .toString() ??
                                      '0'
                                  : detailProductController.quantityTE?.text ??
                                      '0',
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailProductController.quantityTE,
                                      keyboardType: TextInputType.number,
                                      onCancel: () {
                                    detailProductController.quantityTE?.text =
                                        detailProductController
                                                .product?.quantity
                                                .toString() ??
                                            '0';
                                  }, onSubmitted: () {
                                    detailProductController.updateUI();
                                  }),
                                );
                              },
                            ),
                            // titleEditTitle(title: 'Hãng sản suất', value: 'Vietcom'),
                            titleEditTitle(
                              title: 'Giảm giá',
                              showEdit: isIconEdit,
                              value: isView
                                  ? '${detailProductController.product?.discount.toString() ?? '0'} %'
                                  : '${detailProductController.discountTE?.text ?? '0'} %',
                              onTap: () {
                                Get.bottomSheet(
                                  showBottomTextInput(
                                      detailProductController.discountTE,
                                      keyboardType: TextInputType.number,
                                      onCancel: () {
                                    detailProductController.discountTE?.text =
                                        detailProductController
                                                .product?.discount
                                                .toString() ??
                                            '0';
                                  }, onSubmitted: () {
                                    detailProductController.updateUI();
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textTitleMedium('Danh mục (nhãn)'),
                                isIconEdit
                                    ? IconButton(
                                        onPressed: () {
                                          Get.bottomSheet(
                                              detailProductController.obx(
                                                  (state) =>
                                                      showBottomListMutilChose(
                                                        options:
                                                            detailProductController
                                                                .listCategory,
                                                        value: detailProductController
                                                            .listCategorySelect,
                                                        onSelect: (p0) {
                                                          if (detailProductController
                                                                  .listCategorySelect
                                                                  ?.contains(
                                                                      p0) ??
                                                              false) {
                                                            detailProductController
                                                                .listCategorySelect
                                                                ?.remove(p0);
                                                          } else {
                                                            detailProductController
                                                                .listCategorySelect
                                                                ?.add(p0);
                                                          }
                                                          detailProductController
                                                              .updateUI();
                                                        },
                                                        buildOption: (p0) =>
                                                            textBodyMedium(
                                                                p0.key ?? ''),
                                                      )));
                                        },
                                        icon: const Icon(
                                            FontAwesomeIcons.lightPenToSquare),
                                        color: Get.theme.primaryColor,
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            cHeight(4),
                            Wrap(
                              // spacing: 8,
                              children: [
                                for (var category in detailProductController
                                        .listCategorySelect ??
                                    []) ...[
                                  Chip(
                                    label: textBodyMedium(category.key),
                                    avatar: Icon(
                                      FontAwesomeIcons.solidTag,
                                      color: Color(int.parse(
                                          '0xff${category.data.color}')),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    side: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                    shape: const StadiumBorder(),

                                    // shadowColor: Colors.amber,
                                    // backgroundColor: Colors.red,
                                  )
                                ]
                              ],
                            )
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
                                isIconEdit
                                    ? IconButton(
                                        onPressed: () {
                                          Get.bottomSheet(
                                            showBottomTextInput(
                                                detailProductController.noteTE,
                                                onCancel: () {
                                              detailProductController
                                                      .noteTE?.text =
                                                  detailProductController
                                                          .product?.note ??
                                                      '';
                                            }, onSubmitted: () {
                                              detailProductController
                                                  .updateUI();
                                            }),
                                          );
                                        },
                                        icon: const Icon(
                                            FontAwesomeIcons.lightPenToSquare),
                                        color: Get.theme.primaryColor,
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            cHeight(4),
                            ExpandableText(
                              isView
                                  ? detailProductController.product?.note ??
                                      'Trống'
                                  : detailProductController.noteTE?.text ??
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
              ),
              appBar: AppBar(
                title: textTitleLarge(isView
                    ? detailProductController.product?.code ?? 'Trống'
                    : detailProductController.codeTE?.text ?? 'Trống'),
                centerTitle: false,
                surfaceTintColor: bg500,
                backgroundColor: bg500,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: FxButton.medium(
                      borderRadiusAll: 100,
                      onPressed: () {
                        setState(() {
                          isIconEdit = !isIconEdit;
                          if (isIconEdit) {
                            isView = false;
                          } else {
                            isView = true;
                          }
                        });

                        if (arguments['type'] == 'view' && !isIconEdit) {
                          detailProductController.updateProduct();
                          return;
                        }
                        if (arguments['type'] == 'create' && !isIconEdit) {
                          detailProductController.createProduct();
                          isView = false;
                          isIconEdit = true;
                          return;
                        }
                      },
                      shadowColor: Colors.transparent,
                      child: arguments['type'] == 'view'
                          ? isIconEdit
                              ? textTitleMedium('Lưu', color: Colors.white)
                              : textTitleMedium('Sửa', color: Colors.white)
                          : textTitleMedium('Tạo', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        onLoading: const LoadingCustom());
  }
}
