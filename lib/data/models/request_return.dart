// ignore_for_file: public_member_api_docs, sort_constructors_first
class RequestReturn {
  String? uid;
  String? name;
  String? supplierID;
  String? supplierName;
  num? totalMoney;
  num? totalAmountRefunded;
  String? timeRequestReturn;
  String? supplierStatus;
  String? browsingStatus;
  String? personnelWarehouseStaffId;
  String? personnelWarehouseStaffName;
  String? note;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  RequestReturn(
      {this.uid,
      this.name,
      this.supplierID,
      this.supplierName,
      this.totalMoney,
      this.totalAmountRefunded,
      this.timeRequestReturn,
      this.supplierStatus,
      this.browsingStatus,
      this.personnelWarehouseStaffId,
      this.personnelWarehouseStaffName,
      this.note,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  RequestReturn.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    name = json['name'];
    supplierID = json['supplierID'];
    supplierName = json['supplierName'];
    totalMoney = json['totalMoney'];
    totalAmountRefunded = json['totalAmountRefunded'];
    timeRequestReturn = json['timeRequestReturn'];
    supplierStatus = json['supplierStatus'];
    browsingStatus = json['browsingStatus'];
    personnelWarehouseStaffId = json['personnelWarehouseStaffId'];
    personnelWarehouseStaffName = json['personnelWarehouseStaffName'];
    note = json['note'];
    id = json['\$id'];
    createdAt = json['\$createdAt'];
    updatedAt = json['\$updatedAt'];
    if (json['\$permissions'] != null) {
      permissions = [];
      json['\$permissions'].forEach((v) {
        permissions!.add(v);
      });
    }
    collectionId = json['\$collectionId'];
    databaseId = json['\$databaseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uid;
    data['name'] = name;
    data['supplierID'] = supplierID;
    data['supplierName'] = supplierName;
    data['totalMoney'] = totalMoney;
    data['totalAmountRefunded'] = totalAmountRefunded;
    data['timeRequestReturn'] = timeRequestReturn;
    data['supplierStatus'] = supplierStatus;
    data['browsingStatus'] = browsingStatus;
    data['personnelWarehouseStaffId'] = personnelWarehouseStaffId;
    data['personnelWarehouseStaffName'] = personnelWarehouseStaffName;
    data['note'] = note;
    // data['\$id'] = id;
    // data['\$createdAt'] = createdAt;
    // data['\$updatedAt'] = updatedAt;
    // if (permissions != null) {
    //   data['\$permissions'] = permissions;
    // }
    // data['\$collectionId'] = collectionId;
    // data['\$databaseId'] = databaseId;
    return data;
  }

  RequestReturn copyWith({
    String? uid,
    String? name,
    String? supplierID,
    String? supplierName,
    num? totalMoney,
    num? totalAmountRefunded,
    String? timeRequestReturn,
    String? supplierStatus,
    String? browsingStatus,
    String? personnelWarehouseStaffId,
    String? personnelWarehouseStaffName,
    String? note,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return RequestReturn(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      supplierID: supplierID ?? this.supplierID,
      supplierName: supplierName ?? this.supplierName,
      totalMoney: totalMoney ?? this.totalMoney,
      totalAmountRefunded: totalAmountRefunded ?? this.totalAmountRefunded,
      timeRequestReturn: timeRequestReturn ?? this.timeRequestReturn,
      supplierStatus: supplierStatus ?? this.supplierStatus,
      browsingStatus: browsingStatus ?? this.browsingStatus,
      personnelWarehouseStaffId:
          personnelWarehouseStaffId ?? this.personnelWarehouseStaffId,
      personnelWarehouseStaffName:
          personnelWarehouseStaffName ?? this.personnelWarehouseStaffName,
      note: note ?? this.note,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      permissions: permissions ?? this.permissions,
      collectionId: collectionId ?? this.collectionId,
      databaseId: databaseId ?? this.databaseId,
    );
  }
}
