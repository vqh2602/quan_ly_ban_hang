import 'dart:async';
import 'dart:io';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/product_mixin.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:uuid/uuid.dart';

class DetailProductController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, AppWriteMixin, ProductMixin {
        final formKey = GlobalKey<FormState>();
  var arguments = Get.arguments;
  Product? product;
  List<SelectOptionItem>? listUnit = []; // ds đơn vị tính
  SelectOptionItem? selectedUnit; // đơn vị tính được chọn
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
    priceTE = TextEditingController(text: product?.price?.toString() ?? '0');
    importPriceTE =
        TextEditingController(text: product?.importPrice?.toString() ?? '0');
    quantityTE =
        TextEditingController(text: product?.quantity?.toString() ?? '0');
    discountTE =
        TextEditingController(text: product?.discount?.toString() ?? '0');
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

// lấy dl sản phẩm qua id
  getDetaiProduct(String? id, {Product? productData}) async {
    loadingUI();
    if (product == null) {
      product = await getDetailProductMixin(id: id);
    } else {
      product = productData;
    }

//gắn dữ liệu sp vào các trường edit
    initResetData(product: product);

    var listCategoryResult = listCategory
        ?.where((e1) => (product?.category ?? [])
            .where((e2) => e1.value == e2.toString())
            .isNotEmpty)
        .toList();

    listCategorySelect = listCategoryResult;

    selectedUnit = listUnit
        ?.where((element) => element.value == product?.unit)
        .firstOrNull;

    changeUI();
  }

// cập nhật sp
  updateProduct() async {
    loadingUI();
    var result = await updateDetailProductMixin(
        product: product?.copyWith(
      code: codeTE?.text,
      name: nameTE?.text,
      bardcode: barcodeTE?.text,
      price: double.parse(priceTE?.text ?? '0'),
      importPrice: double.parse(importPriceTE?.text ?? '0'),
      quantity: double.parse(quantityTE?.text ?? '0'),
      discount: double.parse(discountTE?.text ?? '0'),
      note: noteTE?.text,
      image: imageUrl,
      unit: selectedUnit?.value,
      category: listCategorySelect?.map((e) => e.value ?? '').toList() ?? [],
    ));
    if (result != null) {
      product = result;
      getDetaiProduct(null, productData: result);
    }
    changeUI();
  }

// tạo sản phẩm
  createProduct() async {
    loadingUI();
    if (codeTE?.text == null ||
        nameTE?.text == null ||
        barcodeTE?.text == null ||
        codeTE?.text == '' ||
        nameTE?.text == '' ||
        barcodeTE?.text == '') {
      buildToast(
          message: 'Không để trống dữ liệu: mã, tên, mã vạch,...',
          status: TypeToast.toastError);
      changeUI();
      return;
    } else {
      var result = await createDetailProductMixin(
          product: Product(
        uid: uuid.v4(),
        code: codeTE?.text,
        name: nameTE?.text,
        bardcode: barcodeTE?.text,
        price: double.parse(priceTE?.text ?? '0'),
        importPrice: double.parse(importPriceTE?.text ?? '0'),
        quantity: double.parse(quantityTE?.text ?? '0'),
        discount: double.parse(discountTE?.text ?? '0'),
        note: noteTE?.text,
        image: imageUrl,
        numberSales: 0,
        unit: selectedUnit?.value,
        category: listCategorySelect?.map((e) => e.value ?? '').toList() ?? [],
      ));
      if (result != null) {
        initResetData();
      }
    }
    changeUI();
  }

// tải ảnh lên imgur
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
