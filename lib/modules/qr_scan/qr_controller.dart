import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/modules/details/detail_product/detail_product_screen.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/product_mixin.dart';
import 'package:vibration/vibration.dart';

class QrController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, ProductMixin {
  Barcode? result; // kết quả
  bool statusCamera = true; // bật / tắt // trạng thái camera
  bool flashCamera = true; // bật / tắt // đèn flash
  bool flipCam = true; // bật / tắt // came trước / cam sau
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? screen; // điều hướng sang: gom mã , kiểm kê
  String? dataQr;
  bool playSound = true;

  bool nhapCode = false;
  TextEditingController textEditingControllerCode = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    textEditingControllerCode.text = '';
    change(null, status: RxStatus.success());
  }

  // tự nhập code khi qr không quét đc mã
  void setNhapCode() {
    nhapCode = !nhapCode;
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
      result = null;
      // set dungwf cam
      await controller!.pauseCamera(); // dừng
      statusCamera = false;
      update();
      goToItemInfo();
    } else {
      Get.snackbar('Có lỗi xảy ra', 'Hãy chắc chắn rằng bạn đã nhập mã',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  //lấy dữ liệu và sử dụng cho các màn sau
  Future<void> updateResult(Barcode data) async {
    result = data;
    // print('ketqua: ${await QrDataConnect().getDataWithID(QrDataConnect().apiUrl(result!.code!))}');
    //   update();
  }

  // khu vực điều hướng camera
  Future<void> startCamera() async {
    await controller!.resumeCamera(); // dừng
    statusCamera = true;
    playSound = true;
    // print('ketqua: ${await QrDataConnect().getDataWithID(QrDataConnect().apiUrl(result!.code!))}');
    //   update();
  }

  Future<void> flipCamera(QRViewController controller) async {
    await controller
        .flipCamera()
        .whenComplete(() => flipCam = !flipCam); // lật camera ( trước/ sau)
    update();
  }

  Future<void> toggleFlash(QRViewController controller) async {
    // bật flash
    await controller
        .toggleFlash()
        .whenComplete(() => flashCamera = !flashCamera);
    update();
  }

  Future<void> pauseStartCamera(QRViewController controller) async {
    statusCamera
        ? await controller.pauseCamera() // dừng
        : await controller.resumeCamera(); // tiếp tục
    statusCamera = !statusCamera;
    // gắn lại giá trị ban đầu sau mỗi lần ấn nút
    result = null;
    update();
  }
  // Future<void> pauseCamera(QRViewController controller) async {
  //   await controller.pauseCamera(); // dừng
  //   statusCamera = false;
  //   update();
  // }

  // hàm thực hiện đọc mã qr
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      updateResult(scanData).whenComplete(() async {
        // pauseCamera(controller);
        dataQr = result!.code;
        result = null;
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
  Future<void> goToItemInfo() async {
    loadingUI();
    Product? product;
    try {
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate();
      }
      product = await getListProductWithBardcodeMixin(bardcode: dataQr);
    } on Exception catch (_) {}
    changeUI();
    if (product == null) {
      Get.snackbar('Có lỗi xảy ra', 'Không tìm thấy sản phẩm',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Get.toNamed(DetailProductSreen.routeName,
        arguments: {"product": product, "type": "QR"});
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

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
