import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/data/storage.dart';
import 'package:quan_ly_ban_hang/modules/init.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

mixin UserMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();
  User getUserInBox() {
    return box.read(Storages.dataUser) != null
        ? User.fromJson(box.read(Storages.dataUser))
        : User();
  }

  /// cập nhật user
  Future<User?> updateDetailUserMixin(
      {User? user, String? id, bool isUpdateUserLogin = false}) async {
    User? result;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblPersonnelID,
        documentId: user?.$id ?? id ?? '',
        data: user?.toJson());
    if (res.data.isNotEmpty) {
      result = User.fromJson(res.data);
      if (isUpdateUserLogin) {
        await saveUserInBox(dataUser: res.data);
      }
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
  Future<void> saveUserInBox({User? user, Map? dataUser}) async {
    await box.write(Storages.dataUser, dataUser ?? user?.toJson());
  }

  Future<void> clearDataUser() async {
    await box.remove(Storages.dataUser);
  }

  Future<void> clearAndResetApp() async {
    await Get.deleteAll(force: true); //deleting all controllers
    Phoenix.rebirth(Get.context!); // Restarting app
    Get.reset(); // resetting getx
    await initialize();
  }
}
