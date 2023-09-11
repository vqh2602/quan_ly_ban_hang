import 'package:appwrite/appwrite.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/product.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

mixin ProductMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();
  List<Product>? listProductMixin = [];

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
}
