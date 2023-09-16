// ignore_for_file: public_member_api_docs, sort_constructors_first
class DetailRequestReturn {
  String? uid;
  String? requestReturnId;
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

  DetailRequestReturn(
      {this.uid,
      this.requestReturnId,
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

  DetailRequestReturn.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    requestReturnId = json['requestReturnId'];
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
    data['requestReturnId'] = requestReturnId;
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

  DetailRequestReturn copyWith({
    String? uid,
    String? requestReturnId,
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
    return DetailRequestReturn(
      uid: uid ?? this.uid,
      requestReturnId: requestReturnId ?? this.requestReturnId,
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
