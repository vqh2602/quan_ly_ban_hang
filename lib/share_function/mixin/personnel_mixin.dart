import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/personnel.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/modules/list/list_personnel/list_personnel_controller.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

ListPersonnelController listPersonnelController = Get.find();

mixin PersonnelMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();

  List<Personnel>? listPersonnelMixin;

  initRequestReturnMixin() async {
    await realTime();
  }

// lắng ghe sự kiện thay đổi và vập nhật - realtime
  realTime() async {
    final realtime = Realtime(client);
// Subscribe to files channel
    final subscription = realtime.subscribe([
      'databases.${Env.config.appWriteDatabaseID}.collections.${Env.config.tblPersonnelID}.documents'
    ]);

    subscription.stream.listen((response) async {
      if (response.events.contains('databases.*.collections.*.documents.*')) {
        await listPersonnelController.getListPersonnels();
        // Log when a new file is uploaded
        // if (kDebugMode) {
        //   print('realtime_db ycdt');
        // }
      }
    });
  }


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

  /// tìm kiếm sdt hoặc cccd đã tồn tại chưa
  /// **Cập nhật** truyền đủ phone và cccd
  /// [ nếu list rỗng đúng, list có 1 phần tử đúng, list > 1 phần tử sai]
  /// **Tạo mới**
  /// [ nếu list rỗng đúng, list có 1 phần tử sai, list > 1 phần tử sai]
  /// ds ng dùng
  Future<List<Personnel>?> checkUniquePersonnelMixin(
      {String? phone, String? cccd}) async {
    List<Personnel>? listPersonnel = [];
    if (phone != null) {
      var res = await appWriteRepo.databases.listDocuments(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblPersonnelID,
          queries: [
            ...[Query.equal('phone', phone)],
          ]);
      if (res.documents.isNotEmpty) {
        listPersonnel.addAll(
            res.documents.map((e) => Personnel.fromJson(e.data)).toList());
      }
    }
    if (cccd != null) {
      var res2 = await appWriteRepo.databases.listDocuments(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblPersonnelID,
          queries: [
            ...[Query.equal('cccd', cccd)]
          ]);
      if (res2.documents.isNotEmpty) {
        listPersonnel.addAll(
            res2.documents.map((e) => Personnel.fromJson(e.data)).toList());
      }
    }
    // loại bỏ phần tử trùng
    final ids = listPersonnel.map((e) => e.uId).toSet();
    listPersonnel.retainWhere((x) => ids.remove(x.uId));
    listPersonnel = listPersonnel.toSet().toList();
    return listPersonnel;
  }
}
