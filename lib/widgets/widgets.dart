
import 'package:quan_ly_ban_hang/widgets/color_custom.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget searchBar(
    {double? width,
    Function(String)? onChange,
    required TextEditingController controller}) {
  return Container(
    // margin: const EdgeInsets.symmetric(horizontal: 4 * 5),
    width: width ?? Get.width,
    decoration: BoxDecoration(
      color: colorF3.withOpacity(0.3),
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      onChanged: onChange,
      controller: controller,
      textAlign: TextAlign.left,
      style: textStyleCustom(
        fontSize: 14,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.all(4 * 3),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.7,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.7,
          ),
        ),
        hintText: "Tìm kiếm ...",
        hintStyle: textStyleCustom(
          fontSize: 14,
          color: Colors.white,
        ),
        prefixIcon: const Icon(
          LucideIcons.search,
          size: 30,
          color: Colors.white,
        ),
      ),
    ),
  );
}

//avater tròn
Widget avatarImage({
  required String url,
  double? radius,
}) {
  bool loadImageError = false;
  return StatefulBuilder(builder: (context, setState) {
    return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(url),
        onBackgroundImageError: (dynamic exception, StackTrace? stackTrace) {
          setState(() {
            loadImageError = true;
          });
        },
        child: loadImageError
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/images/image_notfound.jpg'))
            : null);
  });
}

Widget buttonSetting({
  required IconData iconStart,
  required IconData iconEnd,
  Function? onTap,
  required String title,
  bool isToggle = false,
  Color? disabledTrackColor,
  Color? enabledTrackColor,
  bool valToggle = false,
  Function(bool?)? onChangeToggle,
}) {
  return Container(
    decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 0.5))),
    padding: const EdgeInsets.only(top: 4 * 5, bottom: 4 * 5),
    child: InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4 * 5,
            children: [
              Icon(
                iconStart,
                size: 4 * 6,
              ),
              textTitleSmall(title),
            ],
          ),
          isToggle
              ? GFToggle(
                  onChanged: onChangeToggle!,
                  value: valToggle,
                  disabledTrackColor:
                      disabledTrackColor ?? Colors.grey.shade300,
                  enabledTrackColor: enabledTrackColor ?? Colors.black,
                  type: GFToggleType.ios,
                )
              : Icon(
                  iconEnd,
                  size: 4 * 5,
                ),
        ],
      ),
    ),
  );
}

Widget noData({required Function inReload}) {
  return Container(
    margin: EdgeInsets.zero,
    color: Get.theme.colorScheme.background,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              // color: Colors.cyan,
              margin: EdgeInsets.zero,
              //height: 20,
              child: Lottie.asset('assets/animate/nodata.json',
                  width: Get.width, fit: BoxFit.fill)),
          textBodyMedium(
            'Không có dữ liệu',
            color: Get.theme.colorScheme.onBackground,
          ),
          GFButton(
            onPressed: () {
              inReload();
            },
            color: Get.theme.colorScheme.onBackground,
            colorScheme: Get.theme.colorScheme,
            text: 'Làm mới',
          )
        ],
      ),
    ),
  );
}

Widget cWidth(double val) => SizedBox(
      width: val,
    );
Widget cHeight(double val) => SizedBox(
      height: val,
    );
