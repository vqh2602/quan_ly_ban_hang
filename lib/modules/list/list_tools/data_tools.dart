// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/modules/acc_detail/account_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_customer/customer_detail_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_request_return/detail_request_return_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_sales_invoice/detail_sales_invoice_screen.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_warehouse_receipt/detail_warehouse_receipt_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_customer/list_customer_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_request_return/list_request_return_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_sales_order/list_sales_order_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_supplier/list_supplier_screen.dart';
import 'package:quan_ly_ban_hang/modules/list/list_warehouse_receipt/list_warehouse_receipt_screen.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

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
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'C_HD', 'BH' 'AD'])) {
          Get.toNamed(DetailSalesInvoiceSreen.routeName,
              arguments: {'type': 'create'});
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              FontAwesomeIcons.solidCartFlatbedBoxes,
              color: color ?? b500,
            ),
          ),
      backgroundColor: Colors.white,
      name: 'Tạo đơn nhập kho',
      group: 'hoadon',
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'C_NK', 'NK', 'AD'])) {
          Get.toNamed(DetailWarehouseReceiptScreen.routeName,
              arguments: {'type': 'create'});
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              FontAwesomeIcons.boxOpenFull,
              color: color ?? Colors.white,
            ),
          ),
      backgroundColor: Colors.green,
      name: 'Tạo yêu cầu đổi trả',
      group: 'hoadon',
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'C_YC', 'NK', 'AD'])) {
          Get.toNamed(DetailRequestReturnScreen.routeName,
              arguments: {'type': 'create'});
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Icon(
              FontAwesomeIcons.solidBoxesStacked,
              color: color ?? Colors.white,
            ),
          ),
      backgroundColor: a500,
      name: 'Tạo mới sản phẩm',
      group: 'sanpham',
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'NK', 'C_SP', 'AD'])) {
          Get.toNamed(DetailProductSreen.routeName,
              arguments: {'type': 'create'});
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Icon(
              FontAwesomeIcons.solidUserVisor,
              color: color ?? a500,
            ),
          ),
      backgroundColor: Colors.white,
      name: 'Tạo mới khách hàng',
      group: 'khachhang',
      onTap: () {
        if (ShareFuntion().checkPermissionUserLogin(
            permission: ['QL', 'BH', 'GH', 'C_KH', 'AD'])) {
          Get.toNamed(CustomerDetailScreen.routeName,
              arguments: {'type': 'create'});
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Icon(
              FontAwesomeIcons.personCarryBox,
              color: color ?? Colors.white,
            ),
          ),
      backgroundColor: a500,
      name: 'Tạo mới nhân viên',
      group: 'nhanvien',
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'C_NV', 'AD'])) {
          Get.toNamed(AccountDetailScreen.routeName,
              arguments: {'type': 'create'});
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              FontAwesomeIcons.solidUsersLine,
              color: color ?? Colors.white,
            ),
          ),
      backgroundColor: Colors.orange[800],
      name: 'Quản lý khách hàng',
      group: 'khachhang',
      onTap: () {
        if (ShareFuntion().checkPermissionUserLogin(
            permission: ['QL', 'V_KH', 'BH', 'GH', 'AD'])) {
          Get.toNamed(ListCustomerSreen.routeName);
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Icon(
              FontAwesomeIcons.solidParachuteBox,
              color: color ?? Colors.white,
            ),
          ),
      backgroundColor: Colors.lime[800],
      name: 'Quản lý sản phẩm',
      group: 'sanpham',
      onTap: () {
        // if (ShareFuntion()
        //     .checkPermissionUserLogin(permission: ['QL', 'V_NV', 'AD'])) {
        Get.toNamed(ListProductSreen.routeName);
        // } else {
        //   buildToast(
        //       message: 'Không có quyền xem thông tin',
        //       status: TypeToast.toastError);
        // }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Icon(
              FontAwesomeIcons.solidPeopleGroup,
              color: color ?? Colors.white,
            ),
          ),
      backgroundColor: b500,
      name: 'Quản lý nhân viên',
      group: 'nhanvien',
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'V_NV', 'AD'])) {
          Get.toNamed(ListPersonnelSreen.routeName);
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Icon(
            FontAwesomeIcons.solidStore,
            color: color ?? b500,
          ),
      backgroundColor: Colors.white,
      name: 'Quản lý nhà cung cấp',
      group: 'ncc',
      onTap: () {
        if (ShareFuntion().checkPermissionUserLogin(
            permission: ['QL', 'V_NCC', 'NK', 'AD'])) {
          Get.toNamed(ListSupplierSreen.routeName);
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              FontAwesomeIcons.solidBoxBallot,
              color: color ?? Colors.white,
            ),
          ),
      backgroundColor: Colors.purple,
      name: 'Quản lý đơn hàng bán',
      group: 'ncc',
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'BH', 'GH', 'AD'])) {
          Get.toNamed(ListSalesOrderSreen.routeName);
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              FontAwesomeIcons.solidBoxesPacking,
              color: color ?? Colors.white,
            ),
          ),
      backgroundColor: Colors.indigo,
      name: 'Quản lý đơn nhập kho',
      group: 'ncc',
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'NK', 'V_NK', 'AD'])) {
          Get.toNamed(ListWarehouseReceiptSreen.routeName);
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
  DataTool(
      icon: (color) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              FontAwesomeIcons.truckFast,
              color: color ?? a500,
            ),
          ),
      backgroundColor: Colors.white,
      name: 'Quản lý yêu cầu đổi trả',
      group: 'ncc',
      onTap: () {
        if (ShareFuntion()
            .checkPermissionUserLogin(permission: ['QL', 'NK', 'V_NK', 'AD'])) {
          Get.toNamed(ListRequestReturnSreen.routeName);
        } else {
          buildToast(
              message: 'Không có quyền xem thông tin',
              status: TypeToast.toastError);
        }
      }),
];
