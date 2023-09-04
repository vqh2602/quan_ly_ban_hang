// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_customer/list_customer_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_supplier/list_supplier_screen.dart';

class DataTool {
  String? name;
  Widget Function(Color?)? icon;
  Color? backgroundColor;
  Function? onTap;
  String? group;
  DataTool({
    this.name,
    this.icon,
    this.backgroundColor,
    this.onTap,
    this.group,
  });
}

List<DataTool> listDataTools = [
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.solidBallotCheck,
            color: color ?? Colors.white,
          ),
      backgroundColor: a500,
      name: 'Tạo đơn bán hàng',
      group: 'hoadon',
      onTap: () {}),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.solidCartFlatbedBoxes,
            color: color ?? b500,
          ),
      backgroundColor: Colors.white,
      name: 'Tạo đơn nhập kho',
      group: 'hoadon',
      onTap: () {}),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.boxOpenFull,
            color: color ?? Colors.white,
          ),
      backgroundColor: Colors.green,
      name: 'Tạo yêu cầu đổi trả',
      group: 'hoadon',
      onTap: () {}),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.solidBoxesStacked,
            color: color ?? Colors.white,
          ),
      backgroundColor: a500,
      name: 'Tạo mới sản phẩm',
      group: 'sanpham',
      onTap: () {
        Get.toNamed(DetailProductSreen.routeName,
            arguments: {'type': 'create'});
      }),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.solidUserVisor,
            color: color ?? a500,
          ),
      backgroundColor: Colors.white,
      name: 'Tạo mới khách hàng',
      group: 'khachhang',
      onTap: () {}),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.personCarryBox,
            color: color ?? Colors.white,
          ),
      backgroundColor: a500,
      name: 'Tạo mới nhân viên',
      group: 'nhanvien',
      onTap: () {}),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.solidUsersLine,
            color: color ?? Colors.white,
          ),
      backgroundColor: Colors.orange[800],
      name: 'Quản lý khách hàng',
      group: 'khachhang',
      onTap: () {
        Get.toNamed(ListCustomerSreen.routeName);
      }),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.solidPeopleGroup,
            color: color ?? Colors.white,
          ),
      backgroundColor: b500,
      name: 'Quản lý nhân viên',
      group: 'nhanvien',
      onTap: () {
        Get.toNamed(ListPersonnelSreen.routeName);
      }),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.solidBoxesPacking,
            color: color ?? b500,
          ),
      backgroundColor: Colors.white,
      name: 'Quản lý nhà cung cấp',
      group: 'ncc',
      onTap: () {
        Get.toNamed(ListSupplierSreen.routeName);
      }),
];
