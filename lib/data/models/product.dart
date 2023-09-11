// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String? uid;
  String? name;
  num? quantity;
  num? importPrice;
  num? price;
  List<String>? category;
  num? numberSales;
  num? discount;
  String? code;
  String? bardcode;
  String? unit;
  String? note;
  String? image;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  Product(
      {this.uid,
      this.name,
      this.quantity,
      this.importPrice,
      this.price,
      this.category,
      this.numberSales,
      this.discount,
      this.code,
      this.bardcode,
      this.unit,
      this.note,
      this.image,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  Product.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    quantity = json['quantity'];
    importPrice = json['importPrice'];
    price = json['price'];
    category = json['category'].cast<String>();
    numberSales = json['numberSales'];
    discount = json['discount'];
    code = json['code'];
    bardcode = json['bardcode'];
    unit = json['unit'];
    note = json['note'];
    image = json['image'];
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
    data['uid'] = uid;
    data['name'] = name;
    data['quantity'] = quantity;
    data['importPrice'] = importPrice;
    data['price'] = price;
    data['category'] = category;
    data['numberSales'] = numberSales;
    data['discount'] = discount;
    data['code'] = code;
    data['bardcode'] = bardcode;
    data['unit'] = unit;
    data['note'] = note;
    data['image'] = image;
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

  Product copyWith({
    String? uid,
    String? name,
    num? quantity,
    num? importPrice,
    num? price,
    List<String>? category,
    num? numberSales,
    num? discount,
    String? code,
    String? bardcode,
    String? unit,
    String? note,
    String? image,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return Product(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      importPrice: importPrice ?? this.importPrice,
      price: price ?? this.price,
      category: category ?? this.category,
      numberSales: numberSales ?? this.numberSales,
      discount: discount ?? this.discount,
      code: code ?? this.code,
      bardcode: bardcode ?? this.bardcode,
      unit: unit ?? this.unit,
      note: note ?? this.note,
      image: image ?? this.image,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      permissions: permissions ?? this.permissions,
      collectionId: collectionId ?? this.collectionId,
      databaseId: databaseId ?? this.databaseId,
    );
  }
}
