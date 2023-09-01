import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

Widget loaddingRefreshIndicator(
    {required BuildContext context,
    required Widget child,
    required IndicatorController controller}) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      if (!controller.isIdle)
        Positioned(
          top: -20.0,
          child: SizedBox(
              // color: Colors.black,
              height: 200,
              width: Get.width,
              // margin: EdgeInsets.only(bottom: 20),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Lottie.asset(
                  'assets/animations/loadleaf.json',
                  fit: BoxFit.fill,
                ),
              )),
        ),
      Transform.translate(
        offset: Offset(0, 100.0 * controller.value * 1.5),
        child: child,
      ),
    ],
  );
}
