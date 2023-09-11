// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_supplier/supplier_detail_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/loading_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/theme_textinput.dart';

/// tham số truyền vào
/// [type]: **view** - xem, và sửa; **create** - tạo ,
/// [supplierID]: id của khach hang, nếu type là chế độ view thì gọi api lấy tt nhân viên
class SupplierDetailScreen extends StatefulWidget {
  final bool? isEdit;
  const SupplierDetailScreen({
    Key? key,
    this.isEdit,
  }) : super(key: key);
  static const String routeName = '/supplier_detail';
  @override
  State<SupplierDetailScreen> createState() => _SupplierDetailScreenState();
}

class _SupplierDetailScreenState extends State<SupplierDetailScreen> {
  SupplierDetailController supplierDetailController = Get.find();
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
        supplierDetailController.getDataSupplier(id: arguments['supplierID']);
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
              title: textLableLarge('Thông tin nhà cung cấp'),
              centerTitle: false,
              // leading: const SizedBox(),
              surfaceTintColor: bg500,
              backgroundColor: bg500,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: FxButton.medium(
                    borderRadiusAll: 100,
                      onPressed: () {
                        if (keyForm1.currentState?.validate() ?? false) {
                          if (isView) {
                            supplierDetailController.updateSupplier();
                          } else {
                            supplierDetailController.createSupplier();
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
    return supplierDetailController.obx(
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
                                  controller: supplierDetailController.nameTE,
                                  validator:
                                      supplierDetailController.validateString,
                                  readOnly: (isView || isCreate) ? false : true,
                                  decoration:
                                      textFieldInputStyle(label: 'Tên ncc (*)'),
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
                        readOnly: (isView || isCreate) ? false : true,
                        controller: supplierDetailController.phoneTE,
                        decoration: textFieldInputStyle(label: 'Số điện thoại'),
                        maxLines: 1,
                      ),
        
                      const SizedBox(
                        height: 4 * 5,
                      ),
                      TextField(
                        onTap: () {},
                        style: textStyleCustom(fontSize: 16),
                        controller: supplierDetailController.addressTE,
                        readOnly: (isView || isCreate) ? false : true,
                        decoration: textFieldInputStyle(label: 'Địa chỉ'),
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 4 * 5,
                      ),
                      TextField(
                        onTap: () {},
                        style: textStyleCustom(fontSize: 16),
                        controller: supplierDetailController.noteTE,
                        readOnly: (isView || isCreate) ? false : true,
                        decoration: textFieldInputStyle(label: 'Ghi chú'),
                        maxLines: 15,
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
