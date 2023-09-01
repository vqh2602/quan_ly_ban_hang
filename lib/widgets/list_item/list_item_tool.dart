import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quan_ly_ban_hang/c_theme/c_theme.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:quan_ly_ban_hang/widgets/widgets.dart';

Widget itemTool(
    {Color? textColor,
    bool isTextSmall = true,
    Color? bgColor,
    Color? iconColor}) {
  return InkWell(
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
            backgroundColor: bgColor ?? Colors.white,
            radius: 30,
            child: Icon(
              FontAwesomeIcons.ballotCheck,
              size: 30,
              color: iconColor ?? b500,
            ),
          ),
        ),
        cHeight(4),
        isTextSmall
            ? textBodySmall(
                 'tạo hoá đơn bán',
                textAlign: TextAlign.center,
                color: textColor ?? Colors.white,
              )
            : textBodyMedium(
                 'tạo hoá đơn bán',
                textAlign: TextAlign.center,
                color: textColor ?? Colors.white,
              )
      ]),
    ),
  );
}
