class WarehouseReceipt {
  String? uid;
  String? supplierID;
  String? supplierName;
  num? totalMoney;
  String? timeWarehouse;
  String? paymentStatus;
  String? deliveryStatus;
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

  WarehouseReceipt(
      {this.uid,
      this.supplierID,
      this.supplierName,
      this.totalMoney,
      this.timeWarehouse,
      this.paymentStatus,
      this.deliveryStatus,
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

  WarehouseReceipt.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    supplierID = json['supplierID'];
    supplierName = json['supplierName'];
    totalMoney = json['totalMoney'];
    timeWarehouse = json['timeWarehouse'];
    paymentStatus = json['paymentStatus'];
    deliveryStatus = json['deliveryStatus'];
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
    data['supplierID'] = supplierID;
    data['supplierName'] = supplierName;
    data['totalMoney'] = totalMoney;
    data['timeWarehouse'] = timeWarehouse;
    data['paymentStatus'] = paymentStatus;
    data['deliveryStatus'] = deliveryStatus;
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

  WarehouseReceipt copyWith({
    String? uid,
    String? supplierID,
    String? supplierName,
    num? totalMoney,
    String? timeWarehouse,
    String? paymentStatus,
    String? deliveryStatus,
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
    return WarehouseReceipt(
      uid: uid ?? this.uid,
      supplierID: supplierID ?? this.supplierID,
      supplierName: supplierName ?? this.supplierName,
      totalMoney: totalMoney ?? this.totalMoney,
      timeWarehouse: timeWarehouse ?? this.timeWarehouse,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
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
