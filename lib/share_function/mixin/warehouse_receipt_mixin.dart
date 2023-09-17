import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/detail_warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/data/models/warehouse_receipt.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/modules/list/list_warehouse_receipt/list_warehouse_receipt_controller.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

ListWarehouseReceiptController listWarehouseReceiptController = Get.find();

mixin WarehouseReceiptMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();

  initWarehouseReceiptMixin() async {
    await realTime();
  }
// lắng ghe sự kiện thay đổi và vập nhật - realtime
  realTime() {
    final realtime = Realtime(client);
// Subscribe to files channel
    final subscription = realtime.subscribe([
      'databases.${Env.config.appWriteDatabaseID}.collections.${Env.config.tblWarehouseReceiptID}.documents'
    ]);
    subscription.stream.listen((response) async {
      if (response.events.contains('databases.*.collections.*.documents.*')) {
        await listWarehouseReceiptController.getListWarehouseReceipt();
        // Log when a new file is uploaded
        // print('realtime_db: ${response.payload}');
      }
    });
  }

  /// ds đơn bán hàng
  Future<List<WarehouseReceipt>?> getListWarehouseReceiptMixin() async {
    List<WarehouseReceipt>? listWarehouseReceipt;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblWarehouseReceiptID);
    if (res.documents.isNotEmpty) {
      listWarehouseReceipt =
          res.documents.map((e) => WarehouseReceipt.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listWarehouseReceipt;
  }

  /// chi tiết đơn bán
  Future<WarehouseReceipt?> getDetailWarehouseReceiptMixin({String? id}) async {
    WarehouseReceipt? warehouseReceipt;
    var res = await appWriteRepo.databases.getDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblWarehouseReceiptID,
        documentId: id ?? '');
    if (res.data.isNotEmpty) {
      warehouseReceipt = WarehouseReceipt.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra khi lấy thông tin dánh sách sản phẩm hoá đơn',
          message: '',
          status: TypeToast.getError);
      return null;
    }
    return warehouseReceipt;
  }

  /// cập nhật đơn bán
  Future<WarehouseReceipt?> updateDetailWarehouseReceiptMixin(
      {WarehouseReceipt? warehouseReceipt}) async {
    WarehouseReceipt? result;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblWarehouseReceiptID,
        documentId: warehouseReceipt?.id ?? '',
        data: warehouseReceipt?.toJson());
    if (res.data.isNotEmpty) {
      result = WarehouseReceipt.fromJson(res.data);
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
  Future<WarehouseReceipt?> createDetailWarehouseReceiptMixin(
      {required WarehouseReceipt warehouseReceipt}) async {
    WarehouseReceipt? result;
    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblWarehouseReceiptID,
          documentId: ID.unique(),
          data: warehouseReceipt.toJson());
      if (res.data.isNotEmpty) {
        result = WarehouseReceipt.fromJson(res.data);
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
  Future<List<DetailWarehouseReceipt>?> getListDetailProductInWarehouseReceiptMixin(
      {required String? idWarehouseReceipt}) async {
    List<DetailWarehouseReceipt>? listDetailSalseOrder;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblDetailWarehouseReceiptID,
        queries: [Query.equal('wareHouseId', idWarehouseReceipt)]);
    if (res.documents.isNotEmpty) {
      listDetailSalseOrder =
          res.documents.map((e) => DetailWarehouseReceipt.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listDetailSalseOrder;
  }

  /// cập nhật danh sách chi tiết sản phẩm trong hoá đơn
  Future<DetailWarehouseReceipt?> updateDetailProductInWarehouseReceiptMixin(
      {DetailWarehouseReceipt? detailWarehouseReceipt}) async {
    DetailWarehouseReceipt? detailSalseOrderResult;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblDetailWarehouseReceiptID,
        documentId: detailWarehouseReceipt?.id ?? '',
        data: detailWarehouseReceipt?.toJson());
    if (res.data.isNotEmpty) {
      detailSalseOrderResult = DetailWarehouseReceipt.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return detailSalseOrderResult;
  }

  /// xoá danh sách chi tiết sản phẩm trong hoá đơn
  Future<DetailWarehouseReceipt?> deleteDetailProductInWarehouseReceiptMixin(
      {DetailWarehouseReceipt? detailWarehouseReceipt}) async {
    DetailWarehouseReceipt? detailSalseOrderResult;
    var res = await appWriteRepo.databases.deleteDocument(
      databaseId: Env.config.appWriteDatabaseID,
      collectionId: Env.config.tblDetailWarehouseReceiptID,
      documentId: detailWarehouseReceipt?.id ?? '',
    );

    if (res != null) {
      // detailSalseOrderResult = DetailWarehouseReceipt.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return detailSalseOrderResult;
  }

  /// tạo sản phẩm trong hoá đơn
  Future<DetailWarehouseReceipt?> createDetailProductInWarehouseReceiptMixin(
      {DetailWarehouseReceipt? detailWarehouseReceipt}) async {
    DetailWarehouseReceipt? result;

    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblDetailWarehouseReceiptID,
          documentId: ID.unique(),
          data: detailWarehouseReceipt?.toJson() ?? {});
      if (res.data.isNotEmpty) {
        result = DetailWarehouseReceipt.fromJson(res.data);
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
