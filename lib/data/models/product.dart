class Product {
  String? uid;
  String? name;
  int? quantity;
  int? importPrice;
  int? price;
  List<String>? category;
  int? numberSales;
  int? discount;
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
    uid = json['id'];
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
    data['id'] = uid;
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
    data['\$id'] = id;
    data['\$createdAt'] = createdAt;
    data['\$updatedAt'] = updatedAt;
    if (permissions != null) {
      data['\$permissions'] = permissions;
    }
    data['\$collectionId'] = collectionId;
    data['\$databaseId'] = databaseId;
    return data;
  }
}
