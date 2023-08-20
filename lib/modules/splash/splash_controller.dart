import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/data/storage.dart';
import 'package:appwrite/appwrite.dart';
import 'package:quan_ly_ban_hang/modules/home/home_screen.dart';

class SplashController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    testappWire();
    changeUI();
  }

  testappWire() async {
    Client client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('64c8b797c7af7b05577b')
        .setSelfSigned(
            status: true); //Đối với chứng chỉ tự ký, chỉ sử dụng để phát triển
    // ng dùng ẩn danh
    final account = Account(client);
    try {
      final session = await account.get();
    } on Exception catch (_) {
      final user = await account.createAnonymousSession();
    }

    //db
    Databases databases = Databases(client); // Your project ID
    var result = await databases.listDocuments(
      databaseId: '64c8b7b0c8f4f758c52d',
      collectionId: '64c8b7e68b4d6d089c46',
    );
    print(result.documents);
  }

  Future<void> checkLogin() async {
    // var dataUser = await box.read(Storages.dataUser);
    // //kiểm tra dữ liệu user và thời gian đăng nhập
    // // Future.delayed(const Duration(seconds: 5), () {
    // //   Get.offAndToNamed(HomeScreen.routeName);
    // // });
    // if (dataUser != null && await checkLoginTimeOut()) {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAndToNamed(HomeScreen.routeName);
      });
    // } else {
    //   Future.delayed(const Duration(seconds: 4), () {
    //     Get.offAndToNamed(LoginScreen.routeName);
    //   });
    // }
  }

  Future<bool> checkLoginTimeOut() async {
    var dataTimeOut = await box.read(Storages.dataLoginTime);
    if (dataTimeOut != null) {
      // Kiểm tra một thời điểm có nằm trong một khoảng thời gian hay không
      try {
        DateTime dateTime = DateTime.now();
        DateTime startDate = DateTime.parse(dataTimeOut);
        DateTime endDate =
            startDate.add(const Duration(hours: Config.dataLoginTimeOut));
        if (dateTime.isAfter(startDate) && dateTime.isBefore(endDate)) {
          return true;
        } else {}
      } on Exception catch (_) {
        return false;
      }
    }
    return false;
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
