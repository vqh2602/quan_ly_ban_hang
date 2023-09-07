import 'package:appwrite/appwrite.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/models/detail_sales_order.dart';
import 'package:quan_ly_ban_hang/data/models/sales_order.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';

mixin SalesOrderMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();

  /// ds đơn bán hàng
  Future<List<SalesOrder>?> getListSalesOrderMixin() async {
    List<SalesOrder>? listSalesOrder;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblSalesOrderID);
    if (res.documents.isNotEmpty) {
      listSalesOrder =
          res.documents.map((e) => SalesOrder.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listSalesOrder;
  }

  /// chi tiết đơn bán
  Future<SalesOrder?> getDetailSalesOrderMixin({String? id}) async {
    SalesOrder? salesOrder;
    var res = await appWriteRepo.databases.getDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblSalesOrderID,
        documentId: id ?? '');
    if (res.data.isNotEmpty) {
      salesOrder = SalesOrder.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return salesOrder;
  }

  /// cập nhật đơn bán
  Future<SalesOrder?> updateDetailSalesOrderMixin(
      {SalesOrder? salesOrder}) async {
    SalesOrder? result;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblSalesOrderID,
        documentId: salesOrder?.id ?? '',
        data: salesOrder?.toJson());
    if (res.data.isNotEmpty) {
      result = SalesOrder.fromJson(res.data);
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
  Future<SalesOrder?> createDetailSalesOrderMixin(
      {required SalesOrder salesOrder}) async {
    SalesOrder? result;

    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblSalesOrderID,
          documentId: ID.unique(),
          data: salesOrder.toJson());
      if (res.data.isNotEmpty) {
        result = SalesOrder.fromJson(res.data);
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

  /// danh sách chi tiết sản phẩm trong hoá đơn
  Future<List<DetailSalesOrder>?> getListDetailProductInSalesOrderMixin(
      {required String? idSalesOrder}) async {
    List<DetailSalesOrder>? listDetailSalseOrder;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblDetailSalesOrderID,
        queries: [Query.equal('salesOrderId', idSalesOrder)]);
    if (res.documents.isNotEmpty) {
      listDetailSalseOrder =
          res.documents.map((e) => DetailSalesOrder.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listDetailSalseOrder;
  }
}
