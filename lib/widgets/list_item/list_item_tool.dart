import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';

import 'package:quan_ly_ban_hang/modules/list/list_tools/data_tools.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget itemTool({
  Color? textColor,
  Color? clearBackgroundColor,
  bool isTextSmall = true,
  DataTool? dataTool,
}) {
  return InkWell(
    onTap: () {
      if (dataTool?.onTap != null) dataTool?.onTap!();
    },
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: SizedBox(
      width: 80,
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ]),
          child: CircleAvatar(
            backgroundColor: clearBackgroundColor ??
                dataTool?.backgroundColor ??
                Colors.white,
            radius: 30,
            child: Center(
                child: dataTool?.icon!(
                        (clearBackgroundColor != null) ? b500 : null) ??
                    const SizedBox()),
          ),
        ),
        cHeight(4),
        isTextSmall
            ? textBodySmall(
                dataTool?.name ?? '',
                textAlign: TextAlign.center,
                color: textColor ?? Colors.white,
              )
            : textBodyMedium(
                dataTool?.name ?? '',
                textAlign: TextAlign.center,
                color: textColor ?? Colors.white,
              )
      ]),
    ),
  );
}
