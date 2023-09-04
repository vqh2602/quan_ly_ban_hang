import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

Widget loaddingRefreshIndicator(
    {required BuildContext context,
    required Widget child,
    required IndicatorController controller}) {
  // print(controller.value);
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      if ((!controller.side.isNone &&
              !controller.isDragging &&
              !controller.isIdle &&
              controller.value > 0.5) ||
          controller.value > 0.5)
        Positioned(
          top: 100.0,
          child: Container(
              color: Colors.transparent,
              height: 200,
              width: Get.width,
              // margin: EdgeInsets.only(bottom: 20),
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Lottie.asset(
                    'assets/animation/loadleaf.json',
                  ),
                ),
              )),
        ),
      Transform.translate(
        offset: Offset(0, 100.0 * controller.value * 2),
        child: child,
      ),
    ],
  );
}
