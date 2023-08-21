import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/data/repositories/repo.dart';

class UserRepo extends Repo {
  GetStorage box = GetStorage();

  // đăng ký
  Future<void> signupWithEmail({
    required String name,
    required String email,
    required String passW,
    required String birth,
    required bool sex,
    required double height,
    required double weight,
    required String address,
    required String avatar,
  }) async {
    var res = await dioRepo.post('/api/register', data: {
      "name": name,
      "email": email,
      "birthday": birth,
      "gender": sex,
      "password": passW,
      "address": address,
      "weight": weight,
      "height": height,
      "avatar": avatar,
    });

    var result = jsonDecode(res.toString());
    if (result["success"]) {
      // buildToast(type: TypeToast.success, title: result['message']);
    } else {
      //   buildToast(type: TypeToast.failure, title: result["message"]);
    }
  }
}
