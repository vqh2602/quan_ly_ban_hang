import 'dart:io';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quan_ly_ban_hang/data/models/category.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum TypeDate { ddMMyyyy, yyyyMMdd, ddMMyyyyhhmm, hhmm, dd, yyyy, mM }

class ShareFuntion {
  static void dateTimePicker(
      {required Function(DateTime) onchange, required Function onComplete}) {
    Get.bottomSheet(
        backgroundColor: Get.theme.colorScheme.background,
        Container(
          height: 200,
          padding: EdgeInsets.zero,
          child: CupertinoDatePicker(
              onDateTimeChanged: onchange,
              initialDateTime: DateTime.now(),
              //backgroundColor: Colors.white,
              dateOrder: DatePickerDateOrder.dmy,
              mode: CupertinoDatePickerMode.date),
        )).whenComplete(() => onComplete());
  }

  static String formatDate(
      {required TypeDate type, required DateTime? dateTime}) {
    if (dateTime == null) return 'Trống'.tr;
    switch (type) {
      case TypeDate.ddMMyyyy:
        return DateFormat('dd-MM-yyyy').format(dateTime);
      case TypeDate.yyyyMMdd:
        return DateFormat('yyyy-MM-dd').format(dateTime);
      case TypeDate.ddMMyyyyhhmm:
        return DateFormat('dd-MM-yyyy hh:mm').format(dateTime);
      case TypeDate.hhmm:
        return DateFormat('hh:mm').format(dateTime);
      case TypeDate.dd:
        return dateTime.day.toString();
      case TypeDate.yyyy:
        return dateTime.year.toString();
      case TypeDate.mM:
        return dateTime.month.toString();
    }
  }

// khoảng cách ngày
  static int daysBetween({required DateTime from, required DateTime to}) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    int days = (to.difference(from).inHours / 24).round();
    return days <= 0 ? 0 : days;
  }

//tính buổi
  static String getSesisonDay() {
    DateTime dt = DateTime.now();
    if (dt.hour >= 18 || (dt.hour >= 0 && dt.hour < 4)) return 'tối'.tr;
    if (dt.hour >= 4 && dt.hour < 11) return 'sáng'.tr;
    if (dt.hour >= 11 && dt.hour < 13) return 'trưa'.tr;
    return 'chiều'.tr;
  }

  static Future<String> getCurrentUrl(String url) async {
    if (Platform.isIOS) {
      String a = url.substring(url.indexOf("Documents/") + 10, url.length);
      Directory dir = await getApplicationDocumentsDirectory();
      a = "${dir.path}/$a";
      //print('aaa $a');
      return a;
    } else {
      return url;
    }
  }

  static Future<void> onPopDialog(
      {required BuildContext context,
      required String title,
      required Function onCancel,
      required Function onSubmit}) async {
    await showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title:
            textBodyMedium( 'Thông báo'.tr, fontWeight: FontWeight.bold),
        content: Container(
          margin: const EdgeInsets.only(top: 12),
          child: textBodySmall(
             title,
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: textBodySmall(
                 "Hủy".tr,
                color: Get.theme.colorScheme.error,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3),
            onPressed: () {
              // Navigator.of(context).pop(false);
              onCancel();
            },
          ),
          CupertinoDialogAction(
            child: textBodySmall(
                 'Xác nhận'.tr,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3),
            onPressed: () {
              // Navigator.of(context).pop(true);
              onSubmit();
            },
          ),
        ],
      ),
    );
  }

  static String getLocalConvertString() {
    Locale? locale = Get.deviceLocale;
    //print('vitri : ${locale?.languageCode}');
    switch (locale?.languageCode.toString()) {
      case 'en':
        return 'en';
      case 'vi':
        return 'vi';
      default:
        return 'en';
    }
  }

  static showWebInApp(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  static String formatCurrency(num number) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(number);
  }

  static String formatNumber({required String number}) {
    try {
      num n = num.parse(number);
      if (n >= 1000 && n < 1000000) {
        double numberInN = n / 1000.0;
        return '${NumberFormat("#.#").format(numberInN)}N';
      } else if (n >= 1000000) {
        double numberInTR = n / 1000000.0;
        return '${NumberFormat("#.#").format(numberInTR)}TR';
      } else {
        return number.toString();
      }
    } on Exception catch (_) {}
    return 'Trống';
  }

  /// lấy unit qua id
  static Unit? getUnitWithIDFunc(String? id, {List<Unit>? listUnit}) {
    return listUnit?.where((element) => element.uid == id).firstOrNull;
  }

  /// lấy Category qua id
  static Category? getCategoryWithIDFunc(String? id,
      {List<Category>? listCategory}) {
    return listCategory?.where((element) => element.uid == id).firstOrNull;
  }
}
