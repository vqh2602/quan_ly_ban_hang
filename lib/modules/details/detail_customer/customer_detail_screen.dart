// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_customer/customer_detail_controller.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/s_show_chose.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/theme_textinput.dart';

/// tham số truyền vào
/// [type]: **view** - xem, và sửa; **create** - tạo ,
/// [customerID]: id của khach hang, nếu type là chế độ view thì gọi api lấy tt nhân viên
class CustomerDetailScreen extends StatefulWidget {
  final bool? isEdit;
  const CustomerDetailScreen({
    Key? key,
    this.isEdit,
  }) : super(key: key);
  static const String routeName = '/customer_detail';
  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  CustomerDetailController customerDetailController = Get.find();
  GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormA1');
  var arguments = Get.arguments;
  final ImagePicker picker = ImagePicker();
  bool isView = false; // XEM HAY LÀ TẠO MỚI
  bool isCreate = false; // hiển thị icon edit

  @override
  void initState() {
    if (Get.arguments != null) {
      if (arguments['type'] == 'view') {
        setState(() {
          isView = true;
        });
        customerDetailController.getDataCustomer(id: arguments['customerID']);
      }
      if (arguments['type'] == 'create') {
        setState(() {
          isCreate = true;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: (widget.isEdit ?? true)
          ? AppBar(
              title: textLableLarge('Thông tin khách hàng'),
              centerTitle: false,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back(result: customerDetailController.idCreate);
                  }),
              surfaceTintColor: bg500,
              backgroundColor: bg500,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: FxButton.medium(
                      borderRadiusAll: 100,
                      onPressed: () {
                        if (ShareFuntion().checkPermissionUserLogin(
                            permission: [
                              'QL',
                              'BH',
                              'GH',
                              'C_KH',
                              'E_KH',
                              'AD'
                            ])) {
                        } else {
                          buildToast(
                              message: 'Không có quyền xem thông tin',
                              status: TypeToast.toastError);
                          return;
                        }

                        if (keyForm1.currentState?.validate() ?? false) {
                          if (isView) {
                            customerDetailController.updateCustomer();
                          } else {
                            customerDetailController.createCustomer();
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
    return customerDetailController.obx(
        (state) => SafeArea(
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
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  onTap: () {},
                                  style: textStyleCustom(fontSize: 16),
                                  controller: customerDetailController.nameTE,
                                  validator: ShareFuntion.validateName,
                                  readOnly: (isView || isCreate) ? false : true,
                                  decoration:
                                      textFieldInputStyle(label: 'Họ & tên(*)'),
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
                        keyboardType: TextInputType.phone,
                        readOnly: (isView || isCreate) ? false : true,
                        controller: customerDetailController.phoneTE,
                        validator: ShareFuntion.validateSDT,
                        decoration:
                            textFieldInputStyle(label: 'Số điện thoại (*)'),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 4 * 5,
                      ),
                      TextFormField(
                        onTap: () {},
                        style: textStyleCustom(fontSize: 16),
                        controller: customerDetailController.addressTE,
                        readOnly: (isView || isCreate) ? false : true,
                        validator: customerDetailController.validateString,
                        decoration: textFieldInputStyle(label: 'Địa chỉ (*)'),
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
                                if ((isView || isCreate)) {
                                  Get.bottomSheet(customerDetailController
                                      .obx((state) => showBottomListChose(
                                            options: customerDetailController
                                                .listGender,
                                            value: customerDetailController
                                                .genderItemSelect,
                                            onSelect: (p0) {
                                              customerDetailController
                                                  .genderItemSelect = p0;
                                              customerDetailController
                                                  .updateDataTextEditing();
                                              customerDetailController
                                                  .updateUI();
                                            },
                                            buildOption: (p0) =>
                                                textBodyMedium(p0.key ?? ''),
                                          )));
                                }
                              },
                              style: textStyleCustom(fontSize: 16),
                              controller: customerDetailController.genderTE,
                              keyboardType: TextInputType.number,
                              validator:
                                  customerDetailController.validateString,
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
                      TextField(
                        onTap: () {},
                        style: textStyleCustom(fontSize: 16),
                        controller: customerDetailController.noteTE,
                        readOnly: (isView || isCreate) ? false : true,
                        decoration: textFieldInputStyle(label: 'Ghi chú'),
                        maxLines: 10,
                      ),
                      const SizedBox(
                        height: 4 * 5,
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
