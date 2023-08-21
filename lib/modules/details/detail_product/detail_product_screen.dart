import 'dart:io';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/compoment/box_detail.dart';
import 'package:quan_ly_ban_hang/widgets/image_custom.dart';
import 'package:quan_ly_ban_hang/widgets/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class DetailProductSreen extends StatefulWidget {
  const DetailProductSreen({super.key});
  static const String routeName = '/list_product';

  @override
  State<DetailProductSreen> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProductSreen> {
  DetailProductController detailProductController =
      Get.put(DetailProductController());
  final ImagePicker picker = ImagePicker();

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
              boxDetail(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textTitleMedium(text: 'Ảnh sản phẩm'),
                  cHeight(4),
                  GestureDetector(
                    onTap: () async {
                      // Pick an image.
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        File file = File(image.path);
                        detailProductController.uploadImageWithImgur(file);
                      }
                    },
                    child: SizedBox(
                        width: Get.width,
                        height: Get.width * 0.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: imageNetwork(
                              url: detailProductController.imageUrl ?? '',
                              fit: BoxFit.cover),
                        )),
                  )
                ],
              )),
              cHeight(16),
              boxDetail(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textTitleMedium(text: 'Thông tin'),
                  cHeight(4),
                  titleEditTitle(title: 'Mã sản phẩm', value: 'Điều hoà 100 u'),
                  //  cHeight(2),
                  titleEditTitle(
                      title: 'Tên sản phẩm', value: 'Điều hoà 100 u'),
                  titleEditTitle(title: 'Mã vạch', value: '1263576383'),
                  titleEditTitle(
                      title: 'Giá bán', value: formatCurrency(59000008)),
                  titleEditTitle(
                      title: 'Giá nhập', value: formatCurrency(57000008)),
                  titleEditTitle(title: 'Đơn vị', value: 'Cái'),
                  titleEditTitle(title: 'Số lượng', value: '399'),
                  titleEditTitle(title: 'Hãng sản suất', value: 'Vietcom'),
                  titleEditTitle(title: 'Giảm giá', value: '0%'),
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
                      textTitleMedium(text: 'Danh mục (nhãn)'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.lightPenToSquare),
                        color: Get.theme.primaryColor,
                      ),
                    ],
                  ),
                  cHeight(4),
                  Wrap(
                    // spacing: 8,
                    children: [
                      for (int i = 0; i < 5; i++) ...[
                        Chip(
                          label: textBodyMedium(text: 'Điều hoà hoà'),
                          avatar: const Icon(
                            FontAwesomeIcons.solidTag,
                            color: Colors.amberAccent,
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
                      textTitleMedium(text: 'Ghi chú'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.lightPenToSquare),
                        color: Get.theme.primaryColor,
                      ),
                    ],
                  ),
                  cHeight(4),
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
        title: textTitleLarge(text: 'SP.12082023.YYSB'),
        surfaceTintColor: bg500,
        backgroundColor: bg500,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: FxButton.medium(
              onPressed: () {},
              shadowColor: Colors.transparent,
              child: textTitleMedium(text: 'Sửa', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
