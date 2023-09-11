

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quan_ly_ban_hang/modules/qr_scan/qr_controller.dart';
import 'package:quan_ly_ban_hang/widgets/base/base.dart';
import 'package:quan_ly_ban_hang/widgets/text_custom.dart';

class QrScan extends StatefulWidget {
  const QrScan({super.key});

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  QrController qrController = Get.find();
  @override
  Widget build(BuildContext context) {
    return buildBody(
        context: context,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  QRView(
                    key: qrController.qrKey,
                    onQRViewCreated: qrController.onQRViewCreated,
                  ),
                  IgnorePointer(
                    child: ClipPath(
                      clipper: InvertedCircleClipper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(
                      () => Lottie.asset('assets/animation/qrscan.json',
                          fit: BoxFit.fill,
                          animate:
                              qrController.statusCamera.value ? true : false,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.3),
                    ),
                  ),
                  // tien ich
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4 * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                qrController
                                    .flipCamera(qrController.controller!);
                              },
                              icon: Obx(() => qrController.flipCam.value
                                  ? const Icon(
                                      Icons.cameraswitch_outlined,
                                      color: Colors.white,
                                      size: 4 * 8,
                                    )
                                  : const Icon(
                                      Icons.cameraswitch,
                                      color: Colors.white,
                                      size: 4 * 8,
                                    ))),
                          IconButton(
                              onPressed: () {
                                qrController
                                    .toggleFlash(qrController.controller!);
                              },
                              icon: Obx(
                                () => qrController.flashCamera.value
                                    ? const Icon(
                                        Icons.flash_on_outlined,
                                        color: Colors.white,
                                        size: 4 * 8,
                                      )
                                    : const Icon(
                                        Icons.flash_off,
                                        color: Colors.white,
                                        size: 4 * 8,
                                      ),
                              )),
                          IconButton(
                              onPressed: () {
                                qrController
                                    .pauseStartCamera(qrController.controller!);
                              },
                              icon: Obx(
                                () => qrController.statusCamera.value
                                    ? const Icon(
                                        Icons.pause,
                                        color: Colors.white,
                                        size: 4 * 8,
                                      )
                                    : const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 4 * 8,
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SafeArea(
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: AnimatedContainer(
                              margin: const EdgeInsets.only(top: 4 * 7),
                              padding: const EdgeInsets.all(4 * 5),
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              // width: _width,
                              height: qrController.nhapCode.value ? 300 : 170,
                              width: qrController.nhapCode.value
                                  ? MediaQuery.of(context).size.width * 0.8
                                  : 250,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(4 * 5),
                              ),
                              child: (qrController.result.value != null)
                                  ? Container(
                                      color: Colors.white30,
                                      child: InkWell(
                                        onTap: () {
                                          // if (argumentData[0]['screen'] == 'gomma') {
                                          //   Get.toNamed(
                                          //       ProductInformationScreen.routeName,
                                          //       arguments: [
                                          //         {"screen": 'gomma'},
                                          //       ]);
                                          // } else {
                                          //   Get.toNamed(
                                          //       ProductInformationScreen.routeName,
                                          //       arguments: [
                                          //         {"screen": 'kiemke'},
                                          //       ]);
                                          // }
                                        },
                                        child: const SizedBox(),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 125,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: textBodyMedium(
                                              'Quét mã vạch',
                                              fontWeight: FontWeight.bold,
                                              // color: Get.theme.primaryColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: textBodySmall(
                                              'Đưa mã vào giữa khung hình',
                                            ),
                                          ),
                                          GFButton(
                                              onPressed: () {
                                                qrController.setNhapCode();
                                              },
                                              color: Colors.transparent,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    textBodySmall(
                                                      'Nhập mã thủ công',
                                                      color: qrController
                                                              .nhapCode.value
                                                          ? Get.theme
                                                              .primaryColor
                                                          : Colors.black,
                                                    ),
                                                    qrController.nhapCode.value
                                                        ? const Icon(LucideIcons
                                                            .chevronUp)
                                                        : const Icon(LucideIcons
                                                            .chevronDown)
                                                  ],
                                                ),
                                              )),
                                          qrController.nhapCode.value
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 4 * 2),
                                                  child:
                                                      qrController
                                                          .obx(
                                                              (state) =>
                                                                  TextField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    controller:
                                                                        qrController
                                                                            .textEditingControllerCode,
                                                                    decoration: InputDecoration(
                                                                        suffixIcon: IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            qrController.textEditingControllerCode.clear();
                                                                            // setState(() { qrController.textEditingControllerCode.clear(); });
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.clear,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                        labelText: 'Nhập mã',
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey),
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: Get.theme.primaryColor),
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        )),
                                                                  )),
                                                )
                                              : const SizedBox(),
                                          qrController.nhapCode.value
                                              ? SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  child: GFButton(
                                                      onPressed: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        qrController.postNhapCode(
                                                            qrController
                                                                .textEditingControllerCode
                                                                .text);
                                                      },
                                                      color: Get
                                                          .theme.primaryColor,
                                                      shape:
                                                          GFButtonShape.pills,
                                                      child: textBodyMedium(
                                                        'Hoàn tất',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                )
                                              : const SizedBox()
                                        ],
                                      ))),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SafeArea(
                      child: ElevatedButton.icon(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          LucideIcons.chevronLeft,
                          color: Colors.white,
                        ),
                        label: textBodySmall(
                          'Quay lại',
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: Colors.transparent),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          LucideIcons.history,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  final Size windowSize = MediaQueryData.fromView(
          WidgetsBinding.instance.platformDispatcher.views.single)
      .size;
  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: windowSize.height * 0.3,
        width: windowSize.width * 0.8,
      ))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
