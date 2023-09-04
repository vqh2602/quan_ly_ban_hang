class Env {
  static late ModuleConfig config;
}

class ModuleConfig {
  String flavor = 'base';
  String baseUrl = '';
  String imgurApi = '';
  String projectAppWriteID = '';
  String endpointAppWrite = '';
  String appWriteDatabaseID = '';
  /// SẢN PHẨM
  String tblProductID = '';
  String appWriteApiKey='12621e21de83a7c08702669907869bbbdc20f4fda456eef9938aff6c92448d60eb18c1c2c860a1c4e3e9e671726c1d62b65df85abebd7c3d67948f6f53ca7c2422aa6cd88b5c9b41412af8423e565c87c72f286e79ae8ff8547290e21d33a156c694ded2e1067d00a82fd9c7e0f01897b7e139c1acfbb32a1055c55dc3247fee';
  /// NHÂN VIÊN
  String tblPersonnelID = '';
  /// ĐƠN VỊ
  String tblUnitID ='tbl_unit'; 
  /// TRẠNG THÁI
  String tblStatusID = 'tbl_status';
  /// QUYỀN
  String tblPermissionID = 'tbl_permission';
  /// CHỨC VỤ
  String tblDepartmentID = 'tbl_department';
  /// DANH MỤC - NHÃN
  String tblCategoryID = 'tbl_category';
  /// KHÁCH HÀNG
  String tblCustomerID = 'tbl_customer';
  /// Nhà Cung cấp
  String tblSupplierID = 'tbl_supplier';


}
