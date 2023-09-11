class Unit {
  String? uid;
  String? name;
  String? sign;
  String? note;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  Unit(
      {this.uid,
      this.name,
      this.sign,
      this.note,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  Unit.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    name = json['name'];
    sign = json['sign'];
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
    data['uid'] = uid;
    data['name'] = name;
    data['sign'] = sign;
    data['note'] = note;
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
