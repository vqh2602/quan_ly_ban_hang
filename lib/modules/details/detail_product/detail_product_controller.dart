import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:uuid/uuid.dart';

class DetailProductController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, AppWriteMixin {
  var arguments = Get.arguments;
  Product? product;
  List<SelectOptionItem>? listUnit = []; // ds đơn vị tính
  List<SelectOptionItem>? listCategory = []; // ds nhãn
  List<SelectOptionItem>? listCategorySelect = []; // ds nhãn được chọn
  ImgurRepo imgurRepo = ImgurRepo();
  var uuid = const Uuid();

  TextEditingController? codeTE, // mã sản phẩm
      nameTE, // tên sản phẩm
      barcodeTE, // barcode mã vạch
      priceTE, // giá bán
      importPriceTE, // giá nhập
      quantityTE, // số lượng
      // unitTE; // đơn vị tính,
      discountTE, // giảm giá
      noteTE; // ghi chú

  String? imageUrl;
  @override
  Future<void> onInit() async {
    super.onInit();
    initResetData();
    await initDataList();
    if (arguments['type'] == 'view') {
      await getDetaiProduct(arguments['productID']);
    }

    changeUI();
  }

  // khởi tạo dl
  initResetData({Product? product}) {
    nameTE = TextEditingController(text: product?.name);
    barcodeTE = TextEditingController(text: product?.bardcode);
    priceTE = TextEditingController(text: product?.price.toString());
    importPriceTE =
        TextEditingController(text: product?.importPrice.toString());
    quantityTE = TextEditingController(text: product?.quantity.toString());
    discountTE = TextEditingController(text: product?.discount.toString());
    noteTE = TextEditingController(text: product?.note);
    codeTE = TextEditingController(text: product?.code);
    imageUrl = product?.image ?? '';
  }

// lấy ds list data
  initDataList() async {
    loadingUI();
    var listUnitRequest = await getListUnitMixin();
    var listCategoryRequest = await getListCategoryMixin();
    listUnit = listUnitRequest
        ?.map((e) => SelectOptionItem(key: e.name, value: e.uid, data: e))
        .toList();
    listCategory = listCategoryRequest
        ?.map((e) => SelectOptionItem(key: e.name, value: e.uid, data: e))
        .toList();
    changeUI();
  }

  getDetaiProduct(String? id) async {
    loadingUI();
    product = await getDetailProductMixin(id: id);

    initResetData(product: product);

    var listCategoryResult = listCategory
        ?.where((e1) => (product?.category ?? [])
            .where((e2) => e1.value == e2.toString())
            .isNotEmpty)
        .toList();

    listCategorySelect = listCategoryResult;
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
