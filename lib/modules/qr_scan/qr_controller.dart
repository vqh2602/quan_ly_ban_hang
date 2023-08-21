import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  Rx<Barcode?> result = Rx<Barcode?>(null); // kết quả
  RxBool statusCamera = true.obs; // bật / tắt // trạng thái camera
  RxBool flashCamera = true.obs; // bật / tắt // đèn flash
  RxBool flipCam = true.obs; // bật / tắt // came trước / cam sau
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? screen; // điều hướng sang: gom mã , kiểm kê
  String? dataQr;
  bool playSound = true;

  Rx<bool> nhapCode = false.obs;
  TextEditingController textEditingControllerCode = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    textEditingControllerCode.text = '';
    change(null, status: RxStatus.success());
  }

  // tự nhập code khi qr không quét đc mã
  void setNhapCode() {
    nhapCode.value = !nhapCode.value;
    // print('nhapdoe : $nhapCode');
    update();
  }

  void setNhapCodeData() {
    textEditingControllerCode.text = '';
    // print('nhapdoe : $nhapCode');
    update();
  }

  Future<void> postNhapCode(String? code) async {
    if (code != '') {
      dataQr = code;
      result.value = null;
      // set dungwf cam
      await controller!.pauseCamera(); // dừng
      statusCamera.value = false;
      update();
      goToItemInfo();
    } else {
      Get.snackbar('Có lỗi xảy ra', 'Hãy chắc chắn rằng bạn đã nhập mã',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  //lấy dữ liệu và sử dụng cho các màn sau
  Future<void> updateResult(Barcode data) async {
    result.value = data;
    // print('ketqua: ${await QrDataConnect().getDataWithID(QrDataConnect().apiUrl(result.value!.code!))}');
    //   update();
  }

  // khu vực điều hướng camera
  Future<void> startCamera() async {
    await controller!.resumeCamera(); // dừng
    statusCamera.value = true;
    playSound = true;
    // print('ketqua: ${await QrDataConnect().getDataWithID(QrDataConnect().apiUrl(result.value!.code!))}');
    //   update();
  }

  Future<void> flipCamera(QRViewController controller) async {
    await controller.flipCamera().whenComplete(
        () => flipCam.value = !flipCam.value); // lật camera ( trước/ sau)
    update();
  }

  Future<void> toggleFlash(QRViewController controller) async {
    // bật flash
    await controller
        .toggleFlash()
        .whenComplete(() => flashCamera.value = !flashCamera.value);
    update();
  }

  Future<void> pauseStartCamera(QRViewController controller) async {
    statusCamera.value
        ? await controller.pauseCamera() // dừng
        : await controller.resumeCamera(); // tiếp tục
    statusCamera.value = !statusCamera.value;
    // gắn lại giá trị ban đầu sau mỗi lần ấn nút
    result.value = null;
    update();
  }
  // Future<void> pauseCamera(QRViewController controller) async {
  //   await controller.pauseCamera(); // dừng
  //   statusCamera.value = false;
  //   update();
  // }

  // hàm thực hiện đọc mã qr
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      updateResult(scanData).whenComplete(() async {
        // pauseCamera(controller);
        dataQr = result.value!.code;
        result.value = null;
        update();
        //print('data: ${dataQr} | ');
        playSound = true;
        // playBeep();
        goToItemInfo();
      });
    });

    // sửa lỗi màn hình khỏi động bị đen bắt buộc phải chạm mới mở camera
    controller.pauseCamera();
    controller.resumeCamera();
  }

  // lấy trạng thái đnag ở kiểm kê hay gom mã
  void setScreen(String s) {
    screen = s;
    update();
  }

  // chuyển màn
  void goToItemInfo() {
    // Get.toNamed(
    //   // ProductDetailScreen.routeName,
    //   arguments: {"qr_code_data": dataQr},
    // );
    // if (screen == 'gomma') {
    //   Get.toNamed(ProductInformationScreen.routeName, arguments: [
    //     {"screen": 'gomma'},
    //   ]);
    // } else {
    //   Get.toNamed(ProductInformationScreen.routeName, arguments: [
    //     {"screen": 'kiemke'},
    //   ]);
    // }
  }

}
