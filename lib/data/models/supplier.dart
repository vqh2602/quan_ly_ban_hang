// ignore_for_file: public_member_api_docs, sort_constructors_first
class Supplier {
  String? uid;
  String? name;
  String? phone;
  String? address;
  String? note;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  Supplier(
      {this.uid,
      this.name,
      this.phone,
      this.address,
      this.note,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    note = json['note'];
    id = json['\$id'];
    createdAt = json['$createdAt'];
    updatedAt = json['$updatedAt'];
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
    data['phone'] = phone;
    data['address'] = address;
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

  Supplier copyWith({
    String? uid,
    String? name,
    String? phone,
    String? address,
    String? note,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return Supplier(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
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
