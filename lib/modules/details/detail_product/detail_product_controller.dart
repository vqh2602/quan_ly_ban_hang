import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';

class DetailProductController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  ImgurRepo imgurRepo = ImgurRepo();

  String? imageUrl;
  @override
  Future<void> onInit() async {
    super.onInit();

    changeUI();
  }

  uploadImageWithImgur(File file) async {
    loadingUI();
    var res = await imgurRepo.upLoadImageImgur(file);
    imageUrl = res?["link"];
    changeUI();
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
