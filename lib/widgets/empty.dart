
import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:lottie/lottie.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget emptyWidget({double? width, double? height, Function? onTap}) {
  return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Lottie.asset('assets/animation/empty.json'),
          textBodyMedium('Không có thông tin!'),
          cHeight(12),
          if (onTap != null)
            FxButton.outlined(
              borderColor: a500,

                child: textBodyMedium('Làm mới'),
                onPressed: () {
                  onTap();
                })
        ]),
      ));
}
