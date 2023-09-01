import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';
import 'package:quan_ly_ban_hang/data/storage.dart';
// import 'package:appwrite/appwrite.dart';
import 'package:quan_ly_ban_hang/modules/auth/login/login_screen.dart';
import 'package:quan_ly_ban_hang/modules/home/home_screen.dart';
// import 'package:dart_appwrite/dart_appwrite.dart' as server_appwrite;

class SplashController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  ImgurRepo imgurRepo = ImgurRepo();
  var arguments = Get.arguments;

  @override
  Future<void> onInit() async {
    super.onInit();
    // testappWire();
    // await testappWireServer();
    changeUI();
  }

  // testappWireServer() async {
  //   server_appwrite.Client client = server_appwrite.Client()
  //       .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
  //       .setProject('64c8b797c7af7b05577b')
  //       .setKey(
  //           '12621e21de83a7c08702669907869bbbdc20f4fda456eef9938aff6c92448d60eb18c1c2c860a1c4e3e9e671726c1d62b65df85abebd7c3d67948f6f53ca7c2422aa6cd88b5c9b41412af8423e565c87c72f286e79ae8ff8547290e21d33a156c694ded2e1067d00a82fd9c7e0f01897b7e139c1acfbb32a1055c55dc3247fee')
  //       .setSelfSigned(
  //           status: true); //Đối với chứng chỉ tự ký, chỉ sử dụng để phát triển
  //   // ng dùng ẩn danh
  //   final account = server_appwrite.Account(client);

  //   try {
  //     // final session =
  //     // await account.getSession( sessionId: );
  //   } on Exception catch (_) {
  //     // final user =
  //   }

  //   //db
  //   server_appwrite.Databases databases =
  //       server_appwrite.Databases(client); // Your project ID
  //   // var result =
  //   // await databases.listDocuments(
  //   //   databaseId: '64c8b7b0c8f4f758c52d',
  //   //   collectionId: '64c8b7e68b4d6d089c46',
  //   // );
  //   // print(result.documents);
  //   await databases.deleteCollection(
  //     databaseId: '64c8b7b0c8f4f758c52d',
  //     collectionId: '64ed9ae91c1b8391f172',
  //   );
  // }

  Future<void> checkLogin() async {
    var dataUser = await box.read(Storages.dataUser);
    // kiểm tra dữ liệu user và thời gian đăng nhập
    // Future.delayed(const Duration(seconds: 5), () {
    //   Get.offAndToNamed(HomeScreen.routeName);
    // });
    if (dataUser != null && await checkLoginTimeOut()) {
      if (arguments?["refreshToken"] ?? false) {
        await imgurRepo.resetTokenImgur();
      }
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAndToNamed(HomeScreen.routeName);
      });
    } else {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAndToNamed(LoginScreen.routeName);
      });
    }
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
