import 'package:get_storage/get_storage.dart';
import 'package:appwrite/appwrite.dart';
import 'package:quan_ly_ban_hang/config/config.dart';

Client client = Client()
    .setEndpoint(Env.config.endpointAppWrite) // Your Appwrite Endpoint
    .setProject(Env.config.projectAppWriteID)
    .setSelfSigned(
        status: true); //Đối với chứng chỉ tự ký, chỉ sử dụng để phát triển

class AppWriteRepo {
  GetStorage box = GetStorage();
  Databases databases = Databases(client); // Your project ID

  initDataAccount() async {
    // ng dùng ẩn danh
    final account = Account(client);

    //             final user = await account.create(
    // userId: ID.unique(),
    // email: 'vqh2602@gmail.com',
    // password: '12345678');
    try {
      // final session =

      await account.get();
    } on Exception catch (_) {
      // final user =
      await account.createAnonymousSession();
    }
  }
}
