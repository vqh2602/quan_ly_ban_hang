// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';

import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/image_custom.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/s_show_chose.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/theme_textinput.dart';

/// tham số truyền vào
/// [type]: **view** - xem, và sửa; **create** - tạo ,**user** là người dùng đang đăng nhập
/// [personnelID]: id của nhân viên, nếu type là chế độ view thì gọi api lấy tt nhân viên
class AccountDetailScreen extends StatefulWidget {
  final bool? isEdit;
  final bool? isRefesh;
  const AccountDetailScreen({
    Key? key,
    this.isRefesh,
    this.isEdit,
  }) : super(key: key);
  static const String routeName = '/account_detail';
  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  AccountDetailController accountDetailController =
      Get.put(AccountDetailController());
  var arguments = Get.arguments;
  final ImagePicker picker = ImagePicker();
  bool isView = false; // XEM HAY LÀ TẠO MỚI
  bool isCreate = false; // hiển thị icon edit
  bool isUser = true; // ng dùng hiện tại

  @override
  void initState() {
    if (Get.arguments != null) {
      if (arguments['type'] == 'view') {
        setState(() {
          isView = true;
          isUser = false;
        });
        // accountDetailController.loadingUI();
        accountDetailController.getDataUser(id: arguments['personnelID']);
      }
      if (arguments['type'] == 'create') {
        setState(() {
          isCreate = true;
          isUser = false;
        });
        accountDetailController.initData();
      }
      if (arguments['type'] == 'user' ||
          (arguments['type'] == null || arguments == null)) {
        setState(() {
          isUser = true;
        });
        // accountDetailController.loadingUI();
        accountDetailController.getDataUser();
      } else {
        // accountDetailController.getDataUser();
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: (widget.isEdit ?? true)
          ? AppBar(
              title: textLableLarge('Thông tin tài khoản'),
              // leading: const SizedBox(),
              surfaceTintColor: bg500,
              backgroundColor: bg500,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: FxButton.medium(
                      onPressed: () {
                        if (accountDetailController.formKey.currentState
                                ?.validate() ??
                            false) {
                          if (isView || isUser) {
                            accountDetailController.updateUser(
                                isUpdateUserLogin: isUser);
                          } else {
                            accountDetailController.createPersonnel();
                          }
                        }
                      },
                      shadowColor: Colors.transparent,
                      child: textBodyMedium(isCreate ? 'Tạo' : 'Lưu',
                          color: Colors.white)),
                )
              ],
            )
          : null,
    );
  }

  Widget _buildBody() {
    return accountDetailController.obx(
        (state) => SafeArea(
                child: SingleChildScrollView(
              child: Form(
                key: accountDetailController.formKey,
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
                            borderRadius: BorderRadius.circular(20),
                            onTap: () async {
                              if (isCreate || isView || isUser) {
                                accountDetailController.setAvatar();
                              }
                            },
                            child: Ink(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.transparent,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: imageNetwork(
                                        url: accountDetailController.avatar ??
                                            '',
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
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
                                  controller: accountDetailController.nameTE,
                                  validator:
                                      accountDetailController.validateString,
                                  readOnly: (isView || isCreate) ? false : true,
                                  decoration:
                                      textFieldInputStyle(label: 'Họ & tên(*)'),
                                ),
                                const SizedBox(
                                  height: 4 * 5,
                                ),
                                TextFormField(
                                  onTap: () {},
                                  style: textStyleCustom(fontSize: 16),
                                  controller: accountDetailController.CCCDTE,
                                  readOnly: (isView || isCreate) ? false : true,
                                  validator:
                                      accountDetailController.validateString,
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
                      TextFormField(
                        onTap: () {},
                        style: textStyleCustom(fontSize: 16),
                        readOnly: (isView || isCreate) ? false : true,
                        controller: accountDetailController.phoneTE,
                        validator: accountDetailController.validateString,
                        decoration: textFieldInputStyle(label: 'Số điện thoại'),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 4 * 5,
                      ),
                      TextFormField(
                        onTap: () {
                          if (isCreate || isView) {
                            ShareFuntion.dateTimePicker(onchange: (date) {
                              accountDetailController.birthday = date;
                              accountDetailController.updateDataTextEditing();
                              accountDetailController.update();
                            });
                          }
                        },
                        style: textStyleCustom(fontSize: 16),
                        showCursor: false,
                        readOnly: (isView || isCreate) ? false : true,
                        controller: accountDetailController.birtTE,
                        decoration: textFieldInputStyle(label: 'Năm sinh (*)'),
                        validator: accountDetailController.validateString,
                      ),
                      const SizedBox(
                        height: 4 * 5,
                      ),
                      TextField(
                        onTap: () {},
                        style: textStyleCustom(fontSize: 16),
                        controller: accountDetailController.addressTE,
                        readOnly: (isView || isCreate) ? false : true,
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
                              onTap: () {
                                if (isView || isCreate) {
                                  Get.bottomSheet(accountDetailController
                                      .obx((state) => showBottomListChose(
                                            options: accountDetailController
                                                .listDepartment,
                                            value: accountDetailController
                                                .departmentItemSelect,
                                            onSelect: (p0) {
                                              accountDetailController
                                                  .departmentItemSelect = p0;
                                              accountDetailController
                                                  .updateDataTextEditing();
                                              accountDetailController
                                                  .updateUI();
                                            },
                                            buildOption: (p0) =>
                                                textBodyMedium(p0.key ?? ''),
                                          )));
                                }
                              },
                              style: textStyleCustom(fontSize: 16),
                              controller: accountDetailController.departmentTE,
                              validator: accountDetailController.validateString,
                              decoration: textFieldInputStyle(label: 'Chức vụ'),
                              readOnly: true,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(
                            width: 4 * 5,
                          ),
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                if ((isView || isCreate)) {
                                  Get.bottomSheet(accountDetailController
                                      .obx((state) => showBottomListChose(
                                            options: accountDetailController
                                                .listGender,
                                            value: accountDetailController
                                                .genderItemSelect,
                                            onSelect: (p0) {
                                              accountDetailController
                                                  .genderItemSelect = p0;
                                              accountDetailController
                                                  .updateDataTextEditing();
                                              accountDetailController
                                                  .updateUI();
                                            },
                                            buildOption: (p0) =>
                                                textBodyMedium(p0.key ?? ''),
                                          )));
                                }
                              },
                              style: textStyleCustom(fontSize: 16),
                              controller: accountDetailController.genderTE,
                              keyboardType: TextInputType.number,
                              validator: accountDetailController.validateString,
                              readOnly: true,
                              decoration:
                                  textFieldInputStyle(label: 'Giới tính'),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4 * 5,
                      ),
                      TextFormField(
                        onTap: () {
                          if ((isView || isCreate)) {
                            Get.bottomSheet(accountDetailController
                                .obx((state) => showBottomListMutilChose(
                                      options: accountDetailController
                                          .listPermission,
                                      value: accountDetailController
                                          .listPermissionSelect,
                                      onSelect: (p0) {
                                        if (accountDetailController
                                                .listPermissionSelect
                                                ?.contains(p0) ??
                                            false) {
                                          accountDetailController
                                              .listPermissionSelect
                                              ?.remove(p0);
                                        } else {
                                          accountDetailController
                                              .listPermissionSelect
                                              ?.add(p0);
                                        }
                                        accountDetailController
                                            .updateDataTextEditing();
                                        accountDetailController.updateUI();
                                      },
                                      buildOption: (p0) =>
                                          textBodyMedium(p0.key ?? ''),
                                    )));
                          }
                        },
                        style: textStyleCustom(fontSize: 16),
                        showCursor: false,
                        readOnly: true,
                        controller: accountDetailController.permissionTE,
                        decoration: textFieldInputStyle(label: 'Quyền hạn (*)'),
                      ),
                      const SizedBox(
                        height: 4 * 10,
                      ),
                      if (isUser)
                        FxButton.block(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            onPressed: () {
                              accountDetailController.logout();
                            },
                            child: textTitleMedium('Đăng xuất'.toUpperCase(),
                                color: Colors.white)),
                      if (ShareFuntion.checkPermissionUser(
                              user: accountDetailController.userLogin,
                              permission: ['E_NV', 'C_NV', 'AD']) &&
                          !isCreate &&
                          arguments != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Checkbox(
                                value: accountDetailController.isResetPassword,
                                onChanged: (bool? value) {
                                  accountDetailController.isResetPassword =
                                      value ?? false;
                                  accountDetailController.update();
                                },
                              ),
                              textBodyMedium('Đặt lại mật khẩu (12345678)')
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 4 * 10,
                      ),
                    ],
                  ),
                ),
              ),
            )),
        onLoading: const LoadingCustom());
  }
}
