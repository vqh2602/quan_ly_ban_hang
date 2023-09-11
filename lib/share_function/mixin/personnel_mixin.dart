import 'package:appwrite/appwrite.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/personnel.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

mixin PersonnelMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();

  List<Personnel>? listPersonnelMixin;

  /// ds ng dùng
  Future<List<Personnel>?> getListPersonnelMixin({bool isCache = false}) async {
    if (isCache &&
        listPersonnelMixin != null &&
        (listPersonnelMixin?.isNotEmpty ?? false)) {
      return listPersonnelMixin;
    }
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblPersonnelID);
    if (res.documents.isNotEmpty) {
      listPersonnelMixin =
          res.documents.map((e) => Personnel.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listPersonnelMixin;
  }

  /// chi tiết ng dùng
  Future<Personnel?> getDetailPersonnelMixin({String? id}) async {
    Personnel? personnel;
    var res = await appWriteRepo.databases.getDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblPersonnelID,
        documentId: id ?? '');
    if (res.data.isNotEmpty) {
      personnel = Personnel.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return personnel;
  }

  /// cập nhật ng dùng
  Future<Personnel?> updateDetailPersonnelMixin({Personnel? personnel}) async {
    Personnel? result;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblPersonnelID,
        documentId: personnel?.id ?? '',
        data: personnel?.toJson());
    if (res.data.isNotEmpty) {
      result = Personnel.fromJson(res.data);
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

  /// tạo ng dùng
  Future<Personnel?> createDetailPersonnelMixin(
      {required Personnel personnel}) async {
    Personnel? result;

    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblPersonnelID,
          documentId: ID.unique(),
          data: personnel.toJson());
      if (res.data.isNotEmpty) {
        result = Personnel.fromJson(res.data);
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
