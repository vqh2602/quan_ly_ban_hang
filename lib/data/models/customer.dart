// ignore_for_file: public_member_api_docs, sort_constructors_first
class Customer {
  String? uid;
  String? name;
  String? gender;
  String? address;
  String? phone;
  String? note;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  Customer(
      {this.uid,
      this.name,
      this.gender,
      this.address,
      this.phone,
      this.note,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  Customer.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    name = json['name'];
    gender = json['gender'];
    address = json['address'];
    phone = json['phone'];
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
    data['gender'] = gender;
    data['address'] = address;
    data['phone'] = phone;
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

  Customer copyWith({
    String? uid,
    String? name,
    String? gender,
    String? address,
    String? phone,
    String? note,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return Customer(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      phone: phone ?? this.phone,
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
