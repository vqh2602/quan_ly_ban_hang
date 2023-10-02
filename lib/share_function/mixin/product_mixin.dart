import 'package:appwrite/appwrite.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/modules/list/list_product/list_product_controller.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

ListProductController listProductController = Get.find();

mixin ProductMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();
  List<Product>? listProductMixin = [];

  initProductMixin() async {
    await realTime();
  }

// lắng ghe sự kiện thay đổi và vập nhật - realtime
  realTime() {
    final realtime = Realtime(client);
// Subscribe to files channel
    final subscription = realtime.subscribe([
      'databases.${Env.config.appWriteDatabaseID}.collections.${Env.config.tblProductID}.documents'
    ]);
    subscription.stream.listen((response) async {
      if (response.events.contains('databases.*.collections.*.documents.*')) {
        await listProductController.getListProducts();
        // Log when a new file is uploaded
        // print('realtime_db: ${response.payload}');
      }
    });
  }

  /// ds sản phẩm
  Future<List<Product>?> getListProductMixin({bool isCache = false}) async {
    if (isCache &&
        listProductMixin != null &&
        (listProductMixin?.isNotEmpty ?? false)) {
      return listProductMixin;
    }

    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblProductID);
    if (res.documents.isNotEmpty) {
      listProductMixin =
          res.documents.map((e) => Product.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listProductMixin;
  }

  /// chi tiết sản phẩm
  Future<Product?> getDetailProductMixin({String? id}) async {
    Product? product;
    var res = await appWriteRepo.databases.getDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblProductID,
        documentId: id ?? '');
    if (res.data.isNotEmpty) {
      product = Product.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return product;
  }

  /// cập nhật sản phẩm
  Future<Product?> updateDetailProductMixin({Product? product}) async {
    Product? result;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblProductID,
        documentId: product?.id ?? '',
        data: product?.toJson());
    if (res.data.isNotEmpty) {
      result = Product.fromJson(res.data);
      buildToast(
          title: 'Cập nhật thành công',
          message: '',
          status: TypeToast.getSuccess);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return result;
  }

  /// tạo sản phẩm
  Future<Product?> createDetailProductMixin({required Product product}) async {
    Product? result;

    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblProductID,
          documentId: ID.unique(),
          data: product.toJson());
      if (res.data.isNotEmpty) {
        result = Product.fromJson(res.data);
        buildToast(
            title: 'Tạo mới thành công',
            message: '',
            status: TypeToast.getSuccess);
      } else {
        buildToast(
            title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
        return null;
      }
    } on Exception catch (_) {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }

    return result;
  }

  /// sản phẩm với id
  Future<Product?> getListProductWithIdMixin({String? idProduct}) async {
    Product? product;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblProductID,
        queries: [Query.equal('uid', idProduct)]);
    if (res.documents.isNotEmpty) {
      product = res.documents
          .map((e) => Product.fromJson(e.data))
          .toList()
          .firstOrNull;
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return product;
  }

  /// sản phẩm với MÃ VẠCH
  Future<Product?> getListProductWithBardcodeMixin({String? bardcode}) async {
    Product? product;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblProductID,
        queries: [Query.equal('bardcode', bardcode)]);
    if (res.documents.isNotEmpty) {
      product = res.documents
          .map((e) => Product.fromJson(e.data))
          .toList()
          .firstOrNull;
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return product;
  }

  /// tìm kiếm mã sản phẩm hoặc mã vạch đã tồn tại chưa
  /// **Cập nhật** truyền đủ mã sp và mã vạch
  /// [ nếu list rỗng đúng, list có 1 phần tử đúng, list > 1 phần tử sai]
  /// **Tạo mới**
  /// [ nếu list rỗng đúng, list có 1 phần tử sai, list > 1 phần tử sai]
  /// ds ng dùng
  Future<List<Product>?> checkUniqueProductMixin(
      {String? code, String? bardcode}) async {
    List<Product>? listProduct = [];
    if (code != null) {
      var res = await appWriteRepo.databases.listDocuments(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblProductID,
          queries: [
            ...[Query.equal('code', code)],
          ]);
      if (res.documents.isNotEmpty) {
        listProduct.addAll(
            res.documents.map((e) => Product.fromJson(e.data)).toList());
      }
    }
    if (bardcode != null) {
      var res2 = await appWriteRepo.databases.listDocuments(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblProductID,
          queries: [
            ...[Query.equal('bardcode', bardcode)]
          ]);
      if (res2.documents.isNotEmpty) {
        listProduct.addAll(
            res2.documents.map((e) => Product.fromJson(e.data)).toList());
      }
    }
    // loại bỏ phần tử trùng
    final ids = listProduct.map((e) => e.uid).toSet();
    listProduct.retainWhere((x) => ids.remove(x.uid));
    listProduct = listProduct.toSet().toList();
    return listProduct;
  }
}
