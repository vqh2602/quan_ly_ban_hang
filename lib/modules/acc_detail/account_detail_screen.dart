// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';

import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/theme_textinput.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

class AccountDetailScreen extends StatefulWidget {
  final bool? isEdit;
  const AccountDetailScreen({
    Key? key,
    this.isEdit,
  }) : super(key: key);
  static const String routeName = '/account_detail';
  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  AccountDetailController accountDetailController =
      Get.put(AccountDetailController());
  GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormA1');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: (widget.isEdit ?? true)
          ? AppBar(
              title: textLableLarge( 'Chỉnh sửa tài khoản'),
              // leading: const SizedBox(),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: FxButton.medium(
                      onPressed: () {
                        if (keyForm1.currentState?.validate() ?? false) {
                          accountDetailController.updateUser();
                        }
                      },
                      shadowColor: Colors.transparent,
                      child: textBodyMedium('Lưu', color: Colors.white)),
                )
              ],
            )
          : null,
    );
  }

  Widget _buildBody() {
    return accountDetailController.obx((state) => SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: keyForm1,
            child: Container(
              margin: EdgeInsets.zero,
              padding: alignment_20_0(),
              // color: Get.theme.colorScheme.background,
              child: Column(
                children: [
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          accountDetailController.setAvatar();
                        },
                        child: Ink(
                          child: avatarImage(
                              url: '',
                              imageF: accountDetailController.base64Image,
                              isFileImage: true,
                              radius: 60),
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 5,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              onTap: () {},
                              style: textStyleCustom(fontSize: 16),
                              controller: accountDetailController.firstNameTE,
                              validator: accountDetailController.validateString,
                              decoration:
                                  textFieldInputStyle(label: 'Họ & tên(*)'),
                            ),
                            const SizedBox(
                              height: 4 * 5,
                            ),
                            TextFormField(
                              onTap: () {},
                              style: textStyleCustom(fontSize: 16),
                              controller: accountDetailController.lastNameTE,
                              validator: accountDetailController.validateString,
                              decoration:
                                  textFieldInputStyle(label: 'Số CCCD (*)'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextField(
                    onTap: () {},
                    style: textStyleCustom(fontSize: 16),
                    readOnly: true,
                    controller: accountDetailController.emailTE,
                    decoration: textFieldInputStyle(label: 'Số điện thoại'),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: textStyleCustom(fontSize: 16),
                    showCursor: false,
                    readOnly: true,
                    controller: accountDetailController.birtTE,
                    decoration: textFieldInputStyle(label: 'Năm sinh (*)'),
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  // Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         accountDetailController.sex = 1;
                  //         accountDetailController.updateUI();
                  //       },
                  //       child: Container(
                  //         padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(
                  //                 width: 1,
                  //                 color: accountDetailController.sex == 1
                  //                     ? Colors.black
                  //                     : Colors.grey)),
                  //         child: Center(
                  //           child: textBodyMedium(
                  //                'Nam',
                  //               color: accountDetailController.sex == 1
                  //                   ? Colors.black
                  //                   : Colors.grey),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 4 * 5,
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         accountDetailController.sex = 0;
                  //         accountDetailController.updateUI();
                  //       },
                  //       child: Container(
                  //         padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(
                  //                 width: 1,
                  //                 color: accountDetailController.sex == 0
                  //                     ? Colors.black
                  //                     : Colors.grey)),
                  //         child: Center(
                  //           child: textBodyMedium(
                  //                'Nữ',
                  //               color: accountDetailController.sex == 0
                  //                   ? Colors.black
                  //                   : Colors.grey),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 4 * 5,
                  // ),
                  TextField(
                    onTap: () {},
                    style: textStyleCustom(fontSize: 16),
                    controller: accountDetailController.addressTE,
                    decoration: textFieldInputStyle(label: 'Địa chỉ'),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          style: textStyleCustom(fontSize: 16),
                          controller: accountDetailController.heightTE,
                          validator: accountDetailController.numberValidator,
                          decoration: textFieldInputStyle(label: 'Chức vụ'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          style: textStyleCustom(fontSize: 16),
                          controller: accountDetailController.weightTE,
                          keyboardType: TextInputType.number,
                          validator: accountDetailController.numberValidator,
                          decoration: textFieldInputStyle(label: 'Giới tính'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
