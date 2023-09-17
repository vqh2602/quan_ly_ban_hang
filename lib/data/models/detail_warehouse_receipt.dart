// ignore_for_file: public_member_api_docs, sort_constructors_first
class DetailWarehouseReceipt {
  String? uid;
  String? wareHouseId;
  String? productId;
  num? quantity;
  num? importPrice;
  String? note;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  DetailWarehouseReceipt(
      {this.uid,
      this.wareHouseId,
      this.productId,
      this.quantity,
      this.importPrice,
      this.note,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  DetailWarehouseReceipt.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    wareHouseId = json['wareHouseId'];
    productId = json['productId'];
    quantity = json['quantity'];
    importPrice = json['importPrice'];
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
    data['wareHouseId'] = wareHouseId;
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['importPrice'] = importPrice;
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

  DetailWarehouseReceipt copyWith({
    String? uid,
    String? wareHouseId,
    String? productId,
    num? quantity,
    num? importPrice,
    String? note,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return DetailWarehouseReceipt(
      uid: uid ?? this.uid,
      wareHouseId: wareHouseId ?? this.wareHouseId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      importPrice: importPrice ?? this.importPrice,
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
