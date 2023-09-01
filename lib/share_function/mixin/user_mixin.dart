import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/storage.dart';
import 'package:quan_ly_ban_hang/modules/init.dart';

mixin UserMixin {
  GetStorage box = GetStorage();
  User getUserInBox() {
    return box.read(Storages.dataUser) != null
        ? User.fromJson(box.read(Storages.dataUser))
        : User();
  }

  Future<void> saveUserInBox({required User user}) async {
    await box.write(Storages.dataUser, user.toJson());
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
