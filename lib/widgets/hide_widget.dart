import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';

Widget hideWidget(
    {required List<String> permission,
    double? height,
    EdgeInsetsGeometry? padding}) {
  return BlurryContainer(
    blur: ShareFuntion().checkPermissionUserLogin(permission: permission)
        ? 0
        : 10,
    padding: padding ?? alignment_20_0(),
    child: Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: height ?? 200,
      child: ShareFuntion().checkPermissionUserLogin(permission: permission)
          ? const SizedBox()
          : textBodyMedium('Không có quyền xem thông tin'),
    ),
  );
}
