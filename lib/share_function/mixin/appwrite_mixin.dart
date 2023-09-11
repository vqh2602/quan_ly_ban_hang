import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/category.dart';
import 'package:quan_ly_ban_hang/data/models/department.dart';
import 'package:quan_ly_ban_hang/data/models/status.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/data/storage.dart';
import 'package:quan_ly_ban_hang/modules/splash/splash_screen.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/data/models/permission.dart' as permission;

mixin AppWriteMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();
  List<Unit>? listUnitMixin = []; // ds đơn vị tính
  List<Category>? listCategoryMixin = []; // ds nhãn
  List<Department>? listDepartmentMixin = []; // ds phòng ban
  List<permission.Permission>? listPermissionMixin = []; // ds quyền
  List<Status>? listStatusMixin = []; // ds trạng thái

  initMixin() async {
    // await appWriteRepo.initDataAccount();
    await getListUnitMixin();
    await getListCategoryMixin();
    await getListDepartmentMixin();
    await getListPermissionMixin();
  }

  /// đăng nhập
  Future<User?> loginMixin(
      {required String phone, required String password}) async {
    try {
      User? user;
      var res = await appWriteRepo.databases.listDocuments(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblPersonnelID,
          queries: [
            Query.equal('phone', phone),
            Query.equal('password', password),
          ]);
      if (res.documents.isNotEmpty) {
        user = User.fromJson(res.documents.first.data);
        await box.write(Storages.dataUser, res.documents.first.data);
        await box.write(Storages.dataLoginTime, DateTime.now().toString());
        Get.offAndToNamed(SplashScreen.routeName);

        buildToast(
            title: 'Đăng nhập thành công',
            message: 'Chào mừng ${user.name}',
            status: TypeToast.getSuccess);
        return user;
      } else {
        buildToast(
            title: 'Có lỗi xảy ra',
            message: 'Số điện thoại hoặc mật khẩu không đúng',
            status: TypeToast.getError);
        return null;
      }
    } on Exception catch (_) {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
    }
    return null;
  }

  /// ds đơn vị
  Future<List<Unit>?> getListUnitMixin({bool isCache = true}) async {
    if (listUnitMixin != null &&
        (listUnitMixin?.isNotEmpty ?? false) &&
        isCache) {
      return listUnitMixin;
    }
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblUnitID);
    if (res.documents.isNotEmpty) {
      listUnitMixin = res.documents.map((e) => Unit.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listUnitMixin;
  }

  /// ds nhãn- danh mục
  Future<List<Category>?> getListCategoryMixin({bool isCache = true}) async {
    if (listCategoryMixin != null &&
        (listCategoryMixin?.isNotEmpty ?? false) &&
        isCache) {
      return listCategoryMixin;
    }
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblCategoryID);
    if (res.documents.isNotEmpty) {
      listCategoryMixin =
          res.documents.map((e) => Category.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listCategoryMixin;
  }

  /// ds phòng ban
  Future<List<Department>?> getListDepartmentMixin(
      {bool isCache = true}) async {
    if (listDepartmentMixin != null &&
        (listDepartmentMixin?.isNotEmpty ?? false) &&
        isCache) {
      return listDepartmentMixin;
    }
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblDepartmentID);
    if (res.documents.isNotEmpty) {
      listDepartmentMixin =
          res.documents.map((e) => Department.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listDepartmentMixin;
  }

  /// ds phân quyền
  Future<List<permission.Permission>?> getListPermissionMixin(
      {bool isCache = true}) async {
    if (listPermissionMixin != null &&
        (listPermissionMixin?.isNotEmpty ?? false) &&
        isCache) {
      return listPermissionMixin;
    }
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblPermissionID);
    if (res.documents.isNotEmpty) {
      listPermissionMixin = res.documents
          .map((e) => permission.Permission.fromJson(e.data))
          .toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listPermissionMixin;
  }

  /// ds trạng thái
  Future<List<Status>?> getListStatusMixin({bool isCache = true}) async {
    if (listStatusMixin != null &&
        (listCategoryMixin?.isNotEmpty ?? false) &&
        isCache) {
      return listStatusMixin;
    }
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblStatusID);
    if (res.documents.isNotEmpty) {
      listStatusMixin =
          res.documents.map((e) => Status.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listStatusMixin;
  }
}
