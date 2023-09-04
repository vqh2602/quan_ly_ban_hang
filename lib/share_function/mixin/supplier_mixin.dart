import 'package:appwrite/appwrite.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/data/models/supplier.dart';

mixin SupplierMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();

  /// ds khach hàng
  Future<List<Supplier>?> getListSupplierMixin() async {
    List<Supplier>? listSupplier;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblSupplierID);
    if (res.documents.isNotEmpty) {
      listSupplier =
          res.documents.map((e) => Supplier.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listSupplier;
  }

  /// chi tiết khach hang
  Future<Supplier?> getDetailSupplierMixin({String? id}) async {
    Supplier? supplier;
    var res = await appWriteRepo.databases.getDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblSupplierID,
        documentId: id ?? '');
    if (res.data.isNotEmpty) {
      supplier = Supplier.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return supplier;
  }

  /// cập nhật khach hang
  Future<Supplier?> updateDetailSupplierMixin(
      {Supplier? supplier, String? id}) async {
    Supplier? result;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblSupplierID,
        documentId: supplier?.id ?? id ?? '',
        data: supplier?.toJson());
    if (res.data.isNotEmpty) {
      result = Supplier.fromJson(res.data);
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

  /// tạo khach hang
  Future<Supplier?> createDetailSupplierMixin(
      {required Supplier supplier}) async {
    Supplier? result;

    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblSupplierID,
          documentId: ID.unique(),
          data: supplier.toJson());
      if (res.data.isNotEmpty) {
        result = Supplier.fromJson(res.data);
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
}