import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/detail_request_return.dart';
import 'package:quan_ly_ban_hang/data/models/request_return.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/modules/list/list_request_return/list_request_return_controller.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

ListRequestReturnController listRequestReturnController = Get.find();

mixin RequestReturnMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();

  initRequestReturnMixin() async {
    await realTime();
  }

// lắng ghe sự kiện thay đổi và vập nhật - realtime
  realTime() async {
    final realtime = Realtime(client);
// Subscribe to files channel
    final subscription = realtime.subscribe([
      'databases.${Env.config.appWriteDatabaseID}.collections.${Env.config.tblRequestReturnID}.documents'
    ]);

    subscription.stream.listen((response) async {
      if (response.events.contains('databases.*.collections.*.documents.*')) {
        await listRequestReturnController.getListRequestReturn();
        // Log when a new file is uploaded
        if (kDebugMode) {
          print('realtime_db ycdt');
        }
      }
    });
  }

  /// ds đơn bán hàng
  Future<List<RequestReturn>?> getListRequestReturnMixin() async {
    List<RequestReturn>? listRequestReturn;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblRequestReturnID);
    if (res.documents.isNotEmpty) {
      listRequestReturn =
          res.documents.map((e) => RequestReturn.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listRequestReturn;
  }

  /// chi tiết đơn bán
  Future<RequestReturn?> getDetailRequestReturnMixin({String? id}) async {
    RequestReturn? requestReturn;
    var res = await appWriteRepo.databases.getDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblRequestReturnID,
        documentId: id ?? '');
    if (res.data.isNotEmpty) {
      requestReturn = RequestReturn.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra khi lấy thông tin dánh sách sản phẩm hoá đơn',
          message: '',
          status: TypeToast.getError);
      return null;
    }
    return requestReturn;
  }

  /// cập nhật đơn bán
  Future<RequestReturn?> updateDetailRequestReturnMixin(
      {RequestReturn? requestReturn}) async {
    RequestReturn? result;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblRequestReturnID,
        documentId: requestReturn?.id ?? '',
        data: requestReturn?.toJson());
    if (res.data.isNotEmpty) {
      result = RequestReturn.fromJson(res.data);
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

  /// tạo đơn bán
  Future<RequestReturn?> createDetailRequestReturnMixin(
      {required RequestReturn requestReturn}) async {
    RequestReturn? result;
    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblRequestReturnID,
          documentId: ID.unique(),
          data: requestReturn.toJson());
      if (res.data.isNotEmpty) {
        result = RequestReturn.fromJson(res.data);
        buildToast(
            title: 'Tạo mới hoá đơn thành công',
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

  /// danh sách chi tiết sản phẩm trong hoá đơn
  Future<List<DetailRequestReturn>?> getListDetailProductInRequestReturnMixin(
      {required String? idRequestReturn}) async {
    List<DetailRequestReturn>? listDetailSalseOrder;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblDetailRequestReturnID,
        queries: [Query.equal('requestReturnId', idRequestReturn)]);
    if (res.documents.isNotEmpty) {
      listDetailSalseOrder = res.documents
          .map((e) => DetailRequestReturn.fromJson(e.data))
          .toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listDetailSalseOrder;
  }

  /// cập nhật danh sách chi tiết sản phẩm trong hoá đơn
  Future<DetailRequestReturn?> updateDetailProductInRequestReturnMixin(
      {DetailRequestReturn? detailRequestReturn}) async {
    DetailRequestReturn? detailSalseOrderResult;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblDetailRequestReturnID,
        documentId: detailRequestReturn?.id ?? '',
        data: detailRequestReturn?.toJson());
    if (res.data.isNotEmpty) {
      detailSalseOrderResult = DetailRequestReturn.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return detailSalseOrderResult;
  }

  /// xoá danh sách chi tiết sản phẩm trong hoá đơn
  Future<DetailRequestReturn?> deleteDetailProductInRequestReturnMixin(
      {DetailRequestReturn? detailRequestReturn}) async {
    DetailRequestReturn? detailSalseOrderResult;
    var res = await appWriteRepo.databases.deleteDocument(
      databaseId: Env.config.appWriteDatabaseID,
      collectionId: Env.config.tblDetailRequestReturnID,
      documentId: detailRequestReturn?.id ?? '',
    );

    if (res != null) {
      // detailSalseOrderResult = DetailRequestReturn.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return detailSalseOrderResult;
  }

  /// tạo sản phẩm trong hoá đơn
  Future<DetailRequestReturn?> createDetailProductInRequestReturnMixin(
      {DetailRequestReturn? detailRequestReturn}) async {
    DetailRequestReturn? result;

    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblDetailRequestReturnID,
          documentId: ID.unique(),
          data: detailRequestReturn?.toJson() ?? {});
      if (res.data.isNotEmpty) {
        result = DetailRequestReturn.fromJson(res.data);
        buildToast(
            title: 'Đã thêm sản phẩm',
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
