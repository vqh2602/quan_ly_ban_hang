// ignore_for_file: public_member_api_docs, sort_constructors_first
class DetailSalesOrder {
  String? uid;
  String? salesOrderId;
  String? productId;
  num? quantity;
  num? importPrice;
  num? price;
  num? discount;
  String? note;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  DetailSalesOrder(
      {this.uid,
      this.salesOrderId,
      this.productId,
      this.quantity,
      this.importPrice,
      this.price,
      this.discount,
      this.note,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  DetailSalesOrder.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    salesOrderId = json['salesOrderId'];
    productId = json['productId'];
    quantity = json['quantity'];
    importPrice = json['importPrice'];
    price = json['price'];
    discount = json['discount'];
    note = json['note'];
    id = json['\$id'];
    createdAt = json['\$createdAt'];
    updatedAt = json['\$updatedAt'];
    if (json['\$permissions'] != null) {
      permissions = <Null>[];
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
    data['salesOrderId'] = salesOrderId;
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['importPrice'] = importPrice;
    data['price'] = price;
    data['discount'] = discount;
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

  DetailSalesOrder copyWith({
    String? uid,
    String? salesOrderId,
    String? productId,
    num? quantity,
    num? importPrice,
    num? price,
    num? discount,
    String? note,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return DetailSalesOrder(
      uid: uid ?? this.uid,
      salesOrderId: salesOrderId ?? this.salesOrderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      importPrice: importPrice ?? this.importPrice,
      price: price ?? this.price,
      discount: discount ?? this.discount,
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
