import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quan_ly_ban_hang/config/config.dart';
import 'package:quan_ly_ban_hang/data/repositories/appwrite_repo.dart';
import 'package:quan_ly_ban_hang/modules/list/list_customer/list_customer_controller.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:quan_ly_ban_hang/data/models/customer.dart';
ListCustomerController listCustomerController = Get.find();
mixin CustomerMixin {
  AppWriteRepo appWriteRepo = AppWriteRepo();
  GetStorage box = GetStorage();
  List<Customer>? listCustomerMixin = [];


  initRequestReturnMixin() async {
    await realTime();
  }

// lắng ghe sự kiện thay đổi và vập nhật - realtime
  realTime() async {
    final realtime = Realtime(client);
// Subscribe to files channel
    final subscription = realtime.subscribe([
      'databases.${Env.config.appWriteDatabaseID}.collections.${Env.config.tblCustomerID}.documents'
    ]);

    subscription.stream.listen((response) async {
      if (response.events.contains('databases.*.collections.*.documents.*')) {
        await listCustomerController.getListCustomers();
        // Log when a new file is uploaded
        // if (kDebugMode) {
        //   print('realtime_db ycdt');
        // }
      }
    });
  }


  /// ds khach hàng
  Future<List<Customer>?> getListCustomerMixin({bool isCache = false}) async {
    if (isCache &&
        listCustomerMixin!= null &&
        (listCustomerMixin?.isNotEmpty ?? false)) {
      return listCustomerMixin;
    }
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblCustomerID);
    if (res.documents.isNotEmpty) {
      listCustomerMixin=
          res.documents.map((e) => Customer.fromJson(e.data)).toList();
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return listCustomerMixin;
  }

  /// chi tiết khach hang
  Future<Customer?> getDetailCustomerMixin({String? id}) async {
    Customer? customer;
    var res = await appWriteRepo.databases.getDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblCustomerID,
        documentId: id ?? '');
    if (res.data.isNotEmpty) {
      customer = Customer.fromJson(res.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return customer;
  }

  /// lọc kh qua uid
  Future<Customer?> getDetailCustomerWithUIDMixin({String? id}) async {
    Customer? customer;
    var res = await appWriteRepo.databases.listDocuments(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblCustomerID,
        queries: [
          Query.equal('id', id),
        ]);
    if (res.documents.isNotEmpty) {
      customer = Customer.fromJson(res.documents.first.data);
    } else {
      buildToast(
          title: 'Có lỗi xảy ra', message: '', status: TypeToast.getError);
      return null;
    }
    return customer;
  }

  /// cập nhật khach hang
  Future<Customer?> updateDetailCustomerMixin(
      {Customer? customer, String? id}) async {
    Customer? result;
    var res = await appWriteRepo.databases.updateDocument(
        databaseId: Env.config.appWriteDatabaseID,
        collectionId: Env.config.tblCustomerID,
        documentId: customer?.id ?? id ?? '',
        data: customer?.toJson());
    if (res.data.isNotEmpty) {
      result = Customer.fromJson(res.data);
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

  /// tạo khach hang
  Future<Customer?> createDetailCustomerMixin(
      {required Customer customer}) async {
    Customer? result;

    try {
      var res = await appWriteRepo.databases.createDocument(
          databaseId: Env.config.appWriteDatabaseID,
          collectionId: Env.config.tblCustomerID,
          documentId: ID.unique(),
          data: customer.toJson());
      if (res.data.isNotEmpty) {
        result = Customer.fromJson(res.data);
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
}
