import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';

Widget hideWidget(
    {required List<String> permission,
    double? height,
    EdgeInsetsGeometry? padding}) {
      bool hide = ShareFuntion().checkPermissionUserLogin(permission: permission);
  return Visibility(
    visible: !hide,
    child: BlurryContainer(
      blur: hide
          ? 0
          : 10,
      padding: padding ?? alignment_20_0(),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: height ?? 200,
        child: hide
            ? const SizedBox()
            : textBodyMedium('Không có quyền xem thông tin'),
      ),
    ),
  );
}
