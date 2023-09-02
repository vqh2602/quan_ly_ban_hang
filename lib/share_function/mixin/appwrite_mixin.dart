import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/category.dart';
import 'package:quan_ly_ban_hang/data/models/unit.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/data/storage.dart';
import 'package:quan_ly_ban_hang/modules/splash/splash_screen.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

mixin AppWriteMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();
  List<Unit>? listUnitMixin = []; // ds đơn vị tính
  List<Category>? listCategoryMixin = []; // ds nhãn

  initMixin() async {
    // await appWriteRepo.initDataAccount();
    await getListUnitMixin();
    await getListCategoryMixin();
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
        await box.write(Storages.dataUser, user.toJson());
        await box.write(Storages.dataLoginTime, DateTime.now().toString());
        Get.toNamed(SplashScreen.routeName);
        buildToast(
            title: 'Đăng nhập thành công',
            message: 'Chào mừng ${user.name}',
            status: TypeToast.getSuccess);
      } else {
        buildToast(
            title: 'Có lỗi xảy ra',
            message: 'Số điện thoại hoặc mật khẩu không đúng',
            status: TypeToast.getError);
        return null;
      }
      return user;
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
}
